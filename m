From: david@lang.hm
Subject: Re: [Fwd: Re: long-term regression - Parallel Port broken?]
Date: Sat, 21 Jul 2007 19:09:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707211905450.6747@asgard.lang.hm>
References: <1183030080.4249.172.camel@queen.suse.de> <200707061038.50755.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:52307
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbXGVCKB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Jul 2007 22:10:01 -0400
In-Reply-To: <200707061038.50755.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: trenn@suse.de, linux-acpi <linux-acpi@vger.kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>

On Fri, 6 Jul 2007, Bjorn Helgaas wrote:

>> should I test the two individually? or just plan on useing both from now
>> on?
>> I normally disable PnP (both ISA and PCI), should I leave it enabled with
>> the newer kernels and this motherboard?
>
> Ultimately, you should have CONFIG_ACPI=y and CONFIG_PNPACPI=y, and you
> should not have to boot with "noisapnp" or "pnpacpi=off".  My guess is
> that you only need "pnpacpi=off" to work around the current problem.

these two options are enabled and pnpacpi=off does solve the problem.x

> At http://linux.lang.hm/linux, I see dmesg logs (with tons of
> kobject debug that's useless to me) from 2.6.22-rc4.  It would
> be useful to have the log from 2.6.22-rc4 with "pnpacpi=off"
> (which I expect to work), so we could compare it with the
> "2.6.22-rc4.dmesg" log, which I assume a non-working one.

there's now a dmesg.pnpacpi_off which works, and you are correct that the 
dmesg that's there is the non working one.

> Linux PNPACPI currently doesn't manage resources quite the same way
> Windows does, and that might account for this problem.  You might
> try this:
>
>  - boot without "pnpacpi=off" (leave PNPACPI enabled)
>  - before loading the parport_pc driver, do this:
>    # echo "disable" > /sys/devices/pnp0/00:0a/resources
>    # echo "enable" > /sys/devices/pnp0/00:0a/resources
>  - load the parport_pc driver

the parport driver is built-in (and the kernel doesn't include module 
support), is there a way to accomplish the test without switching this to 
a module?

David Lang

> That should cause PNPACPI to run _PRS and _SRS.  Many BIOSes report
> that devices are enabled, but don't actually enable them until _SRS
> is called.
>
> Bjorn
>
>
