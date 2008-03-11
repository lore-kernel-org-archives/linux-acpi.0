From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/12] ACPI: prevent randconfig build failure on empty ACPI_CUSTOM_DSDT_FILE
Date: Tue, 11 Mar 2008 02:51:43 -0400
Message-ID: <7ce9573e093891f5807e6e50f3bd2012f1e5d0fe.1205217406.git.len.brown@intel.com>
References: <1205218309-19695-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:2378 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754126AbYCKGyy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Mar 2008 02:54:54 -0400
In-Reply-To: <1205218309-19695-1-git-send-email-lenb@kernel.org>
In-Reply-To: <b95e9e8d94484c2823be67416f25e9756db149dc.1205217406.git.len.brown@intel.com>
References: <b95e9e8d94484c2823be67416f25e9756db149dc.1205217406.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Len Brown <len.brown@intel.com>

From: Randy Dunlap <randy.dunlap@oracle.com>

Make ACPI_CUSTOM_DSDT boolean config symbol a hidden and derived
value, based on the value of ACPI_CUSTOM_DSDT_FILE (string).
Only the latter is presented to the user as a config option.

This fixes problems with "make randconfig" setting ACPI_CUSTOM_DSDT
but leaving ACPI_CUSTOM_DSDT_FILE empty/blank.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Kconfig |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index f688c21..fbcaa06 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -283,24 +283,23 @@ config ACPI_TOSHIBA
 	  If you have a legacy free Toshiba laptop (such as the Libretto L1
 	  series), say Y.
 
-config ACPI_CUSTOM_DSDT
-	bool "Include Custom DSDT"
+config ACPI_CUSTOM_DSDT_FILE
+	string "Custom DSDT Table file to include"
+	default ""
 	depends on !STANDALONE
-	default n 
 	help
 	  This option supports a custom DSDT by linking it into the kernel.
 	  See Documentation/acpi/dsdt-override.txt
 
-	  If unsure, say N.
-
-config ACPI_CUSTOM_DSDT_FILE
-	string "Custom DSDT Table file to include"
-	depends on ACPI_CUSTOM_DSDT
-	default ""
-	help
 	  Enter the full path name to the file which includes the AmlCode
 	  declaration.
 
+	  If unsure, don't enter a file name.
+
+config ACPI_CUSTOM_DSDT
+	bool
+	default ACPI_CUSTOM_DSDT_FILE != ""
+
 config ACPI_CUSTOM_DSDT_INITRD
 	bool "Read Custom DSDT from initramfs"
 	depends on BLK_DEV_INITRD
-- 
1.5.4.3.422.g34cd6

