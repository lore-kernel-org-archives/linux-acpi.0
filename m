From: Len Brown <lenb@kernel.org>
Subject: [PATCH 16/16] ACPI: Fix section mismatch error for
 acpi_early_processor_set_pdc()
Date: Sat, 16 Jan 2010 02:33:06 -0500
Message-ID: <7a0b73a49ab56fb1e836675c00d6d0d2ba39a714.1263627123.git.len.brown@intel.com>
References: <1263627186-21384-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:58800 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909Ab0APHef (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 Jan 2010 02:34:35 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KWB00L58X1LW0J1@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 16 Jan 2010 01:34:35 -0600 (CST)
In-reply-to: <1263627186-21384-1-git-send-email-lenb@kernel.org>
In-reply-to: <a62e8f1978f49e52f87a711ff6711b323d4b12ff.1263627123.git.len.brown@intel.com>
References: <a62e8f1978f49e52f87a711ff6711b323d4b12ff.1263627123.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Luck, Tony" <tony.luck@intel.com>, Len Brown <len.brown@intel.com>

From: Luck, Tony <tony.luck@intel.com>

Alex Chiang introduced acpi_early_processor_set_pdc() in commit:
 ACPI: processor: call _PDC early
 78f1699659963fff97975df44db6d5dbe7218e55

But this results in a section mismatch:

WARNING: drivers/acpi/acpi.o(.text+0xa9c1): Section mismatch in reference from the
function acpi_early_processor_set_pdc() to the variable .cpuinit.data:processor_idle_dmi_table
The function acpi_early_processor_set_pdc() references
the variable __cpuinitdata processor_idle_dmi_table.
This is often because acpi_early_processor_set_pdc lacks a __cpuinitdata
annotation or the annotation of processor_idle_dmi_table is wrong.

The only caller of acpi_early_processor_set_pdc() is acpi_bus_init() which
is an "__init" function. So the correct fix here is to mark
acpi_early_processor_set_pdc() "__init" too.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Acked-by: Alex Chiang <achiang@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_pdc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
index 30e4dc0..7d4ee39 100644
--- a/drivers/acpi/processor_pdc.c
+++ b/drivers/acpi/processor_pdc.c
@@ -151,7 +151,7 @@ early_init_pdc(acpi_handle handle, u32 lvl, void *context, void **rv)
 	return AE_OK;
 }
 
-void acpi_early_processor_set_pdc(void)
+void __init acpi_early_processor_set_pdc(void)
 {
 	/*
 	 * Check whether the system is DMI table. If yes, OSPM
-- 
1.6.0.6

