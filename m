From: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: [patch 3/3] pci: use stored value of pin from pci_dev
Date: Thu, 27 Oct 2005 12:30:16 -0700
Message-ID: <1130441416.5996.26.camel@whizzy>
References: <20051027192603.488616000@whizzy>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932144AbVJ0Tb1@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: pcihpd-discuss@lists.sourceforge.net
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, rajesh.shah@intel.com, greg@kroah.com, len.brown@intel.com
List-Id: linux-acpi@vger.kernel.org

plain text document attachment (patch-interrupt-pin-pci)
Use the stored value of the interrupt pin rather than try to read
the config again.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
 
 drivers/pci/pci.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.13/drivers/pci/pci.c
===================================================================
--- linux-2.6.13.orig/drivers/pci/pci.c
+++ linux-2.6.13/drivers/pci/pci.c
@@ -567,7 +567,7 @@ pci_get_interrupt_pin(struct pci_dev *de
 {
 	u8 pin;
 
-	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
+	pin = dev->pin;
 	if (!pin)
 		return -1;
 	pin--;

--
