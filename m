From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [PATCH v1 1/3] PCI / ACPI: Do not export pci_get_hp_params()
Date: Fri,  8 Feb 2019 10:24:11 -0600
Message-ID: <20190208162414.3996-2-mr.nuke.me@gmail.com>
References: <20190208162414.3996-1-mr.nuke.me@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190208162414.3996-1-mr.nuke.me@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bhelgaas@google.com
Cc: austin_bolen@dell.com, alex_gagniuc@dellteam.com, keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de, okaya@kernel.org, Alexandru Gagniuc <mr.nuke.me@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This is only used within drivers/pci, and there is no reason to make
it available outside of the PCI core.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/pci-acpi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index e1949f7efd9c..b25e5fa9d1c9 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -366,7 +366,6 @@ int pci_get_hp_params(struct pci_dev *dev, struct hotplug_params *hpp)
 	}
 	return -ENODEV;
 }
-EXPORT_SYMBOL_GPL(pci_get_hp_params);
 
 /**
  * pciehp_is_native - Check whether a hotplug port is handled by the OS
-- 
2.19.2
