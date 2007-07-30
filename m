From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [Fwd: Re: long-term regression - Parallel Port broken?]
Date: Mon, 30 Jul 2007 08:08:17 -0600
Message-ID: <200707300808.17934.bjorn.helgaas@hp.com>
References: <1183030080.4249.172.camel@queen.suse.de> <200707292141.23339.bjorn.helgaas@hp.com> <Pine.LNX.4.64.0707292058040.6510@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel6.hp.com ([156.153.255.205]:46453 "EHLO atlrel6.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757386AbXG3OPy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 Jul 2007 10:15:54 -0400
In-Reply-To: <Pine.LNX.4.64.0707292058040.6510@asgard.lang.hm>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: david@lang.hm
Cc: trenn@suse.de, linux-acpi <linux-acpi@vger.kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>

On Sunday 29 July 2007 09:59:18 pm david@lang.hm wrote:
> On Sun, 29 Jul 2007, Bjorn Helgaas wrote:
> 
> >>>
> >>> Could you try the attached patch and collect the dmesg log and contents
> >>> of /proc/interrupts?
> >>
> >> done, see the files
> >> 2.6.22-rc4.interrupts
> >> 2.6.22-rc4.dmesg.test
> >> at http://lang.hm/linux
> >
> > Thanks, but you booted with "pnpacpi=off", so we didn't learn anything.
> > The port works with "pnpacpi=off" even without the patch.  Somebody
> > else tried my "disable/init/activate" patch with terrible results, so
> > that approach will need more work.
> 
> Ok, the new versions are there now.

I assume the port still didn't work.  My current theory is that
there's something wrong with parport DMA.

> > This seems an awful lot like this bug report:
> >  http://bugzilla.kernel.org/show_bug.cgi?id=5832
> >
> > Can you take a look at 5832, and maybe we can combine your problem
> > with that one if you agree they look the same?
> 
> yes, it definantly looks like the same thing.

OK, I added you to the cc: list of 5832.

Bjorn


