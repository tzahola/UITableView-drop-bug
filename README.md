# UITableView-drop-bug
A bug in iOS 13 where UITableView stops responding to drop interaction

## Description

If a new drag & drop interaction follows a previous drop operation close enough, `UITableView` stops tracking it, even though the dragged items are hovering above the table view. The only way to get the table view start tracking the drag session again, is moving outside of the table view's bounds and then back above the table.

Demonstration:

![demo](UITableView-drop-bug.gif)

## Steps to reproduce

1. Clone this project
1. Run the `UITableViewDropBug` target
1. Drag the view labelled "Drag me!" to the table view a few times, thus filling the table with rows. 
1. When finishing a previous drop, immediately initiate a new drag interaction and drag the item over the table view as quickly as possible.
1. The table view might make some glitchy transition and then the drag session will no longer be tracked by the table view. If you now release the dragged item, the interaction will be cancelled without inserting the next row into the table. However if you now drag the item outside the bounds of the table view, and re-enter the table view's bounds, the drag session will get tracket correctly. 

## Bug report

Reported to Apple as FB7545138.
