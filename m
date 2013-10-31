From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 01/15] ACPICA: Update default space handlers.
Date: Thu, 31 Oct 2013 09:29:49 +0800
Message-ID: <f96c3f150c8f49a17adb2783b98ce60d1c0f192b.1383182393.git.lv.zheng@intel.com>
References: <cover.1383009405.git.lv.zheng@intel.com> <cover.1383182392.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:56179 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751728Ab3JaBad (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Oct 2013 21:30:33 -0400
In-Reply-To: <cover.1383182392.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

This patch decreases 11 lines of divergences.

This patch includes code fragment that is already in ACPICA upstream.
Thus applying this patch can help to reduce the source code differences
between Linux and ACPICA upstream.

This code fragment is only useful to ACPICA utilities that might occur in
tools/power/acpi folder and there is no functional changes can be caused to
the Linux kernel by applying this patch.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/exregion.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index 303429bb..9d28867e 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -400,6 +400,7 @@ acpi_ex_pci_config_space_handler(u32 function,
 	switch (function) {
 	case ACPI_READ:
 
+		*value = 0;
 		status = acpi_os_read_pci_configuration(pci_id, pci_register,
 							value, bit_width);
 		break;
-- 
1.7.10

