From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 07/16] ACPICA: Tables: Add sanity check in acpi_put_table()
Date: Mon, 10 Jul 2017 15:23:21 +0800
Message-ID: <8ef4ab2e50e5aad6eca3db2131ba33e676e2dff7.1499671182.git.lv.zheng@intel.com>
References: <cover.1499671181.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:63750 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751224AbdGJHXZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 Jul 2017 03:23:25 -0400
In-Reply-To: <cover.1499671181.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 73512384c9eb1e7f1b28d0a7372df26a3732f96b

To avoid caller to trigger unexpected warning messages (Link #1):
  ACPI Warning: Table ffffffffbb461d20, Validation count is zero before decrement
Which is reported from acpi_tb_put_table(). When the table is validated, the
pointer must be non-zero. Thus the message is not suitable for invalidated
tables. This patch fixes the callee side based on this fact. Reported by
Cristian Aravena Romero, Fixed by Lv Zheng.

Link: https://github.com/acpica/acpica/commit/73512384
Link: https://bugzilla.kernel.org/show_bug.cgi?id=191221 [#1]
Reported-by: Cristian Aravena Romero <caravena@gmail.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/tbxface.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index 010b1c43..18508b2 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -369,6 +369,10 @@ void acpi_put_table(struct acpi_table_header *table)
 
 	ACPI_FUNCTION_TRACE(acpi_put_table);
 
+	if (!table) {
+		return_VOID;
+	}
+
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 
 	/* Walk the root table list */
-- 
2.7.4

