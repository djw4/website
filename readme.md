1. `docker compose up -d`
2. Available at http://localhost:4000/

```
Alternatively use:
docker run --name hexo -d -p 4000:4000 -v '/hexo/posts:/opt/hexo/ipple1986/source/_posts' -v '/hexo/themes:/opt/hexo/ipple1986/themes' -v '/hexo/_config.yml:/opt/hexo/ipple1986/_config.yml' ipple1986/hexo
```

```
Add  #  git submodule add https://github.com/probberechts/hexo-theme-cactus.git themes/cactus
Update  #  git submodule update --init --recursive
```