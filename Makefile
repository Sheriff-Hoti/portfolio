docker.build:
		docker build -t resume-pdf -f Dockerfile .
docker.run:
		docker run --rm --init --ipc=host -v "$(PWD)/public:/app/public" resume-pdf
docker.gen:
		make docker.build
		make docker.run