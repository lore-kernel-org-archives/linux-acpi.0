From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH 3/4] x86 hibernate: Mark ACPI NVS memory region at startup
Date: Fri, 31 Oct 2008 00:59:46 +0100
Message-ID: <200810310059.47564.rjw@sisk.pl>
References: <200810222249.20629.rjw@sisk.pl> <1225272091.2665.4.camel@rzhang-dt> <20081029111837.GA20466@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:52002 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750848AbYJ3XzN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Oct 2008 19:55:13 -0400
In-Reply-To: <20081029111837.GA20466@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>

On Wednesday, 29 of October 2008, Pavel Machek wrote:
> Hi!
> 
> > > > > +static int __init e820_mark_nvs_memory(void)
> > > > > +{
> > > > > +	int i;
> > > > > +
> > > > > +	if (efi_enabled)
> > > > > +		return 0;
> > > > 
> > > > Aha, not unrelated... why is that? EFI does not use acpi? 
> > > 
> > > With EFI we are not supposed to do that.  Rui knows the details.  Rui?
> > > 
> > well, 
> > about EFI nvs memory, I only get
> > "EfiACPIMemoryNVS: The OS and loader must preserve this memory range in
> > the working and ACPI S1???S3 states." in the ACPI spec 3.0b.
> > whether we should save/restore this piece of memory is not clear.

Well. it's clear enough.  Section 15.3.2 evidently refers to E820 and the EFI's
GetMemoryMap() on equal footing.

> > I'd prefer not to touch it currently.
> 
> EFI is a bootloader. Why should we change our runtime behaviour
> depending on bootloader?
> 
> EFI should be still compatible with normal ACPI, right? ...like you
> should be able to boot the same kernel with the same ACPI BIOS using
> EFI or EFI w/ legacy emulation.
> 
> So special-casing it here does not seem right.

I agree.

I'm going to send an updated patch to Len.

Thanks,
Rafael
