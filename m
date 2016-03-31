From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [RFC PATCH 0/4] Add ACPI support for pinctrl configuration
Date: Thu, 31 Mar 2016 14:44:41 +0300
Message-ID: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
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

Irina Tirdea (4):
  pinctrl: Rename pinctrl_utils_dt_free_map to pinctrl_utils_free_map
  pinctrl: pinconf-generic: Add ACPI support
  pinctrl: Add ACPI support
  pinctrl: Parse GpioInt/GpioIo resources

 Documentation/acpi/pinctrl-properties.txt        | 282 ++++++++++++
 drivers/acpi/property.c                          |   8 +-
 drivers/base/property.c                          |  36 +-
 drivers/pinctrl/Makefile                         |   1 +
 drivers/pinctrl/acpi.c                           | 551 +++++++++++++++++++++++
 drivers/pinctrl/acpi.h                           |  32 ++
 drivers/pinctrl/bcm/pinctrl-bcm281xx.c           |   2 +-
 drivers/pinctrl/bcm/pinctrl-cygnus-mux.c         |   2 +-
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c         |   2 +-
 drivers/pinctrl/bcm/pinctrl-nsp-gpio.c           |   2 +-
 drivers/pinctrl/berlin/berlin.c                  |   2 +-
 drivers/pinctrl/core.c                           |  26 ++
 drivers/pinctrl/core.h                           |   2 +
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c    |   4 +-
 drivers/pinctrl/meson/pinctrl-meson.c            |   2 +-
 drivers/pinctrl/nomadik/pinctrl-abx500.c         |   4 +-
 drivers/pinctrl/nomadik/pinctrl-nomadik.c        |   4 +-
 drivers/pinctrl/pinconf-generic.c                | 123 +++--
 drivers/pinctrl/pinctrl-amd.c                    |   2 +-
 drivers/pinctrl/pinctrl-as3722.c                 |   2 +-
 drivers/pinctrl/pinctrl-at91-pio4.c              |   4 +-
 drivers/pinctrl/pinctrl-digicolor.c              |   2 +-
 drivers/pinctrl/pinctrl-lpc18xx.c                |   2 +-
 drivers/pinctrl/pinctrl-palmas.c                 |   2 +-
 drivers/pinctrl/pinctrl-pic32.c                  |   2 +-
 drivers/pinctrl/pinctrl-pistachio.c              |   2 +-
 drivers/pinctrl/pinctrl-tb10x.c                  |   2 +-
 drivers/pinctrl/pinctrl-utils.c                  |   4 +-
 drivers/pinctrl/pinctrl-utils.h                  |   2 +-
 drivers/pinctrl/pinctrl-zynq.c                   |   2 +-
 drivers/pinctrl/pxa/pinctrl-pxa2xx.c             |   2 +-
 drivers/pinctrl/qcom/pinctrl-msm.c               |   2 +-
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c         |   2 +-
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c          |   2 +-
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c         |   2 +-
 drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c          |   2 +-
 drivers/pinctrl/stm32/pinctrl-stm32.c            |   4 +-
 drivers/pinctrl/tegra/pinctrl-tegra-xusb.c       |   2 +-
 drivers/pinctrl/tegra/pinctrl-tegra.c            |   4 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-core.c |   2 +-
 include/linux/acpi.h                             |   4 +-
 include/linux/pinctrl/pinconf-generic.h          |  27 +-
 include/linux/property.h                         |   9 +
 43 files changed, 1063 insertions(+), 114 deletions(-)
 create mode 100644 Documentation/acpi/pinctrl-properties.txt
 create mode 100644 drivers/pinctrl/acpi.c
 create mode 100644 drivers/pinctrl/acpi.h

-- 
1.9.1
