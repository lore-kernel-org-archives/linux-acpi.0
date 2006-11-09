From: akpm@osdl.org
Subject: [patch 1/2] ACPI: Clear GPE before disabling it
Date: Wed, 08 Nov 2006 19:44:45 -0800
Message-ID: <200611090344.kA93ijKB003447@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:3245 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1754705AbWKIDpW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Nov 2006 22:45:22 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, william.morrow@amd.com, jordan.crouse@amd.com, len.brown@intel.com, luming.yu@intel.com, robert.moore@intel.com

From: William Morrow <william.morrow@amd.com>

On some BIOSen, the GPE bit will remain set even if it is disabled,
resulting in a interrupt storm.  This patch clears the bit before disabling
it.

Signed-off-by: William Morrow <william.morrow@amd.com>
Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
Cc: "Yu, Luming" <luming.yu@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/events/evgpe.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletion(-)

diff -puN drivers/acpi/events/evgpe.c~acpi-clear-gpe-before-disabling-it drivers/acpi/events/evgpe.c
--- a/drivers/acpi/events/evgpe.c~acpi-clear-gpe-before-disabling-it
+++ a/drivers/acpi/events/evgpe.c
@@ -677,10 +677,22 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_eve
 	case ACPI_GPE_DISPATCH_METHOD:
 
 		/*
-		 * Disable GPE, so it doesn't keep firing before the method has a
+		 * Clear GPE, so it doesn't keep firing before the method has a
 		 * chance to run.
 		 */
+		status = acpi_hw_clear_gpe(gpe_event_info);
+		if (ACPI_FAILURE(status)) {
+			ACPI_EXCEPTION((AE_INFO, status,
+					"Unable to clear GPE[%2X]",
+					gpe_number));
+			return_UINT32(ACPI_INTERRUPT_NOT_HANDLED);
+		}
+		/*
+		 * Disable GPE, so it doesn't keep happen again.
+		 */
+
 		status = acpi_ev_disable_gpe(gpe_event_info);
+
 		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, status,
 					"Unable to disable GPE[%2X]",
_
