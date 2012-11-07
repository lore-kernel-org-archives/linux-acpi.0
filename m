From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] ACPI: fix missing unlock on error in acpi_memory_remove_memory()
Date: Wed, 7 Nov 2012 20:38:04 +0800
Message-ID: <CAPgLHd_=OTwu-3tVXT0o8+x=N_9dZOkQ4A7HFr0SNdUiyAy_yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org, rjw@sisk.pl, wency@cn.fujitsu.com
Cc: yongjun_wei@trendmicro.com.cn, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add the missing mutex_unlock() before return from function
acpi_memory_remove_memory() in the error handling case.

Introduce by commit 85fcb3758c10e063a2a30dfad75017097999deed
'ACPI / memory-hotplug: introduce a mutex lock to protect the list in acpi_memory_device'

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/acpi/acpi_memhotplug.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index 92c973a..e573e87 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -325,8 +325,10 @@ static int acpi_memory_remove_memory(struct acpi_memory_device *mem_device)
 	list_for_each_entry_safe(info, n, &mem_device->res_list, list) {
 		if (info->enabled) {
 			result = remove_memory(info->start_addr, info->length);
-			if (result)
+			if (result) {
+				mutex_unlock(&mem_device->list_lock);
 				return result;
+			}
 		}
 
 		list_del(&info->list);
