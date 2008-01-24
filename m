From: Len Brown <lenb@kernel.org>
Subject: [PATCH 4/8] ACPI: on OSI(Linux), print needed DMI rather than requesting dmidecode output
Date: Wed, 23 Jan 2008 21:32:43 -0500
Message-ID: <f40cd6fddcb1d51d8a2a67ddc81c14a3532f3cb7.1201141721.git.len.brown@intel.com>
References: <1201141967-28134-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:31725 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752410AbYAXCdk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Jan 2008 21:33:40 -0500
In-Reply-To: <1201141967-28134-1-git-send-email-lenb@kernel.org>
In-Reply-To: <81b4e1f6269cea345f17d3aa349ec9beb31a8cd3.1201141721.git.len.brown@intel.com>
References: <81b4e1f6269cea345f17d3aa349ec9beb31a8cd3.1201141721.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 93ad5f4..2203153 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1190,10 +1190,16 @@ acpi_os_validate_interface (char *interface)
 	if (!strcmp("Linux", interface)) {
 		printk(KERN_WARNING PREFIX
 			"System BIOS is requesting _OSI(Linux)\n");
-		printk(KERN_WARNING PREFIX
-			"If \"acpi_osi=Linux\" works better,\n"
-			"Please send dmidecode "
-			"to linux-acpi@vger.kernel.org\n");
+		if (acpi_dmi_dump())
+			printk(KERN_NOTICE PREFIX
+				"[please extract dmidecode output]\n");
+		printk(KERN_NOTICE PREFIX
+			"Please send DMI info above to "
+			"linux-acpi@vger.kernel.org\n");
+		printk(KERN_NOTICE PREFIX
+			"If \"acpi_osi=%sLinux\" works better, "
+			"please notify linux-acpi@vger.kernel.org\n",
+			osi_linux ? "!" : "");
 		if(osi_linux)
 			return AE_OK;
 	}
-- 
1.5.4.rc4.14.g6fc74

