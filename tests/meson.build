unit_test_files = [
    'ImageIO/test_Reader.vala'
]

copy = find_program('copy_resources.py')

run_command(
    copy,
    join_paths('images', 'image_1.png'),
    join_paths('images', 'image_1.png')
)

foreach name : unit_test_files
    test(name, executable(name, name, sources, dependencies: dependencies))
endforeach
