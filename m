From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6.23 regression fix] acpi_ec_remove(): fix use-after-free
Date: Sun, 29 Jul 2007 17:00:37 +0200
Message-ID: <20070729150036.GL16817@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:47885 "EHLO
	mailhub.stusta.mhn.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1764273AbXG2PBA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 Jul 2007 11:01:00 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

This patch fixes an obvious use-after-free introduced by
commit 837012ede14a8fc088be3682c964da7fc6af026b.

Spotted by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---
--- linux-2.6.23-rc1-mm1/drivers/acpi/ec.c.old	2007-07-28 07:59:49.000000000 +0200
+++ linux-2.6.23-rc1-mm1/drivers/acpi/ec.c	2007-07-28 08:00:25.000000000 +0200
@@ -730,14 +730,14 @@
 static int acpi_ec_remove(struct acpi_device *device, int type)
 {
 	struct acpi_ec *ec;
-	struct acpi_ec_query_handler *handler;
+	struct acpi_ec_query_handler *handler, *tmp;
 
 	if (!device)
 		return -EINVAL;
 
 	ec = acpi_driver_data(device);
 	mutex_lock(&ec->lock);
-	list_for_each_entry(handler, &ec->list, node) {
+	list_for_each_entry_safe(handler, tmp, &ec->list, node) {
 		list_del(&handler->node);
 		kfree(handler);
 	}

