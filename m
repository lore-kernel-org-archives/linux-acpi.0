From: Wen Congyang <wency@cn.fujitsu.com>
Subject: [PATCH 5/8] don't print message if request_resource() failed
Date: Tue, 26 Jun 2012 17:21:23 +0800
Message-ID: <4FE97F13.3000804@cn.fujitsu.com>
References: <4FE97DD5.6030205@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FE97DD5.6030205@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Yasuaki ISIMATU <isimatu.yasuaki@jp.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

If register_memory_resource() fails, the caller(add_memory()) will
return -EEXIST, and add_memory() returns -EEXIST only when
register_memory_resource() fails. The function acpi_memory_enable_device()
doesn't treat such erro as a fetal error, and don't want this message.
The function that calls add_memory() has printed message if add_memory()
failed, so don't print message in register_memory_resource().

Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
---
 mm/memory_hotplug.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0d7e3ec..2a14d35 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -74,7 +74,6 @@ static struct resource *register_memory_resource(u64 start, u64 size)
 	res->end = start + size - 1;
 	res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
 	if (request_resource(&iomem_resource, res) < 0) {
-		printk("System RAM resource %pR cannot be added\n", res);
 		kfree(res);
 		res = NULL;
 	}
-- 
1.7.1
