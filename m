From: Chris Wright <chrisw-3NddpPZAyC0@public.gmane.org>
Subject: Re: Fixing USB interrupt problems with ACPI enabled
Date: Wed, 3 Sep 2003 15:37:46 -0700
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030903153746.A19323@osdlab.pdx.osdl.net>
References: <7F740D512C7C1046AB53446D3720017304AEEC@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7F740D512C7C1046AB53446D3720017304AEEC-exJ48ZlmiLrcnAH0NVKmOFDQ4js95KgL@public.gmane.org>; from jun.nakajima-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org on Sat, Aug 30, 2003 at 08:47:41AM -0700
To: "Nakajima, Jun" <jun.nakajima-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi <linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

* Nakajima, Jun (jun.nakajima-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org) wrote:
> Doing this for Len, who is on vacation. We would like to thank the
> people who provided debugging info such as acpidmp, dmidecode, and
> demsg. This is one of our findings, and we believe this would fix some
> interrupt problems (with USB, for example) with ACPI enabled, especially
> when the dmesg reads like:
> 
> ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 0
> ACPI: PCI Interrupt Link [ALKB] enabled at IRQ 0
> ACPI: PCI Interrupt Link [ALKC] enabled at IRQ 0
> ACPI: PCI Interrupt Link [ALKD] enabled at IRQ 0
> 
> Basically we assumed that _CRS returned the one we set with _SRS, when
> setting up a PCI interrupt link device, but that's not the case with
> some AML codes. Some of them always return 0.
> Attached is a patch against 2.4.23-pre1. It should be easy to apply this
> to 2.6. 

This patch wouldn't compile with CONFIG_ACPI_DEBUG=y (I'm using
2.6.0-test4-mm5).  Simple fix below.  With this patch my machine is worse
off than without it.  In either case the machine hangs during boot (not
in the same place, of course).  And booting with pci=noapci works w/out
the patch, but leaves the machine nearly disfunctional w/ the patch.
Any particular information helpful?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

--- 2.6.0-test4-mm5/drivers/acpi/pci_link.c.try	Wed Sep  3 15:06:33 2003
+++ 2.6.0-test4-mm5/drivers/acpi/pci_link.c	Wed Sep  3 15:07:22 2003
@@ -285,6 +285,8 @@ acpi_pci_link_try_get_current (
 {
 	int result;
 
+	ACPI_FUNCTION_TRACE("acpi_pci_link_try_get_current");
+
 	result = acpi_pci_link_get_current(link);
 	if (result && link->irq.active) {
  		return_VALUE(result);
