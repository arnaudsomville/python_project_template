ARG REGISTRY_URL
FROM ${REGISTRY_URL}/baseimages/python-3-11:0.2.7
SHELL ["/bin/bash", "-c"]

# Ordering matters: https://github.com/GoogleContainerTools/kaniko/issues/1524
COPY --chown=1000:1000 ./pdm.lock ./README.md ./pyproject.toml /home/${USERNAME}/app_source/
COPY --chown=1000:1000 ./src /home/${USERNAME}/app_source/src 
COPY --chown=1000:1000 ./data /home/${USERNAME}/app_source/data  
WORKDIR /home/${USERNAME}/app_source/
# Docker secrets have compatibility issues with kaniko: 
#   https://github.com/GoogleContainerTools/kaniko/issues/489
#   https://github.com/GoogleContainerTools/kaniko/issues/1505
#   https://github.com/GoogleContainerTools/kaniko/issues/1850
RUN source "${HOME}/.bashrc" && \
    pdm use "${HOME}/miniconda3/bin/python" && \
    pdm install --prod --no-editable --no-lock

EXPOSE 8000
ENTRYPOINT [ "/bin/bash", "-c" ]
HEALTHCHECK --interval=10s --timeout=10s  CMD wget localhost:8000/health || exit 1
CMD [ "source ${HOME}/.bashrc && uvicorn api:app --app-dir src/api/ --host 0.0.0.0 --port 8000" ]

