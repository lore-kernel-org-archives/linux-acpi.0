From: Len Brown <lenb@kernel.org>
Subject: [PATCH] ACPICA: add debug dump of BIOS _OSI strings
Date: Tue, 03 Feb 2009 18:17:55 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902031811400.5607@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:12936 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbZBCXR7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Feb 2009 18:17:59 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-2.01 (built Jun 13 2007; 32bit))
 with ESMTPA id <0KEI00KXMJDXSZ75@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 03 Feb 2009 17:17:58 -0600 (CST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: devel@lists.acpica.org
Cc: linux-acpi@vger.kernel.org

Bob,
I'd like to make this minor change to the (linuxized) ACPICA code,
for it can tell us a little about the BIOS w/o having the user
go to the trouble to dump the tables etc.

If you made this change in the upstream ACPICA code,
then that would be dandy.

thanks,
-Len

>From 3e0676a9b699d12b2bd0a8807459ac4277b181fc Mon Sep 17 00:00:00 2001
From: Len Brown <len.brown@intel.com>
Date: Tue, 3 Feb 2009 18:04:39 -0500
Subject: [PATCH] ACPICA: add debug dump of BIOS _OSI strings
Organization: Intel Open Source Technology Center

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
1.6.1.2.319.gbd9e

