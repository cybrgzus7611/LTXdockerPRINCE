FROM runpod/comfyui:latest

COPY start.sh /download_models.sh
RUN chmod +x /download_models.sh

COPY video_ltx2.3_ia2v_-_workingprineai.json /tmp/ltx2_ia2v.json
