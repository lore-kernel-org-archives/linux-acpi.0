From: Lv Zheng <zetalog@gmail.com>
Subject: [PATCH] ACPICA: acpidump: Fix repetitive table dump in -n mode.
Date: Wed, 28 May 2014 01:14:55 +0800
Message-ID: <a30bdaa475e88783a01f055f56499904448a0f4e.1401210415.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:38115 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984AbaE0RPM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 May 2014 13:15:12 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so9383729pab.8
        for <linux-acpi@vger.kernel.org>; Tue, 27 May 2014 10:15:12 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Lv Zheng <lv.zheng@intel.com>

In "-n" mode, reserved tables (RSDP/RSDT/XSDT/DSDT/FACS) are dumped
multiple times due a missing instance check in osl_get_bios_table().
This patch fixes this issue.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 tools/power/acpi/os_specific/service_layers/oslinuxtbl.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
index ba7bad0..28c5200 100644
--- a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
+++ b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
@@ -783,6 +783,10 @@ osl_get_bios_table(char *signature,
 	    ACPI_COMPARE_NAME(signature, ACPI_SIG_XSDT) ||
 	    ACPI_COMPARE_NAME(signature, ACPI_SIG_DSDT) ||
 	    ACPI_COMPARE_NAME(signature, ACPI_SIG_FACS)) {
+		if (instance > 0) {
+			return (AE_LIMIT);
+		}
+
 		/*
 		 * Get the appropriate address, either 32-bit or 64-bit. Be very
 		 * careful about the FADT length and validate table addresses.
-- 
1.7.10

