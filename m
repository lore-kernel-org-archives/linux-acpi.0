From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 4/5] ACPI / PM: Make suspend_nvs_save() use acpi_os_map_memory()
Date: Fri, 7 Jan 2011 01:45:58 +0100
Message-ID: <201101070145.58907.rjw@sisk.pl>
References: <201101070141.02951.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:38177 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752727Ab1AGArp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 6 Jan 2011 19:47:45 -0500
In-Reply-To: <201101070141.02951.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jiri Slaby <jirislaby@gmail.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

It turns out that the NVS memory region that suspend_nvs_save()
attempts to map has been already mapped by acpi_os_map_memory(), so
suspend_nvs_save() should better use acpi_os_map_memory() for mapping
memory to avoid conflicts.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/nvs.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/nvs.c
===================================================================
--- linux-2.6.orig/drivers/acpi/nvs.c
+++ linux-2.6/drivers/acpi/nvs.c
@@ -12,6 +12,7 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
+#include <acpi/acpiosxf.h>
 
 /*
  * Platforms, like ACPI, may want us to save some memory used by them during
@@ -113,7 +114,8 @@ int suspend_nvs_save(void)
 
 	list_for_each_entry(entry, &nvs_list, node)
 		if (entry->data) {
-			entry->kaddr = ioremap(entry->phys_start, entry->size);
+			entry->kaddr = acpi_os_map_memory(entry->phys_start,
+							  entry->size);
 			if (!entry->kaddr) {
 				suspend_nvs_free();
 				return -ENOMEM;

