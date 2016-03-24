From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 14/30] ACPICA: iASL: Cleanup/optimization for ToPLD macro support
Date: Thu, 24 Mar 2016 09:40:05 +0800
Message-ID: <4da101fe100b86735bb812d4160c6735347b34f2.1458714003.git.lv.zheng@intel.com>
References: <cover.1458714002.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:62216 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757037AbcCXBkH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Mar 2016 21:40:07 -0400
In-Reply-To: <cover.1458714002.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 0e6125401cf38427d5376f4bafbfb3d5a40f8467

Use local variables for access to string/value Op fields.
Move duplicate PLD string tables to a single common table.

Link: https://github.com/acpica/acpica/commit/0e612540
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    9 +++++++++
 drivers/acpi/acpica/utglobal.c |   43 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 51b073b..54b42a5 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -361,6 +361,15 @@ ACPI_GLOBAL(u32, acpi_gbl_num_objects);
 
 #endif				/* ACPI_DEBUGGER */
 
+#if defined (ACPI_DISASSEMBLER) || defined (ACPI_ASL_COMPILER)
+
+ACPI_GLOBAL(const char, *acpi_gbl_pld_panel_list[]);
+ACPI_GLOBAL(const char, *acpi_gbl_pld_vertical_position_list[]);
+ACPI_GLOBAL(const char, *acpi_gbl_pld_horizontal_position_list[]);
+ACPI_GLOBAL(const char, *acpi_gbl_pld_shape_list[]);
+
+#endif
+
 /*****************************************************************************
  *
  * Application globals
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index 48fffcf..d45899c 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -221,6 +221,49 @@ struct acpi_fixed_event_info acpi_gbl_fixed_event_info[ACPI_NUM_FIXED_EVENTS] =
 };
 #endif				/* !ACPI_REDUCED_HARDWARE */
 
+#if defined (ACPI_DISASSEMBLER) || defined (ACPI_ASL_COMPILER)
+
+/* to_pld macro: compile/disassemble strings */
+
+const char *acpi_gbl_pld_panel_list[] = {
+	"TOP",
+	"BOTTOM",
+	"LEFT",
+	"RIGHT",
+	"FRONT",
+	"BACK",
+	"UNKNOWN",
+	NULL
+};
+
+const char *acpi_gbl_pld_vertical_position_list[] = {
+	"UPPER",
+	"CENTER",
+	"LOWER",
+	NULL
+};
+
+const char *acpi_gbl_pld_horizontal_position_list[] = {
+	"LEFT",
+	"CENTER",
+	"RIGHT",
+	NULL
+};
+
+const char *acpi_gbl_pld_shape_list[] = {
+	"ROUND",
+	"OVAL",
+	"SQUARE",
+	"VERTICALRECTANGLE",
+	"HORIZONTALRECTANGLE",
+	"VERTICALTRAPEZOID",
+	"HORIZONTALTRAPEZOID",
+	"UNKNOWN",
+	"CHAMFERED",
+	NULL
+};
+#endif
+
 /* Public globals */
 
 ACPI_EXPORT_SYMBOL(acpi_gbl_FADT)
-- 
1.7.10

