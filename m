From: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: [patch 3/4] pci: really fix parent's subordinate busnr
Date: Tue, 17 Jan 2006 16:57:01 -0800
Message-ID: <1137545822.19858.48.camel@whizzy>
References: <20060116200218.275371000@whizzy>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932528AbWARAzB@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, pcihpd-discuss@lists.sourceforge.net, len.brown@intel.com, linux-acpi@vger.kernel.org, pavel@ucw.cz
List-Id: linux-acpi@vger.kernel.org

After you find the maximum value of the subordinate buses below the child
bus, you must fix the parent's subordinate bus number again, otherwise
it may be too small.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com> 


 drivers/pci/probe.c |    5 +++++
 1 files changed, 5 insertions(+)

--- linux-2.6.15-mm.orig/drivers/pci/probe.c
+++ linux-2.6.15-mm/drivers/pci/probe.c
@@ -537,6 +537,11 @@ int __devinit pci_scan_bridge(struct pci
 			pci_fixup_parent_subordinate_busnr(child, max);
 			/* Now we can scan all subordinate buses... */
 			max = pci_scan_child_bus(child);
+			/*
+			 * now fix it up again since we have found
+			 * the real value of max.
+			 */
+			pci_fixup_parent_subordinate_busnr(child, max);
 		} else {
 			/*
 			 * For CardBus bridges, we leave 4 bus numbers
