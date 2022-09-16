# chess

Project spec is from https://www.theodinproject.com/lessons/ruby-ruby-final-project

## Description

This is a CLI based chess game. If you want to read about the rules of chess [this](http://www.chessvariants.org/d.chess/chess.html) is an excellent resource. This project was made as the final Ruby project for the [Odin Project](https://theodinproject.com/) Ruby section.

There were a number of new tools and patterns I used in this project. Most notably the Factory and Null Object patterns. It was an opportunity to flesh out my OOP skills, putting to use things like Inheritance and Polymorphism to a degree I hadn't done before. This was also my first experience working with ANSI escape codes, where in the past I had used gems like [colorize](https://github.com/fazibear/colorize)

The largest challenge about this project to me was the scale of it, most projects I have done so far were much smaller, and this is the first project I could really feel the benefits of OOP and effective abstractions.

## Demo

https://user-images.githubusercontent.com/94348738/189549411-3d947951-293c-48b6-b8bd-7432cc90347d.mp4

## Features

All special moves (castling, en passant), all draw conditions (stalemate, repetition, fifty halfmove clock). 

## How To Play

The easiest way to play is on the online [repl](https://replit.com/@kaleobeo/chess#lib/chess.rb), though the best would be to install it. The repl colors may not work properly, and I was not yet able to get rspec working in repl.it. If you clone this repo, do so on Ruby 3.1, it is not compatible with older versions.

After installing, run tests by using \$ rspec, and start the game by using \$ ruby main.rb
