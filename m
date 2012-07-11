From: Wen Congyang <wency@cn.fujitsu.com>
Subject: [PATCH 5/7 v2] bind the memory device when the driver is being loaded
Date: Wed, 11 Jul 2012 15:49:51 +0800
Message-ID: <4FFD301F.4060409@cn.fujitsu.com>
References: <4FFD2F1E.10006@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FFD2F1E.10006@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Yasuaki ISIMATU <isimatu.yasuaki@jp.fujitsu.com>, David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
List-Id: linux-acpi@vger.kernel.org

We had introduced acpi_hotmem_initialized to avoid strange add_memory fail
message. But the memory device may not be used by the kernel, and the
device should be bound when the driver is being loaded. Remove
acpi_hotmem_initialized to allow that the device can be bound when the
driver is being loaded.

Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
---
 drivers/acpi/acpi_memhotplug.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index 1597348..3765375 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -87,8 +87,6 @@ struct acpi_memory_device {
 	struct list_head res_list;
 };
 
-static int acpi_hotmem_initialized;
-
 static acpi_status
 acpi_memory_get_resource(struct acpi_resource *resource, void *context)
 {
@@ -470,15 +468,6 @@ static int acpi_memory_device_add(struct acpi_device *device)
 
 	printk(KERN_DEBUG "%s \n", acpi_device_name(device));
 
-	/*
-	 * Early boot code has recognized memory area by EFI/E820.
-	 * If DSDT shows these memory devices on boot, hotplug is not necessary
-	 * for them. So, it just returns until completion of this driver's
-	 * start up.
-	 */
-	if (!acpi_hotmem_initialized)
-		return 0;
-
 	if (!acpi_memory_check_device(mem_device)) {
 		/* call add_memory func */
 		result = acpi_memory_enable_device(mem_device);
@@ -585,7 +574,6 @@ static int __init acpi_memory_device_init(void)
 		return -ENODEV;
 	}
 
-	acpi_hotmem_initialized = 1;
 	return 0;
 }
 
-- 
1.7.1
