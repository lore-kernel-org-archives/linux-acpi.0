From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH v2 1/7] PCI: make disabled window printk style match the
	enabled ones
Date: Mon, 08 Feb 2010 15:44:23 -0700
Message-ID: <20100208224423.27954.37294.stgit@bob.kio>
References: <20100208224236.27954.4358.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20100208224236.27954.4358.stgit@bob.kio>
Sender: linux-pci-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Tony Luck <tony.luck@intel.com>, linux-pci@vger.kernel.org, Peter Haight <peterh@sapros.com>, Gary Hade <garyhade@us.ibm.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Larry Finger <Larry.Finger@lwfinger.net>
List-Id: linux-acpi@vger.kernel.org


No functional change; this just tweaks the changes from 349e1823a405
so the new printks for disabled PCI-to-PCI bridge windows match the
ones for the enabled windows.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---

 drivers/pci/probe.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index d300943..2555d66 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -325,7 +325,7 @@ void __devinit pci_read_bridge_bases(struct pci_bus *child)
 		dev_printk(KERN_DEBUG, &dev->dev, "  bridge window %pR\n", res);
 	} else {
 		dev_printk(KERN_DEBUG, &dev->dev,
-			 "  bridge window [io  %04lx - %04lx] reg reading\n",
+			 "  bridge window [io  %#06lx-%#06lx] (disabled)\n",
 				 base, limit);
 	}
 
@@ -341,7 +341,7 @@ void __devinit pci_read_bridge_bases(struct pci_bus *child)
 		dev_printk(KERN_DEBUG, &dev->dev, "  bridge window %pR\n", res);
 	} else {
 		dev_printk(KERN_DEBUG, &dev->dev,
-			"  bridge window [mem 0x%08lx - 0x%08lx] reg reading\n",
+			"  bridge window [mem %#010lx-%#010lx] (disabled)\n",
 					 base, limit + 0xfffff);
 	}
 
@@ -384,7 +384,7 @@ void __devinit pci_read_bridge_bases(struct pci_bus *child)
 		dev_printk(KERN_DEBUG, &dev->dev, "  bridge window %pR\n", res);
 	} else {
 		dev_printk(KERN_DEBUG, &dev->dev,
-		     "  bridge window [mem 0x%08lx - %08lx pref] reg reading\n",
+		     "  bridge window [mem %#010lx-%#010lx pref] (disabled)\n",
 					 base, limit + 0xfffff);
 	}
 }
