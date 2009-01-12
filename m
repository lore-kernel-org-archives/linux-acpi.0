From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] : ACPI : Use RSDT instead of XSDT by adding boot option of "acpi=rsdt"
Date: Mon, 12 Jan 2009 23:17:07 +0100
Message-ID: <200901122317.08849.trenn@suse.de>
References: <20081031184233.8588.42241.stgit@thinkpad> <200901121513.06126.trenn@suse.de> <20090112141655.GA21052@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:34280 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752472AbZALWQe (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Mon, 12 Jan 2009 17:16:34 -0500
In-Reply-To: <20090112141655.GA21052@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, "Linux-acpi@vger.kernel.org" <Linux-acpi@vger.kernel.org>, me@markdoughty.co.uk, ibm-acpi-devel@lists.sourceforge.net

On Monday 12 January 2009 03:16:55 pm Matthew Garrett wrote:
> On Mon, Jan 12, 2009 at 03:13:04PM +0100, Thomas Renninger wrote:
> > On Friday 09 January 2009 13:34:16 Matthew Garrett wrote:
> > > If you know of any machines that behave this way, I'd be
> > > impressed - and it'll be far easier to dmi whitelist them than the
> > > other way around.
> >
> > What do you mean with "easy"?
> >
> > 99.998% of all machines work fine with the current, spec conform
> > implementation.
> > There are the two ThinkPads for which the vendor admitted that the BIOS
> > is broken which work better with the rsdt blacklisted.
>
> Two Thinkpads, an entire range of HP workstations, how many others?
You wanted to provide more info about the HPs. Are they even sold? Have you 
informed HP that their BIOSes are broken?
It's easy and safe (also in respect of not breaking Windows) for them to fix 
them. If we do not wait some more months, I am confident they are going to do 
it, tell me privately if you need contacts.

> We have no idea which bugs are being triggered by this. Refusing to fix it 
> because we'll potentially break some machines that may not even exist is 
> not a sensible plan.
The plan is to stay to the spec. Is that so wrong?
There are netbooks which only support Linux and I hope there will be a lot 
more machines only supporting Linux as OS in the future.
Such Windows compatibility, Spec violating fixes will break them.
It's the broken BIOSes, those machines the vendor never ever tried booting 
Linux which need the boot param and blacklist adding...

Maybe we come away with this change this time, maybe we hurt someone badly who
did everything right: stick to the spec, tested and verified that Linux works 
fine.

       Thomas
