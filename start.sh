#!/bin/bash
set -e

MODELS_PATH=/workspace/runpod-slim/ComfyUI/models

mkdir -p ${MODELS_PATH}/checkpoints
mkdir -p ${MODELS_PATH}/loras
mkdir -p ${MODELS_PATH}/latent_upscale_models
mkdir -p ${MODELS_PATH}/vae
mkdir -p ${MODELS_PATH}/text_encoders

download_if_missing() {
    local dest="$1"
    local url="$2"
    if [ ! -f "$dest" ]; then
        echo "Downloading $(basename $dest)..."
        curl -L \
            -H "Authorization: Bearer ${HF_TOKEN}" \
            --retry 3 \
            -o "$dest" \
            "$url"
    else
        echo "✓ $(basename $dest) already exists, skipping."
    fi
}

download_if_missing "${MODELS_PATH}/checkpoints/ltx-2.3-22b-dev-fp8.safetensors" \
    "https://huggingface.co/Lightricks/LTX-2.3-fp8/resolve/main/ltx-2.3-22b-dev-fp8.safetensors"
download_if_missing "${MODELS_PATH}/loras/ltx-2.3-22b-distilled-lora-384.safetensors" \
    "https://huggingface.co/Lightricks/LTX-2.3/resolve/main/ltx-2.3-22b-distilled-lora-384.safetensors"
download_if_missing "${MODELS_PATH}/loras/gemma-3-12b-it-abliterated_lora_rank64_bf16.safetensors" \
    "https://huggingface.co/Comfy-Org/ltx-2/resolve/main/split_files/loras/gemma-3-12b-it-abliterated_lora_rank64_bf16.safetensors"
download_if_missing "${MODELS_PATH}/latent_upscale_models/ltx-2.3-spatial-upscaler-x2-1.0.safetensors" \
    "https://huggingface.co/Lightricks/LTX-2.3/resolve/main/ltx-2.3-spatial-upscaler-x2-1.0.safetensors"
download_if_missing "${MODELS_PATH}/vae/ltx-av-step-1751000_vocoder_24K.safetensors" \
    "https://huggingface.co/Lightricks/LTX-2/resolve/main/vocoder/ltx-av-step-1751000_vocoder_24K.safetensors"
download_if_missing "${MODELS_PATH}/vae/model.safetensors" \
    "https://huggingface.co/Lightricks/LTX-2/resolve/main/vocoder/model.safetensors"
download_if_missing "${MODELS_PATH}/text_encoders/gemma_3_12B_it_fp4_mixed.safetensors" \
    "https://huggingface.co/Comfy-Org/ltx-2/resolve/main/split_files/text_encoders/gemma_3_12B_it_fp4_mixed.safetensors"

echo "All models ready."
