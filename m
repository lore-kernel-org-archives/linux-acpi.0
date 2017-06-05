From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 44/53] ACPICA: Changed Gbl_disasm_flag to acpi_gbl_disasm_flag
Date: Mon,  5 Jun 2017 16:41:36 +0800
Message-ID: <a8743061be4bfd0e2c5be1cc8db2afcc55e3f20b.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23890 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751668AbdFEIlj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:41:39 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Erik Schmauss <erik.schmauss@intel.com>, Bob Moore <robert.moore@intel.com>

From: Erik Schmauss <erik.schmauss@intel.com>

ACPICA commit 0e0a87111f280c197661689979b2c48443b0326c

This is a name change as well as a change in the scope of this flag.
This is done so that it can be referenced in the dispatcher.

Link: https://github.com/acpica/acpica/commit/0e0a8711
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acglobal.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 896d548..95eed44 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -369,6 +369,8 @@ ACPI_GLOBAL(const char, *acpi_gbl_pld_vertical_position_list[]);
 ACPI_GLOBAL(const char, *acpi_gbl_pld_horizontal_position_list[]);
 ACPI_GLOBAL(const char, *acpi_gbl_pld_shape_list[]);
 
+ACPI_INIT_GLOBAL(u8, acpi_gbl_disasm_flag, FALSE);
+
 #endif
 
 /*
-- 
2.7.4

