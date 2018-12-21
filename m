From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Device properties framework updates for v4.21-rc1
Date: Fri, 21 Dec 2018 12:10:10 +0100
Message-ID: <CAJZ5v0ja-twfG-0a7=JewPeyQxc2FmqPaN8Vi5ZVTNDjcFCX8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-acpi@vger.kernel.org

Hi Linus,

This goes early due to the upcoming holidays period.

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 devprop-4.21-rc1

with top-most commit f569da8c994c2254a106bdb537aa271399e288ec

 device property: fix fwnode_graph_get_next_endpoint() documentation

on top of commit 2e6e902d185027f8e3cb8b7305238f7e35d6a436

 Linux 4.20-rc4

to receive device properties framework updates for 4.21-rc1.

These introduce "software nodes" that are analogous to the DT and ACPI
firmware nodes except that they can be created by drivers themselves
and do a couple of assorted cleanups.

Specifics:

 - Introduce "software nodes", analogous to the DT and ACPI firmware
   nodes except that they can be created by kernel code, in order to
   complement fwnodes representing real firmware nodes when they are
   incomplete (for example missing device properties) and to supply
   the primary fwnode when the firmware lacks hardware description
   for a device completely, and replace the "property_set" struct
   fwnode_handle type with software nodes (Heikki Krogerus).

 - Clean up the just introduced software nodes support and fix a comment
   in the graph-handling code (Colin Ian King, Marco Felsch).

Thanks!


---------------

Colin Ian King (1):
      drivers: base: swnode: remove need for a temporary string for
the node name

Heikki Krogerus (6):
      driver core: platform: Remove duplicated device_remove_properties() call
      drivers core: Prepare support for multiple platform notifications
      ACPI / glue: Add acpi_platform_notify() function
      drivers: base: Introducing software nodes to the firmware node framework
      device property: Move device_add_properties() to swnode.c
      device property: Remove struct property_set

Marco Felsch (1):
      device property: fix fwnode_graph_get_next_endpoint() documentation

---------------

 .../ABI/testing/sysfs-devices-software_node        |  10 +
 drivers/acpi/bus.c                                 |   1 -
 drivers/acpi/glue.c                                |  21 +-
 drivers/acpi/internal.h                            |   1 -
 drivers/base/Makefile                              |   2 +-
 drivers/base/core.c                                |  34 +-
 drivers/base/platform.c                            |   1 -
 drivers/base/property.c                            | 513 +---------------
 drivers/base/swnode.c                              | 675 +++++++++++++++++++++
 include/linux/acpi.h                               |  10 +
 include/linux/property.h                           |  12 +
 11 files changed, 766 insertions(+), 514 deletions(-)
