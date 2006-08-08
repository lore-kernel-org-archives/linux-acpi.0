From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: [PATCH] ACPI: Clear GPE before disabling it
Date: Tue, 8 Aug 2006 13:19:03 -0600
Message-ID: <20060808191903.GA10816@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary=M9NhX3UHpAaciwkO
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030205AbWHHTRT@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, william.morrow@amd.com
List-Id: linux-acpi@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On AMD Geode BIOSen, we have problems with GPE interrupt storms.  The
attached patch resolves that.  This should be fine for all implementations,
though.

Jordan
-- 
Jordan Crouse
Senior Linux Engineer
Advanced Micro Devices, Inc.
<www.amd.com/embeddedprocessors>

--M9NhX3UHpAaciwkO
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline;
 filename=acpi-s1-fix.patch
Content-Transfer-Encoding: 7bit

[PATCH] ACPI:  Clear GPE before disabling it

From: William Morrow <william.morrow@amd.com>

On some BIOSen, the GPE bit will remain set even if it is disabled, 
resulting in a interrupt storm.  This patch clears the bit before 
disabling it.

Signed-off-by:  William Morrow <william.morrow@amd.com>
Signed-off-by:  Jordan Crouse <jordan.crouse@amd.com>
---

 drivers/acpi/events/evgpe.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/events/evgpe.c b/drivers/acpi/events/evgpe.c
index c76c058..1f93b23 100644
--- a/drivers/acpi/events/evgpe.c
+++ b/drivers/acpi/events/evgpe.c
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

--M9NhX3UHpAaciwkO--
