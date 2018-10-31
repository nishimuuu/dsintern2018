FROM jupyter/datascience-notebook

MAINTAINER nishimuuu

USER root 
RUN set -x && \
      apt-get -y update && \
      apt-get -y install swig && \
      pip install seaborn gensim prophet statsmodels hyperopt && \
      pip install pyyaml jupyter_contrib_nbextensions jupyterlab ipython-sql && \
      pip install mlxtend && \
      pip install forestci skope-rules imbalanced-learn sklearn-pandas category_encoders sklearn-template boruta sklearn-contrib-lightning && \
      pip install Flask tornado && \
      pip install boto3 joblib && \
      pip install xgboost && \
      pip install auto-sklearn featuretools tpot  && \
      pip install psycopg2 lightgbm && \
      pip install git+https://github.com/coreylynch/pyFM && \
      git clone https://github.com/scikit-learn-contrib/polylearn.git && \
      cd polylearn && \
      python setup.py build && \
      python setup.py install && \
      cd ../ 

USER jovyan

WORKDIR /home/jovyan
RUN set -x && \
      rm /home/jovyan/.jupyter/jupyter_notebook_config.py && \
      jupyter notebook --generate-config && \
      mkdir -p /home/jovyan/.jupyter/lab/user-settings/@jupyterlab/codemirror-extension && \
      mkdir -p /home/jovyan/.jupyter/lab/user-settings/@jupyterlab/apputils-extension && \
      rm -r /home/jovyan/.cache/* && \
      mkdir -p $(jupyter --data-dir)/nbextensions/usability && \
      cd $(jupyter --data-dir)/nbextensions/usability && \
      git clone https://github.com/lambdalisue/jupyter-vim-binding.git vim_binding && \
      chmod -R go-w vim_binding && \
      jupyter contrib nbextension install --user && \
      jupyter serverextension enable --py jupyterlab --sys-prefix 

# Jupyter configuration
COPY ./src/docker/jupyter_notebook_config.py /home/jovyan/.jupyter/jupyter_notebook_config.py
COPY ./src/docker/themes.jupyterlab-settings /home/jovyan/.jupyter/lab/user-settings/@jupyterlab/apputils-extension/themes.jupyterlab-settings
COPY ./src/docker/commands.jupyterlab-settings /home/jovyan/.jupyter/lab/user-settings/@jupyterlab/codemirror-extension/commands.jupyterlab-settings

# Fonts configuration
COPY ./src/docker/Ricty-Regular.ttf /usr/local/share/fonts/Ricty-Regular.ttf

# matplotlib configuration
COPY ./src/docker/mplstyle /opt/conda/lib/python3.6/site-packages/matplotlib/mpl-data/stylelib/
COPY ./src/docker/matplotlibrc /home/jovyan/.matplotlib/matplotlibrc

ENTRYPOINT ["jupyter", "lab"]

