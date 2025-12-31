import os
from huggingface_hub import login

hf_token = os.getenv("HUGGINGFACE_HUB_TOKEN")
if hf_token:
    login(token=hf_token)


@app.on_event("startup")
def load_model():
    global pipe
    pipe = StableDiffusionPipeline.from_pretrained(
        MODEL_ID,
        torch_dtype=torch.float16,
        variant="fp16",
    ).to("cuda")
    pipe.safety_checker = None

    # Attempt to load LoRA if present — but don't crash if it's missing
    try:
        if os.path.isfile(LORA_PATH):
            pipe.unet = PeftModel.from_pretrained(pipe.unet, LORA_PATH)
    except Exception as e:
        print(f"[WARN] LoRA not loaded: {e}")

