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
		keydown_fn: on_keydown
	)

	app.ctx.run()

}

fn on_keydown(key gg.KeyCode, mod gg.Modifier, mut app &App) {

	if key == .w || key == .up {
		app.img.vel.y = -5
	}
	
	if key == .s || key == .down {
		app.img.vel.y = 5
	}

	if key == .a || key == .left {
		app.img.vel.x = -5
	}

	if key == .d || key == .right {
		app.img.vel.x = 5
	}

	else {
		app.img.vel.x = 0
		app.img.vel.y = 0
	}
}

fn init(mut app &App) {

	app.img.img = app.ctx.create_image(os.resource_abs_path(app.file_name))

}

fn (mut app App) draw() {

	app.img.pos += app.img.vel

	app.ctx.draw_image(app.img.pos.x, app.img.pos.y, app.img.img.width, app.img.img.height, app.img.img)

}

fn frame(mut app &App) {
	app.ctx.begin()
	app.draw()
	app.ctx.end()
}
