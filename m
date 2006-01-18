From: Patrick Mochel <mochel@digitalimplant.org>
Subject: [RFC] Rewriting the ACPI Driver Model
Date: Tue, 17 Jan 2006 18:55:19 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0601171850330.19077-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from digitalimplant.org ([64.62.235.95]:60138 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S964865AbWARCz1
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jan 2006 21:55:27 -0500
Received: from localhost ([127.0.0.9]) by digitalimplant.org for <linux-acpi@vger.kernel.org>; Tue, 17 Jan 2006 18:55:19 -0800
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org



In November 2005, after some discussion with Len Brown and Shaohua Li,
I decided to rewrite the ACPI driver model. After looking at two
previous attempts by Shaohua, and going through 3 revisions myself, I
have posted a series of 219 patches here:

http://kernel.org/pub/linux/kernel/people/mochel/patches/acpi/driver-model/


Unfortunately, the effort is not finished. Not all drivers have been
converted, and all of the old ACPI driver model infrastructure still
exists. There will be more patches coming in the near future, but
under steady urging by Len, I've decided to solicit the work so far
for feedback from the community.

I will not be posting the patches to the mailing list, except under
explicit request. I intend to setup a git tree on kernel.org for
people to pull from, but that will have to wait until tomorrow.

There are a number of things to cover about the patches, so let's get
started..


Justification
-------------

* Personal
  I have honestly been wanting to do this ever since I wrote the 2.5
  driver model. But, a lack of time and motivation has prevented me
  until now. So, this is very much scratching an itch.

* Power Management
  Because ACPI devices are not registered with the global device tree,
  they receive no notification of suspend or resume transitions,
  providing for some nasty and hard-to-fix bugs.

  One example is the button driver that needs the event cleared on
  suspend, if the transition was initiated by a button press. Not
  doing so can cause the system to power off or reset when it resumes
  (because it thinks the button has been pressed then). It is
  literally a 1-line fix that is impossible without the right
  infrastructure.

* User Interface
  Many of us would like to see the /proc/acpi/ interface be removed
  and transition to a sysfs-based interface. These patches provide the
  compatible interface using sysfs so that we may start transitioning
  user space tools to use that instead.

* Driver Maintainability
  Few, if any, of these drivers are actively maintained. That's Ok,
  since ACPI as a whole is actively maintained and most of the drivers
  are not that large. But, the code presents some inhibitors to making
  them lovable:
  - Deviance from kernel coding style (they were written using the
    ACPI coding style, even though they are 100% Linux-specific).
  - Duplicated code, often doing inconsistently
  - Lots of unnecessary code (superflous parameter checks, unused
    variables, etc)

  By rewriting them, cleaning them up, and making them conform they
  should be easier to maintain over time.

* Core Maintainability
  The ACPI driver model was written before the 2.5 Linux Driver Model
  was merged, and even though the existing authors knew that it was
  incompatible, they were not able to update it. As a result, it
  duplicates a lot of functionality that it would get for free if it
  had been adapated to the core driver model.

  By doing this work, the ACPI core driver code becomes much simpler,
  which makes it easier to debug and easier to extend.

* Device Association
  There are many cases where an ACPI object needs to be associated
  with a device discovered by a native Linux driver. This is possible
  today, but the solution is ugly. This work will not make it work,
  but given the architecture and the cleaning up of the code, it
  should make it easier to derive a solution.


Design Philosophy
-----------------

Instead of changing the ACPI driver model and the drivers in place, I
chose to simply create a new driver model on top of the existing
driver model and duplicate each of the drivers in the process of
rewriting them.

While some will cringe on sheer principle, it has a lot of benefits,
mainly centering around the prevention of a) huge patches and b) flag
day changes for the drivers.
- Easier to verify functionality and compatability
- Easier to delineate changes
- Easier to make small, incremental changes to the drivers
- Easier to evolve the new core and convert drivers to solely use that

Once all the drivers are converted, the new core can quickly take on
the functionality of the old core, and unused code can simply vanish.


Coding Style
------------

In rewriting the drivers, I quickly tired of doing the same thing over
and over, so I created a lot of helpers to do things automatically.
These come in two forms:

- Code (functions)
  Most of the drivers implement the same helpers for getting and
  setting values via AML, instead of duplicating the same setup and
  error checking code throughout their drivers. It's a huge win for
  readability.

  Eventually, a central set of helpers that implement this
  functionality and the local versions of each can be deleted. This
  will have the added benefit of centralizing most/all of the access
  to the ACPI CA in the driver model core.

