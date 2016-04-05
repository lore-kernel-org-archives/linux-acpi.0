From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [RFC PATCH v2 0/3] Add ACPI support for pinctrl configuration
Date: Tue,  5 Apr 2016 18:33:23 +0300
Message-ID: <1459870406-15219-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Octavian Purdila <octavian.purdila@intel.com>, Cristina Ciocan <cristina.ciocan@intel.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>
List-Id: linux-acpi@vger.kernel.org

This is a proposal for adding ACPI support for pin controller
configuration.

It has been developed to enable the MinnowBoard and IoT community
by providing an easy way to specify pin multiplexing and
pin configuration.

This proposal is based on using _DSD properties to specify device
states and configuration nodes and it follows closely the device
tree model. Device states are defined using the Device Properties
format and the configuration nodes are defined using the
Hierarchical Properties Extension format. The generic properties
for the configuration nodes are the same as the ones for device
tree, while pincontroller drivers can also define custom ones.

Changes from v1:
 - address code review comments regarding coding style, documentation
and fixes
 - rewrote patch 3 ("pinctrl: Parse GpioInt/GpioIo resources") to
avoid using triple pointers
 - define pinconf_generic_dt_node_to_map since it is used by pinctrl
sirf driver
 - add dependency on PINCONF_GENERIC to the entire ACPI parsing code
 - dropped first patch from the series since it got merged
("pinctrl: Rename pinctrl_utils_dt_free_map to pinctrl_utils_free_map")

Irina Tirdea (3):
  pinctrl: pinconf-generic: Add ACPI support
  pinctrl: Add ACPI support
  pinctrl: Parse GpioInt/GpioIo resources

 Documentation/acpi/pinctrl-properties.txt | 292 +++++++++++++++++
 drivers/acpi/property.c                   |   8 +-
 drivers/base/property.c                   |  36 ++-
 drivers/pinctrl/Makefile                  |   1 +
 drivers/pinctrl/acpi.c                    | 519 ++++++++++++++++++++++++++++++
 drivers/pinctrl/acpi.h                    |  32 ++
 drivers/pinctrl/core.c                    |  26 ++
 drivers/pinctrl/core.h                    |   2 +
 drivers/pinctrl/pinconf-generic.c         | 121 ++++---
 include/linux/acpi.h                      |   4 +-
 include/linux/pinctrl/pinconf-generic.h   |  35 +-
 include/linux/property.h                  |   9 +
 12 files changed, 1010 insertions(+), 75 deletions(-)
 create mode 100644 Documentation/acpi/pinctrl-properties.txt
 create mode 100644 drivers/pinctrl/acpi.c
 create mode 100644 drivers/pinctrl/acpi.h

-- 
1.9.1
