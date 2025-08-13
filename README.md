# 🖼️ PixDL — Deep Learning for Image Recognition

`PixDL` is a collection of GPU-powered **computer vision** projects for advanced data scientists.
It demonstrates **CNN architectures**, **transfer learning**, and **data augmentation** using **PyTorch** and **TensorFlow** inside **Docker** containers.

Each notebook is self-contained and guides you through:
- 📂 Data loading (with instructions provided)
- 📊 Exploratory Data Analysis (EDA)
- 🛠 Preprocessing
- 🧠 Model training & evaluation
- ✅ Accuracy & confusion matrix
- 🏆 Best model selection
- 🔍 Predictions & inference

---

## 🚀 Requirements
- GPU-enabled machine
- [Docker Desktop](https://www.docker.com/products/docker-desktop)
- `uv` package
- Familiarity with **MLflow** in **GCP** or **AWS** (notebook assumes you can set it up)

> 💡 This toolkit is designed for **advanced data scientists** with local GPU access.

---

## 📂 Projects

| Project | Framework | Notes |
|---------|-----------|-------|
| **Cat vs Dog Classification (PyTorch)** | PyTorch + MLflow | Runs on GCP with MLflow tracking |
| **Cat vs Dog Classification (TensorFlow)** | TensorFlow | Local GPU training |
| **Handwritten Digit Recognition** | TensorFlow | Classic MNIST classification |
