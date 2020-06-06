#!/usr/bin/env sh
set -x
npm run build
set +x

echo 'The following "npm" command downloads and installs the npm serve module'
set -x
npm install serve
set +x

echo 'The "serve" command has a trailing ampersand so that the command runs'
echo 'as a background process (i.e. asynchronously). Otherwise, this command'
echo 'can pause running builds of CI/CD applications indefinitely.'

set -x
./node_modules/serve/bin/serve.js -c 0 -s build &
sleep 1
echo $! > .pidfile
set +x

echo 'Now...'
echo 'Visit http://localhost:5000 to see your Node.js/React application in action.'
echo '(This is why you specified the "args ''-p 5000:5000''" parameter)'