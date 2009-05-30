From: Len Brown <lenb@kernel.org>
Subject: [PATCH 49/65] ACPI: processor: move device _HID into driver
Date: Fri, 29 May 2009 21:42:27 -0400
Message-ID: <9eccbc2f67efd0d19c47f40182abf2965c287add.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:60103 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756677AbZE3Bm7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:42:59 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF003QPORPE2K0@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:43:02 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

The ACPI0007 _HID used for processor "Device" objects in the namespace
is not needed outside the processor driver, so move it there.  Also, the
#define is only used once, so just remove it and hard-code "ACPI0007".

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_core.c |    2 +-
 include/acpi/acpi_drivers.h   |    1 -
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index cf627d6..cabff4c 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -89,7 +89,7 @@ static int acpi_processor_handle_eject(struct acpi_processor *pr);
 
 static const struct acpi_device_id processor_device_ids[] = {
 	{ACPI_PROCESSOR_OBJECT_HID, 0},
-	{ACPI_PROCESSOR_HID, 0},
+	{"ACPI0007", 0},
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, processor_device_ids);
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index c9922b3..5e8ed3a 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -58,7 +58,6 @@
 
 #define ACPI_POWER_HID			"LNXPOWER"
 #define ACPI_PROCESSOR_OBJECT_HID	"LNXCPU"
-#define ACPI_PROCESSOR_HID		"ACPI0007"
 #define ACPI_SYSTEM_HID			"LNXSYSTM"
 #define ACPI_THERMAL_HID		"LNXTHERM"
 #define ACPI_BUTTON_HID_POWERF		"LNXPWRBN"
-- 
1.6.0.6

