From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0047/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:36:54 +0800
Message-ID: <20160802103654.16901-1-baolex.ni@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16050 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754660AbcHBLPY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Aug 2016 07:15:24 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, x86@kernel.org, hpa@zytor.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, travis@sgi.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/acpi/pci_slot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_slot.c b/drivers/acpi/pci_slot.c
index 7188e53..ed76724 100644
--- a/drivers/acpi/pci_slot.c
+++ b/drivers/acpi/pci_slot.c
@@ -43,7 +43,7 @@ MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 MODULE_PARM_DESC(debug, "Debugging mode enabled or not");
-module_param(debug, bool, 0644);
+module_param(debug, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
 #define _COMPONENT		ACPI_PCI_COMPONENT
 ACPI_MODULE_NAME("pci_slot");
-- 
2.9.2

