From: "canquan.shen" <shencanquan@huawei.com>
Subject: [PATCH v4] acpi: Fix CPU hot removal problem
Date: Thu, 15 Sep 2011 09:06:50 +0800
Message-ID: <4E714FAA.8060708@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([119.145.14.67]:51140 "EHLO
	szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243Ab1IOBHB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Sep 2011 21:07:01 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: Bjorn Helgaas <bhelgaas@google.com>, "shemminger@vyatta.com" <shemminger@vyatta.com>, "yakui.zhao@intel.com" <yakui.zhao@intel.com>, "xiaowei.yang@huawei.com" <xiaowei.yang@huawei.com>, hanweidong <hanweidong@huawei.com>, linqiangmin@huawei.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

We run linux as a guest in Xen environment. When we used the xen tools
(xm vcpu-set <n>) to hot add and remove vcpu to and from the guest, we
encountered the failure on vcpu removal. We found the reason is that it
didn't go to really remove cpu in the cpu removal code path.

This patch adds acpi_bus_trim in acpi_process_hotplug_notify to fix this
issue. With this patch, it works fine for us.

Signed-off-by:Canquan Shen <shencanquan@huawei.com>
---
  drivers/acpi/processor_driver.c |    6 ++++++
  1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/processor_driver.c 
b/drivers/acpi/processor_driver.c
index a4e0f1b..03d92d6 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -641,6 +641,7 @@ static void 
acpi_processor_hotplug_notify(acpi_handle handle,
  	struct acpi_processor *pr;
  	struct acpi_device *device = NULL;
  	int result;
+	u32 id;


  	switch (event) {
@@ -677,6 +678,11 @@ static void 
acpi_processor_hotplug_notify(acpi_handle handle,
  				    "Driver data is NULL, dropping EJECT\n");
  			return;
  		}
+		id = pr->id;
+		if (acpi_bus_trim(device, 1)) {
+			printk(KERN_ERR  PREFIX
+				    "Fail to Remove CPU %d\n", id);
+		}
  		break;
  	default:
  		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-- 
1.7.6.0

