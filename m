From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0051/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:37:10 +0800
Message-ID: <20160802103710.17165-1-baolex.ni@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:26194 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754697AbcHBLPY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
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
 drivers/acpi/processor_throttling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index c72e648..bf0e128 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -44,7 +44,7 @@ ACPI_MODULE_NAME("processor_throttling");
  *  1 -> acpi processor driver ignores _TPC values
  */
 static int ignore_tpc;
-module_param(ignore_tpc, int, 0644);
+module_param(ignore_tpc, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(ignore_tpc, "Disable broken BIOS _TPC throttling support");
 
 struct throttling_tstate {
-- 
2.9.2

