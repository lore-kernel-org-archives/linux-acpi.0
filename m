From: akpm@linux-foundation.org
Subject: [patch 5/5] acpi: use ACPI_DEBUG_PRINT instead of printk
Date: Tue, 04 Mar 2008 15:06:36 -0800
Message-ID: <200803042306.m24N6bml001816@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47923 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934588AbYCDXJj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Mar 2008 18:09:39 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, gcosta@redhat.com

From: Glauber Costa <gcosta@redhat.com>

For consistency, use ACPI_DEBUG_PRINT instead of printk in
acpi_processor_hotplug_notify() for BUS_CHECK and DEVICE_CHECK events

Signed-off-by: Glauber Costa <gcosta@redhat.com>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/processor_core.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff -puN drivers/acpi/processor_core.c~acpi-use-acpi_debug_print-instead-of-printk drivers/acpi/processor_core.c
--- a/drivers/acpi/processor_core.c~acpi-use-acpi_debug_print-instead-of-printk
+++ a/drivers/acpi/processor_core.c
@@ -899,9 +899,10 @@ static void __ref acpi_processor_hotplug
 	switch (event) {
 	case ACPI_NOTIFY_BUS_CHECK:
 	case ACPI_NOTIFY_DEVICE_CHECK:
-		printk("Processor driver received %s event\n",
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+		"Processor driver received %s event\n",
 		       (event == ACPI_NOTIFY_BUS_CHECK) ?
-		       "ACPI_NOTIFY_BUS_CHECK" : "ACPI_NOTIFY_DEVICE_CHECK");
+		       "ACPI_NOTIFY_BUS_CHECK" : "ACPI_NOTIFY_DEVICE_CHECK"));
 
 		if (!is_processor_present(handle))
 			break;
_
