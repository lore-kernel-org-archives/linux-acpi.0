From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v2 0/6]  device property: Introducing software nodes
Date: Fri,  9 Nov 2018 17:21:32 +0300
Message-ID: <20181109142138.54770-1-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

This is the second version of my proposal for "software nodes". There
was a "dereferencing freed memory" bug in patch 3/5 which is now
fixed. device_add_properties() and device_remove_properties() no
longer change places in the code as requested by Andy.

The original RFC can be checked from here:
https://lkml.org/lkml/2018/10/12/518

The origin commit message:

To continue the discussion started by Dmitry [1], this is my proposal
that I mentioned in my last mail. In short, the idea is that instead
of trying to extend the support for the currently used struct
property_set, I'm proposing that we introduce a completely new,
independent type of fwnode, and replace the struct property_set with
it. I'm calling the type "software node" here.

The reason for a complete separation of the software nodes from the
generic property handling code is the need to be able to create the
nodes independently from the devices that they are bind to.

The way this works is that every node that is created will have a
kobject registered. That will take care the ref counting for us, and
also allow us to for example display the properties in sysfs.

There are a few more details in patch 3/5 about the software nodes in
the commit message.

[1] https://lkml.org/lkml/2018/9/17/1067

--
heikki


Heikki Krogerus (6):
  driver core: platform: Remove duplicated device_remove_properties()
    call
  drivers core: Prepare support for multiple platform notifications
  ACPI / glue: Add acpi_platform_notify() function
  drivers: base: Introducing software nodes to the firmware node
    framework
  device property: Move device_add_properties() to swnode.c
  device property: Remove struct property_set

 .../ABI/testing/sysfs-devices-software_node   |  10 +
 drivers/acpi/bus.c                            |   1 -
 drivers/acpi/glue.c                           |  21 +-
 drivers/acpi/internal.h                       |   1 -
 drivers/base/Makefile                         |   2 +-
 drivers/base/core.c                           |  34 +-
 drivers/base/platform.c                       |   1 -
 drivers/base/property.c                       | 511 +------------
 drivers/base/swnode.c                         | 678 ++++++++++++++++++
 include/linux/acpi.h                          |  10 +
 include/linux/property.h                      |  12 +
 11 files changed, 768 insertions(+), 513 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-software_node
 create mode 100644 drivers/base/swnode.c

-- 
2.19.1
