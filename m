From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] acpi: missing break
Date: Thu, 25 Oct 2012 15:32:37 +0100
Message-ID: <20121025143229.17059.47783.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:53792 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759744Ab2JYObG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Oct 2012 10:31:06 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@linux.intel.com, linux-acpi@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

We handle NOTIFY_THROTTLING so don't then fll through to unsupported event

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/acpi/processor_driver.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index ae50bfc..a4352b8 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -409,6 +409,7 @@ static void acpi_processor_notify(struct acpi_device *device, u32 event)
 		acpi_bus_generate_proc_event(device, event, 0);
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
 						  dev_name(&device->dev), event, 0);
+		break;
 	default:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Unsupported event [0x%x]\n", event));

