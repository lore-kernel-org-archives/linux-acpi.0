From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 29/31] ACPICA: Disassembler: Some cleanup of the table dump module.
Date: Mon, 13 Apr 2015 11:51:16 +0800
Message-ID: <dcd3d65ba07b8fc19b284ed58c9e453868f377a8.1428893939.git.lv.zheng@intel.com>
References: <cover.1428893935.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1428893935.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 330e3b7ec96fbd2e0677b786c09d86be36dd5673

Cleanup of LPIT table output (Dean Nelson)
Split some long lines.

Link: https://github.com/acpica/acpica/commit/330e3b7e
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl2.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index e3ab1ff..cafdeb5 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -846,7 +846,8 @@ struct acpi_lpit_header {
 
 enum acpi_lpit_type {
 	ACPI_LPIT_TYPE_NATIVE_CSTATE = 0x00,
-	ACPI_LPIT_TYPE_SIMPLE_IO = 0x01
+	ACPI_LPIT_TYPE_SIMPLE_IO = 0x01,
+	ACPI_LPIT_TYPE_RESERVED = 0x02	/* 2 and above are reserved */
 };
 
 /* Masks for Flags field above  */
-- 
1.7.10
