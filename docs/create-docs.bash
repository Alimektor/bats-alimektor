#!/usr/bin/env -S bash -e

SRC_DIR="src"
DOCS_DIR="docs"

if ! command -v shdoc &>/dev/null; then
    echo "shdoc is not installed. Please install it using the following command:"
    echo "git clone https://github.com/reconquest/shdoc.git"
    echo "cd shdoc"
    echo "make install"
    exit 1
fi

docs_name=()

echo "Creating docs..."
for src in "${SRC_DIR}"/*.bash; do
    shell_file_name="$(basename "${src}")"
    shell_doc_name="${shell_file_name%.bash}.md"
    echo "Creating ${shell_doc_name}..."
    shdoc <"${src}" >"${DOCS_DIR}/${shell_doc_name}"
    docs_name+=("${shell_doc_name}")
done
echo "Docs created successfully!"

cat >"${DOCS_DIR}/functions.md" <<__MAIN_DOC__
# Functions #

Use the following functions in your tests:

__MAIN_DOC__

for doc in "${docs_name[@]}"; do
    cat >>"${DOCS_DIR}/functions.md" <<EOF
- [${doc}](/${DOCS_DIR}/${doc})
EOF
done
