import sys
import re
import slugify

def parse_line(line):
    image_folder = "Image"
    if line.startswith('! '):
        return '## ❗: ' + line[2:]
    elif line.startswith('IMAGE'):
        if line[5:].startswith('_P:'):
            fn = line[8:].replace(' ', '%20').replace('\n', '')
        else:
            fn = line[6:].replace(' ', '%20').replace('\n', '')
        return '![' + './' + image_folder + '/' + fn + '](' + image_folder + '/' + fn + ')\n\n'
    elif line.startswith('['):
        section = "# "
        a = line[1:].split(']')
        section += a[1]
        return section
    elif line.startswith('GOTO'):
        if line[4:].startswith('_P:'):
            content = line[6:].strip()
        else:
            content = line[4:].strip()
        
        match = re.search(r'\\?\[([^\]]+)\]', content)
        if match:
            section = match.group(1).replace('\\', '')
            title_start = match.end()
            title = content[title_start:].strip()
            slug = slugify.slugify(title)
            return f'[{section}. {title}](#{slug})\n\n'
        else:
            return '## ' + content
    else:
        return line


if __name__ == '__main__':
    if len(sys.argv) < 3:
        print("Usage: python Me_Note2Markdown.py <input_file> <output_file>")
        sys.exit(1)
    buffer = []
    with open(sys.argv[1], 'r', encoding="utf8") as f:
        lines = f.readlines()
        if lines[0] != '//Table of contents\n':
            sys.exit(1)
        for line in lines[1:]:
            buffer.append(parse_line(line))
    with open(sys.argv[2], 'w', encoding="utf8") as f:
        f.writelines(buffer)