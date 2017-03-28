From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v6 00/12] ACPI graph support
Date: Tue, 28 Mar 2017 10:52:15 +0300
Message-ID: <1490687547-18311-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:13642 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754656AbdC1HxX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Mar 2017 03:53:23 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, rafael@kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com

Hello everyone,

Rafael: this set has no external dependencies, it can be applied without
the two other sets. Tested with the V4L2 fwnode patches both on ACPI and
DT. I'll still address Mika's comments in the bugfix set and repost the
other patch with dependency information.

The patches apply on both v4.11-rc1 and linux-next. I'd like to base my
V4L2 patches on this set; could you create me an immutable branch on
v4.11-rc1 when you apply the patches, please? The rest of the patches are
not needed for here since they make no interface changes to the fwnode
framework.

Thanks.


This is the sixth version of the ACPI graph support patchset.

The previous RFC version of the set is available here:

<URL:http://www.spinics.net/lists/linux-acpi/msg69547.html> 

There are also v1, v2, v3, v4 and v5 which can be found here:

<URL:http://www.spinics.net/lists/linux-acpi/msg71661.html>
<URL:http://www.spinics.net/lists/linux-acpi/msg71809.html>
<URL:http://www.spinics.net/lists/linux-acpi/msg72171.html>
<URL:http://www.spinics.net/lists/linux-acpi/msg72346.html>
<URL:http://www.spinics.net/lists/linux-acpi/msg72641.html>

This set contains patches written by Mika Westerberg and by myself. The 
patchset brings support for graphs to ACPI. The functionality achieved by 
these patches is very similar to what the Device tree provides: the port
and the endpoint concept are being employed. The patches make use of the
_DSD property and data extensions to achieve this. The fwnode interface is
extended by graph functionality; this way graph information originating 
from both OF and ACPI may be accessed using the same interface, without 
being aware of the underlying firmware interface. 

The last patch of the set contains ASL documentation including an example.

The entire set may also be found here (on mediatree.git master, but it
also applies cleanly on linux-next):

<URL:https://git.linuxtv.org/sailus/media_tree.git/log/?h=acpi-graph> 

The resulting fwnode graph interface has been tested using V4L2 async with
fwnode matching and smiapp and omap3isp drivers, with appropriate changes 
to make use of the fwnode interface in drivers.

I'm additionally moving the firmware implementation specific code from
drivers/base/property.c to firmware specific locations. I'll post that
patchset soon. It'll be available here:

<URL:https://git.linuxtv.org/sailus/media_tree.git/log/?h=acpi-graph-cleaned>

The V4L2 patches can be found here. The fwnode graph interface is used by 
the newly added V4L2 fwnode framework which replaces the V4L2 OF
framework, with equivalent functionality. 

<URL:https://git.linuxtv.org/sailus/media_tree.git/log/?h=v4l2-acpi>

changes since v5.1:

- Drop patch "of: Add nop implementation of of_get_next_parent()". It is
  no longer needed.

changes since v5:

- Read the "endpoint" property on ACPI to read the endpoint number instead
  of relying on the index.

- Call fwnode_get_parent() to get the parent, independently of the FW           
  type. In other words, squashed "device property: Implement                    
  fwnode_get_next_parent() using fwnode interface" to this one.                 

- Clarify port and endpoint node object naming. Using both port and endpoint    
  cleanly resolves object naming by using the appropriate port and              
  endpoint numbers.                                                             
                                                                                
- Endpoint node numbers are unique within a port, not an endpoint.              

changes since v4:

- Use port and endpoint numbers in references. This is more reliable, as
  the port and endpoint numbers are more stable than their location in the
  data extension array. Because of this, also require the "endpoint"
  property to be there. The documentation (the last patch) is changed
  accordingly.

- Move dev_fwnode() implementation back to property.c where it was.
  EXPORT_SYMBOL_GPL() it, and add a prototype in include/linux/property.h.
  This removes the need for patches "[PATCH v4 10/16] irqchip/gic: Add
  missing forward declaration for struct device" and "of: No need to
  include linux/property.h, linux/fwnode.h is sufficient".

- Fix fwnode_graph_parse_endpoint() KernelDoc documentation.

- Add documentation for struct fwnode_endpoint.

- Removed patch "[PATCH v4 09/16] driver core: Arrange headers
  alphabetically" from the set.

changes since v3:

- Rebase on current PM tree including 4.11-rc1 merge --- there were a few
  conflicts.

changes since v2.2:

- Drop device_fwnode_handle() function in favour of moving the existing
  dev_fwnode() function from drivers/base/property.c to linux/property.h
  (now patch 12).

- Unmerge two unrelated patches accidentally merged between RFC v1 and
  PATCH v1 of the series. The patch adding device_fwnode_handle() was
  accidentally merged with "device property: Obtain device's fwnode
  independently of FW type".

- Remove redundant forward declaration of struct device in
  linux/property.h.

changes since v2:

- Include linux/property.h for property fwnode API in additional drivers
  (current patch 11).

changes since v1: 

- Fix a few checkpatch.pl warnings in Mika's patches (too long lines),

- remove the "endpoint" property specifying the endpoint id. The endpoint 
id is a software concept and the index in the endpoint array can be used
instead if needed. The changes are in patches "device property: Add 
support for fwnode endpoints" and "ACPI / DSD: Document references, 
ports and endpoints" and

- add patch "irqchip/gic: Add missing forward declaration for 
struct device" (patch 9) to fix compilation warning on arm64 caused 
by "of: No need to include linux/property.h, linux/fwnode.h is
sufficient" (now patch 10)

changes since RFC v1: 

- Rebased the set --- there were a few conflicts. 

- Fixed a bug in ACPI graph parsing. (Thanks to Mika!)

- Remove one layer (the "ports" node) of the _DSD hierarchical data 
structure. Change the documentation accordingly. Instead, rely on the 
presence of "port" and "endpoint" properties to identify port and 
endpoint nodes. 

- Add a reference the DSD property rule document [1].


Mika Westerberg (6):
  ACPI / property: Add possiblity to retrieve parent firmware node
  device property: Add fwnode_get_parent()
  ACPI / property: Add fwnode_get_next_child_node()
  device property: Add fwnode_get_named_child_node()
  ACPI / property: Add support for remote endpoints
  device property: Add support for remote endpoints

Sakari Ailus (6):
  device property: Add fwnode_handle_get()
  of: Add of_fwnode_handle() to convert device nodes to fwnode_handle
  device property: Make dev_fwnode() public
  device property: Add support for fwnode endpoints
  device property: Add fwnode_get_next_parent()
  ACPI / DSD: Document references, ports and endpoints

 Documentation/acpi/dsd/graph.txt | 162 +++++++++++++++++++++++
 drivers/acpi/property.c          | 237 +++++++++++++++++++++++++++++----
 drivers/base/property.c          | 275 +++++++++++++++++++++++++++++++++++++--
 include/acpi/acpi_bus.h          |   1 +
 include/linux/acpi.h             |  38 +++++-
 include/linux/fwnode.h           |  12 ++
 include/linux/of.h               |   4 +
 include/linux/property.h         |  26 ++++
 8 files changed, 712 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/acpi/dsd/graph.txt

-- 
Kind regards,
Sakari
