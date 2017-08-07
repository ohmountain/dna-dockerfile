FROM ubuntu:latest
COPY ./go1.8.3.linux-amd64.tar.gz $HOME/
RUN sed -i 's/archive.ubuntu/cn.archive.ubuntu/g' /etc/apt/sources.list \ 
        && apt-get update \ 
        && apt-get install git wget build-essential libsqlite3-dev -y \ 
        && mkdir -p $HOME/.golang/gopath \ 
        && tar zvxf go1.8.3.linux-amd64.tar.gz \  
        && mv go $HOME/.golang/ \ 
        && echo "export GOROOT=$HOME/.golang/go" $HOME/.bashrc \
        && echo "export GOBIN=$HOME/.golang/go/bin" $HOME/.bashrc \
        && echo "export GOPATH=$HOME/.golang/gopath" $HOME/.bashrc \
        && echo "export PATH=$GOBIN:$GOPATH/bin:$PATH" $HOME/.bashrc \
        && export GOROOT=$HOME/.golang/go \
        && export GOBIN=$HOME/.golang/go/bin \
        && export GOPATH=$HOME/.golang/gopath \
        && export PATH=$GOBIN:$GOPATH/bin:$PATH \
        && go get github.com/Masterminds/glide \
        && git clone https://github.com/DNAProject/DNA.git \
        && mv DNA $GOPATH/src/ \ 
        && cd $GOPATH/src/DNA \ 
        && glide install \ 
        && mkdir /var/DNASample \
        && go build -o /var/DNASample/DNA main.go \ 
        && go build -o /var/DNASample/nodectl nodectl.go \ 
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/* \ 
