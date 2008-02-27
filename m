From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] ACPI: Fix a duplicate log level
Date: Wed, 27 Feb 2008 20:56:01 +0100
Message-ID: <20080227205601.4c65ed1c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-dmz-233-wednesday.dmz.nerim.net ([195.5.254.233]:64147
	"EHLO kellthuzad.dmz.nerim.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755370AbYB0T6K (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Feb 2008 14:58:10 -0500
Received: from kraid.nerim.net (smtp-103-wednesday.nerim.net [62.4.16.103])
	by kellthuzad.dmz.nerim.net (Postfix) with ESMTP id 232F913DE0
	for <linux-acpi@vger.kernel.org>; Wed, 27 Feb 2008 20:57:59 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/acpi/osl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.25-rc3.orig/drivers/acpi/osl.c	2008-02-16 10:37:18.000000000 +0100
+++ linux-2.6.25-rc3/drivers/acpi/osl.c	2008-02-27 19:08:01.000000000 +0100
@@ -1237,7 +1237,7 @@ int acpi_check_resource_conflict(struct 
 
 	if (clash) {
 		if (acpi_enforce_resources != ENFORCE_RESOURCES_NO) {
-			printk(KERN_INFO "%sACPI: %s resource %s [0x%llx-0x%llx]"
+			printk("%sACPI: %s resource %s [0x%llx-0x%llx]"
 			       " conflicts with ACPI region %s"
 			       " [0x%llx-0x%llx]\n",
 			       acpi_enforce_resources == ENFORCE_RESOURCES_LAX


-- 
Jean Delvare
