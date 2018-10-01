#!/usr/bin/env bash

echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
if [ $? -ne 0 ]; then exit 1; fi

echo "Branches: \$TRAVIS_BRANCH=$TRAVIS_BRANCH, \
  \$RELEASE_BRANCH=$RELEASE_BRANCH"
echo "Repository name: $REPO_NAME"

if [ "$TRAVIS_BRANCH" == "$RELEASE_BRANCH" ]; then
  ## Push with :latest tag.
  docker push ${DOCKER_USER}/${REPO_NAME}:latest
fi

## Push with branch-specific tag.
docker tag ${DOCKER_USER}/${REPO_NAME}:latest \
            ${DOCKER_USER}/${REPO_NAME}:${TRAVIS_BRANCH}
docker push ${DOCKER_USER}/${REPO_NAME}:${TRAVIS_BRANCH}
