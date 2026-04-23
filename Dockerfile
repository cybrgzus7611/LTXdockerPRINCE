FROM runpod/comfyui:latest

# Copy model download script
COPY start.sh /download_models.sh
RUN chmod +x /download_models.sh

# Copy workflow to a temp location (will be moved at runtime)
COPY video_ltx2.3_ia2v_-_workingprineai.json /tmp/ltx2_ia2v.json

# Wrap the base image's startup: download models first, then run original
RUN cp /start.sh /original_start.sh && \
    printf '#!/bin/bash\n/download_models.sh\nexec /original_start.sh "$@"\n' > /start.sh && \
    chmod +x /start.sh
