From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/10] ACPI: Disambiguate processor declaration type
Date: Thu, 06 Nov 2008 23:45:24 -0500
Message-ID: <ad93a765c1834db031b5bf1c2baf2a50d0462ca4.1226032943.git.len.brown@intel.com>
References: <1226033132-16034-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:41641 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200AbYKGEpe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 23:45:34 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9Y002J157XRG02@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 Nov 2008 22:45:34 -0600 (CST)
In-reply-to: <1226033132-16034-1-git-send-email-lenb@kernel.org>
In-reply-to: <007e7d616a5d1c2e16ad627d03f8b97799445e71.1226032943.git.len.brown@intel.com>
References: <007e7d616a5d1c2e16ad627d03f8b97799445e71.1226032943.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Myron Stowe <myron.stowe@hp.com>, Len Brown <len.brown@intel.com>

From: Myron Stowe <myron.stowe@hp.com>

Declaring processors in ACPI namespace can be done using either a
"Processor" definition or a "Device" definition (see section 8.4 -
Declaring Processors; "Advanced Configuration and Power Interface
Specification", Revision 3.0b).  Currently the two processor
declaration types are conflated.

This patch disambiguates the processor declaration's definition type
enabling subsequent code to behave uniquely based explicitly on the
declaration's type.

Signed-off-by: Myron Stowe <myron.stowe@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_core.c |    1 +
 drivers/acpi/scan.c           |    2 +-
 include/acpi/acpi_drivers.h   |    1 +
 3 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 24a362f..0c670dd 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -89,6 +89,7 @@ static int acpi_processor_handle_eject(struct acpi_processor *pr);
 
 
 static const struct acpi_device_id processor_device_ids[] = {
+	{ACPI_PROCESSOR_OBJECT_HID, 0},
 	{ACPI_PROCESSOR_HID, 0},
 	{"", 0},
 };
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index a9dda8e..3fb6e2d 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1043,7 +1043,7 @@ static void acpi_device_set_id(struct acpi_device *device,
 		hid = ACPI_POWER_HID;
 		break;
 	case ACPI_BUS_TYPE_PROCESSOR:
-		hid = ACPI_PROCESSOR_HID;
+		hid = ACPI_PROCESSOR_OBJECT_HID;
 		break;
 	case ACPI_BUS_TYPE_SYSTEM:
 		hid = ACPI_SYSTEM_HID;
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index cf04c60..7469ff3 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -41,6 +41,7 @@
  */
 
 #define ACPI_POWER_HID			"LNXPOWER"
+#define ACPI_PROCESSOR_OBJECT_HID	"ACPI_CPU"
 #define ACPI_PROCESSOR_HID		"ACPI0007"
 #define ACPI_SYSTEM_HID			"LNXSYSTM"
 #define ACPI_THERMAL_HID		"LNXTHERM"
-- 
1.5.6.5

