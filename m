From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [Fwd: Re: long-term regression - Parallel Port broken?]
Date: Sun, 29 Jul 2007 21:41:22 -0600
Message-ID: <200707292141.23339.bjorn.helgaas@hp.com>
References: <1183030080.4249.172.camel@queen.suse.de> <200707241540.43868.bjorn.helgaas@hp.com> <Pine.LNX.4.64.0707291821590.6331@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:53288 "EHLO atlrel7.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937206AbXG3Dl7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Jul 2007 23:41:59 -0400
In-Reply-To: <Pine.LNX.4.64.0707291821590.6331@asgard.lang.hm>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: david@lang.hm
Cc: trenn@suse.de, linux-acpi <linux-acpi@vger.kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>

On Sunday 29 July 2007 07:22:41 pm david@lang.hm wrote:
> On Tue, 24 Jul 2007, Bjorn Helgaas wrote:
> 
> > On Saturday 21 July 2007 08:09:11 pm david@lang.hm wrote:
> >> On Fri, 6 Jul 2007, Bjorn Helgaas wrote:
> >>> Ultimately, you should have CONFIG_ACPI=y and CONFIG_PNPACPI=y, and you
> >>> should not have to boot with "noisapnp" or "pnpacpi=off".  My guess is
> >>> that you only need "pnpacpi=off" to work around the current problem.
> >>
> >> these two options are enabled and pnpacpi=off does solve the problem.
> >> ...
> >> there's now a dmesg.pnpacpi_off which works, and you are correct that the
> >> dmesg that's there is the non working one.
> >
> > Thanks.  Here's what I glean from that.  With no arguments, it doesn't work:
> >
> >    parport_pc 00:0a: reported by Plug and Play ACPI
> >    parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
> >    parport0: Printer, Brother HL-5040 series
> >    lp0: using parport0 (interrupt-driven).
> >
> > With pnpacpi=off, it works:
> >
> >    parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
> >    parport0: irq 7 detected
> >    parport0: Printer, Brother HL-5040 series
> >    lp0: using parport0 (polling).
> >
> > With pnpacpi=off, or a kernel without PNPACPI, we just probe at 0x378
> > and use the port in polling mode, and it works.
> >
> > PNPACPI claims the device supports interrupts, so we try to use it in
> > interrupt mode, and it doesn't work.  It's possible that ACPI is lying
> > to us, and the interrupt really doesn't work.  Or maybe the interrupt
> > *does* work, but the BIOS left it half-configured.
> >
> > Could you try the attached patch and collect the dmesg log and contents
> > of /proc/interrupts?
> 
> done, see the files
> 2.6.22-rc4.interrupts
> 2.6.22-rc4.dmesg.test
> at http://lang.hm/linux

Thanks, but you booted with "pnpacpi=off", so we didn't learn anything.
The port works with "pnpacpi=off" even without the patch.  Somebody
else tried my "disable/init/activate" patch with terrible results, so
that approach will need more work.

This seems an awful lot like this bug report:
  http://bugzilla.kernel.org/show_bug.cgi?id=5832

Can you take a look at 5832, and maybe we can combine your problem
with that one if you agree they look the same?

Bjorn
