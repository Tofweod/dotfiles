# vim: set ft=python:

from distutils.version import LooseVersion
import math
import os
import typing
import vapoursynth as vs

vs_thd_init = os.cpu_count()
if vs_thd_init > 8 and vs_thd_init <= 16:
    vs_thd_dft = 8
elif vs_thd_init > 16:
    if vs_thd_init <= 32:
        vs_thd_dft = vs_thd_init // 2
        if vs_thd_dft % 2 != 0:
            vs_thd_dft = vs_thd_dft - 1
    else:
        vs_thd_dft = 16
else:
    vs_thd_dft = vs_thd_init

vs_api = vs.__api_version__.api_major
if vs_api < 4:
    raise ImportError("帧服务器 VapourSynth 的版本号过低，至少 R57")

core = vs.core
dfttest2 = None
nnedi3_resample = None
qtgmc = None
vsmlrt = None


def FPS_CHANGE(
    input: vs.VideoNode,
    fps_in: float = 24.0,
    fps_out: float = 60.0,
    vs_t: int = vs_thd_dft,
) -> vs.VideoNode:

    func_name = "FPS_CHANGE"
    if not isinstance(input, vs.VideoNode):
        raise vs.Error(f"模块 {func_name} 的子参数 input 的值无效")
    if not isinstance(fps_in, (int, float)) or fps_in <= 0.0:
        raise vs.Error(f"模块 {func_name} 的子参数 fps_in 的值无效")
    if (
        not isinstance(fps_out, (int, float))
        or fps_out <= 0.0
        or fps_out == fps_in
    ):
        raise vs.Error(f"模块 {func_name} 的子参数 fps_out 的值无效")
    if not isinstance(vs_t, int) or vs_t > vs_thd_init:
        raise vs.Error(f"模块 {func_name} 的子参数 vs_t 的值无效")

    core.num_threads = vs_t

    def _ChangeFPS(
        clip: vs.VideoNode, fpsnum: int, fpsden: int = 1
    ) -> vs.VideoNode:
        factor = (fpsnum / fpsden) * (clip.fps_den / clip.fps_num)

        def _frame_adjuster(n: int) -> vs.VideoNode:
            real_n = math.floor(n / factor)
            one_frame_clip = clip[real_n] * (len(clip) + 100)
            return one_frame_clip

        attribute_clip = clip.std.BlankClip(
            length=math.floor(len(clip) * factor), fpsnum=fpsnum, fpsden=fpsden
        )
        return attribute_clip.std.FrameEval(eval=_frame_adjuster)

    src = core.std.AssumeFPS(clip=input, fpsnum=fps_in * 1e6, fpsden=1e6)
    fin = _ChangeFPS(clip=src, fpsnum=fps_out * 1e6, fpsden=1e6)
    output = core.std.AssumeFPS(clip=fin, fpsnum=fps_out * 1e6, fpsden=1e6)

    return output


def FPS_CTRL(
    input: vs.VideoNode,
    fps_in: float = 23.976,
    fps_max: float = 32.0,
    fps_out: typing.Optional[str] = None,
    fps_ret: bool = False,
    vs_t: int = vs_thd_dft,
) -> vs.VideoNode:

    func_name = "FPS_CTRL"
    if not isinstance(input, vs.VideoNode):
        raise vs.Error(f"模块 {func_name} 的子参数 input 的值无效")
    if not isinstance(fps_in, (int, float)) or fps_in <= 0.0:
        raise vs.Error(f"模块 {func_name} 的子参数 fps_in 的值无效")
    if fps_out is not None:
        if not isinstance(fps_out, (int, float)) or fps_out <= 0.0:
            raise vs.Error(f"模块 {func_name} 的子参数 fps_out 的值无效")
    if not isinstance(fps_ret, bool):
        raise vs.Error(f"模块 {func_name} 的子参数 fps_ret 的值无效")
    if not isinstance(vs_t, int) or vs_t > vs_thd_init:
        raise vs.Error(f"模块 {func_name} 的子参数 vs_t 的值无效")

    core.num_threads = vs_t

    if fps_in > fps_max:
        if fps_ret:
            raise Exception("源帧率超过限制的范围，已临时中止。")
        else:
            output = FPS_CHANGE(
                input=input,
                fps_in=fps_in,
                fps_out=fps_out if fps_out else fps_max,
            )
    else:
        output = input

    return output


