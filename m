From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 13/42] ACPICA: Debugger: Remove some unecessary NULL checks
Date: Tue, 29 Dec 2015 13:55:27 +0800
Message-ID: <de27c1c56fc53dd7426b09086191b4ed15ad4e2a.1451367389.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Markus Elfring <elfring@users.sourceforge.net>, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>

ACPICA commit 36fcc1b98def3fb6e20cf5e877ffc3c1592d0140

local strupr function already checks for NULL pointers.
Original linux patch submitted by:
Markus Elfring <elfring@users.sourceforge.net>

Link: https://github.com/acpica/acpica/commit/36fcc1b9
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/dbcmds.c  |    9 ++-------
 drivers/acpi/acpica/dbinput.c |    4 +---
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpica/dbcmds.c b/drivers/acpi/acpica/dbcmds.c
index 84ab1c2..328c35b 100644
--- a/drivers/acpi/acpica/dbcmds.c
+++ b/drivers/acpi/acpica/dbcmds.c
@@ -1131,13 +1131,8 @@ void acpi_db_trace(char *enable_arg, char *method_arg, char *once_arg)
 	u32 debug_layer = 0;
 	u32 flags = 0;
 
-	if (enable_arg) {
-		acpi_ut_strupr(enable_arg);
-	}
-
-	if (once_arg) {
-		acpi_ut_strupr(once_arg);
-	}
+	acpi_ut_strupr(enable_arg);
+	acpi_ut_strupr(once_arg);
 
 	if (method_arg) {
 		if (acpi_db_trace_method_name) {
diff --git a/drivers/acpi/acpica/dbinput.c b/drivers/acpi/acpica/dbinput.c
index 802779a..6203001 100644
--- a/drivers/acpi/acpica/dbinput.c
+++ b/drivers/acpi/acpica/dbinput.c
@@ -625,9 +625,7 @@ static u32 acpi_db_get_line(char *input_buffer)
 
 	/* Uppercase the actual command */
 
-	if (acpi_gbl_db_args[0]) {
-		acpi_ut_strupr(acpi_gbl_db_args[0]);
-	}
+	acpi_ut_strupr(acpi_gbl_db_args[0]);
 
 	count = i;
 	if (count) {
-- 
1.7.10
