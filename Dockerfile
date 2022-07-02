# puxa a imagem oficial do python
FROM python:3
#Seta as variaveis de ambiente 
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV DJANGO_SUPERUSER_EMAIL=admin@teste.com
ENV DJANGO_SUPERUSER_USERNAME=admin
ENV DJANGO_SUPERUSER_PASSWORD=admin123
#Seta o diretorio da aplicacao
WORKDIR /aluraflix
#Instala as dependencias do python
COPY requirements.txt /aluraflix/requirements.txt
RUN pip install --no-cache-dir --requirement /aluraflix/requirements.txt
#Copia o conteudo da aplicacao para o diretorio definido anteriormente
COPY aluraflix /aluraflix/aluraflix
COPY setup /aluraflix/setup
COPY db.sqlite3 /aluraflix/db.sqlite3
COPY manage.py /aluraflix/manage.py

#Libera a execucao por qualquer host
RUN sed -i "s/ALLOWED_HOSTS = \[\]/ALLOWED_HOSTS = \['*']/" setup/settings.py
#Gera a base de dados da aplicacao e cria a conta do superusuario da aplicacao 
RUN python manage.py makemigrations && python manage.py migrate && python manage.py createsuperuser --noinput
#Expoe a porta 8000 do container
EXPOSE 8000
#Executa a aplicacao
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]