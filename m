From: Myron Stowe <myron.stowe@hp.com>
Subject: [PATCH 1/3] ACPI: Disambiguate processor declaration type
Date: Wed, 22 Oct 2008 13:12:29 -0600
Message-ID: <1224702749.6784.15.camel@localhost>
References: <1224702636.6784.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:38103 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756272AbYJVTMa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Oct 2008 15:12:30 -0400
In-Reply-To: <1224702636.6784.13.camel@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: aystarik@gmail.com, linux-acpi <linux-acpi@vger.kernel.org>


Declaring processors in ACPI namespace can be done using either a "Processor"
definition or a "Device" definition (see section 8.4 - Declaring Processors;
"Advanced Configuration and Power Interface Specification", Revision 3.0b).
Currently the two processor declaration types are conflated.

This patch disambiguates the processor declaration's definition type enabling
subsequent code to behave uniquely based explicitly on the declaration's type.

Signed-off-by: Myron Stowe <myron.stowe@hp.com>
CC: Alexey Starikovskiy <aystarik@gmail.com>

---
 drivers/acpi/processor_core.c |    1 +
 drivers/acpi/scan.c           |    2 +-
 include/acpi/acpi_drivers.h   |    1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_core.c	2008-10-16 19:00:37.000000000 -0600
+++ linux-2.6/drivers/acpi/processor_core.c	2008-10-21 13:11:00.000000000 -0600
@@ -89,6 +89,7 @@ static int acpi_processor_handle_eject(s
 
 
 static const struct acpi_device_id processor_device_ids[] = {
+	{ACPI_PROCESSOR_OBJECT_HID, 0},
 	{ACPI_PROCESSOR_HID, 0},
 	{"", 0},
 };
Index: linux-2.6/include/acpi/acpi_drivers.h
===================================================================
--- linux-2.6.orig/include/acpi/acpi_drivers.h	2008-10-16 18:53:26.000000000 -0600
+++ linux-2.6/include/acpi/acpi_drivers.h	2008-10-20 13:23:28.000000000 -0600
@@ -41,6 +41,7 @@
  */
 
 #define ACPI_POWER_HID			"LNXPOWER"
+#define ACPI_PROCESSOR_OBJECT_HID	"ACPI_CPU"
 #define ACPI_PROCESSOR_HID		"ACPI0007"
 #define ACPI_SYSTEM_HID			"LNXSYSTM"
 #define ACPI_THERMAL_HID		"LNXTHERM"
Index: linux-2.6/drivers/acpi/scan.c
===================================================================
--- linux-2.6.orig/drivers/acpi/scan.c	2008-10-16 19:04:58.000000000 -0600
+++ linux-2.6/drivers/acpi/scan.c	2008-10-21 13:09:09.000000000 -0600
@@ -1025,7 +1025,7 @@ static void acpi_device_set_id(struct ac
 		hid = ACPI_POWER_HID;
 		break;
 	case ACPI_BUS_TYPE_PROCESSOR:
-		hid = ACPI_PROCESSOR_HID;
+		hid = ACPI_PROCESSOR_OBJECT_HID;
 		break;
 	case ACPI_BUS_TYPE_SYSTEM:
 		hid = ACPI_SYSTEM_HID;