- Declarations (macros)
  Declaring the same functions and structures over and over and over
  and over sucks, especially when they all look the same (or are the
  same!). So, I created an extensive set of macros to help with this.

  Before the pedantic reflex of "macros are evil" in you kicks in,
  please look at them and the drivers which use them. They all rely on
  a small set of syntactic rules in the drivers, but that actually
  enforces consistency across the drivers, which makes them easier to
  understand.


Code Organization
-----------------

I have created the following directory structure, with two special
directories ('core' and 'legacy'):

drivers/acpi/drivers/
|-- ac
|-- battery
|-- button
|-- core
|-- ec
|-- fan
|-- legacy
|-- power
|-- thermal
`-- video


'core' holds the new core driver model code, including:

- device and driver registration
- optional interfaces (event registration)
- filesystem interfaces (proc, sysfs)
- library functions for drivers to use

'legacy' holds all of the current ACPI drivers, which previously
existed as drivers/acpi/*.c. All of the Kconfig options and Make rules
have been moved into that directory.

drivers/acpi/drivers/ contains Kconfig options that enable support of
the new driver model, as well as offer options for enabling optional
interfaces (e.g. proc and sysfs).

Each driver is given its own directory, and in each of (well, most)
directories, you will find the driver split into the following files:

- Makefile		build rules
- Kconfig		configuration options
- <driver.h>		definitions for that driver
- driver.c		driver registration
- device.c		low-level device access (typically via AML)
- event.c		event notification support
- proc.c		legacy-compatible proc interface
- sysfs.c		new sysfs interface

Some drivers have more files (like the ec driver). Some driver
directories actually contain multiple drivers (like video).


I also added a number of header files in include/acpi/. They are each
simple and fairly self-explanatory.

- device.h
- driver.h
- proc.h
- sysfs.h
- event.h
- resource.h


Registration
------------

The ACPI spec wants each object in the namespace to be treated as a
device. We've tended to reject this, for fear of ACPI completely
taking over the device tree. However, this needs to happen to support
ACPI devices (that are only discovered and accessed via the
namespace, which are those that currently have ACPI drivers).

To make those work, I created an ACPI bus type. It works in exactly
the same way some other buses do - It discovers devices (via the
namespace) and binds those devices to drivers that have registered
with it.

This creates a /sys/bus/acpi/, which has all of the devices and
drivers it knows about listed; and a /sys/devices/ACPI/ ("ACPI" there
is the name of the root object) with all of the ACPI devices in their
actual hierarchy underneath. (The code to enable simply this is in the
first few patches and relatively simple.)

The names of each device is the name that is in the namespace. This
will change. It is not to be relied on (since the name for the same
type of device can easily change between two machines).


User Interface
--------------

Because of the registration model above, we can easily convert the
proc interface for each driver to use sysfs for accessing the same
knobs. I have created a sysfs interface for each of the drivers above
(except video) that exports exactly the same values that the proc
interface does, though it uses the 1 value/file mantra.

The best way to view this interface is to access the devices that are
bound to a particular driver, via the symlinks in

      /sys/bus/acpi/<driver>/

Review
------

The most important thing at this time is review of the new code. Each
driver should be checked to verify that it works and that it offers
the same functionality. I have not been able to test every driver,
unfortunately. There are a few main concerns:


* I have taken some liberties with the cleaning of some of the more
obtuse drivers (specifically ec and video).

- I greatly simplified the way the EC locking works, not to mention
  how the different modes of the driver (intr and poll) interact.

- I changed the video device discovery mechanism, which impacts the
  output switching mechanism.

It's very important that someone with more experience than I with
those devices verifies that a) it should work, and b) it does work.

* Under Len's suggestion, we should look at what is exported via
  sysfs. Since we have an opportunity to change it, we should remove
  unnecessary stuff, and add the things we're missing.

* There are a number of FIXMEs and Questions in the comments. Some are
  left over, some are new. We should address those now.

I'm not sure the best way to facilitate the code review. If someone
has a suggestion, please let me know.


Unfinished Business
-------------------

There are many things left to do, most of which I am eager to
finish. They are, in rough order of priority:

- Convert the PCI drivers
- Convert the hotkey driver (pending its own rewrite from Luming)
- Convert the platform drivers (and develop infrastructure to support
  them).
- Convert the processor driver (or at least clean it up)
- Convert the motherboard and container drivers
- Extract common functions from drivers and put into the core
- Implement needed functions from old core in new core
- Pare down / Eliminate old core
- Write userspace utility that verifies information is correct in
  sysfs (compared to proc)

While I will always accept patches, I don't necessarily expect them.
But, if people want to help out, that's what I need.


Thanks,


	Patrick

