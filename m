From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 03/14] x86 acpi/irq: pci device dev->irq is an isa irq not a gsi
Date: Mon, 29 Mar 2010 16:20:14 -0700
Message-ID: <1269904825-27462-3-git-send-email-ebiederm@xmission.com>
References: <m1r5n2wwah.fsf_-_@fess.ebiederm.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:54133 "EHLO
	out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754006Ab0C2XUt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Mar 2010 19:20:49 -0400
In-Reply-To: <m1r5n2wwah.fsf_-_@fess.ebiederm.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Suresh Siddha <suresh.b.siddha@intel.com>, len.brown@intel.com, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, linux-acpi@vger.kernel.org, Iranna D Ankad <iranna.ankad@in.ibm.com>, Gary Hade <garyhade@us.ibm.com>, Natalie Protasevich <protasnb@gmail.com>, "Eric W. Biederman" <ebiederm@xmission.com>

From: Eric W. Biederman <ebiederm@xmission.com>

Strictly speaking on x86 (where acpi is used) dev->irq must be
a dual i8259 irq input aka an isa irq.  Therefore we should translate
that isa irq into a gsi before passing it to a function that
takes a gsi.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 drivers/acpi/pci_irq.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 843699e..703541d 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -400,11 +400,13 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 	 * driver reported one, then use it. Exit in any case.
 	 */
 	if (gsi < 0) {
+		u32 dev_gsi;
 		dev_warn(&dev->dev, "PCI INT %c: no GSI", pin_name(pin));
 		/* Interrupt Line values above 0xF are forbidden */
-		if (dev->irq > 0 && (dev->irq <= 0xF)) {
-			printk(" - using IRQ %d\n", dev->irq);
-			acpi_register_gsi(&dev->dev, dev->irq,
+		if (dev->irq > 0 && (dev->irq <= 0xF) &&
+		    (acpi_isa_irq_to_gsi(dev->irq, &dev_gsi) == 0)) {
+			printk(" - using ISA IRQ %d\n", dev->irq);
+			acpi_register_gsi(&dev->dev, dev_gsi,
 					  ACPI_LEVEL_SENSITIVE,
 					  ACPI_ACTIVE_LOW);
 			return 0;
-- 
1.6.5.2.143.g8cc62

