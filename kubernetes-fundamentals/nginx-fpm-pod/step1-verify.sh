(( $(curl -fsSL $REGISTRY/v2/php-app/tags/list | grep "php\-app.*example\-1" 2>/dev/null | wc -l) >= 1 )) && echo \"done\"