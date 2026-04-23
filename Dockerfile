FROM runpod/comfyui:latest

COPY COPY download_models.sh /download_models.sh
RUN chmod +x /download_models.sh

COPY video_ltx2.3_ia2v_-_workingprineai.json /tmp/ltx2_ia2v.json
