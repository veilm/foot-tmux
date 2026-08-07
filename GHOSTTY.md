# Ghostty evaluation

Decision timestamp: `1786145172`

We considered replacing foot-tmux with Ghostty and decided against it. Ghostty
is not worth further investigation or migration work for our current workflow.

The main issue is that Ghostty has a larger, more complicated codebase while
our most important terminal behavior is highly specific to this fork. In
particular, foot-tmux recognizes tmux separators, renders them as transparent
double-width gaps, punches those gaps through window padding, and aligns an
animated active-pane border with the resulting geometry. Reproducing this
faithfully in Ghostty would require invasive renderer and layout changes. A
Ghostty fork would therefore be harder to understand and maintain without
providing a meaningful benefit in return.

The proposed advantages do not matter enough for this setup:

- tmux is already the preferred multiplexer, so native tabs and splits are
  redundant;
- Yazi is rarely used, image previews are needed only occasionally, and files
  can be opened in the existing image viewer;
- the current pywal, wallpaper, light-theme, and transparency flows already
  work, including inside tmux and Kakoune;
- styled terminal clipboard copies have no useful role here;
- no Unicode or shaping problems have been observed;
- read-only terminal behavior is unnecessary because tmux pane contents can
  already be opened in the text editor;
- terminal creation is extremely rare, so daemon-backed launch speed is
  irrelevant, and Foot supports a server mode if it is ever needed;
- command progress, command-finished notifications, prompt navigation, and
  native scrollback features do not improve the agent-heavy tmux workflow;
- Hyprland already provides global bindings, window management, and anything
  resembling a drop-down terminal;
- shaders usually trade away readability, and compositor-level effects remain
  available if one is ever desirable;
- terminal background images are redundant because the real wallpaper is
  visible through transparent terminals;
- systemd resource controls and a terminal scripting API are not needed because
  tmux, workstation scripts, Hyprland, and the editable Foot source already
  provide the required control.

We should continue using and extending foot-tmux. Reconsider Ghostty only if a
future release demonstrates a genuinely compelling capability that materially
improves the actual workflow and would be unreasonable to reproduce in Foot.
Ordinary feature growth, popularity, GPU acceleration, or cosmetic demos are
not sufficient reasons to reopen the comparison.
