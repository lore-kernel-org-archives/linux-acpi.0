From: Shaohua Li <shaohua.li@intel.com>
Subject: [RFC 2/2] don't enable link device in IOAPIC mode
Date: Tue, 12 Dec 2006 09:26:32 +0800
Message-ID: <1165886792.19586.26.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:41013 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750809AbWLLB1s (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Dec 2006 20:27:48 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Stian Jordet <stian_web@jordet.nu>, Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>

In Stian's system, if link device is enabled in IOAPIC mode, pci device
will connect to link device and link device connect to IOAPIC pin. That
is the device's interrupt is decided by link's irq. If link device is
disabled, pci device is connected to IOAPIC pin.
There are two devices who share one link device in pic mode, but in
IOAPIC mode, _PRT table reported one device connected to IOAPIC pin and
the other connected to the link device. If the link device is enabled,
the device connected to IOAPIC pin directly will break as _PRT reported
interrupt for the device doesn't reflect the case link device is
enabled. If we leave the link device disabled, the device which
connected to the link device doesn't break. It appears the link device
is just used to get an interrupt number instead of for real interrupt
routing. So in this patch, if current irq model is IOAPIC, we will leave
link device disabled and just use its active irq number.

Signed-off-by: Shaohua Li<shaohua.li@intel.com>

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index d53bd98..655bb49 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -527,6 +527,10 @@ static int acpi_pci_link_allocate(struct
 	int i;
 
 
+	if (acpi_irq_model == ACPI_IRQ_MODEL_IOAPIC && link->irq.active) {
+		link->irq.initialized = 1;
+		return 0;
+	}
 	if (link->irq.initialized) {
 		if (link->refcnt == 0)
 			/* This means the link is disabled but initialized */
