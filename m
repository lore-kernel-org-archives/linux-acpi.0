From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 13/22] ACPICA: Remove extraneous check for null walk_state.
Date: Thu, 23 Jul 2015 12:53:28 +0800
Message-ID: <42d95cd3853a04fe3010b8c6126bab243bbd3b75.1437627016.git.lv.zheng@intel.com>
References: <cover.1437627016.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1437627016.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Markus Elfring <elfring@users.sourceforge.net>, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>

ACPICA commit f9fd6e8bad0f16ce2b436c5cda36ced0c2d85302

Reported by Markus Elfring.

Link: https://github.com/acpica/acpica/commit/f9fd6e8b
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/dsmethod.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index ea2bdde..cb53c44 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -582,9 +582,7 @@ cleanup:
 	/* On error, we must terminate the method properly */
 
 	acpi_ds_terminate_control_method(obj_desc, next_walk_state);
-	if (next_walk_state) {
-		acpi_ds_delete_walk_state(next_walk_state);
-	}
+	acpi_ds_delete_walk_state(next_walk_state);
 
 	return_ACPI_STATUS(status);
 }
-- 
1.7.10
