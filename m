From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH v3 5/7] PCI: make disabled window printk style match the
	enabled ones
Date: Fri, 12 Feb 2010 10:00:12 -0700
Message-ID: <20100212170012.19522.29589.stgit@bob.kio>
References: <20100212165532.19522.47240.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <20100212165532.19522.47240.stgit@bob.kio>
Sender: linux-alpha-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, Peter Haight <peterh@sapros.com>, Gary Hade <garyhade@us.ibm.com>, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-am33-list@redhat.com, Yinghai Lu <yinghai@kernel.org>, linux-alpha@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Larry Finger <Larry.Finger@lwfinger.net>
List-Id: linux-acpi@vger.kernel.org


No functional change; this just tweaks the changes from 349e1823a405
so the new printks for disabled PCI-to-PCI bridge windows match the
ones for the enabled windows.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---

 drivers/pci/probe.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c5ecd3c..dacdeae 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -313,7 +313,7 @@ static void __devinit pci_read_bridge_io(struct pci_bus *child)
 		dev_printk(KERN_DEBUG, &dev->dev, "  bridge window %pR\n", res);
 	} else {
 		dev_printk(KERN_DEBUG, &dev->dev,
-			 "  bridge window [io  %04lx - %04lx] reg reading\n",
+			 "  bridge window [io  %#06lx-%#06lx] (disabled)\n",
 				 base, limit);
 	}
 }
@@ -338,7 +338,7 @@ static void __devinit pci_read_bridge_mmio(struct pci_bus *child)
 		dev_printk(KERN_DEBUG, &dev->dev, "  bridge window %pR\n", res);
 	} else {
 		dev_printk(KERN_DEBUG, &dev->dev,
-			"  bridge window [mem 0x%08lx - 0x%08lx] reg reading\n",
+			"  bridge window [mem %#010lx-%#010lx] (disabled)\n",
 					 base, limit + 0xfffff);
 	}
 }
@@ -390,7 +390,7 @@ static void __devinit pci_read_bridge_mmio_pref(struct pci_bus *child)
 		dev_printk(KERN_DEBUG, &dev->dev, "  bridge window %pR\n", res);
 	} else {
 		dev_printk(KERN_DEBUG, &dev->dev,
-		     "  bridge window [mem 0x%08lx - %08lx pref] reg reading\n",
+		     "  bridge window [mem %#010lx-%#010lx pref] (disabled)\n",
 					 base, limit + 0xfffff);
 	}
 }

