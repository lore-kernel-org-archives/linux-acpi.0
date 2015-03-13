From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: [Bugfix] x86/PCI: Release PCI IRQ resource only if PCI device is disabled when unbinding
Date: Fri, 13 Mar 2015 10:06:43 +0800
Message-ID: <1426212403-16234-1-git-send-email-jiang.liu@linux.intel.com>
References: <1426092450.3643.7.camel@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:20209 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753603AbbCMCEc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Mar 2015 22:04:32 -0400
In-Reply-To: <1426092450.3643.7.camel@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc: Jiang Liu <jiang.liu@linux.intel.com>, "bp @ alien8 . de" <bp@alien8.de>, Lv Zheng <lv.zheng@intel.com>, "yinghai @ kernel . org" <yinghai@kernel.org>, "lenb @ kernel . org" <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org

To support IOAPIC hot-removal, we need to release PCI interrupt resource
when unbinding PCI device driver. But due to historical reason,
/*
 * We would love to complain here if pci_dev->is_enabled is set, that
 * the driver should have called pci_disable_device(), but the
 * unfortunate fact is there are too many odd BIOS and bridge setups
 * that don't like drivers doing that all of the time.
 * Oh well, we can dream of sane hardware when we sleep, no matter how
 * horrible the crap we have to deal with is when we are awake...
 */
some drivers don't call pci_disable_device() when unloading, which
prevents us from reallocating PCI interrupt resource on reloading
PCI driver and causes regressions.

So release PCI interrupt resource only if PCI device is disabled when
unbinding. By this way, we could support IOAPIC hot-removal on latest
platforms and avoid regressions on old platforms.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/pci/common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 3d2612b68694..8d792142cb2a 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -527,7 +527,7 @@ static int pci_irq_notifier(struct notifier_block *nb, unsigned long action,
 	if (action != BUS_NOTIFY_UNBOUND_DRIVER)
 		return NOTIFY_DONE;
 
-	if (pcibios_disable_irq)
+	if (!pci_is_enabled(dev) && pcibios_disable_irq)
 		pcibios_disable_irq(dev);
 
 	return NOTIFY_OK;
-- 
1.7.10.4

