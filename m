From: Yinghai Lu <yhlu.kernel@gmail.com>
Subject: [PATCH 3/7] pci: using %pF in quirks.c
Date: Wed, 24 Sep 2008 19:04:33 -0700
Message-ID: <1222308277-10984-3-git-send-email-yhlu.kernel@gmail.com>
References: <1222308277-10984-1-git-send-email-yhlu.kernel@gmail.com>
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1222308277-10984-1-git-send-email-yhlu.kernel@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Yinghai Lu <yhlu.kernel@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Signed-off-by: Yinghai Lu <yhlu.kernel@gmail.com>
---
 drivers/pci/quirks.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 1f26712..addf2db 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1689,8 +1689,7 @@ static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f, struct pci_f
 		if ((f->vendor == dev->vendor || f->vendor == (u16) PCI_ANY_ID) &&
  		    (f->device == dev->device || f->device == (u16) PCI_ANY_ID)) {
 #ifdef DEBUG
-			dev_dbg(&dev->dev, "calling ");
-			print_fn_descriptor_symbol("%s\n", f->hook);
+			dev_dbg(&dev->dev, "calling %pF\n", f->hook);
 #endif
 			f->hook(dev);
 		}
-- 
1.5.6
