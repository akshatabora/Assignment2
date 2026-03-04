# Dockerfile for SWE645 Homework 2
# This container serves static HTML files using Nginx

FROM nginx:alpine

# Remove default Nginx website
RUN rm -rf /usr/share/nginx/html/*

# Copy Homework 1 files into container
COPY index.html /usr/share/nginx/html/
COPY survey.html /usr/share/nginx/html/
COPY error.html /usr/share/nginx/html/
COPY GMU.jpg /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]