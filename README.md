# Grasp

Test with an example screenshot:

    bundle install
    middleman
    open http://localhost:4567/


## Canvas features

* Should see image at 100%, or at least export at 100%
* Pressing 1=move, 2=arrow, 3=ellipse, 4=rectangle, 5=text, etc
* Pressing Ctrl or CMD should toggle move temporarily and revert back
* Free form
* Eraser
* Paint filling intersecting areas
* Update font to someting nicer
* Forms should work in all directions. Example: a rectangle started at 100,100 should be able to make it to { top: 50, left: 50, right: 100, bottom: 100 }
* Choose color
* Choose font-size
* Choose form sizes (widths)

# App features

* Navigating away should prompt to cancel navigation
* Delete should not navigate away

## Server features

* Save and share /screenshot-path.png
* Versioning and always symlink the /screenshot-path.png to the latest revision
* Easy to share URLs in the front-end

## Some nice to have

* Inline text editing, more like Skitch (no textarea)
* Undo - should just be a matter of diposing of objects in the Grasp.Canvas#objects list
* Redo - a little bit more complicated. It's easy enough to keep a stack of removed objects, but adding them again and re-binding the proper events may be a little bit harder.
* Add a fine border around elements like skitch does when they are selected
