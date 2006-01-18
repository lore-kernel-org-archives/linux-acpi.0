From: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: [patch 4/4]  pci: quirk for IBM Dock II cardbus controllers
Date: Tue, 17 Jan 2006 16:57:04 -0800
Message-ID: <1137545824.19858.49.camel@whizzy>
References: <20060116200218.275371000@whizzy>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964984AbWARAyd@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, pcihpd-discuss@lists.sourceforge.net, len.brown@intel.com, linux-acpi@vger.kernel.org, pavel@ucw.cz
List-Id: linux-acpi@vger.kernel.org

The IBM Dock II cardbus bridges require some extra configuration
before Yenta is loaded in order to setup the Interrupts to be
routed properly. 

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

 drivers/pci/quirks.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+)

--- linux-2.6.15-mm.orig/drivers/pci/quirks.c
+++ linux-2.6.15-mm/drivers/pci/quirks.c
@@ -1242,6 +1242,33 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_IN
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_PXHV,	quirk_pcie_pxh);
 

+/*
+ * Fixup the cardbus bridges on the IBM Dock II docking station
+ */
+static void __devinit quirk_ibm_dock2_cardbus(struct pci_dev *dev)
+{
+	u32 val;
+
+	/*
+	 * tie the 2 interrupt pins to INTA, and configure the
+	 * multifunction routing register to handle this.
+	 */
+	if ((dev->subsystem_vendor == PCI_VENDOR_ID_IBM) &&
+		(dev->subsystem_device == 0x0148)) {
+		printk(KERN_INFO "PCI: Found IBM Dock II Cardbus Bridge "
+			"applying quirk\n");
+		pci_read_config_dword(dev, 0x8c, &val);
+		val = ((val & 0xffffff00) | 0x1002);
+		pci_write_config_dword(dev, 0x8c, val);
+		pci_read_config_dword(dev, 0x80, &val);
+		val = ((val & 0x00ffff00) | 0x2864c077);
+		pci_write_config_dword(dev, 0x80, val);
+	}
+}
+
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_1420,
+				quirk_ibm_dock2_cardbus);
+
 static void __devinit quirk_netmos(struct pci_dev *dev)
 {
 	unsigned int num_parallel = (dev->subsystem_device & 0xf0) >> 4;
