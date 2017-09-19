From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 0/2] fwnode property API improvements
Date: Tue, 19 Sep 2017 12:39:10 +0300
Message-ID: <20170919093912.32356-1-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:58458 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751512AbdISJjP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 19 Sep 2017 05:39:15 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: devicetree@vger.kernel.org, robh@kernel.org, frowand.list@gmail.com, mika.westerberg@linux.intel.com, rafael@kernel.org, hverkuil@xs4all.nl

Hi,

This patchset does two things: make fwnode_handle_get() return the node,
just as of_node_get() does, and add a macro for iterating over graph
endpoints. The V4L2 fwnode framework would be a user for the macro.

Sakari Ailus (2):
  device property: Make fwnode_handle_get() return the fwnode
  device property: Add a macro for interating over graph endpoints

 drivers/base/property.c  | 9 +++++++--
 drivers/of/property.c    | 4 ++--
 include/linux/fwnode.h   | 2 +-
 include/linux/property.h | 6 +++++-
 4 files changed, 15 insertions(+), 6 deletions(-)

-- 
2.11.0

