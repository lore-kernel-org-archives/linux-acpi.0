From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH for linus tree] ACPI: remove duplicated lines of merging problems with acpi_processor_add
Date: Tue,  7 Feb 2012 08:20:37 -0800
Message-ID: <1328631637-9488-2-git-send-email-yinghai@kernel.org>
References: <1328631637-9488-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:25166 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754126Ab2BGQVL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Feb 2012 11:21:11 -0500
In-Reply-To: <1328631637-9488-1-git-send-email-yinghai@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-acpi@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Renninger <trenn@suse.de>

Those lines have two copies.

Not sure how it could happen, looks like git problem.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Renninger <trenn@suse.de>

---
 drivers/acpi/processor_driver.c |    7 -------
 1 file changed, 7 deletions(-)

Index: linux-2.6/drivers/acpi/processor_driver.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_driver.c
+++ linux-2.6/drivers/acpi/processor_driver.c
@@ -586,13 +586,6 @@ static int __cpuinit acpi_processor_add(
 	if (pr->flags.need_hotplug_init)
 		return 0;
 
-	/*
-	 * Do not start hotplugged CPUs now, but when they
-	 * are onlined the first time
-	 */
-	if (pr->flags.need_hotplug_init)
-		return 0;
-
 	result = acpi_processor_start(pr);
 	if (result)
 		goto err_remove_sysfs;
