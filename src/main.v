module main

import gg
import gx
import os

struct Vec2 {
mut:
	x int
	y int
}

fn (a Vec2) + (b Vec2) Vec2 {
	return Vec2{a.x + b.x, a.y + b.y}
}

fn (a Vec2) - (b Vec2) Vec2 {
	return Vec2{a.x - b.x, a.y - b.y}
}


struct Img {
mut:
	img gg.Image
	pos Vec2
	vel Vec2
	size f32
}

struct App {
mut:
	ctx    &gg.Context = unsafe { nil }
	img  Img
	file_name string
}

const (
	win_width = 800
	win_height = 600
)

fn main() {

	mut app := &App{
		ctx: 0,
		file_name: "assets/human.png"
	}

	app.ctx = gg.new_context(
		bg_color: gx.white
		width: win_width
		height: win_height
		create_window: true
		window_title: "Game.v"
		frame_fn: frame
		user_data: app
		init_fn: init
	)

	app.ctx.run()

}

fn init(mut app &App) {

	app.img.img = app.ctx.create_image(os.resource_abs_path(app.file_name))
	app.img.pos = Vec2{60, 60}
	app.img.size = 2
}

fn (mut app App) draw() {
	app.ctx.draw_image(app.img.pos.x, app.img.pos.y, app.img.img.width*app.img.size, app.img.img.height*app.img.size, app.img.img)
}

fn frame(mut app &App) {

	app.img.vel.x = 0
	app.img.vel.y = 0


	if app.ctx.pressed_keys[int(gg.KeyCode.a)] || app.ctx.pressed_keys[int(gg.KeyCode.left)] {
		println("Left key down")
		app.img.vel.x -= 5
	}

	if app.ctx.pressed_keys[int(gg.KeyCode.d)] || app.ctx.pressed_keys[int(gg.KeyCode.right)] {
		println("Right key down")
		app.img.vel.x += 5
	}

	if app.ctx.pressed_keys[int(gg.KeyCode.w)] || app.ctx.pressed_keys[int(gg.KeyCode.up)] {
		println("Up key down")
		app.img.vel.y -= 5
	}

	if app.ctx.pressed_keys[int(gg.KeyCode.s)] || app.ctx.pressed_keys[int(gg.KeyCode.down)] {
		println("Down key down")
		app.img.vel.y += 5
	}
	

	if app.ctx.pressed_keys[int(gg.KeyCode.escape)] {
		exit(0)
	}

	app.img.pos.x += app.img.vel.x
	app.img.pos.y += app.img.vel.y



	app.ctx.begin()
	app.draw()
	app.ctx.end()
}
