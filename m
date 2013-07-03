From: Haicheng Li <haicheng.li@linux.intel.com>
Subject: [PATCH 3/3] acpi: remove unused LIST_HEAD(acpi_device_list)
Date: Wed,  3 Jul 2013 23:16:18 +0800
Message-ID: <1372864578-6925-3-git-send-email-haicheng.li@linux.intel.com>
References: <1372864578-6925-1-git-send-email-haicheng.li@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1372864578-6925-1-git-send-email-haicheng.li@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Haicheng Li <haicheng.lee@gmail.com>, Haicheng Li <haicheng.li@linux.intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Cc: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Haicheng Li <haicheng.li@linux.intel.com>
---
 drivers/acpi/scan.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 27da630..fcc0cdc 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -29,7 +29,6 @@ extern struct acpi_device *acpi_root;
 
 static const char *dummy_hid = "device";
 
-static LIST_HEAD(acpi_device_list);
 static LIST_HEAD(acpi_bus_id_list);
 static DEFINE_MUTEX(acpi_scan_lock);
 static LIST_HEAD(acpi_scan_handlers_list);
-- 
1.7.9.5
