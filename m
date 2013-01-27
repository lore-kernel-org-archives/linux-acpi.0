From: Andreas Fleig <andreasfleig@gmail.com>
Subject: [PATCH] ACPI: Fix /proc/acpi/wakeup for devices w/o bus or parent
Date: Sun, 27 Jan 2013 15:17:55 +0100
Message-ID: <51053713.6090804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f53.google.com ([209.85.214.53]:62717 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754965Ab3A0OR5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Jan 2013 09:17:57 -0500
Received: by mail-bk0-f53.google.com with SMTP id j10so915474bkw.12
        for <linux-acpi@vger.kernel.org>; Sun, 27 Jan 2013 06:17:56 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Fix /proc/acpi/wakeup for devices without bus or parent

This patch fixes printing the wakeup status for devices without a bus
or parent, such as laptop lid switches and sleep buttons. These devices
have an empty physical_node_list, because acpi_bind_one is never run
for them.

Signed-off-by: Andreas Fleig <andreasfleig@gmail.com>
---
diff --git a/drivers/acpi/proc.c b/drivers/acpi/proc.c
index 27adb09..3623ea8 100644
--- a/drivers/acpi/proc.c
+++ b/drivers/acpi/proc.c
@@ -314,7 +314,8 @@ acpi_system_wakeup_device_seq_show(struct seq_file 
*seq, void *offset)
  		if (!dev->physical_node_count)
  			seq_printf(seq, "%c%-8s\n",
  				dev->wakeup.flags.run_wake ?
-				'*' : ' ', "disabled");
+				'*' : ' ', device_may_wakeup(&dev->dev) ?
+				"enabled" : "disabled");
  		else {
  			struct device *ldev;
  			list_for_each_entry(entry, &dev->physical_node_list,
