From: Len Brown <lenb@kernel.org>
Subject: [PATCH 30/98] ACPICA: Conditionally compile
 acpi_set_firmware_waking_vector64
Date: Sat, 28 Mar 2009 00:31:05 -0400
Message-ID: <4f70e371cdf6ab4f988fbaf2257e6259422ba662.1238214618.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:64533 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753818AbZC1Ecx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:53 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700D8D8MEGXBX@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:40 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

This function is only needed on 64-bit host operating systems.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/hwsleep.c |    5 ++++-
 include/acpi/acpixf.h         |    8 ++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index 51868f4..26e249e 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -90,6 +90,7 @@ acpi_set_firmware_waking_vector(u32 physical_address)
 
 ACPI_EXPORT_SYMBOL(acpi_set_firmware_waking_vector)
 
+#if ACPI_MACHINE_WIDTH == 64
 /*******************************************************************************
  *
  * FUNCTION:    acpi_set_firmware_waking_vector64
@@ -100,7 +101,8 @@ ACPI_EXPORT_SYMBOL(acpi_set_firmware_waking_vector)
  * RETURN:      Status
  *
  * DESCRIPTION: Sets the 64-bit X_firmware_waking_vector field of the FACS, if
- *              it exists in the table.
+ *              it exists in the table. This function is intended for use with
+ *              64-bit host operating systems.
  *
  ******************************************************************************/
 acpi_status
@@ -124,6 +126,7 @@ acpi_set_firmware_waking_vector64(u64 physical_address)
 }
 
 ACPI_EXPORT_SYMBOL(acpi_set_firmware_waking_vector64)
+#endif
 
 /*******************************************************************************
  *
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 8f9df62..e10c896 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -351,11 +351,11 @@ acpi_status acpi_get_register_unlocked(u32 register_id, u32 *return_value);
 
 acpi_status acpi_set_register(u32 register_id, u32 value);
 
-acpi_status
-acpi_set_firmware_waking_vector(u32 physical_address);
+acpi_status acpi_set_firmware_waking_vector(u32 physical_address);
 
-acpi_status
-acpi_set_firmware_waking_vector64(u64 physical_address);
+#if ACPI_MACHINE_WIDTH == 64
+acpi_status acpi_set_firmware_waking_vector64(u64 physical_address);
+#endif
 
 acpi_status acpi_read(u32 *value, struct acpi_generic_address *reg);
 
-- 
1.6.0.6

