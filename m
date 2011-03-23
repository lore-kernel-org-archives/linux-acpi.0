From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/42] ACPI / PM: Use existing ACPI iomaps for NVS save/restore
 (v2)
Date: Wed, 23 Mar 2011 02:42:20 -0400
Message-ID: <bb45e394e21eb2abc710ad43d98ebac1069bf355.1300862481.git.len.brown@intel.com>
References: <1300862575-10206-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:32930 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338Ab1CWGnS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 02:43:18 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LII00LYV002W5C2@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Mar 2011 01:43:15 -0500 (CDT)
In-reply-to: <1300862575-10206-1-git-send-email-lenb@kernel.org>
In-reply-to: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>

From: Rafael J. Wysocki <rjw@sisk.pl>

Modify the NVS save/restore code to use acpi_os_get_iomem() and
acpi_os_unmap_memory() to acquire and release references to ACPI
iomaps, respectively.  If there's no ACPI iomap corresponding to the
given NVS page, acpi_os_ioremap() is used to map that page and
iounmap() is used to unmap it during resume.  [If the page is not
present in the ACPI iomaps already, it doesn't make sense to add its
mapping to the list of ACPI iomaps, because it's going to be thrown
away during the subsequent resume anyway.]

Testing on my HP nx6325 shows that approx. 90% of the NVS pages
have already been mapped by ACPI before suspend and are present in
the ACPI iomaps, so this change appears to be the right thing to do
in general.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/nvs.c |   22 +++++++++++++++++++---
 1 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/nvs.c b/drivers/acpi/nvs.c
index fa5a1df..096787b 100644
--- a/drivers/acpi/nvs.c
+++ b/drivers/acpi/nvs.c
@@ -26,6 +26,7 @@ struct nvs_page {
 	unsigned int size;
 	void *kaddr;
 	void *data;
+	bool unmap;
 	struct list_head node;
 };
 
@@ -44,6 +45,9 @@ int suspend_nvs_register(unsigned long start, unsigned long size)
 {
 	struct nvs_page *entry, *next;
 
+	pr_info("PM: Registering ACPI NVS region at %lx (%ld bytes)\n",
+		start, size);
+
 	while (size > 0) {
 		unsigned int nr_bytes;
 
@@ -81,7 +85,13 @@ void suspend_nvs_free(void)
 			free_page((unsigned long)entry->data);
 			entry->data = NULL;
 			if (entry->kaddr) {
-				iounmap(entry->kaddr);
+				if (entry->unmap) {
+					iounmap(entry->kaddr);
+					entry->unmap = false;
+				} else {
+					acpi_os_unmap_memory(entry->kaddr,
+							     entry->size);
+				}
 				entry->kaddr = NULL;
 			}
 		}
@@ -115,8 +125,14 @@ int suspend_nvs_save(void)
 
 	list_for_each_entry(entry, &nvs_list, node)
 		if (entry->data) {
-			entry->kaddr = acpi_os_ioremap(entry->phys_start,
-						    entry->size);
+			unsigned long phys = entry->phys_start;
+			unsigned int size = entry->size;
+
+			entry->kaddr = acpi_os_get_iomem(phys, size);
+			if (!entry->kaddr) {
+				entry->kaddr = acpi_os_ioremap(phys, size);
+				entry->unmap = !!entry->kaddr;
+			}
 			if (!entry->kaddr) {
 				suspend_nvs_free();
 				return -ENOMEM;
-- 
1.7.4.1.343.ga91df

