FROM rocker/r2u:jammy

LABEL org.opencontainers.image.authors="Lise Vaudor <lise.vaudor@ens-lyon.fr>, Samuel Dunesme <samuel.dunesme@ens-lyon.fr>"
LABEL org.opencontainers.image.source="https://github.com/lvaudor/learnr_Restart_exos_tableaux"
LABEL org.opencontainers.image.description="Deck d'exercices sur la manipulation de tableaux avec dplyr dans R."

RUN locale-gen fr_FR.UTF-8

RUN Rscript -e 'install.packages("shiny")'
RUN Rscript -e 'install.packages("learnr")'
RUN Rscript -e 'install.packages("remotes")'
RUN Rscript -e 'remotes::install_github("rstudio/gradethis")'
RUN Rscript -e 'install.packages("dplyr")'
RUN Rscript -e 'install.packages("readr")'



# On copie l'arborescence de fichiers dans un dossier app à la racine de l'image. Ce sera le working directory des containers lancés avec notre image
RUN mkdir /app
ADD . /app
WORKDIR /app

EXPOSE 3841

RUN groupadd -g 1010 app && useradd -c 'app' -u 1010 -g 1010 -m -d /home/app -s /sbin/nologin app
USER app

CMD  ["R", "-f", "run.R"]
