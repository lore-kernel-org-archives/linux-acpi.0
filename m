From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v5 0/5] Move firmware specific code to firmware specific locations
Date: Thu,  4 May 2017 10:14:06 +0300
Message-ID: <1493882051-28814-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:63336 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751764AbdEDHPX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 4 May 2017 03:15:23 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com

Hi folks,

This set moves firmware specific implementations of the device / fwnode 
property API to locations that are specific to firmware implementation, 
still leaving property set (which isn't really firmware) implementation in
drivers/base/property.c.

since v3 (the cover page for v4 was unfortunately lost):

- Rebased on linux-next.

- Depend on "of: Move OF property and graph API from base.c to property.c"
  posted to devicetree list yesterday. My thinking is this would be better
  go through Rob's tree. Thinking about it more, the first patch in this
  set should, too.

- In the old set, patch 1 ("device property: Read strings using string
  array reading functions") has since been merged to linux-pm tree. Patch
  2 ("device property: Implement fwnode_get_next_parent() using fwnode
  interface") was squashed to "device property: Add
  fwnode_get_next_parent()" which is in linux-pm as well.

- Refactor the implementation of fwnode graph operations in order to
  implement basic operations in a firmware specific way separately from
  the common part. In particular, graph_get_remote_port() and
  graph_get_remote_port_parent() have been replaced by
  graph_get_port_parent().

- Added patches 5 and 6 to implement fwnode variant of
  fwnode_graph_get_remote_node() which is seen as a better API for many
  (or most) drivers than the other graph API primitives.

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

<URL:http://www.spinics.net/lists/linux-acpi/msg72895.html>

Sakari Ailus (5):
  of: Add of_graph_get_port_parent() to obtain a port's parent node
  device property: Move FW type specific functionality to FW specific
    files
  device property: Move fwnode graph ops to firmware specific locations
  device property: Introduce fwnode_device_is_available()
  device property: Add FW type agnostic fwnode_graph_get_remote_node

 drivers/acpi/property.c  | 126 ++++++++++++++++++
 drivers/acpi/scan.c      |   1 +
 drivers/base/property.c  | 337 +++++++++++++++++++----------------------------
 drivers/of/property.c    | 197 +++++++++++++++++++++++++--
 include/linux/acpi.h     |   4 +
 include/linux/fwnode.h   |  66 ++++++++++
 include/linux/of.h       |   2 +
 include/linux/property.h |   3 +
 8 files changed, 524 insertions(+), 212 deletions(-)

-- 
2.7.4
