From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 05/15] ACPICA: debugger: dbconvert: free pld_info on error return path
Date: Fri, 19 Feb 2016 14:16:34 +0800
Message-ID: <3b8dcecd0f2b96bb037e6e433bf60a2e887e6f91.1455857580.git.lv.zheng@intel.com>
References: <cover.1455857575.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1455857575.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Colin Ian King <colin.king@canonical.com>, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

ACPICA commit 23e644670539e23818fa81e2af5e89ad6657e75c

A failed allocation of new_buffer causes a leak of pld_info
because the error return path fails to free pld_info. Ensure
it is freed on the error exit path.

Link: https://github.com/acpica/acpica/commit/23e64467
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/dbconvert.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/dbconvert.c b/drivers/acpi/acpica/dbconvert.c
index 9fee88f..68f4e0f4 100644
--- a/drivers/acpi/acpica/dbconvert.c
+++ b/drivers/acpi/acpica/dbconvert.c
@@ -408,7 +408,7 @@ void acpi_db_dump_pld_buffer(union acpi_object *obj_desc)
 
 	new_buffer = acpi_db_encode_pld_buffer(pld_info);
 	if (!new_buffer) {
-		return;
+		goto exit;
 	}
 
 	/* The two bit-packed buffers should match */
@@ -479,6 +479,7 @@ void acpi_db_dump_pld_buffer(union acpi_object *obj_desc)
 			       pld_info->horizontal_offset);
 	}
 
-	ACPI_FREE(pld_info);
 	ACPI_FREE(new_buffer);
+exit:
+	ACPI_FREE(pld_info);
 }
-- 
1.7.10
