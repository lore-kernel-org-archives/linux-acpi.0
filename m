From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/19] ACPI: power: update error message
Date: Sat, 16 May 2009 02:02:01 -0400
Message-ID: <ddc50b6ad634d9ce2526a777d4b7da80effdfb60.1242453625.git.len.brown@intel.com>
References: <1242453736-20763-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:28805 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbZEPGCV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 May 2009 02:02:21 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KJQ00AZ93FWWHRC@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 16 May 2009 01:02:21 -0500 (CDT)
In-reply-to: <1242453736-20763-1-git-send-email-lenb@kernel.org>
In-reply-to: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
References: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

"Transitioning device [%s] to D%d" is not correct.
We print this line when we attempted to transition
the device, and it failed.

So instead, print
"Device [%s] failed to transition to D%d\n"

This can happen under two conditions:

1. acpi_power_transition() fails when trying to handle the
   _ON/_OFF for associated power resource.

2. acpi_evaluate_object() on the explicit _PS0/_PS3
   for that actual device could fail.

this change clarifies, but doesn't fix
http://bugzilla.kernel.org/show_bug.cgi?id=13243

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index e8f7b64..ae862f1 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -312,7 +312,7 @@ int acpi_bus_set_power(acpi_handle handle, int state)
       end:
 	if (result)
 		printk(KERN_WARNING PREFIX
-			      "Transitioning device [%s] to D%d\n",
+			      "Device [%s] failed to transition to D%d\n",
 			      device->pnp.bus_id, state);
 	else {
 		device->power.state = state;
-- 
1.6.0.6

