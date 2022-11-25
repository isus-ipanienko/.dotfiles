VOLUME="$(pamixer --get-volume-human)"

while [[ -z "$VOLUME" ]]
do
    sleep 1
    VOLUME="$(pamixer --get-volume-human)"
done

if [ "$VOLUME" = "muted" ]; then
    VOLUME="MUT"
fi

echo "$VOLUME"
