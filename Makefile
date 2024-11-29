# Spécifie le shell à utiliser
SHELL := /bin/bash

# Vérifie que le nom de l'environnement est fourni
ifndef ENV
$(error ENV n'est pas défini. Utilisez 'make ENV=<env_name>')
endif

# Variables
PYTHON_VERSION=3.11
CONDA_PATH := $(shell conda info --base)
MAX_RETRIES=3

# Étapes
all: conda_env pdm_setup sphinx_setup clean

conda_env:
	@echo "Création de l'environnement conda $(ENV)..."
	conda create -n $(ENV) python=$(PYTHON_VERSION) -y
	@echo "Environnement $(ENV) créé avec succès."

pdm_setup:
	@echo "Activation de l'environnement et installation de PDM..."
	source $(CONDA_PATH)/etc/profile.d/conda.sh && \
	conda activate $(ENV) && \
	pip install --upgrade pip && \
	pip install pdm==2.20.1
	pdm init
	@echo "Initialisation et installation des dépendances avec PDM..."
	$(MAKE) pdm_retry
	@echo "PDM installé avec succès dans l'environnement $(ENV)."

pdm_retry:
	@echo "Tentative d'installation avec PDM (jusqu'à $(MAX_RETRIES) essais)..."
	@for i in $(shell seq 1 $(MAX_RETRIES)); do \
		echo "Essai $$i sur $(MAX_RETRIES)..."; \
		pdm install && break || echo "Échec, nouvelle tentative..."; \
	done

sphinx_setup:
	@echo "Configuration de Sphinx avec PDM..."
	source $(CONDA_PATH)/etc/profile.d/conda.sh && \
	conda activate $(ENV) && \
	sphinx-quickstart --no-sep --project="Your Project" --author="Your Name" --release="0.1" --quiet docs
	@echo "Sphinx configuré avec succès."

clean:
	@echo "Nettoyage des fichiers générés..."
	rm -rf docs/_build docs/source docs/make.bat docs/Makefile
	rm -rf src/python_project_template
	rm -rf tests/python_project_template
	@echo "Fichiers nettoyés."
