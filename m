From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 02/15] ACPICA: Remove incorrect "static" from a global structure
Date: Fri, 19 Feb 2016 14:16:14 +0800
Message-ID: <6ed1ba35fb42d964983170d7d0c313404cf3f256.1455857579.git.lv.zheng@intel.com>
References: <cover.1455857575.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1455857575.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 7a9956a2afd3863fa7d9fe4a64a957389d09f3c2

Reported by Colin Ian King. ACPICA BZ 1239.

Link: https://github.com/acpica/acpica/commit/7a9956a2
Link: https://bugs.acpica.org/show_bug.cgi?id=1239
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acpredef.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index 52f6bee..5faeab4 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -1125,7 +1125,7 @@ const union acpi_predefined_info acpi_gbl_resource_names[] = {
 	PACKAGE_INFO(0, 0, 0, 0, 0, 0)	/* Table terminator */
 };
 
-static const union acpi_predefined_info acpi_gbl_scope_names[] = {
+const union acpi_predefined_info acpi_gbl_scope_names[] = {
 	{{"_GPE", 0, 0}},
 	{{"_PR_", 0, 0}},
 	{{"_SB_", 0, 0}},
-- 
1.7.10
