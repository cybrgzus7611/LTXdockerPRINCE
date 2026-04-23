FROM runpod/comfyui:latest

COPY start.sh /download_models.sh
RUN chmod +x /download_models.sh

COPY video_ltx2.3_ia2v_-_workingprineai.json /tmp/ltx2_ia2v.json

# Append our model download to the end of the base image's start script
RUN sed -i '/ComfyUI crashed/i \/download_models.sh' /start.sh