def RIFE_STD(
    input: vs.VideoNode,
    model: typing.Literal[23, 41, 43, 45] = 23,
    t_tta: bool = False,
    fps_num: int = 2,
    fps_den: int = 1,
    sc_mode: typing.Literal[0, 1, 2] = 1,
    skip: bool = True,
    stat_th: float = 60.0,
    gpu: typing.Literal[0, 1, 2] = 0,
    gpu_t: int = 2,
    vs_t: int = vs_thd_dft,
) -> vs.VideoNode:

    func_name = "RIFE_STD"
    if not isinstance(input, vs.VideoNode):
        raise vs.Error(f"模块 {func_name} 的子参数 input 的值无效")
    if model not in [23, 41, 43, 45]:
        raise vs.Error(f"模块 {func_name} 的子参数 model 的值无效")
    if not isinstance(t_tta, bool):
        raise vs.Error(f"模块 {func_name} 的子参数 t_tta 的值无效")
    if not isinstance(fps_num, int) or fps_num < 2:
        raise vs.Error(f"模块 {func_name} 的子参数 fps_num 的值无效")
    if (
        not isinstance(fps_den, int)
        or fps_den >= fps_num
        or fps_num / fps_den <= 1
    ):
        raise vs.Error(f"模块 {func_name} 的子参数 fps_den 的值无效")
    if sc_mode not in [0, 1, 2]:
        raise vs.Error(f"模块 {func_name} 的子参数 sc_mode 的值无效")
    if not isinstance(skip, bool):
        raise vs.Error(f"模块 {func_name} 的子参数 skip 的值无效")
    if (
        not isinstance(stat_th, (int, float))
        or stat_th <= 0.0
        or stat_th > 60.0
    ):
        raise vs.Error(f"模块 {func_name} 的子参数 stat_th 的值无效")
    if gpu not in [0, 1, 2]:
        raise vs.Error(f"模块 {func_name} 的子参数 gpu 的值无效")
    if not isinstance(gpu_t, int) or gpu_t <= 0:
        raise vs.Error(f"模块 {func_name} 的子参数 gpu_t 的值无效")
    if not isinstance(vs_t, int) or vs_t > vs_thd_init:
        raise vs.Error(f"模块 {func_name} 的子参数 vs_t 的值无效")

    if not hasattr(core, "rife"):
        raise ModuleNotFoundError(
            f"模块 {func_name} 依赖错误：缺失插件，检查项目 rife"
        )
    if skip:
        if not hasattr(core, "vmaf"):
            raise ModuleNotFoundError(
                f"模块 {func_name} 依赖错误：缺失插件，检查项目 vmaf"
            )
    if sc_mode == 1:
        if not hasattr(core, "misc"):
            raise ModuleNotFoundError(
                f"模块 {func_name} 依赖错误：缺失插件，检查项目 misc"
            )
    elif sc_mode == 2:
        if not hasattr(core, "mv"):
            raise ModuleNotFoundError(
                f"模块 {func_name} 依赖错误：缺失插件，检查项目 mv"
            )

    core.num_threads = vs_t
    fmt_in = input.format.id
    colorlv = getattr(input.get_frame(0).props, "_ColorRange", 0)

    if sc_mode == 0:
        cut0 = input
    elif sc_mode == 1:
        cut0 = core.misc.SCDetect(clip=input, threshold=0.15)
    elif sc_mode == 2:
        sup = core.mv.Super(clip=input, pel=1)
        vec = core.mv.Analyse(super=sup, isb=True)
        cut0 = core.mv.SCDetection(
            clip=input, vectors=vec, thscd1=240, thscd2=130
        )

    cut1 = core.resize.Bilinear(clip=cut0, format=vs.RGBS, matrix_in_s="709")
    cut2 = core.rife.RIFE(
        clip=cut1,
        model=(model + 1) if t_tta else model,
        factor_num=fps_num,
        factor_den=fps_den,
        gpu_id=gpu,
        gpu_thread=gpu_t,
        sc=True if sc_mode else False,
        skip=skip,
        skip_threshold=stat_th,
    )
    output = core.resize.Bilinear(
        clip=cut2,
        format=fmt_in,
        matrix_s="709",
        range=1 if colorlv == 0 else None,
    )

    return output


