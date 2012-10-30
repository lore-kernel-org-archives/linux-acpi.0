From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 8/8] PCI, ACPI: remove acpi_root_driver in reserse order
Date: Tue, 30 Oct 2012 10:42:45 -0700
Message-ID: <1351618965-16761-9-git-send-email-yinghai@kernel.org>
References: <20121030040237.GA10472@google.com>
 <1351618965-16761-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:33440 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965027Ab2J3RnY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Oct 2012 13:43:24 -0400
In-Reply-To: <1351618965-16761-1-git-send-email-yinghai@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>, Taku Izumi <izumi.taku@jp.fujitsu.com>, Jiang Liu <jiang.liu@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>

aka stop acpi root driver in this sequence: acpiphp, iommu, ioapic.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/acpi/pci_root.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index a27cbb57..012f40d 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -672,7 +672,7 @@ static int acpi_pci_root_remove(struct acpi_device *device, int type)
 	pci_stop_root_bus(root->bus);
 
 	mutex_lock(&acpi_pci_root_lock);
-	list_for_each_entry(driver, &acpi_pci_drivers, node)
+	list_for_each_entry_reverse(driver, &acpi_pci_drivers, node)
 		if (driver->remove)
 			driver->remove(root);
 	mutex_unlock(&acpi_pci_root_lock);
-- 
1.7.7

