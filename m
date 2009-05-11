From: yakui_zhao <yakui.zhao@intel.com>
Subject: [PATCH]: ACPI: Cleanup in ACPI device power state transition
Date: Mon, 11 May 2009 09:24:36 +0800
Message-ID: <1242005076.3773.133.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:2504 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756342AbZEKBW2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 10 May 2009 21:22:28 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

From: Zhao Yakui <yakui.zhao@intel.com>

Cleanup in the function of acpi device power state transition.
When the ACPI device can't be transited to the target D-state, OS should report 
the warning message of "Failure in transiting device [%s] to D%d state" instead
of "Transiting device[%s] to D%d state".

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/bus.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/bus.c
===================================================================
--- linux-2.6.orig/drivers/acpi/bus.c	2009-05-11 08:57:49.000000000 +0800
+++ linux-2.6/drivers/acpi/bus.c	2009-05-11 09:16:27.000000000 +0800
@@ -321,7 +321,7 @@
       end:
 	if (result)
 		printk(KERN_WARNING PREFIX
-			      "Transitioning device [%s] to D%d\n",
+			      "Failure in transiting device [%s] to D%d\n",
 			      device->pnp.bus_id, state);
 	else {
 		device->power.state = state;


