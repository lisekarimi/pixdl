FROM nvidia/cuda:12.8.1-cudnn-devel-ubuntu24.04

WORKDIR /workspace

# Install system dependencies
RUN apt update && apt install -y \
   software-properties-common wget \
   && add-apt-repository ppa:deadsnakes/ppa -y \
   && apt update && apt install -y \
   python3.11 python3.11-dev python3.11-distutils \
   libgl1 libglib2.0-0 libsm6 libxext6 libxrender1 libgomp1 \
   && apt clean && rm -rf /var/lib/apt/lists/*

# Install pip
RUN wget https://bootstrap.pypa.io/get-pip.py && \
   python3.11 get-pip.py && \
   rm get-pip.py

# Install custom TensorFlow wheel + TF dependencies
RUN wget https://github.com/nsmit-tta-iso/tensorflow-rtx-50-series/releases/download/2.20.0dev/tensorflow-2.20.0.dev0+selfbuilt-cp311-cp311-linux_x86_64.whl && \
   python3.11 -m pip install tensorflow-2.20.0.dev0+selfbuilt-cp311-cp311-linux_x86_64.whl --break-system-packages --no-deps && \
   rm tensorflow-2.20.0.dev0+selfbuilt-cp311-cp311-linux_x86_64.whl

# Install TensorFlow dependencies
RUN python3.11 -m pip install --break-system-packages \
   astunparse flatbuffers gast google_pasta keras-nightly libclang ml_dtypes opt_einsum \
   requests tb-nightly termcolor typing_extensions wrapt absl-py protobuf h5py grpcio

# Install data science, computer vision, Jupyter, and utilities
RUN python3.11 -m pip install --break-system-packages \
   pillow numpy matplotlib opencv-python pandas seaborn scikit-learn \
   jupyter jupyterlab ipywidgets tqdm

EXPOSE 8888
CMD ["python3.11", "-m", "jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
