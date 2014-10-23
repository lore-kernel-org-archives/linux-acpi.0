From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 5/6] ACPI/OSL: Cleanup branch logics.
Date: Thu, 23 Oct 2014 10:12:28 +0800
Message-ID: <8755bcd69676dd1ac4734db27b89fe0d13732864.1414029477.git.lv.zheng@intel.com>
References: <cover.1414029477.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1414029477.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch cleans up trivial branch logics in acpi_os_unmap_iomem() to
eliminate several lines. No functional changes.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Tested-by: Fei Yang <fei.yang@intel.com>
---
 drivers/acpi/mem.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/mem.c b/drivers/acpi/mem.c
index c472237..c7c35f7 100644
--- a/drivers/acpi/mem.c
+++ b/drivers/acpi/mem.c
@@ -194,12 +194,10 @@ void __ref acpi_os_unmap_iomem(void __iomem *virt, acpi_size size)
 
 	mutex_lock(&acpi_ioremap_lock);
 	map = acpi_map_lookup_virt(virt, size);
-	if (!map) {
-		mutex_unlock(&acpi_ioremap_lock);
+	if (map)
+		acpi_map_put(map);
+	else
 		WARN(true, PREFIX "%s: bad address %p\n", __func__, virt);
-		return;
-	}
-	acpi_map_put(map);
 	mutex_unlock(&acpi_ioremap_lock);
 
 	acpi_map_cleanup(map);
-- 
1.7.10
