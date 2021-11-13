# docker build -t stockfish/cluster:debian .
# docker run -v /tmp/stockfish:/download stockfish/cluster:debian
FROM debian:latest as builder
RUN apt-get update && \
	apt-get install -y git mpich make gcc curl g++ && \
	git clone https://github.com/official-stockfish/Stockfish.git && \
	cd Stockfish/src/ && \
	git checkout cluster && \
	make -j10 ARCH=x86-64-avx2 clean build COMPILER=mpicxx mpi=yes && \
	mkdir /app && \
	cp stockfish /app/stockfish-cluster
CMD [ "cp /app/stockfish-cluster /download/" ]

