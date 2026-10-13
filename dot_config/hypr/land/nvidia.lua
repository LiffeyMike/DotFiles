-- land/nvidia.conf -> Lua. Require from hyprland.lua only when on NVIDIA.

hl.env("LIBVA_DRIVER_NAME",         "nvidia")
hl.env("XDG_SESSION_TYPE",          "wayland")
hl.env("GBM_BACKEND",               "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("WLR_NO_HARDWARE_CURSORS",   "1")
hl.env("WLR_DRM_DEVICES",           "/dev/dri/card0")

-- Shader disk cache: 10 GiB, never trimmed. Also set in ~/.config/uwsm/env (the live path under uwsm).
hl.env("__GL_SHADER_DISK_CACHE_SIZE",         "10737418240")
hl.env("__GL_SHADER_DISK_CACHE_SKIP_CLEANUP", "1")
