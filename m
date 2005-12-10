From: Dave Jones <davej@redhat.com>
Subject: ACPI sleeping whilst atomic warnings on resume.
Date: Sat, 10 Dec 2005 02:02:12 -0500
Message-ID: <20051210070212.GA28005@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964926AbVLJHC3@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: acpi-devel@lists.sourceforge.net
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

This has been broken for months.  On resume, we call acpi_pci_link_set()
with interrupts off, so we get a warning when we try to do a kmalloc
of non atomic memory.  The actual allocation is just 2 long's
(plus extra byte for some reason I can't fathom), so a simple conversion
to GFP_ATOMIC is probably the safest way to fix this.

The error looks like this..

Debug: sleeping function called from invalid context at mm/slab.c:2486
in_atomic():0, irqs_disabled():1
 [<c0143f6c>] kmem_cache_alloc+0x40/0x56
 [<c0206a2e>] acpi_pci_link_set+0x3f/0x17f
 [<c0206f96>] irqrouter_resume+0x1e/0x3c
 [<c0239bca>] __sysdev_resume+0x11/0x6b
 [<c0239e88>] sysdev_resume+0x34/0x52
 [<c023de21>] device_power_up+0x5/0xa

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.14/drivers/acpi/pci_link.c~	2005-12-10 01:58:17.000000000 -0500
+++ linux-2.6.14/drivers/acpi/pci_link.c	2005-12-10 01:58:36.000000000 -0500
@@ -316,7 +316,7 @@ static int acpi_pci_link_set(struct acpi
 	if (!link || !irq)
 		return_VALUE(-EINVAL);
 
-	resource = kmalloc(sizeof(*resource) + 1, GFP_KERNEL);
+	resource = kmalloc(sizeof(*resource) + 1, GFP_ATOMIC);
 	if (!resource)
 		return_VALUE(-ENOMEM);
 
