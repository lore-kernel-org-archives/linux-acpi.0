From: Jiang Liu <liuj97@gmail.com>
Subject: [RFC PATCH 09/11] PCI: serialize hotplug operations triggered by PCI hotplug sysfs interfaces
Date: Fri, 23 Mar 2012 22:58:25 +0800
Message-ID: <1332514707-9673-10-git-send-email-jiang.liu@huawei.com>
References: <1332514707-9673-1-git-send-email-jiang.liu@huawei.com>
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1332514707-9673-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>
Cc: Jiang Liu <jiang.liu@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>, Ashok Raj <ashok.raj@intel.com>, Jiang Liu <liuj97@gmail.com>, Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Use pci_lock_hotplug()/pci_unlock_hotplug() to serialize hotplug operations
triggered by PCI hotplug sysfs interfaces.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/pci/hotplug/pci_hotplug_core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index 202f4a9..633fe3a 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -121,6 +121,7 @@ static ssize_t power_write_file(struct pci_slot *pci_slot, const char *buf,
 		retval = -ENODEV;
 		goto exit;
 	}
+	pci_lock_hotplug();
 	switch (power) {
 		case 0:
 			if (slot->ops->disable_slot)
@@ -136,6 +137,7 @@ static ssize_t power_write_file(struct pci_slot *pci_slot, const char *buf,
 			err ("Illegal value specified for power\n");
 			retval = -EINVAL;
 	}
+	pci_unlock_hotplug();
 	module_put(slot->ops->owner);
 
 exit:	
-- 
1.7.5.4
