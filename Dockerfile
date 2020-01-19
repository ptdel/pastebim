FROM nimlang/nim:onbuild

VOLUME /pastes

COPY . .

ENTRYPOINT ["./pastebim" ]
