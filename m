From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 0/7] Remove fwnode type field, constify property fwnode arguments
Date: Thu, 13 Jul 2017 16:27:00 +0300
Message-ID: <1499952427-16130-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello everyone,

This set removes the struct fwnode_handle type field and constifies the
fwnode arguments in the fwnode property API more or less the way they are
const in OF property API.

Comments are welcome.

All the dependent patches apart from the fix to the previous fwnode
patches are merged except (which is in linux-pm tree linux-next branch):

<URL:http://www.spinics.net/lists/linux-acpi/msg75957.html>

v1 can be found here:

<URL:http://www.spinics.net/lists/linux-acpi/msg74564.html>

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

Sakari Ailus (7):
  ACPI: Use IS_ERR_OR_NULL() instead of non-NULL check in
    is_acpi_data_node
  device property: Get rid of struct fwnode_handle type field
  ACPI: Prepare for constifying acpi_get_next_subnode() fwnode argument
  ACPI: Constify acpi_bus helper functions, switch to macros
  ACPI: Constify internal fwnode arguments
  device property: Constify argument to pset fwnode backend
  device property: Constify fwnode property API

 drivers/acpi/property.c   | 154 +++++++++++++++++++++++++++-------------------
 drivers/acpi/scan.c       |   3 +-
 drivers/base/property.c   | 103 +++++++++++++++++--------------
 drivers/of/property.c     |  35 ++++++-----
 include/acpi/acpi_bus.h   |  52 +++++++++++-----
 include/linux/acpi.h      |  68 ++++++++++----------
 include/linux/fwnode.h    |  37 +++++------
 include/linux/irqdomain.h |   4 +-
 include/linux/of.h        |   3 +-
 include/linux/property.h  |  63 ++++++++++---------
 kernel/irq/irqdomain.c    |  10 +--
 11 files changed, 293 insertions(+), 239 deletions(-)

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
