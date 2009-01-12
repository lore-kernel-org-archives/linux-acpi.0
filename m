From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH] : ACPI : Use RSDT instead of XSDT by adding boot option of "acpi=rsdt"
Date: Mon, 12 Jan 2009 23:38:57 +0000
Message-ID: <20090112233857.GB6849@srcf.ucam.org>
References: <20081031184233.8588.42241.stgit@thinkpad> <200901121513.06126.trenn@suse.de> <20090112141655.GA21052@srcf.ucam.org> <200901122317.08849.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:43480 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbZALXjI (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Mon, 12 Jan 2009 18:39:08 -0500
Content-Disposition: inline
In-Reply-To: <200901122317.08849.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, "Linux-acpi@vger.kernel.org" <Linux-acpi@vger.kernel.org>, me@markdoughty.co.uk, ibm-acpi-devel@lists.sourceforge.net

On Mon, Jan 12, 2009 at 11:17:07PM +0100, Thomas Renninger wrote:
> On Monday 12 January 2009 03:16:55 pm Matthew Garrett wrote:
> > On Mon, Jan 12, 2009 at 03:13:04PM +0100, Thomas Renninger wrote:
> > > 99.998% of all machines work fine with the current, spec conform
> > > implementation.
> > > There are the two ThinkPads for which the vendor admitted that the BIOS
> > > is broken which work better with the rsdt blacklisted.
> >
> > Two Thinkpads, an entire range of HP workstations, how many others?
> You wanted to provide more info about the HPs. Are they even sold? Have you 
> informed HP that their BIOSes are broken?
> It's easy and safe (also in respect of not breaking Windows) for them to fix 
> them. If we do not wait some more months, I am confident they are going to do 
> it, tell me privately if you need contacts.

Yes, this has been discussed with HP. Some of the machines are still 
being sold - some are out of support and so will not receive updated 
BIOSes. http://www.google.com/search?q=32%2F64X%20address%20mismatch 
shows that it's not just limited to Thinkpads and HPs.

> > We have no idea which bugs are being triggered by this. Refusing to fix it 
> > because we'll potentially break some machines that may not even exist is 
> > not a sensible plan.
> The plan is to stay to the spec. Is that so wrong?

When sticking to the spec results in hardware that fails to work, then 
yes, sticking to the spec is the wrong thing to do. We violate all sorts 
of specs in all sorts of places simply because hardware and software are 
written by humans who make mistakes. When producing an operating system, 
the aim is for it to work on the hardware our users want supported.

> There are netbooks which only support Linux and I hope there will be a lot 
> more machines only supporting Linux as OS in the future.
> Such Windows compatibility, Spec violating fixes will break them.
> It's the broken BIOSes, those machines the vendor never ever tried booting 
> Linux which need the boot param and blacklist adding...

Find me one x86 netbook vendor who hasn't validated Windows on their 
system.

> Maybe we come away with this change this time, maybe we hurt someone badly who
> did everything right: stick to the spec, tested and verified that Linux works 
> fine.

Or, more likely, we make this change and people find that their hardware 
starts working.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
