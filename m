From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH 3/4] ACPI, APEI, Add APEI bit support in generic _OSC call
Date: Tue, 21 Jun 2011 15:16:26 +0800
Message-ID: <1308640587-24502-4-git-send-email-ying.huang@intel.com>
References: <1308640587-24502-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308640587-24502-1-git-send-email-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Tony Luck <tony.luck@intel.com>, ying.huang@intel.com, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org
List-Id: linux-acpi@vger.kernel.org

In APEI firmware first mode, hardware error is reported by hardware to
firmware firstly, then firmware reports the error to Linux in a GHES
error record via POLL/SCI/IRQ/NMI etc.

This may result in some issues if OS has no full APEI support.  So
some firmware implementation will work in a back-compatible mode by
default.  Where firmware will only notify OS in old-fashion, without
GHES record.  For example, for a fatal hardware error, only NMI is
signaled, no GHES record.

To gain full APEI power on these machines, APEI bit in generic _OSC
call should be specified to tell firmware that Linux has full APEI
support.  This patch adds the APEI bit support in generic _OSC call.

Signed-off-by: Huang Ying <ying.huang@intel.com>
---
 drivers/acpi/bus.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -39,6 +39,7 @@
 #include <linux/pci.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
+#include <acpi/apei.h>
 #include <linux/dmi.h>
 #include <linux/suspend.h>
 
@@ -541,6 +542,11 @@ static void acpi_bus_osc_support(void)
 #if defined(CONFIG_ACPI_PROCESSOR) || defined(CONFIG_ACPI_PROCESSOR_MODULE)
 	capbuf[OSC_SUPPORT_TYPE] |= OSC_SB_PPC_OST_SUPPORT;
 #endif
+
+#ifdef CONFIG_ACPI_APEI_GHES
+	if (!ghes_disable)
+		capbuf[OSC_SUPPORT_TYPE] |= OSC_SB_APEI_SUPPORT;
+#endif
 	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
 		return;
 	if (ACPI_SUCCESS(acpi_run_osc(handle, &context)))
