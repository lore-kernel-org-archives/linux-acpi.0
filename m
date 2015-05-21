From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 17/19] ACPICA: acpi_help: Add option to display all known/supported ACPI tables.
Date: Thu, 21 May 2015 10:31:52 +0800
Message-ID: <766126a088089526ac664f68d5a5fcebe0763725.1432175162.git.lv.zheng@intel.com>
References: <cover.1432175162.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1432175162.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit d6d003556c6fc22e067d5d511577128a661266c3

-t option displays all ACPI tables.

Link: https://github.com/acpica/acpica/commit/d6d00355
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/aclocal.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 3596958..ffdb956 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -1175,4 +1175,9 @@ struct ah_uuid {
 	char *string;
 };
 
+struct ah_table {
+	char *signature;
+	char *description;
+};
+
 #endif				/* __ACLOCAL_H__ */
-- 
1.7.10
