import Xmobar hiding (main)
--import XMobar.Config.Types (OnScreen)

config :: Config
config = defaultConfig
    { font = "xft:Fira Code:size=12"
    , bgColor = "#002b36" -- solarizedBase03 aka solarizedBackground
    , fgColor = "#839496" -- solarizedBase0 aka solarizedForeground
    , additionalFonts = [ "xft:FontAwesome:size=12" ]
    , border = BottomB
    , borderColor = "#586e75" -- solarizedBase01
    , position = OnScreen 1 Top
    , commands =
        [ Run $ UnsafeStdinReader
        , Run $ Date "%a %d %b %Y %I:%M:%S %p" "date" 1
        , Run $ Battery
            [ "-t", "<acstatus><watts> <leftvbar> <left>% <timeleft>"
            , "-L", "20", "-H", "80"
            , "--"
            , "-L", "0", "-H", "0"
            , "-O", "P", "-i", "I", "-o", "U"
            ] 10
        , Run $ DynNetwork [] 10
        ]
    , sepChar = "%"
    , alignSep = "}{"
    , template = "%UnsafeStdinReader% }{ ┃ %battery% ┃ %date%"
    }

main :: IO ()
main = xmobar config
