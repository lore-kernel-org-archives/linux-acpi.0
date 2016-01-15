From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 3/4] ACPICA: Silence a -Wbad-function-cast warning when acpi_uintptr_t is 'uintptr_t'.
Date: Fri, 15 Jan 2016 08:17:11 +0800
Message-ID: <66c17dfa39ec6efcb0797dba02bef38996f672e9.1452741212.git.lv.zheng@intel.com>
References: <cover.1452741211.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1452741211.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Sascha Wildner <saw@online.de>
List-Id: linux-acpi@vger.kernel.org

From: Sascha Wildner <saw@online.de>

Signed-off-by: Sascha Wildner <saw@online.de>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/dbdisply.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/dbdisply.c b/drivers/acpi/acpica/dbdisply.c
index f10c158..502bb58 100644
--- a/drivers/acpi/acpica/dbdisply.c
+++ b/drivers/acpi/acpica/dbdisply.c
@@ -599,12 +599,14 @@ void acpi_db_display_calling_tree(void)
 
 void acpi_db_display_object_type(char *object_arg)
 {
+	acpi_size arg;
 	acpi_handle handle;
 	struct acpi_device_info *info;
 	acpi_status status;
 	u32 i;
 
-	handle = ACPI_TO_POINTER(strtoul(object_arg, NULL, 16));
+	arg = strtoul(object_arg, NULL, 16);
+	handle = ACPI_TO_POINTER(arg);
 
 	status = acpi_get_object_info(handle, &info);
 	if (ACPI_FAILURE(status)) {
-- 
1.7.10
