From: Tomas Carnecky <tom@dbservice.com>
Subject: [Announce] acpi daemon with support for netlink and evdev events
Date: Wed, 5 Dec 2007 21:24:58 +0000 (UTC)
Message-ID: <47586B71.9020607@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from neopsis.com ([213.239.204.14]:60980 "EHLO
	matterhorn.dbservice.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751880AbXLEVY1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Dec 2007 16:24:27 -0500
Date: Thu, 06 Dec 2007 22:36:49 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: nico-linux-20071129@schottelius.org

   What is it?
  =============

An acpi deamon that processes events from various sources, passes these
to scripts for further processing and also broadcasts dbus events.
Currently it contains drivers for (generic-)netlink and evdev event
sources. Configuration and event processing is done in Lua, a
leightweight scripting language.


   How does it work?
  ===================

Drivers are automatically registered into the daemon when the binary is
loaded into memory. The main executable fist creates a Lua environment
and then loads the event source configuration and the scripts which are
invoked when an event is received. Each event source (called a channel)
is defined by the driver, optional arguments and a function (callback).
In the main function a loop polls on all fd's and waits for events. When
a channel receives a new event, it is first passed to the channel
callback which can perform modifications to the event. Then the event is
passed to all scripts (which are really just Lua functions) in a well
defined order. Each script can abort the execution at any point. In any
case a dbus broadcast even is sent to the system bus.

   What needs to be done?
  ========================

Overall code cleanup, documentation/readme, error checking. Improve the
Lua environment (currently only two useful functions are available),
maybe add the Lua base functions (string, table, coroutine etc.).
Consult with desktop developers if they need a particular functionality
(better adjust the overall design now rather then trying to do it a
hacky way later on).


   What features are missing?
  ============================

I had planed to integrate it more with dbus. One feature I think would
be useful is the ability to schedule actions (as opposed to immediate
invocation of scripts) and the ability to cancel those through dbus. One
particular use-case would be when the user presses the 'sleep' button
and the desktop is performing a task that really shouldn't be
interrupted, then the desktop could cancel or delay the suspend-to-ram
action.


   How do I use it?
  ==================

A bit Lua knowledge is required for writing the scripts! To compile it
you'll need dbus-1 and lua. Compile acpid with 'make', a sample client
application with 'make all'. You'll need to start acpid as root as it
needs to register a name with the system bus. Also make sure to copy the
attached acpi.conf to /etc/dbus-1/system.d/.
You may need to edit config.lua and scripts.lua, but it should work out
of the box. Start acpid from the root directory of the source. If your
computer now generates an acpi event, you should see some output in
stdout. You can also start the client and it will also receive all
events and print those to stdout as well.


   So where can I get the source?
  ================================

Sources are available in a tarball only. You'll see that it also
contains a git repository. Once I figure out how to set up gitweb I'll
be pushing the source to my server.


Questions/Suggestions? Just send me an email.

Nico, I saw your email to the LKML and I thought you might be interested
in my project and source.

tom

PS: I'm not subscribed.. you know the drill.
