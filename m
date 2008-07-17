From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [Openipmi-developer] acpi_find_bmc() and acpi_get_table()
Date: Thu, 17 Jul 2008 12:32:10 -0600
Message-ID: <200807171232.11183.bjorn.helgaas@hp.com>
References: <200702102327.28312.lenb@kernel.org> <200707181319.41081.bjorn.helgaas@hp.com> <5DDAB7BA7BDB58439DD0EED0B8E9A3AE53C94D@ausx3mpc102.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:21546 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757604AbYGQSdK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jul 2008 14:33:10 -0400
In-Reply-To: <5DDAB7BA7BDB58439DD0EED0B8E9A3AE53C94D@ausx3mpc102.aus.amer.dell.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jordan_Hargrave@dell.com
Cc: Matt_Domsch@dell.com, minyard@acm.org, alexey.y.starikovskiy@linux.intel.com, linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, lenb@kernel.org

On Thursday 19 July 2007 10:32:11 am Jordan_Hargrave@dell.com wrote:
> From Bjorn:
> >> In RHEL5 there was a change made to the acpi motherboard driver to
> >> not attach if any of the _CRS values are not I/O ports.
> 
> >Yes.  This is part of linux-2.6-x86_64-memory-hotplug.patch, and it
> >apparently helps fix a bug:
> >  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=208445,
> >But I can't read the bugzilla, so I don't know exactly how.  I suspect
> >some hot-addable memory device also had a _CID of PNP0C01, and they
> >had the same problem you now have with IPMI.
> 
> >But making the motherboard driver ignore devices if they have any
> >non-I/O port resources seems like the wrong fix.
> 
> Yeah but it gets even better, that bugfix has a bug itself.. the acpi_walk_resources 
> function also passes the end-of-list (79 00) marker into the callback.  This isn't a
> resource I/O type, so the motherboard object is failing to attach to any PNP0C01
> device.  This is why the IPMI driver can find the IPI0001 device on RHEL5 but not on 
> RHEL4/SLES10/SLES9.

Hi Jordan,

This is ancient history now.  But I've been doing some PNP work
recently, and I'd like to resurrect your work towards making the
IPMI driver a real PNP driver rather than relying on the static
SPMI table as it does today.

What's the current status of your work?  If you don't want to
continue it yourself, I'd like to pick it up (unless there's some
show-stopper reason why it can't ever work, of course).  Do you
have any work-in-progress that you could post?

Thanks,
  Bjorn
