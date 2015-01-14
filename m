From: Moritz Fischer <moritz.fischer@ettus.com>
Subject: [PATCH] acpi: nvs: Fixed checkpatch.pl warning.
Date: Wed, 14 Jan 2015 11:18:53 +0100
Message-ID: <1421230733-24149-2-git-send-email-moritz.fischer@ettus.com>
References: <1421230733-24149-1-git-send-email-moritz.fischer@ettus.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:48122 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154AbbANKTW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Jan 2015 05:19:22 -0500
Received: by mail-we0-f180.google.com with SMTP id w62so7845675wes.11
        for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2015 02:19:20 -0800 (PST)
In-Reply-To: <1421230733-24149-1-git-send-email-moritz.fischer@ettus.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Moritz Fischer <moritz.fischer@ettus.com>

Patch replaces printk(KERN_INFO with pr_info.

Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
---
 drivers/acpi/nvs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/nvs.c b/drivers/acpi/nvs.c
index 85287b8..e22235c 100644
--- a/drivers/acpi/nvs.c
+++ b/drivers/acpi/nvs.c
@@ -171,7 +171,7 @@ int suspend_nvs_save(void)
 {
 	struct nvs_page *entry;
 
-	printk(KERN_INFO "PM: Saving platform NVS memory\n");
+	pr_info("PM: Saving platform NVS memory\n");
 
 	list_for_each_entry(entry, &nvs_list, node)
 		if (entry->data) {
@@ -203,7 +203,7 @@ void suspend_nvs_restore(void)
 {
 	struct nvs_page *entry;
 
-	printk(KERN_INFO "PM: Restoring platform NVS memory\n");
+	pr_info("PM: Restoring platform NVS memory\n");
 
 	list_for_each_entry(entry, &nvs_list, node)
 		if (entry->data)
-- 
1.9.3

