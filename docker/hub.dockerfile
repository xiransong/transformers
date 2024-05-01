FROM python:3.10-slim
ENV PYTHONDONTWRITEBYTECODE=1
USER root
RUN apt-get update &&  apt-get install -y --no-install-recommends libsndfile1-dev espeak-ng time git g++ cmake pkg-config openssh-client git
ENV VIRTUAL_ENV=/usr/local
RUN pip install uv && uv venv
RUN uv pip install --no-cache-dir -U pip setuptools GitPython
RUN uv pip install --no-cache --upgrade 'torch' --index-url https://download.pytorch.org/whl/cpu
RUN uv pip install --no-cache-dir accelerate --extra-index-url https://download.pytorch.org/whl/cpu
RUN uv pip install --no-cache-dir tensorflow-cpu tf-keras
RUN uv pip install --no-cache-dir "transformers[flax,quality,vision,testing]"
RUN git lfs install

RUN pip uninstall -y transformers
RUN apt-get clean && rm -rf /var/lib/apt/lists/* && apt-get autoremove && apt-get autoclean