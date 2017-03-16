From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v3 0/4] Move firmware specific code to firmware specific       locations
Date: Thu, 16 Mar 2017 15:34:45 +0200
Message-ID: <1489671289-20406-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:47336 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752384AbdCPNfv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 16 Mar 2017 09:35:51 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

Hi folks,

This set moves firmware specific implementations of the device / fwnode 
property API to locations that are specific to firmware implementation, 
still leaving property set (which isn't really firmware) implementation in
drivers/base/property.c.

The set depends on the ACPI graph support v5 (10/13 v5.1) patches I posted
a moment ago.

The patches may be found with dependencies here:

<URL:https://git.linuxtv.org/sailus/media_tree.git/log/?h=acpi-graph-cleaned>

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

--
Kind regards, 
Sakari

