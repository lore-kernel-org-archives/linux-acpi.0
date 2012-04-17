From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH 5/6] PCI/ACPI: Map PCI D3cold state to ACPI D3cold state
Date: Tue, 17 Apr 2012 13:47:55 +0800
Message-ID: <1334641676-14566-6-git-send-email-ming.m.lin@intel.com>
References: <1334641676-14566-1-git-send-email-ming.m.lin@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1334641676-14566-1-git-send-email-ming.m.lin@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.og>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Huang Ying <huang.ying.caritas@gmail.com>, Aaron Lu <aaron.lu@amd.com>
List-Id: linux-acpi@vger.kernel.org

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/pci/pci-acpi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 0f150f2..e641953 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -224,7 +224,7 @@ static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 		[PCI_D1] = ACPI_STATE_D1,
 		[PCI_D2] = ACPI_STATE_D2,
 		[PCI_D3hot] = ACPI_STATE_D3,
-		[PCI_D3cold] = ACPI_STATE_D3
+		[PCI_D3cold] = ACPI_STATE_D3_COLD
 	};
 	int error = -EINVAL;
 
-- 
1.7.2.5
