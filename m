From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v7 0/6] Move firmware specific code to firmware specific locations
Date: Tue,  6 Jun 2017 12:37:35 +0300
Message-ID: <1496741861-8240-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kieran.bingham-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi folks, 

This set moves firmware specific implementations of the device / fwnode 
property API to locations that are specific to firmware implementation, 
still leaving property set (which isn't really firmware) implementation in
drivers/base/property.c.

This set depends on an immutable branch in Rob's tree here:

git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git dt/property-move

The patches this set and the dependencies may be found with dependencies
here:

<URL:https://git.linuxtv.org/sailus/media_tree.git/log/?h=acpi-graph-cleaned>

since v6:

- Move changes intended to be in patch 2 from patch 3. This was related to
  NULL-safe of_fwnode_handle(). No other changes.

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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
