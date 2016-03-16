From: Prashanth Prakash <pprakash@codeaurora.org>
Subject: [PATCH 1/3] ACPI: move ACPI_SYSTEM_HID to acpi_drivers.h
Date: Wed, 16 Mar 2016 13:37:00 -0600
Message-ID: <1458157022-18633-2-git-send-email-pprakash@codeaurora.org>
References: <1458157022-18633-1-git-send-email-pprakash@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60428 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932586AbcCPThT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Mar 2016 15:37:19 -0400
In-Reply-To: <1458157022-18633-1-git-send-email-pprakash@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: harba@codeaurora.org, rjw@rjwysocki.net, "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>

From: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>

ACPI_SYSTEM_HID is defined in drivers/acpi/bus.c out-of-band.

Move the definition to include/acpi/acpi_drivers.h, together
with other Linux specific HIDs, so that it can be used by other
code.

Signed-off-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
---
 drivers/acpi/scan.c         | 3 ++-
 include/acpi/acpi_drivers.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 407a376..358e3c8 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -13,6 +13,8 @@
 #include <linux/nls.h>
 #include <linux/dma-mapping.h>
 
+#include <acpi/acpi_drivers.h>
+
 #include <asm/pgtable.h>
 
 #include "internal.h"
@@ -22,7 +24,6 @@ ACPI_MODULE_NAME("scan");
 extern struct acpi_device *acpi_root;
 
 #define ACPI_BUS_CLASS			"system_bus"
-#define ACPI_BUS_HID			"LNXSYBUS"
 #define ACPI_BUS_DEVICE_NAME		"System Bus"
 
 #define ACPI_IS_ROOT_DEVICE(device)    (!(device)->parent)
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index 29c6912..3638f6f 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -52,6 +52,7 @@
 #define ACPI_POWER_HID			"LNXPOWER"
 #define ACPI_PROCESSOR_OBJECT_HID	"LNXCPU"
 #define ACPI_SYSTEM_HID			"LNXSYSTM"
+#define ACPI_BUS_HID			"LNXSYBUS"
 #define ACPI_THERMAL_HID		"LNXTHERM"
 #define ACPI_BUTTON_HID_POWERF		"LNXPWRBN"
 #define ACPI_BUTTON_HID_SLEEPF		"LNXSLPBN"
-- 
Qualcomm Technologies, Inc. on behalf
of the Qualcomm Innovation Center, Inc.  The Qualcomm Innovation Center, Inc. 
is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

