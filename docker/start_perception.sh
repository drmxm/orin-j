#!/usr/bin/env bash
# Fail hard, but relax -u while sourcing ROS
set -Eeuo pipefail
set +u
source /opt/ros/humble/setup.bash
set -u

# Read env (defaults)
UVC_DEVICE="${UVC_DEVICE:-/dev/video0}"
RGB_WIDTH="${RGB_WIDTH:-1920}"
RGB_HEIGHT="${RGB_HEIGHT:-1080}"
RGB_FPS="${RGB_FPS:-30.0}"
RGB_PIXEL_FORMAT="${RGB_PIXEL_FORMAT:-mjpeg2rgb}"
RGB_FRAME_ID="${RGB_FRAME_ID:-uvc_rgb}"
RGB_CAMERA_NAME="${RGB_CAMERA_NAME:-arducam_rgb}"
RGB_INFO_URL="${RGB_INFO_URL:-file:///work/config/rgb_1920x1080.yaml}"
RGB_IMAGE_TOPIC="${RGB_IMAGE_TOPIC:-/sensors/rgb/image_raw}"
RGB_INFO_TOPIC="${RGB_INFO_TOPIC:-/sensors/rgb/camera_info}"

echo "[perception] Using device ${UVC_DEVICE} ${RGB_WIDTH}x${RGB_HEIGHT}@${RGB_FPS}"

if [[ -e "${UVC_DEVICE}" ]]; then
  echo "[perception] Device name: $(cat /sys/class/video4linux/$(basename ${UVC_DEVICE})/name 2>/dev/null || echo '?')"
  (v4l2-ctl -d "${UVC_DEVICE}" --list-formats-ext || true) | sed 's/^/[v4l2] /'
else
  echo "[perception] WARNING: ${UVC_DEVICE} not present. The node will retry internally."
fi

exec ros2 run usb_cam usb_cam_node_exe \
  --ros-args \
  -p camera_name:="${RGB_CAMERA_NAME}" \
  -p video_device:="${UVC_DEVICE}" \
  -p image_width:="${RGB_WIDTH}" \
  -p image_height:="${RGB_HEIGHT}" \
  -p framerate:="${RGB_FPS}" \
  -p pixel_format:="${RGB_PIXEL_FORMAT}" \
  -p camera_frame_id:="${RGB_FRAME_ID}" \
  -p camera_info_url:="${RGB_INFO_URL}" \
  -r image_raw:="${RGB_IMAGE_TOPIC}" \
  -r camera_info:="${RGB_INFO_TOPIC}"
