From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v2 0/4] device property: Add fwnode_get_name() helper
Date: Thu,  8 Nov 2018 19:51:52 +0300
Message-ID: <20181108165156.60073-1-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

This is the second version of my proposal for this helper. The
first version can be checked here:
https://lkml.org/lkml/2018/11/5/326

In order to support also ACPI properly, I decided to change the API.
The function fwnode_name() is now fwnode_get_name(), and instead of
returning pointer to the name, the function copies it to a buffer. I
did that because acpica does not offer a way to get a pointer to the
node name, and the name is clearly expected to be accessed only with
the namespace lock held.

I think this is better approach in any case. It will also solve the
problem of getting rid of the unit-address part from DT node names.

Let me know what you guys think.

--
heikki


Heikki Krogerus (4):
  device property: Introduce fwnode_get_name()
  ACPI: property: Add acpi_fwnode_name()
  of/property: Add of_fwnode_name()
  device property: Drop get_named_child_node callback

 drivers/acpi/property.c  | 43 ++++++++++++++++++++++------------------
 drivers/base/property.c  | 34 ++++++++++++++++++++++++++++++-
 drivers/of/property.c    | 26 ++++++++++--------------
 include/linux/fwnode.h   |  6 +++---
 include/linux/property.h |  2 ++
 5 files changed, 73 insertions(+), 38 deletions(-)

-- 
2.19.1
