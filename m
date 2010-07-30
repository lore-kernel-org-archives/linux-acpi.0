From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH 5/6] PCI: portdrv: disable native hot-plug interrupt
Date: Fri, 30 Jul 2010 15:24:14 +0900
Message-ID: <4C52700E.3020605@jp.fujitsu.com>
References: <201007282323.56351.rjw@sisk.pl> <20100728144358.5e2c12ce@virtuousgeek.org> <4C510B90.9070302@jp.fujitsu.com> <201007291745.39285.rjw@sisk.pl> <4C526A85.3070902@jp.fujitsu.com> <4C526E3E.3000600@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <4C526E3E.3000600@jp.fujitsu.com>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, linux-pci@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

Some BIOS enable PCIe native hot-plug interrupt on _OSC evaluation.
But it should not be enabled until hot-plug service driver is loaded,
otherwise something wrong (ex. interrupt storm) can happen. So disable
hot-plug interrupt at port service probe time.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---
 drivers/pci/pcie/portdrv_core.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

Index: linux-2.6.35-rc6/drivers/pci/pcie/portdrv_core.c
===================================================================
--- linux-2.6.35-rc6.orig/drivers/pci/pcie/portdrv_core.c
+++ linux-2.6.35-rc6/drivers/pci/pcie/portdrv_core.c
@@ -253,8 +253,17 @@ static int get_port_device_capability(st
 	/* Hot-Plug Capable */
 	if ((cap_mask & PCIE_PORT_SERVICE_HP) && (reg16 & PCI_EXP_FLAGS_SLOT)) {
 		pci_read_config_dword(dev, pos + PCI_EXP_SLTCAP, &reg32);
-		if (reg32 & PCI_EXP_SLTCAP_HPC)
+		if (reg32 & PCI_EXP_SLTCAP_HPC) {
 			services |= PCIE_PORT_SERVICE_HP;
+			/*
+			 * Disable hot-plug interrupts in case the hot-plug
+			 * service driver is not loaded.
+			 */
+			pos += PCI_EXP_SLTCTL;
+			pci_read_config_word(dev, pos, &reg16);
+			reg16 &= ~(PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
+			pci_write_config_word(dev, pos, reg16);
+		}
 	}
 	/* AER capable */
 	if ((cap_mask & PCIE_PORT_SERVICE_AER)
