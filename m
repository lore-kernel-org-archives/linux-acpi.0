From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 1/6] ACPICA: Debugger: Remove unnecessary status check
Date: Thu, 19 Nov 2015 14:08:21 +0800
Message-ID: <d13c2314e8a4a3403505a543c01f5c79b5792330.1447910797.git.lv.zheng@intel.com>
References: <cover.1446790780.git.lv.zheng@intel.com> <cover.1447910797.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:27011 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753515AbbKSGI0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Nov 2015 01:08:26 -0500
In-Reply-To: <cover.1447910797.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Colin Ian King <colin.king@canonical.com>, Bob Moore <robert.moore@intel.com>

From: Colin Ian King <colin.king@canonical.com>

ACPICA commit f9d5c6c9a25e9f5ac05458bfcd8b381e21bb2ba5

ACPICA BZ 1205. Colin Ian King.

Link: https://bugs.acpica.org/show_bug.cgi?id=1205
Link: https://github.com/acpica/acpica/commit/f9d5c6c9
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/dbinput.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/acpi/acpica/dbinput.c b/drivers/acpi/acpica/dbinput.c
index 0480254..fe93f67 100644
--- a/drivers/acpi/acpica/dbinput.c
+++ b/drivers/acpi/acpica/dbinput.c
@@ -1246,9 +1246,6 @@ acpi_status acpi_db_user_commands(char prompt, union acpi_parse_object *op)
 			 * and wait for the command to complete.
 			 */
 			acpi_os_release_mutex(acpi_gbl_db_command_ready);
-			if (ACPI_FAILURE(status)) {
-				return (status);
-			}
 
 			status =
 			    acpi_os_acquire_mutex(acpi_gbl_db_command_complete,
-- 
1.7.10

