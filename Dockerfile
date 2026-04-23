FROM runpod/comfyui:latest

ENV COMFYUI_PATH=/workspace/runpod-slim/ComfyUI
ENV MODELS_PATH=${COMFYUI_PATH}/models
ENV CUSTOM_NODES_PATH=${COMFYUI_PATH}/custom_nodes

# Create model directories
RUN mkdir -p \
    ${MODELS_PATH}/checkpoints \
    ${MODELS_PATH}/loras \
    ${MODELS_PATH}/latent_upscale_models \
    ${MODELS_PATH}/vae \
    ${MODELS_PATH}/text_encoders

# Install custom nodes
RUN git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git \
    ${CUSTOM_NODES_PATH}/comfyui-videohelpersuite && \
    pip install -r ${CUSTOM_NODES_PATH}/comfyui-videohelpersuite/requirements.txt || true

RUN git clone https://github.com/rgthree/rgthree-comfy.git \
    ${CUSTOM_NODES_PATH}/rgthree-comfy && \
    pip install -r ${CUSTOM_NODES_PATH}/rgthree-comfy/requirements.txt || true

RUN git clone https://github.com/kijai/ComfyUI-KJNodes.git \
    ${CUSTOM_NODES_PATH}/ComfyUI-KJNodes && \
    pip install -r ${CUSTOM_NODES_PATH}/ComfyUI-KJNodes/requirements.txt || true

RUN git clone https://github.com/Jasonzzt/ComfyUI-CacheDiT.git \
    ${CUSTOM_NODES_PATH}/ComfyUI-CacheDiT && \
    pip install -r ${CUSTOM_NODES_PATH}/ComfyUI-CacheDiT/requirements.txt || true

# Manager security level
RUN mkdir -p ${COMFYUI_PATH}/user/__manager && \
    printf '[manager]\nsecurity_level = weak\n' \
    > ${COMFYUI_PATH}/user/__manager/config.ini

# Copy workflow
COPY video_ltx2_3_ia2v_-_workingprineai.json \
     ${COMFYUI_PATH}/user/default/workflows/ltx2_ia2v.json

# Copy startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
