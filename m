From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 02/21] ACPICA: Fix a couple warnings detected on FreeBSD build
Date: Fri,  8 Mar 2013 17:20:04 +0800
Message-ID: <bc6901cac9bc3f474b4a81c36c654ac3adaad986.1361292877.git.lv.zheng@intel.com>
References: <cover.1361292877.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:17381 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756027Ab3CHJUd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Mar 2013 04:20:33 -0500
In-Reply-To: <cover.1361292877.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Jung-uk Kim <jkim@FreeBSD.org>, Lv Zheng <lv.zheng@intel.com>

From: Jung-uk Kim <jkim@FreeBSD.org>

This fixes a global and a pointer cast. Jung-uk Kim.

Signed-off-by: Jung-uk Kim <jkim@FreeBSD.org>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index ecb4992..feaa5d5 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -413,7 +413,7 @@ ACPI_EXTERN u8 acpi_gbl_db_output_flags;
 
 #ifdef ACPI_DISASSEMBLER
 
-u8 ACPI_INIT_GLOBAL(acpi_gbl_ignore_noop_operator, FALSE);
+ACPI_EXTERN u8 ACPI_INIT_GLOBAL(acpi_gbl_ignore_noop_operator, FALSE);
 
 ACPI_EXTERN u8 acpi_gbl_db_opt_disasm;
 ACPI_EXTERN u8 acpi_gbl_db_opt_verbose;
-- 
1.7.10

