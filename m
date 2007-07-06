From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [Fwd: Re: long-term regression - Parallel Port broken?]
Date: Fri, 6 Jul 2007 15:20:36 -0600
Message-ID: <200707061520.37137.bjorn.helgaas@hp.com>
References: <1183030080.4249.172.camel@queen.suse.de> <200707061038.50755.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:43018 "EHLO atlrel8.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764244AbXGFV0z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 6 Jul 2007 17:26:55 -0400
In-Reply-To: <200707061038.50755.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: david@lang.hm, linux-acpi <linux-acpi@vger.kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>

On Friday 06 July 2007 10:38:50 am Bjorn Helgaas wrote:
> > should I test the two individually? or just plan on useing both from now 
> > on?
> > I normally disable PnP (both ISA and PCI), should I leave it enabled with 
> > the newer kernels and this motherboard?
> 
> Ultimately, you should have CONFIG_ACPI=y and CONFIG_PNPACPI=y, and you
> should not have to boot with "noisapnp" or "pnpacpi=off".  My guess is
> that you only need "pnpacpi=off" to work around the current problem.
> 
> At http://linux.lang.hm/linux, I see dmesg logs (with tons of
> kobject debug that's useless to me) from 2.6.22-rc4.  It would
> be useful to have the log from 2.6.22-rc4 with "pnpacpi=off"
> (which I expect to work), so we could compare it with the
> "2.6.22-rc4.dmesg" log, which I assume a non-working one.
> 
> Linux PNPACPI currently doesn't manage resources quite the same way
> Windows does, and that might account for this problem.  You might
> try this:
> 
>   - boot without "pnpacpi=off" (leave PNPACPI enabled)
>   - before loading the parport_pc driver, do this:
>     # echo "disable" > /sys/devices/pnp0/00:0a/resources
>     # echo "enable" > /sys/devices/pnp0/00:0a/resources

Sorry, I meant:

     # echo "disable" > /sys/devices/pnp0/00:0a/resources
     # echo "clear"   > /sys/devices/pnp0/00:0a/resources
     # echo "enable"  > /sys/devices/pnp0/00:0a/resources
