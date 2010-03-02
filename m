From: Chase Douglas <chase.douglas@ubuntu.com>
Subject: [PATCH] Reduce ACPI resource conflict message to KERN_INFO
Date: Tue,  2 Mar 2010 16:09:12 -0500
Message-ID: <1267564152-11048-1-git-send-email-chase.douglas@ubuntu.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:40526 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453Ab0CBVJP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Mar 2010 16:09:15 -0500
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1NmZL8-0004fC-Cy
	for <linux-acpi@vger.kernel.org>; Tue, 02 Mar 2010 21:09:14 +0000
Received: from cpe-98-31-46-159.woh.res.rr.com ([98.31.46.159] helo=canonical.com)
	by hutte.canonical.com with esmtpsa (TLS-1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.69)
	(envelope-from <chase.douglas@canonical.com>)
	id 1NmZL8-00007c-4x
	for linux-acpi@vger.kernel.org; Tue, 02 Mar 2010 21:09:14 +0000
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

Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
---
 drivers/acpi/osl.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 02e8464..9689b68 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1151,11 +1151,9 @@ int acpi_check_resource_conflict(const struct resource *res)
 
 	if (clash) {
 		if (acpi_enforce_resources != ENFORCE_RESOURCES_NO) {
-			printk("%sACPI: %s resource %s [0x%llx-0x%llx]"
+			printk(KERN_INFO "ACPI: %s resource %s [0x%llx-0x%llx]"
 			       " conflicts with ACPI region %s"
 			       " [0x%llx-0x%llx]\n",
-			       acpi_enforce_resources == ENFORCE_RESOURCES_LAX
-			       ? KERN_WARNING : KERN_ERR,
 			       ioport ? "I/O" : "Memory", res->name,
 			       (long long) res->start, (long long) res->end,
 			       res_list_elem->name,
-- 
1.6.3.3

