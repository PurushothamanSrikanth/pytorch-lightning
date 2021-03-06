.PHONY: test clean docs

# to imitate SLURM set only single node
export SLURM_LOCALID=0
# assume you have installed need packages
export SPHINX_MOCK_REQUIREMENTS=0

test:
	pip install -r requirements/devel.txt
	# install APEX, see https://github.com/NVIDIA/apex#linux

	# use this to run tests
	rm -rf _ckpt_*
	rm -rf ./lightning_logs
	python -m coverage run --source pytorch_lightning -m pytest pytorch_lightning tests pl_examples -v --flake8
	python -m coverage report

	# specific file
	# python -m coverage run --source pytorch_lightning -m pytest --flake8 --durations=0 -v -k

docs: clean
	pip install --quiet -r requirements/docs.txt
	python -m sphinx -b html -W docs/source docs/build

clean:
	# clean all temp runs
	rm -rf $(shell find . -name "mlruns")
	rm -rf .mypy_cache
	rm -rf .pytest_cache
	rm -rf ./docs/build
	rm -rf ./docs/source/generated
	rm -rf ./docs/source/*/generated
	rm -rf ./docs/source/api
