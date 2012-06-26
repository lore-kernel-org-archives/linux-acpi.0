From: Wen Congyang <wency@cn.fujitsu.com>
Subject: [PATCH 2/8] free memory device if acpi_memory_enable_device() failed
Date: Tue, 26 Jun 2012 17:19:33 +0800
Message-ID: <4FE97EA5.9010904@cn.fujitsu.com>
References: <4FE97DD5.6030205@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:4562 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754261Ab2FZJPI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Jun 2012 05:15:08 -0400
In-Reply-To: <4FE97DD5.6030205@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Yasuaki ISIMATU <isimatu.yasuaki@jp.fujitsu.com>

If acpi_memory_enable_device() fails, acpi_memory_enable_device() will
return a non-zero value, which means we fail to bind the memory device
to this driver. So we should free memory device before acpi_memory_device_add()
returns.

Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
---
 drivers/acpi/acpi_memhotplug.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index f6831d1..bb7bc66 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -454,9 +454,11 @@ static int acpi_memory_device_add(struct acpi_device *device)
 	if (!acpi_memory_check_device(mem_device)) {
 		/* call add_memory func */
 		result = acpi_memory_enable_device(mem_device);
-		if (result)
+		if (result) {
 			printk(KERN_ERR PREFIX
 				"Error in acpi_memory_enable_device\n");
+			acpi_free_memory_device(mem_device);
+		}
 	}
 	return result;
 }
-- 
1.7.1

