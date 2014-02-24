# Suffix for missing options.
error_suffix='Please add this option to the wercker.yml or add a heroku deployment target on the website which will set these options for you.'
exit_code_push=0
exit_code_run=0

# Install heroku toolbelt if needed
if ! type heroku &> /dev/null ;
then
    info 'heroku toolbelt not found, starting installing it'

    #cd $TMPDIR
    # result=$(sudo wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh)

    sudo apt-get update
    sudo apt-get install -y ruby1.9.1 git-core
    result=$(sudo dpkg -i $WERCKER_STEP_ROOT/foreman-0.60.0.deb $WERCKER_STEP_ROOT/heroku-3.2.0.deb $WERCKER_STEP_ROOT/heroku-toolbelt-3.2.0.deb)

    if [[ $? -ne 0 ]];then
        warning $result
        fail 'heroku toolbelt installation failed';
    else
        info 'finished heroku toolbelt installation';
    fi
else
    info 'heroku toolbelt is available, and will not be installed by this step'
    debug "type heroku: $(type heroku)"
    debug "heroku version: $(heroku --version)"
fi

if [ -n "$WERCKER_FOREMAN_RUN" ]
then
    if [ -n "$WERCKER_FOREMAN_OPTIONS" ]
        options=""
    then
        options=$WERCKER_FOREMAN_OPTIONS
    run_command="$WERCKER_FOREMAN_RUN"

    debug "starting heroku run $run_command"
    foreman $options run "$run_command"
    exit_code_run=$?
fi

# Validate git run
if [ $exit_code_run -ne 0 ]
then
    fail 'foreman run failed'
fi
