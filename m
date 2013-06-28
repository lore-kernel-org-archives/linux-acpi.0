From: Jiang Liu <liuj97@gmail.com>
Subject: [PATCH v3 04/10] ACPI, DOCK: simplify implementation of dock_create_acpi_device()
Date: Sat, 29 Jun 2013 00:24:37 +0800
Message-ID: <1372436683-31711-5-git-send-email-liuj97@gmail.com>
References: <1372436683-31711-1-git-send-email-liuj97@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1372436683-31711-1-git-send-email-liuj97@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@sisk.pl>
Cc: liuj97@gmail.com, Jiang Liu <jiang.liu@huawei.com>, Yijing Wang <wangyijing@huawei.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

From: Jiang Liu <jiang.liu@huawei.com>

The return value of dock_create_acpi_device() is not used at all,
so change the signature to return void and simplify implementation.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/acpi/dock.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 8c4214d..22183c4 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -351,10 +351,8 @@ static int dock_present(struct dock_station *ds)
  *  handle if one does not exist already.  This should cause
  *  acpi to scan for drivers for the given devices, and call
  *  matching driver's add routine.
- *
- *  Returns a pointer to the acpi_device corresponding to the handle.
  */
-static struct acpi_device * dock_create_acpi_device(acpi_handle handle)
+static void dock_create_acpi_device(acpi_handle handle)
 {
 	struct acpi_device *device;
 	int ret;
@@ -367,10 +365,7 @@ static struct acpi_device * dock_create_acpi_device(acpi_handle handle)
 		ret = acpi_bus_scan(handle);
 		if (ret)
 			pr_debug("error adding bus, %x\n", -ret);
-
-		acpi_bus_get_device(handle, &device);
 	}
-	return device;
 }
 
 /**
-- 
1.8.1.2
