From: Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v9 6/6] PCI: Stub out pci_request_acs() when CONFIG_PCI is not set
Date: Fri, 14 Dec 2018 16:33:19 +0000
Message-ID: <20181214163319.27479-7-okaya@kernel.org>
References: <20181214163319.27479-1-okaya@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181214163319.27479-1-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

ACPI IORT table code relies on pci_request_acs() to be present. Define
a stub function when CONFI_PCI is not set.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 include/linux/pci.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 51a5a5217667..f0f2f55ea93c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2101,7 +2101,11 @@ static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
 	return NULL;
 }
 
+#ifdef CONFIG_PCI
 void pci_request_acs(void);
+#else
+static inline void pci_request_acs(void) {}
+#endif
 bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags);
 bool pci_acs_path_enabled(struct pci_dev *start,
 			  struct pci_dev *end, u16 acs_flags);
-- 
2.19.0
