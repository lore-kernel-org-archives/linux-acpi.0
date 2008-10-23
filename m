From: Len Brown <lenb@kernel.org>
Subject: [PATCH 055/122] ACPI suspend: Always use the 32-bit waking vector
Date: Thu, 23 Oct 2008 02:38:29 -0400
Message-ID: <a6629105dd03d370fcb31e97bddf223fa4bb651e.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms172071pub.verizon.net ([206.46.172.71]:62933 "EHLO
	vms172071pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754902AbYJWGkF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:05 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms172071.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K96007DGIIQ8MB1@vms172071.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:03 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

According to the ACPI specification 2.0c and later, the 64-bit waking vector
should be cleared and the 32-bit waking vector should be used, unless we want
the wake-up code to be called by the BIOS in Protected Mode.  Moreover, some
systems (for example HP dv5-1004nr) are known to fail to resume if the 64-bit
waking vector is used.  Therefore, modify the code to clear the 64-bit waking
vector, for FACS version 1 or greater, and set the 32-bit one before suspend.

http://bugzilla.kernel.org/show_bug.cgi?id=11368

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/hardware/hwsleep.c |   39 ++++++++++++---------------------------
 1 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/drivers/acpi/hardware/hwsleep.c b/drivers/acpi/hardware/hwsleep.c
index 130a44b..25dccdf 100644
--- a/drivers/acpi/hardware/hwsleep.c
+++ b/drivers/acpi/hardware/hwsleep.c
@@ -78,19 +78,17 @@ acpi_set_firmware_waking_vector(acpi_physical_address physical_address)
 		return_ACPI_STATUS(status);
 	}
 
-	/* Set the vector */
+	/*
+	 * According to the ACPI specification 2.0c and later, the 64-bit
+	 * waking vector should be cleared and the 32-bit waking vector should
+	 * be used, unless we want the wake-up code to be called by the BIOS in
+	 * Protected Mode.  Some systems (for example HP dv5-1004nr) are known
+	 * to fail to resume if the 64-bit vector is used.
+	 */
+	if (facs->version >= 1)
+		facs->xfirmware_waking_vector = 0;
 
-	if ((facs->length < 32) || (!(facs->xfirmware_waking_vector))) {
-		/*
-		 * ACPI 1.0 FACS or short table or optional X_ field is zero
-		 */
-		facs->firmware_waking_vector = (u32) physical_address;
-	} else {
-		/*
-		 * ACPI 2.0 FACS with valid X_ field
-		 */
-		facs->xfirmware_waking_vector = physical_address;
-	}
+	facs->firmware_waking_vector = (u32)physical_address;
 
 	return_ACPI_STATUS(AE_OK);
 }
@@ -134,20 +132,7 @@ acpi_get_firmware_waking_vector(acpi_physical_address * physical_address)
 	}
 
 	/* Get the vector */
-
-	if ((facs->length < 32) || (!(facs->xfirmware_waking_vector))) {
-		/*
-		 * ACPI 1.0 FACS or short table or optional X_ field is zero
-		 */
-		*physical_address =
-		    (acpi_physical_address) facs->firmware_waking_vector;
-	} else {
-		/*
-		 * ACPI 2.0 FACS with valid X_ field
-		 */
-		*physical_address =
-		    (acpi_physical_address) facs->xfirmware_waking_vector;
-	}
+	*physical_address = (acpi_physical_address)facs->firmware_waking_vector;
 
 	return_ACPI_STATUS(AE_OK);
 }
-- 
1.5.5.1