def FMT_CHANGE(
    input: vs.VideoNode,
    fmtc: bool = False,  # TODO
    algo: typing.Literal[1, 2, 3, 4] = 1,
    param_a: float = 0.0,
    param_b: float = 0.0,
    w_out: int = 0,
    h_out: int = 0,
    fmt_pix: typing.Literal[-1, 0, 1, 2, 3] = -1,
    dither: typing.Literal[0, 1, 2, 3] = 0,
    vs_t: int = vs_thd_dft,
) -> vs.VideoNode:

    func_name = "FMT_CHANGE"
    if not isinstance(input, vs.VideoNode):
        raise vs.Error(f"模块 {func_name} 的子参数 input 的值无效")
    if not isinstance(fmtc, bool):
        raise vs.Error(f"模块 {func_name} 的子参数 fmtc 的值无效")
    if algo not in [1, 2, 3, 4]:
        raise vs.Error(f"模块 {func_name} 的子参数 algo 的值无效")
    if not isinstance(param_a, (int, float)) or not isinstance(
        param_b, (int, float)
    ):
        raise vs.Error(
            f"模块 {func_name} 的子参数 param_a 或 param_b 的值无效"
        )
    if not isinstance(w_out, int) or not isinstance(h_out, int):
        raise vs.Error(f"模块 {func_name} 的子参数 w_out 或 h_out 的值无效")
    if isinstance(w_out, int) and isinstance(h_out, int):
        if w_out < 0 or h_out < 0:
            raise vs.Error(
                f"模块 {func_name} 的子参数 w_out 或 h_out 的值无效"
            )
    if fmt_pix not in [-1, 0, 1, 2, 3]:
        raise vs.Error(f"模块 {func_name} 的子参数 fmt_pix 的值无效")
    if dither not in [0, 1, 2, 3]:
        raise vs.Error(f"模块 {func_name} 的子参数 dither 的值无效")
    if not isinstance(vs_t, int) or vs_t > vs_thd_init:
        raise vs.Error(f"模块 {func_name} 的子参数 vs_t 的值无效")

    core.num_threads = vs_t
    fmt_in = input.format.id
    algo_val = ["Bilinear", "Bicubic", "Lanczos", "Spline36"][algo - 1]
    resizer = getattr(core.resize, algo_val)
    if fmt_pix > 0:
        fmt_pix_val = [vs.YUV420P8, vs.YUV420P10, vs.YUV444P16][fmt_pix - 1]
        fmt_out = fmt_pix_val
    elif fmt_pix == 0:
        fmt_out = fmt_in
        if fmt_in not in [vs.YUV420P8, vs.YUV420P10]:
            fmt_out = vs.YUV420P10
    dither_val = ["none", "ordered", "random", "error_diffusion"][dither]

    output = resizer(
        clip=input,
        width=w_out if w_out else None,
        height=h_out if h_out else None,
        filter_param_a=param_a,
        filter_param_b=param_b,
        format=fmt_pix_val if fmt_pix >= 0 else None,
        dither_type=dither_val,
    )

    return output


##################################################
## 限制输出的格式与高度
##################################################


