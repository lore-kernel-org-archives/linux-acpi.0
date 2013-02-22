From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2/2] ACPI: Overriding ACPI tables via initrd only works with an initrd and on X86
Date: Fri, 22 Feb 2013 14:12:22 +0100
Message-ID: <1361538742-67599-3-git-send-email-trenn@suse.de>
References: <1361538742-67599-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56747 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757099Ab3BVNMb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Feb 2013 08:12:31 -0500
In-Reply-To: <1361538742-67599-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: hpa@zytor.com
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, rjw@sisk.pl, aaron.lu@intel.com, devurandom@gmx.net, Thomas Renninger <trenn@suse.de>

Reflect this dependency in Kconfig.

Shorten the config description as suggested by Borislav Petkov.

Finding a suitable memory area to store the modified table(s) has been
taken over from arch/x86/kernel/setup.c and makes use of max_low_pfn_mapped:
memblock_find_in_range(0, max_low_pfn_mapped,...)
This one is X86 specific. It may not be hard to extend this functionality
for other ACPI aware architectures if there is need for.

For now make this feature only available for X86 to avoid build failures on
IA64, compare with:
https://bugzilla.kernel.org/show_bug.cgi?id=54091


Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Thomas Renninger <Thomas Renninger" trenn@suse.de>
---
 drivers/acpi/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 1a4ed64..c692404 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -266,7 +266,8 @@ config ACPI_CUSTOM_DSDT
 	default ACPI_CUSTOM_DSDT_FILE != ""
 
 config ACPI_INITRD_TABLE_OVERRIDE
-	bool "ACPI tables can be passed via uncompressed cpio in initrd"
+	bool "ACPI tables override via initrd"
+	depends on BLK_DEV_INITRD && X86
 	default n
 	help
 	  This option provides functionality to override arbitrary ACPI tables
-- 
1.7.6.1

