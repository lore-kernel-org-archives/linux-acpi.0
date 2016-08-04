From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 06/30] ACPICA: Disassembler: Add option to emit embedded External operators/opcodes
Date: Thu,  4 Aug 2016 16:43:02 +0800
Message-ID: <08c39ea1d26669ef70d0814edc84ad987f927021.1470299677.git.lv.zheng@intel.com>
References: <cover.1470299677.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:49038 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932352AbcHDInN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Aug 2016 04:43:13 -0400
In-Reply-To: <cover.1470299677.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 152a8ca2c7fc877d6aff0f9d0965184ef2ddce5c

Opcode 0x15 was added in ACPI 6.0 for disassemblers.
The disassembler by default does not emit the actual opcodes, they
are used internally. Option added for internal debugging only.

This patch doesn't affect Linux kernel as disassembler is not in
the Linux kernel.

Link: https://github.com/acpica/acpica/commit/152a8ca2
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index fded776..8c2c504 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -317,6 +317,7 @@ ACPI_INIT_GLOBAL(u8, acpi_gbl_ignore_noop_operator, FALSE);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_cstyle_disassembly, TRUE);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_force_aml_disassembly, FALSE);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_dm_opt_verbose, TRUE);
+ACPI_INIT_GLOBAL(u8, acpi_gbl_dm_emit_external_opcodes, FALSE);
 
 ACPI_GLOBAL(u8, acpi_gbl_dm_opt_disasm);
 ACPI_GLOBAL(u8, acpi_gbl_dm_opt_listing);
-- 
1.7.10

