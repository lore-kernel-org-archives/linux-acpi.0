From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 26/30] ACPICA: Interpreter: Fix wrong conditions for acpi_ev_install_region_handlers() invocation
Date: Thu, 24 Mar 2016 09:41:32 +0800
Message-ID: <e2582aeb94d03c0b8c0781a1812b30f669d0ccfe.1458714003.git.lv.zheng@intel.com>
References: <cover.1458714002.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1458714002.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 9a6ecc9ec9ee067cad51eec539230bf494421d76

Since AE_ALREADY_EXISTS has already been converted to AE_OK in
acpi_ev_install_region_handlers(), this patch simplies a return value
check. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/9a6ecc9e
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/tbxfload.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 3151968..ac71abc 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -82,7 +82,7 @@ acpi_status __init acpi_load_tables(void)
 	 * their customized default region handlers.
 	 */
 	status = acpi_ev_install_region_handlers();
-	if (ACPI_FAILURE(status) && status != AE_ALREADY_EXISTS) {
+	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status,
 				"During Region initialization"));
 		return_ACPI_STATUS(status);
-- 
1.7.10
