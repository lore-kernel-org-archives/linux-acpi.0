From: <Jordan_Hargrave@Dell.com>
Subject: RE: [Openipmi-developer] acpi_find_bmc() and acpi_get_table()
Date: Thu, 19 Jul 2007 11:32:11 -0500
Message-ID: <5DDAB7BA7BDB58439DD0EED0B8E9A3AE53C94D@ausx3mpc102.aus.amer.dell.com>
References: <200702102327.28312.lenb@kernel.org> <5DDAB7BA7BDB58439DD0EED0B8E9A3AE073879@ausx3mpc102.aus.amer.dell.com> <5DDAB7BA7BDB58439DD0EED0B8E9A3AE53C94B@ausx3mpc102.aus.amer.dell.com> <200707181319.41081.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:22206 "EHLO
	ausc60pc101.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S939769AbXGSQgT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Jul 2007 12:36:19 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: bjorn.helgaas@hp.com
Cc: Matt_Domsch@Dell.com, minyard@acm.org, alexey.y.starikovskiy@linux.intel.com, linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, lenb@kernel.org

>From Bjorn:
>> In RHEL5 there was a change made to the acpi motherboard driver to
>> not attach if any of the _CRS values are not I/O ports.

>Yes.  This is part of linux-2.6-x86_64-memory-hotplug.patch, and it
>apparently helps fix a bug:
>  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=208445,
>But I can't read the bugzilla, so I don't know exactly how.  I suspect
>some hot-addable memory device also had a _CID of PNP0C01, and they
>had the same problem you now have with IPMI.

>But making the motherboard driver ignore devices if they have any
>non-I/O port resources seems like the wrong fix.

Yeah but it gets even better, that bugfix has a bug itself.. the acpi_walk_resources 
function also passes the end-of-list (79 00) marker into the callback.  This isn't a
resource I/O type, so the motherboard object is failing to attach to any PNP0C01
device.  This is why the IPMI driver can find the IPI0001 device on RHEL5 but not on 
RHEL4/SLES10/SLES9.

--jordan hargrave
Dell Enterprise Linux Engineering



-----Original Message-----
From: Bjorn Helgaas [mailto:bjorn.helgaas@hp.com]
Sent: Wed 7/18/2007 2:19 PM
To: Hargrave, Jordan
Cc: Domsch, Matt; minyard@acm.org; alexey.y.starikovskiy@linux.intel.com; linux-acpi@vger.kernel.org; openipmi-developer@lists.sourceforge.net; lenb@kernel.org
Subject: Re: [Openipmi-developer] acpi_find_bmc() and acpi_get_table()
 
On Wednesday 18 July 2007 10:49:58 am Jordan_Hargrave@dell.com wrote:
> I've done some more investigating on this and found why this works
> in RHEL5 but not other releases (RHEL4/SLES9/SLES10). 
> 
> The acpi motherboard driver is claiming all devices with _HID or
> _CID of PNP0C01.  Our BIOS declares the IPI0001 with a _CID of
> PNP0C01, so the acpi motherboard driver normally claims it.  When
> the IPMI driver loads it can't find the IPI0001 device as it is
> already claimed.    

I think this is dumb.  PNP0C01 is a generic "system board" identifier
with no clear programming model that I can see.  What good does it
do to have a _CID of PNP0C01?  The only useful thing that happens in
Linux is that the "motherboard" driver claims PNP0C01 devices and
reserves their resources.  But PNP ought to reserve the resources of
*all* active devices, even if no driver claims them.

So I think this sounds like a BIOS defect.  Of course, I'm sure it's
already in the field, so even if we agree that it's a BIOS problem,
we'd have to work around it in Linux.  What if we had some sort of
quirk that removes that _CID?

> In RHEL5 there was a change made to the acpi motherboard driver to
> not attach if any of the _CRS values are not I/O ports.

Yes.  This is part of linux-2.6-x86_64-memory-hotplug.patch, and it
apparently helps fix a bug:
  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=208445,
But I can't read the bugzilla, so I don't know exactly how.  I suspect
some hot-addable memory device also had a _CID of PNP0C01, and they
had the same problem you now have with IPMI.

But making the motherboard driver ignore devices if they have any
non-I/O port resources seems like the wrong fix.

> Technically the only reason it is working in RHEL5 is due to the
> bug of the motherboard driver not attaching. 

Right.  I'm sure you've noticed that the ACPI motherboard driver has
been removed completely upstream.  It's been replaced by the PNP
"system" driver, which claims all PNP0C01 and PNP0C02 devices regardless
of what sort of resources they have.

> So using acpi_bus_register_driver looks like it won't work as a general solution.
> I'm investigating walking the whole namespace to detect the IPI0001 device.

I think we should make acpi_bus_register_driver() work.  It looks like
we already have two cases (IPMI and memory hotplug), so I'd like to
have a general solution rather than a collection of workarounds.

Bjorn
