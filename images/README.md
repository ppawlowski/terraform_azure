In order to build docker image, run:

```bash
source set_build_vars.sh && docker build -t ${REPO_URL} --build-arg wp_version=${WP_VERSION} --build-arg wp_db_host=${WP_DB_HOST} --build-arg wp_db_user=${WP_DB_USER} --build-arg wp_db_pass=${WP_DB_PASS} --build-arg wp_db_name=${WP_DB_NAME} --build-arg wp_url=${WP_URL} --build-arg wp_title=${WP_TITLE} --build-arg wp_admin_user=${WP_ADMIN_USER} --build-arg wp_admin_pass=${WP_ADMIN_PASS} --build-arg wp_admin_email=${WP_ADMIN_EMAIL} .
```