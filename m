From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v2 0/6] Device property improvements, add %pfw format specifier
Date: Tue, 26 Mar 2019 14:41:00 +0200
Message-ID: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, rafael@kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi all,

This set adds functionality into the device property API (counting a
node's parents as well as obtaining its name) in order to support printing
fwnode names using a new conversion specifier "%pfw". The names that are
produced are equivalent to its OF counterpart "%pOF" on OF systems for the
two supported modifiers ("f" and "P").

Printing a node's name is something that's been available on OF for a long
time and if something is converted to device property API (such as the
V4L2 fwnode framework) it always got removed of a nice feature that was
sometimes essential in debugging. With this set, that no longer is the
case.

This set depends on a cleanup fully releasing the now-deprecated %pf for
other use:

<URL:https://lore.kernel.org/lkml/20190325211906.GA24180@google.com/T/#t>

I was a bit hesitant on how much of this should be covered by the fwnode
ops and how much would be just better to reside in lib/vsprintf.c, but
opted for putting it to the fwnode interface. This keeps it clean in
vsprintf.c and still rather lean on the fwnode ops side while making it
possible to add other firmware types (although that is unlikely I guess).

since v1:

- Add patch to remove support for %pf and %pF (depends on another patch
  removing all use of %pf and %pF) (now 4th patch)

- Fix kerneldoc argument documentation for fwnode_get_name (2nd patch)

- Align kerneldoc style with the rest of drivers/base/property.c (no extra
  newline after function name)

- Make checkpatch.pl complain about "%pf" not followed by "w" (6th patch)

- WARN_ONCE() on use of invalid conversion specifiers ("%pf" not followed
  by "w")

Sakari Ailus (6):
  device property: Add functions for accessing node's parents
  device property: Add fwnode_get_name for returning the name of a node
  device property: Add a function to obtain a node's prefix
  lib/vsprintf: Remove support for %pF and %pf in favour of %pS and %ps
  lib/vsprintf: Make use of fwnode API to obtain node names and
    separators
  lib/vsprintf: Add %pfw conversion specifier for printing fwnode names

 Documentation/core-api/printk-formats.rst |  34 +++++++---
 drivers/acpi/property.c                   |  46 ++++++++++++++
 drivers/base/property.c                   |  82 +++++++++++++++++++++---
 drivers/of/property.c                     |  16 +++++
 include/linux/fwnode.h                    |   4 ++
 include/linux/property.h                  |   5 ++
 lib/vsprintf.c                            | 101 +++++++++++++++++++++---------
 scripts/checkpatch.pl                     |   4 +-
 8 files changed, 245 insertions(+), 47 deletions(-)

-- 
2.11.0
