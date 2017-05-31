From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v6 0/6] Move firmware specific code to firmware specific locations
Date: Wed, 31 May 2017 15:27:06 +0300
Message-ID: <1496233632-25518-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:26110 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751037AbdEaM2i (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 31 May 2017 08:28:38 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com, kieran.bingham@ideasonboard.com

Hi folks, 

This set moves firmware specific implementations of the device / fwnode 
property API to locations that are specific to firmware implementation, 
still leaving property set (which isn't really firmware) implementation in
drivers/base/property.c.

This set depends on the OF patches here:

<URL:https://git.linuxtv.org/sailus/media_tree.git/log/?h=of>

NOTE: These patches are going in through another tree and may not be
merged yet.

The patches this set and the dependencies may be found with dependencies
here:

<URL:https://git.linuxtv.org/sailus/media_tree.git/log/?h=acpi-graph-cleaned>

since v5:

- Rewrap fwnode_property_read_int_array() to match the layout of the rest
  of the file.

- Add Reviewed-by from Mika.

since v4:

- Address Mika's comments on line wrapping and indentation.

- Order acpi_fwnode_get_parent() according to the list of operations in
  struct fwnode_operations.

- Add patch "device property: Add fwnode_graph_get_port_parent" to the set.

since v3:

- The two first patches have been already merged ("device property: Read
  strings using string array reading functions" and "device property:
  Implement fwnode_get_next_parent()).

- Add "ACPI: Constify argument to acpi_device_is_present()".

- Add patch "device property: Introduce fwnode_device_is_available()".

- Add "device property: Add FW type agnostic fwnode_graph_get_remote_node".

- Rebase on current linux-pm master and fwnode cleanup patchset here:

  <URL:http://www.spinics.net/lists/devicetree/msg177549.html>

- Add KernelDoc documentation for graph_parse_endpoint fwnode operation.

since v2:

- Move patches changing the implementation of reading strings and
  implementing fwnode_get_next_parent() using the fwnode interface alone
  in front of the set. I kept them separate as they do change the
  implementation of these operations.

- Merge patches adding the fwnode_operations and moving the
  implementations of the non-graph portions of the fwnode property API to
  firmware specific locations.

- Merge moving graph operations to the same struct into another patch.
  The graph operations in the ops struct are also added in this patch now.

since v1: 

- Move the three bugfixes in front of the set into a separate patchset. 
There are no dependencies to those from the rest of the patches.

- Rebase on current ACPI graph support patches (themselves on PM tree 
4.11-rc1 merge).

Sakari Ailus (5):
  ACPI: Constify argument to acpi_device_is_present()
  device property: Move FW type specific functionality to FW specific
    files
  device property: Move fwnode graph ops to firmware specific locations
  device property: Introduce fwnode_device_is_available()
  device property: Add FW type agnostic fwnode_graph_get_remote_node

 drivers/acpi/device_pm.c |   4 +-
 drivers/acpi/internal.h  |   2 +-
 drivers/acpi/property.c  | 114 ++++++++++++++++
 drivers/acpi/scan.c      |  10 +-
 drivers/base/property.c  | 332 +++++++++++++++++++----------------------------
 drivers/of/property.c    | 144 ++++++++++++++++++++
 include/linux/acpi.h     |   4 +
 include/linux/fwnode.h   |  67 ++++++++++
 include/linux/of.h       |   2 +
 include/linux/property.h |   3 +
 10 files changed, 472 insertions(+), 210 deletions(-)

-- 
2.7.4
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


Kieran Bingham (1):
  device property: Add fwnode_graph_get_port_parent

Sakari Ailus (5):
  ACPI: Constify argument to acpi_device_is_present()
  device property: Move FW type specific functionality to FW specific
    files
  device property: Move fwnode graph ops to firmware specific locations
  device property: Introduce fwnode_device_is_available()
  device property: Add FW type agnostic fwnode_graph_get_remote_node

 drivers/acpi/device_pm.c |   4 +-
 drivers/acpi/internal.h  |   2 +-
 drivers/acpi/property.c  | 117 ++++++++++++++++
 drivers/acpi/scan.c      |  10 +-
 drivers/base/property.c  | 347 ++++++++++++++++++++---------------------------
 drivers/of/property.c    | 148 ++++++++++++++++++++
 include/linux/acpi.h     |   4 +
 include/linux/fwnode.h   |  69 ++++++++++
 include/linux/of.h       |   2 +
 include/linux/property.h |   5 +
 10 files changed, 501 insertions(+), 207 deletions(-)

-- 
2.7.4

*** BLURB HERE ***

Kieran Bingham (1):
  device property: Add fwnode_graph_get_port_parent

Sakari Ailus (5):
  ACPI: Constify argument to acpi_device_is_present()
  device property: Move FW type specific functionality to FW specific
    files
  device property: Move fwnode graph ops to firmware specific locations
  device property: Introduce fwnode_device_is_available()
  device property: Add FW type agnostic fwnode_graph_get_remote_node

 drivers/acpi/device_pm.c |   4 +-
 drivers/acpi/internal.h  |   2 +-
 drivers/acpi/property.c  | 117 ++++++++++++++++
 drivers/acpi/scan.c      |  10 +-
 drivers/base/property.c  | 348 ++++++++++++++++++++---------------------------
 drivers/of/property.c    | 148 ++++++++++++++++++++
 include/linux/acpi.h     |   4 +
 include/linux/fwnode.h   |  69 ++++++++++
 include/linux/of.h       |   2 +
 include/linux/property.h |   5 +
 10 files changed, 502 insertions(+), 207 deletions(-)

-- 
2.7.4

