From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 40/42] ACPICA: Add "root node" case to the ACPI name repair code
Date: Tue, 29 Dec 2015 14:04:11 +0800
Message-ID: <37c017d481b4b6dcb202619ba175009bcf5c4e2e.1451367389.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 95b40b31aa8148629fbe5de0356725fc01298003

Special-case the namespace root node, it has an unusual name.
This case can occur if there are errors during the execution
of module-level code.

Link: https://github.com/acpica/acpica/commit/95b40b31
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utstring.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/acpica/utstring.c b/drivers/acpi/acpica/utstring.c
index 0c2e2d2..958b2f7 100644
--- a/drivers/acpi/acpica/utstring.c
+++ b/drivers/acpi/acpica/utstring.c
@@ -240,6 +240,14 @@ void acpi_ut_repair_name(char *name)
 
 	ACPI_FUNCTION_NAME(ut_repair_name);
 
+	/*
+	 * Special case for the root node. This can happen if we get an
+	 * error during the execution of module-level code.
+	 */
+	if (ACPI_COMPARE_NAME(name, "\\___")) {
+		return;
+	}
+
 	ACPI_MOVE_NAME(&original_name, name);
 
 	/* Check each character in the name */
-- 
1.7.10
