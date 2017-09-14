From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [RFC 0/5] Align and document return values of phandle and reference parsing for OF and ACPI
Date: Thu, 14 Sep 2017 15:29:09 +0300
Message-ID: <20170914122914.14122-1-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:32838 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751740AbdINM3Q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 Sep 2017 08:29:16 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: rafael@kernel.org, robh@kernel.org, mika.westerberg@linux.intel.com, frowand.list@gmail.com

Hi everyone,

I recently came across a difference in behaviour of OF phandle parsing and
ACPI reference parsing, both of which can soon be accessed using
fwnode_property_get_reference_args.

The main change in this proposal touches OF, and specifically the change
is about using -ENODATA to tell that the phandle reference list entry that
was accessed does not exist. -ENOENT was used previously, but the same
error code was also used to tell that a phandle was empty, making it
impossible for the caller to figure out which of the two was the case.

I'm sending the set as RFC. In my limited testing I have found no ill
effects.

These patches are on top of linux-next.

Comments on the approach and the changes themselves would be most welcome.

For what it's worth, fwnode_property_get_reference_args is in Rafael's
tree (as well as in linux-next) and hasn't reached mainline yet. It will
be used in the near future for parsing references to external devices in
the V4L2 framework.

These patches can be found here:

<URL:https://git.linuxtv.org/sailus/media_tree.git/log/?h=fwnode-parse>

Regards,

- Sakari

Sakari Ailus (5):
  clk: Increment assigned-clocks index for empty phandles
  of: Return -ENODATA on accessing out of bounds indices in phandle
    parsing
  of: Return total number of entries in of_count_phandle_with_args
  ACPI: align acpi_fwnode_get_reference_args with OF counterpart
  device property: Document fwnode_property_get_reference_args better

 drivers/acpi/property.c              |  3 +++
 drivers/base/power/domain.c          |  2 +-
 drivers/base/property.c              |  5 +++++
 drivers/clk/clk-conf.c               |  8 +++++---
 drivers/clk/clkdev.c                 |  2 +-
 drivers/gpio/gpiolib-of.c            |  2 +-
 drivers/gpio/gpiolib.c               |  2 +-
 drivers/gpu/host1x/mipi.c            |  2 +-
 drivers/hwspinlock/hwspinlock_core.c |  2 +-
 drivers/iio/inkern.c                 |  2 +-
 drivers/of/base.c                    | 37 ++++++++++++++++++++++++------------
 drivers/pwm/core.c                   |  2 +-
 drivers/regulator/gpio-regulator.c   |  2 +-
 drivers/reset/core.c                 |  3 ++-
 drivers/spi/spi.c                    |  2 +-
 15 files changed, 50 insertions(+), 26 deletions(-)

-- 
2.11.0

