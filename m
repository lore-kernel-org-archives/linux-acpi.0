From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Subject: Re: ACPI kernel panic at boot on 2.6.0-test5-mm1
Date: 09 Sep 2003 21:03:28 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <p734qzlkcn3.fsf@oldwotan.suse.de>
References: <Pine.LNX.4.44.0309091420000.1412-100000@sol.cobite.com.suse.lists.linux.kernel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44.0309091420000.1412-100000-LUS5bfvkRbc2my70JjH4ImAII1b53ziAWbhkZt0VNHiE7OCCvI1iYQ@public.gmane.org>
To: David Mansfield <lkml-cnRKH8LNr2xl57MIdRCFDg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

David Mansfield <lkml-cnRKH8LNr2xl57MIdRCFDg@public.gmane.org> writes:

> at acpi_pci_link_calc_penalties

Try this (untested) patch

(2.6 version untested, I tested a similar patch on the 2.4 backport of
ACPI):

--- linux-2.6.0test5-work/arch/i386/pci/acpi.c-o	2003-08-23 13:03:09.000000000 +0200
+++ linux-2.6.0test5-work/arch/i386/pci/acpi.c	2003-09-09 21:01:49.000000000 +0200
@@ -15,10 +15,11 @@
 
 static int __init pci_acpi_init(void)
 {
+	extern int acpi_disabled;
 	if (pcibios_scanned)
 		return 0;
 
-	if (!(pci_probe & PCI_NO_ACPI_ROUTING)) {
+	if (!(pci_probe & PCI_NO_ACPI_ROUTING) && !acpi_disabled) {
 		if (!acpi_pci_irq_init()) {
 			printk(KERN_INFO "PCI: Using ACPI for IRQ routing\n");
 			printk(KERN_INFO "PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'\n");


-Andi
