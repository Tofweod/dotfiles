return {
  "chrisgrieser/nvim-recorder",
  lazy = true,
  keys = { "q", "Q", "<A-q>", "cq", "yq" },
  config = function()
    require("recorder").setup({
      slots = { "u", "i", "o" },
      mapping = {
        startStopRecording = "q",
        playMacro = "Q",
        switchSlot = "<A-q>",
        editMacro = "cq",
        yankMacro = "yq",
        -- addBreakPoint = "##",
      },
    })
  end,
}
