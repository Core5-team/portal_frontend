FROM nginx:alpine

COPY index.html /usr/share/nginx/html/index.html

RUN rm /etc/nginx/conf.d/default.conf

RUN echo 'server { \
    listen ${PORT}; \
    listen [::]:${PORT}; \
    server_name localhost; \
    location / { \
        root /usr/share/nginx/html; \
        index index.html index.htm; \
    } \
    error_page 500 502 503 504 /50x.html; \
    location = /50x.html { \
        root /usr/share/nginx/html; \
    } \
}' > /etc/nginx/conf.d/default.conf.template

CMD sh -c "envsubst '\$PORT' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"
