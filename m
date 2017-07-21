From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v3 0/8] Remove fwnode type field, constify property fwnode arguments
Date: Fri, 21 Jul 2017 14:39:29 +0300
Message-ID: <1500637177-16095-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:16829 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752269AbdGULmi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Jul 2017 07:42:38 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com, erik.veijola@intel.com, andriy.shevchenko@linux.intel.com

Hello everyone,

This set removes the struct fwnode_handle type field and constifies the
fwnode arguments in the fwnode property API more or less the way they are
const in OF property API.

Comments are welcome.

All the dependent patches are now in linux-pm master branch.

<URL:http://www.spinics.net/lists/linux-acpi/msg75957.html>

v1 can be found here:

<URL:http://www.spinics.net/lists/linux-acpi/msg74564.html>

changes since v2:

- Add 8th patch "device property: Introduce
  fwnode_property_get_reference_args". This allows obtaining references
  with integer arguments using the fwnode interface.

  The functionality will be soon needed in adding support for nvmem
  framework on ACPI as well as in referring to e.g. lens and flash devices
  on V4L2.

- Add Rob's ack on "device property: Constify fwnode property API".

changes since v1:

- Rebase and resolve the conflicts. As there is no longer fwnode->type
  field, __irq_domain_add() won't print the wrong type in an error
  message anymore.

- Add patch "device property: Get rid of struct fwnode_handle type field"
  which wasn't merged from set "Move firmware specific code to firmware
  specific locations". Addressed the ACPI static node bug in that patch
  --- static ACPI nodes have NULL ops now, just like the old IRQCHIP type.

- Add patch "ACPI: Use IS_ERR_OR_NULL() instead of non-NULL check in
  is_acpi_data_node" which extends the error code checks for ACPI data
  node. s. This is in line with existing is_acpi_node() and
  is_acpi_device_node().

- Dropped the V4L2 patches from the set; they're better suitable to be
  merged through the media tree. (For more patches touching the same areas
  are being worked on.)

- Rename fwnode argument in to_pset_node() macro as __to_pset_node_fwnode
  in order to avoid masking local variables where the macro is used. (The
  compiler won't warn about this. Ouch.)

- Clean up patch "ACPI: Constify acpi_get_next_subnode() fwnode argument"
  by separating the root device node (adev) from the child device node
  (child_adev, which is const). Also rename the patch as "ACPI: Prepare
  for constifying acpi_get_next_subnode() fwnode argument".

- Squash patch "ACPI: Constify acpi_graph_get_child_prop_value() fwnode
  argument" with "device property: Constify fwnode property API". The
  former makes a change which is interdependent with the changes made by
  latter (for const-ness).

Sakari Ailus (8):
  ACPI: Use IS_ERR_OR_NULL() instead of non-NULL check in
    is_acpi_data_node
  device property: Get rid of struct fwnode_handle type field
  ACPI: Prepare for constifying acpi_get_next_subnode() fwnode argument
  ACPI: Constify acpi_bus helper functions, switch to macros
  ACPI: Constify internal fwnode arguments
  device property: Constify argument to pset fwnode backend
  device property: Constify fwnode property API
  device property: Introduce fwnode_property_get_reference_args

 drivers/acpi/property.c   | 181 +++++++++++++++++++++++++++++-----------------
 drivers/acpi/scan.c       |   3 +-
 drivers/base/property.c   | 131 +++++++++++++++++++++------------
 drivers/of/property.c     |  66 +++++++++++++----
 include/acpi/acpi_bus.h   |  52 +++++++++----
 include/linux/acpi.h      |  68 ++++++++---------
 include/linux/fwnode.h    |  56 ++++++++------
 include/linux/irqdomain.h |   4 +-
 include/linux/of.h        |   3 +-
 include/linux/property.h  |  67 +++++++++--------
 kernel/irq/irqdomain.c    |  10 +--
 11 files changed, 402 insertions(+), 239 deletions(-)

-- 
2.7.4

