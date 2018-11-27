From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v4 0/3] device property: Add fwnode_get_name() helper
Date: Tue, 27 Nov 2018 17:28:51 +0300
Message-ID: <20181127142855.73899-1-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I'm now returning -EOVERFLOW if the buffer is not big enough as
proposed by Andy.

This is the cover letter from v3:

This is the third version of my proposal for this helper. The
second version can be checked here:
https://lkml.org/lkml/2018/11/8/1005

I'm now passing the length as proposed by both Rob and Andy. I'm also
leaving the .get_named_child_node fwnode op untouched.

--
heikki


Heikki Krogerus (4):
  device property: Introduce fwnode_get_name()
  ACPI: property: Add acpi_fwnode_name()
  of/property: Add of_fwnode_name()
  driver core: Add fwnode member to struct device_connection

 drivers/acpi/property.c  | 28 ++++++++++++++++++++++++++++
 drivers/base/property.c  | 36 ++++++++++++++++++++++++++++++++++++
 drivers/of/property.c    | 13 +++++++++++++
 include/linux/device.h   |  6 ++++++
 include/linux/fwnode.h   |  3 +++
 include/linux/property.h |  2 ++
 6 files changed, 88 insertions(+)

-- 
2.19.2
