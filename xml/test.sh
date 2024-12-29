line='<root dir="~/todo/xml/" ingress="hello I am root">root'

# Step 1: Split line into pre-`>` and post-`>`
IFS=">" read -r attributes content <<< "$line"

# Step 2: Split the pre-`>` part into an array
IFS=" " read -ra parts <<< "$attributes"

# Step 3: Process and print results
echo "Array: ${parts[@]}"       # [root, dir="~/todo/xml/", ingress="hello I am root"]
echo "Array: ${parts[2]}"
echo "Content: $content"        # root

