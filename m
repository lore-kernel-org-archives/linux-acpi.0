From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH]: ACPI: Add the dmi check to make acpi_enforce_resources
 strict
Date: Thu, 02 Apr 2009 17:18:58 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904021706520.4660@localhost.localdomain>
References: <1236687873.7060.31.camel@localhost.localdomain>
 <20090310123950.GA30016@srcf.ucam.org> <1236738885.2820.168.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:22515 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093AbZDBVTS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Apr 2009 17:19:18 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHH0012VSJOLSC8@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 02 Apr 2009 16:19:05 -0500 (CDT)
In-reply-to: <1236738885.2820.168.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg@redhat.com>, "Zhao, Yakui" <yakui.zhao@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>



On Wed, 11 Mar 2009, Zhang Rui wrote:

> On Tue, 2009-03-10 at 20:39 +0800, Matthew Garrett wrote:
> > On Tue, Mar 10, 2009 at 08:24:33PM +0800, yakui_zhao wrote:
> > > Subject: ACPI: Add the dmi check to make acpi_enforce_resources strict
> > > From: Zhao Yakui <yakui.zhao@intel.com>
> > > 
> > >    On some boxes the SMBus PCI controller is not hidden. The SMbus I/O port
> > > will be accessed in AML code. If the i2c driver is still loaded for the SMbus
> > > PCI device, there is no synchronization between OS and BIOS. And the conflict
> > > will happen.
> > >    So the dmi check is added so that the acpi_enforce_resources is strict when
> > > the box falls into the dmi check table. In such case the i2c driver won't be
> > > loaded for the SMbus pci device.
> > 
> > I think the only safe behaviour here is to default to strict on all 
> > hardware.
> > 
> we've discussed this with Len,
> he thinks that we should first generate a DMI patch to fix the eeepc901
> regression, which can be shipped upstream soon.
> then we'll cook up another patch, to set acpi_enforce_resources=strict
> by default, which should be shipped to len's test tree first, and see if
> there are any objections from the SMBus driver side.
> 
> Yakui will send the second patch out soon.

I agree with Matthew.

What I asked for what the DMI patch first -- something we could
send to .29 and .stable w/ minimum risk.

Then (later) on top of that...
a patch to make the DMI unnecessary and switch the 
default -- something we can revert upstream if it turns into a disaster.

at this point, "later" is "now":-)

So I'm going to dump the DMI patch and apply Luca's patch for 2.6.30.

for 2.6.29 we can either go low risk (dmi patch) or change the default
after it cooks in 2.6.30 for a bit.

thanks,
-Len

