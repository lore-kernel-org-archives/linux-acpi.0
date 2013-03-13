From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: [Bug fix PATCH] ACPI,acpi_memhotplug: enable acpi_memory_info->enabled
 of memory device presented at boot-time
Date: Wed, 13 Mar 2013 15:54:55 +0900
Message-ID: <514022BF.3080303@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:54311 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285Ab3CMGz3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Mar 2013 02:55:29 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl
Cc: toshi.kani@hp.com, linux-acpi@vger.kernel.org, tangchen@cn.fujitsu.com, wency@cn.fujitsu.com, laijs@cn.fujitsu.com, linux-kernel@vger.kernel.org

At http://marc.info/?l=linux-acpi&m=135769405622667&w=2 thread,
Toshi Kani mentioned as follows:

"I have a question about the change you made in commit 65479472 in
acpi_memhotplug.c.  This change seems to require that
acpi_memory_enable_device() calls add_memory() to add all memory ranges
represented by memory device objects at boot-time, and keep the results
be used for hot-remove.  

If I understand it right, this add_memory() call fails with EEXIST at
boot-time since all memory ranges should have been added from EFI memory
table (or e820) already.  This results all memory ranges be marked as !
enabled & !failed.  I think this means that we cannot hot-delete any
memory ranges presented at boot-time since acpi_memory_remove_memory()
only calls remove_memory() when the enabled flag is set.  Is that
correct?"

Above mention is correct. Thus even if memory device supports hotplug,
memory presented at boot-time cannot be hot removed since the memory
device's acpi_memory_info->enabled is always 0.

This patch changes to set 1 to "acpi_memory_info->enabled" of memory
device presented at boot-time for hot removing the memory device.

Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

---
 drivers/acpi/acpi_memhotplug.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index da1f82b..88fd46a 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -254,8 +254,8 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
 			continue;
 		}
 
-		if (!result)
-			info->enabled = 1;
+		info->enabled = 1;
+
 		/*
 		 * Add num_enable even if add_memory() returns -EEXIST, so the
 		 * device is bound to this driver.

