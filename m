From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 29/53] ACPICA: Events: Add runtime stub support for event APIs
Date: Mon,  5 Jun 2017 16:40:02 +0800
Message-ID: <1b05cb2a5d3e42d8436e8f36db11336a7aee2247.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:47870 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751503AbdFEIkF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:40:05 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 99bc3beca92c6574ea1d69de42e54f872e6373ce

It is reported that on Linux, RTC driver complains wrong errors on
hardware reduced platform:
  [    4.085420] ACPI Warning: Could not enable fixed event - real_time_clock (4) (20160422/evxface-654)

This patch fixes this by correctly adding runtime reduced hardware check.
Reported by Chandan Tagore, fixed by Lv Zheng.

Link: https://github.com/acpica/acpica/commit/99bc3bec
Tested-by: Chandan Tagore <tagore.chandan@gmail.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/evxfevnt.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/acpi/acpica/evxfevnt.c b/drivers/acpi/acpica/evxfevnt.c
index 82e8971..c773ac4 100644
--- a/drivers/acpi/acpica/evxfevnt.c
+++ b/drivers/acpi/acpica/evxfevnt.c
@@ -180,6 +180,12 @@ acpi_status acpi_enable_event(u32 event, u32 flags)
 
 	ACPI_FUNCTION_TRACE(acpi_enable_event);
 
+	/* If Hardware Reduced flag is set, there are no fixed events */
+
+	if (acpi_gbl_reduced_hardware) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
 	/* Decode the Fixed Event */
 
 	if (event > ACPI_EVENT_MAX) {
@@ -237,6 +243,12 @@ acpi_status acpi_disable_event(u32 event, u32 flags)
 
 	ACPI_FUNCTION_TRACE(acpi_disable_event);
 
+	/* If Hardware Reduced flag is set, there are no fixed events */
+
+	if (acpi_gbl_reduced_hardware) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
 	/* Decode the Fixed Event */
 
 	if (event > ACPI_EVENT_MAX) {
@@ -290,6 +302,12 @@ acpi_status acpi_clear_event(u32 event)
 
 	ACPI_FUNCTION_TRACE(acpi_clear_event);
 
+	/* If Hardware Reduced flag is set, there are no fixed events */
+
+	if (acpi_gbl_reduced_hardware) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
 	/* Decode the Fixed Event */
 
 	if (event > ACPI_EVENT_MAX) {
-- 
2.7.4

