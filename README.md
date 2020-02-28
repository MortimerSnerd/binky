# Binky
An experiment with binding to [@raysan5/raylib](https://github.com/raysan5/raylib)
using [Zig](https://github.com/ziglang/zig)

Nothing important, just using the binding to get famliar with Zig.
Raylib looked like a nice simple C library to bind to and play with 
graphics and sound. 

This is not a package meant to be reused at this time.  As I 
understand the packaging mechanism in Zig right now, I would really 
need to wait until more details of the packaging are fleshed out before
this could be packaged as an easily re-usable library.  And once that
happens, I can clean things up and target actual real releases of
Zig and raylib, rather than whatever I happened to grab that day.


## Technical overview, why it may suck.

This needs a post 0.5.0 Zig, mainly for some improvements in translate-c.
I've been using e381a42de9c0f0c5439a926b0ac99026a0373f49 from 
Feb 20, 2020.  This is based on a build raylib master, 
a8a21312e1ed5b938b1d95016e65d9f44c5e7b82, also from Feb 20th. 

The build expects a static `libraylib.a` library in `vendor/lib`.  The
needed include files from the build are under vendor/include.  So you'll 
need to build your own copy of raylib.

The static library doesn't include the implementation for the `physac` or
`raygui` modules, so we include those in our build ourselves in `src/rayimpl.c`
and just reference it in the build.zig. 

Due to a temporary Zig limitation with passing some <= 16 byte
structs by value, we actually have to generate shims to work around
this in a way that the signature of the raylib functions does not change.
So `src/raylib.zig` and `src/rayshims.c` are both generated by `utils/genshims`.
At a high level, we `zig translate-c` the raylib headers to produce a
zig file, remove some cruft, and then run `genshims.zig` on the cleaned
up zig file, which produces the `raylib.zig` and `rayshims.c` files.  
See the `utils/regen_shims.sh` script for details.  

(Side note:  any language that comes with a working parser for itself
gets a free cookie. The `std.zig` parser made shim generation easy, 
and was mostly flawless.  The only hitch I ran into was documented
in the library source code, so maybe Zig gets two cookies).

Once the ABI limitations are lifted in a future, the shim generation 
shouldn't be necessary, unless I want to be fancy and try to detect
the functions that take a `*Something` and a length, and also 
produce an extra function that takes a `[]Something` instead. 
At this time, I've spent more time messing with the shims than 
playing with raylib, so I'm not feeling really fancy at this time.

## Building

If you really waded through all that and built yourself a raylib.a:

    erf$ zig build run

I haven't tried this on any other platform than Linux.  The `build.zig`
is dumb and just supplies Linux/X specific libraries as link targets.
So you'll have work ahead of you if you want to compile on anything else.

## TODOS
- There are some things in raylib.zig that weren't translated, like the 
   color constants, and some of the easing functions.  Some of those
   might be simple fixes for translate\_c. Others may just need to be 
   in the generation script, or manually.
