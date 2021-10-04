copy = find_program('copy_resources.py')

run_command(
    copy,
    join_paths('images', 'image_1.png'),
    join_paths('images', 'image_1.png')
)

test('Reader', executable('Reader', 'ImageIO/test_Reader.vala', sources, dependencies: dependencies))
test('Writer', executable('Writer', 'ImageIO/test_Writer.vala', sources, dependencies: dependencies))
