From: Len Brown <lenb@kernel.org>
Subject: [PATCH 19/30] ACPICA: add debug dump of BIOS _OSI strings
Date: Sat, 07 Feb 2009 01:41:27 -0500
Message-ID: <3e0676a9b699d12b2bd0a8807459ac4277b181fc.1233988826.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:44024 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722AbZBGGmF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Feb 2009 01:42:05 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KEO008NZNXXR3A1@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Feb 2009 00:41:58 -0600 (CST)
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

on boot, print out the OSI strings the BIOS uses to query the OS.

To see this output...

build with CONFIG_ACPI_DEBUG

boot with
"acpi.debug_level=4" (ACPI_LV_INFO) (enabled by default)
and
"acpi.debug_level=1" (ACPI_UTILITIES) (default is 0)

example output:

ACPI: BIOS _OSI(Windows 2001) supported
ACPI: BIOS _OSI(Windows 2001 SP1) supported
ACPI: BIOS _OSI(Windows 2001 SP2) supported
ACPI: BIOS _OSI(Windows 2006) supported
ACPI: BIOS _OSI(Linux) not-supported
ACPI: BIOS _OSI(FreeBSD) not-supported

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/uteval.c |   21 +++++++++------------
 1 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/acpica/uteval.c b/drivers/acpi/acpica/uteval.c
index da9450b..9c9897d 100644
--- a/drivers/acpi/acpica/uteval.c
+++ b/drivers/acpi/acpica/uteval.c
@@ -116,9 +116,9 @@ acpi_status acpi_ut_osi_implementation(struct acpi_walk_state *walk_state)
 		return_ACPI_STATUS(AE_NO_MEMORY);
 	}
 
-	/* Default return value is SUPPORTED */
+	/* Default return value is 0, NOT-SUPPORTED */
 
-	return_desc->integer.value = ACPI_UINT32_MAX;
+	return_desc->integer.value = 0;
 	walk_state->return_desc = return_desc;
 
 	/* Compare input string to static table of supported interfaces */
@@ -127,10 +127,8 @@ acpi_status acpi_ut_osi_implementation(struct acpi_walk_state *walk_state)
 		if (!ACPI_STRCMP
 		    (string_desc->string.pointer,
 		     acpi_interfaces_supported[i])) {
-
-			/* The interface is supported */
-
-			return_ACPI_STATUS(AE_OK);
+			return_desc->integer.value = ACPI_UINT32_MAX;
+			goto done;
 		}
 	}
 
@@ -141,15 +139,14 @@ acpi_status acpi_ut_osi_implementation(struct acpi_walk_state *walk_state)
 	 */
 	status = acpi_os_validate_interface(string_desc->string.pointer);
 	if (ACPI_SUCCESS(status)) {
-
-		/* The interface is supported */
-
-		return_ACPI_STATUS(AE_OK);
+		return_desc->integer.value = ACPI_UINT32_MAX;
 	}
 
-	/* The interface is not supported */
+done:
+	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INFO, "ACPI: BIOS _OSI(%s) %ssupported\n",
+		string_desc->string.pointer,
+		return_desc->integer.value == 0 ? "not-" : ""));
 
-	return_desc->integer.value = 0;
 	return_ACPI_STATUS(AE_OK);
 }
 
-- 
1.5.6.6

