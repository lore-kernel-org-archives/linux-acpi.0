From: Chase Douglas <chase.douglas@ubuntu.com>
Subject: [PATCH] Reduce ACPI resource conflict message to KERN_INFO, printf cleanup
Date: Wed,  3 Mar 2010 11:21:34 -0500
Message-ID: <1267633294-21815-1-git-send-email-chase.douglas@ubuntu.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:47541 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502Ab0CCQVk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Mar 2010 11:21:40 -0500
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1NmrKN-0003YN-65
	for <linux-acpi@vger.kernel.org>; Wed, 03 Mar 2010 16:21:39 +0000
Received: from cpe-98-31-46-159.woh.res.rr.com ([98.31.46.159] helo=canonical.com)
	by hutte.canonical.com with esmtpsa (TLS-1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.69)
	(envelope-from <chase.douglas@canonical.com>)
	id 1NmrKM-0003pM-TG
	for linux-acpi@vger.kernel.org; Wed, 03 Mar 2010 16:21:39 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

From: Chase Douglas <chase.douglas@canonical.com>

By default, ACPI resource conflict messages are logged at level
KERN_ERR. This is a rather high level for a message that is more a
warning than an indication of a real kernel error. Also, KERN_ERR level
messages can appear over some boot splash screens, and this message is
not serious enough to warrant such treatment. Thus, the log level has
been reduced to KERN_INFO.

Also, cleanup message to use %pR resource printing format.

Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
---
 drivers/acpi/osl.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 02e8464..33a01cb 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1151,16 +1151,10 @@ int acpi_check_resource_conflict(const struct resource *res)
 
 	if (clash) {
 		if (acpi_enforce_resources != ENFORCE_RESOURCES_NO) {
-			printk("%sACPI: %s resource %s [0x%llx-0x%llx]"
-			       " conflicts with ACPI region %s"
-			       " [0x%llx-0x%llx]\n",
-			       acpi_enforce_resources == ENFORCE_RESOURCES_LAX
-			       ? KERN_WARNING : KERN_ERR,
-			       ioport ? "I/O" : "Memory", res->name,
-			       (long long) res->start, (long long) res->end,
-			       res_list_elem->name,
-			       (long long) res_list_elem->start,
-			       (long long) res_list_elem->end);
+			printk(KERN_INFO "ACPI: resource %s %pR"
+			       " conflicts with ACPI region %s %pR\n",
+			       res->name, res, res_list_elem->name,
+			       res_list_elem);
 			if (acpi_enforce_resources == ENFORCE_RESOURCES_LAX)
 				printk(KERN_NOTICE "ACPI: This conflict may"
 				       " cause random problems and system"
-- 
1.6.3.3

