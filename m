From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 3/3] ACPI: processor: move device _HID into driver
Date: Mon, 27 Apr 2009 16:33:46 -0600
Message-ID: <20090427223346.16549.88416.stgit@bob.kio>
References: <20090427223244.16549.99553.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:24088 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758013AbZD0Wdq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Apr 2009 18:33:46 -0400
In-Reply-To: <20090427223244.16549.99553.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

The ACPI0007 _HID used for processor "Device" objects in the namespace
is not needed outside the processor driver, so move it there.  Also, the
#define is only used once, so just remove it and hard-code "ACPI0007".

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
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