def FMT_CTRL(
    input: vs.VideoNode,
    h_max: int = 0,
    h_ret: bool = False,
    spl_b: float = 1 / 3,  # TODO 替换为 FMT_CHANGE
    spl_c: float = 1 / 3,
    fmt_pix: typing.Literal[0, 1, 2, 3] = 0,
    vs_t: int = vs_thd_dft,
) -> vs.VideoNode:

    func_name = "FMT_CTRL"
    if not isinstance(input, vs.VideoNode):
        raise vs.Error(f"模块 {func_name} 的子参数 input 的值无效")
    if not isinstance(h_max, int) or h_max < 0:
        raise vs.Error(f"模块 {func_name} 的子参数 h_max 的值无效")
    if not isinstance(h_ret, bool):
        raise vs.Error(f"模块 {func_name} 的子参数 h_ret 的值无效")
    if not isinstance(spl_b, (int, float)):
        raise vs.Error(f"模块 {func_name} 的子参数 spl_b 的值无效")
    if not isinstance(spl_c, (int, float)):
        raise vs.Error(f"模块 {func_name} 的子参数 spl_c 的值无效")
    if fmt_pix not in [0, 1, 2, 3]:
        raise vs.Error(f"模块 {func_name} 的子参数 fmt_pix 的值无效")
    if not isinstance(vs_t, int) or vs_t > vs_thd_init:
        raise vs.Error(f"模块 {func_name} 的子参数 vs_t 的值无效")

    core.num_threads = vs_t
    fmt_src = input.format
    fmt_in = fmt_src.id
    spl_b, spl_c = float(spl_b), float(spl_c)
    w_in, h_in = input.width, input.height
    # https://github.com/mpv-player/mpv/blob/master/video/filter/vf_vapoursynth.c
    fmt_mpv = [
        vs.YUV420P8,
        vs.YUV420P10,
        vs.YUV422P8,
        vs.YUV422P10,
        vs.YUV410P8,
        vs.YUV411P8,
        vs.YUV440P8,
        vs.YUV444P8,
        vs.YUV444P10,
    ]
    fmt_pass = [vs.YUV420P8, vs.YUV420P10, vs.YUV444P16]
    fmt_safe = [vs.YUV444P8, vs.YUV444P10, vs.YUV444P16]

    if fmt_pix:
        fmt_pix_val = fmt_pass[fmt_pix - 1]
        fmt_out = fmt_pix_val
        if fmt_out == fmt_in:
            clip = input
        else:
            if (fmt_out not in fmt_safe) and (fmt_in in fmt_safe):
                if not (w_in % 2 == 0):
                    w_in = w_in - 1
                if not (h_in % 2 == 0):
                    h_in = h_in - 1
                clip = core.resize.Bicubic(
                    clip=input,
                    width=w_in,
                    height=h_in,
                    filter_param_a=spl_b,
                    filter_param_b=spl_c,
                    format=fmt_out,
                )
            else:
                clip = core.resize.Bilinear(clip=input, format=fmt_out)
    else:
        if fmt_in not in fmt_mpv:
            fmt_out = vs.YUV420P10
            if (fmt_out not in fmt_safe) and (fmt_in in fmt_safe):
                if not (w_in % 2 == 0):
                    w_in = w_in - 1
                if not (h_in % 2 == 0):
                    h_in = h_in - 1
                clip = core.resize.Bicubic(
                    clip=input,
                    width=w_in,
                    height=h_in,
                    filter_param_a=spl_b,
                    filter_param_b=spl_c,
                    format=fmt_out,
                )
            else:
                clip = core.resize.Bilinear(clip=input, format=fmt_out)
        else:
            fmt_out = fmt_in
            clip = input

    if h_max:
        if h_in > h_max:
            if h_ret:
                raise Exception("源高度超过限制的范围，已临时中止。")
            else:
                w_ds = w_in * (h_max / h_in)
                h_ds = h_max
                if fmt_src.subsampling_w or fmt_src.subsampling_h:
                    if not (w_ds % 2 == 0):
                        w_ds = math.floor(w_ds / 2) * 2
                    if not (h_ds % 2 == 0):
                        h_ds = math.floor(h_ds / 2) * 2

    if not h_max and not fmt_pix:
        output = clip
    elif h_max and not fmt_pix:
        if h_max >= h_in:
            output = clip
        else:
            output = core.resize.Bicubic(
                clip=clip,
                width=w_ds,
                height=h_ds,
                filter_param_a=spl_b,
                filter_param_b=spl_c,
            )
    elif not h_max and fmt_pix:
        if fmt_pix_val == fmt_out:
            output = clip
        else:
            output = core.resize.Bilinear(clip=clip, format=fmt_pix_val)
    else:
        if h_max >= h_in:
            if fmt_pix_val == fmt_out:
                output = clip
            else:
                output = core.resize.Bilinear(clip=clip, format=fmt_pix_val)
        else:
            if fmt_pix_val == fmt_out:
                output = core.resize.Bicubic(
                    clip=clip,
                    width=w_ds,
                    height=h_ds,
                    filter_param_a=spl_b,
                    filter_param_b=spl_c,
                )
            else:
                output = core.resize.Bicubic(
                    clip=clip,
                    width=w_ds,
                    height=h_ds,
                    filter_param_a=spl_b,
                    filter_param_b=spl_c,
                )

    return output
