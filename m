From: Wen Congyang <wency@cn.fujitsu.com>
Subject: [PATCH 2/7 v2] free memory device if acpi_memory_enable_device()
 failed
Date: Wed, 11 Jul 2012 15:47:50 +0800
Message-ID: <4FFD2FA6.3060101@cn.fujitsu.com>
References: <4FFD2F1E.10006@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:26996 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756719Ab2GKHnQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Jul 2012 03:43:16 -0400
In-Reply-To: <4FFD2F1E.10006@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Yasuaki ISIMATU <isimatu.yasuaki@jp.fujitsu.com>, David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

If acpi_memory_enable_device() fails, acpi_memory_enable_device() will
return a non-zero value, which means we fail to bind the memory device
to this driver. So we should free memory device before acpi_memory_device_add()
returns.

Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
---
 drivers/acpi/acpi_memhotplug.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index fe699ec..260a9c4 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -457,9 +457,11 @@ static int acpi_memory_device_add(struct acpi_device *device)
 	if (!acpi_memory_check_device(mem_device)) {
 		/* call add_memory func */
 		result = acpi_memory_enable_device(mem_device);
-		if (result)
+		if (result) {
 			printk(KERN_ERR PREFIX
 				"Error in acpi_memory_enable_device\n");
+			acpi_memory_device_free(mem_device);
+		}
 	}
 	return result;
 }
-- 
1.7.1

