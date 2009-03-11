From: Thomas Renninger <trenn@suse.de>
Subject: Re: [RFC PATCH 1/5] ACPI video: check the return value of acpi_video_device_lcd_get_level_current
Date: Wed, 11 Mar 2009 14:15:27 +0100
Message-ID: <200903111415.28681.trenn@suse.de>
References: <1236672205.2820.119.camel@rzhang-dt> <200903111356.01710.trenn@suse.de> <20090311130432.GA21313@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:52736 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752195AbZCKNPc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Mar 2009 09:15:32 -0400
In-Reply-To: <20090311130432.GA21313@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Wednesday 11 March 2009 14:04:32 Matthew Garrett wrote:
> On Wed, Mar 11, 2009 at 01:56:00PM +0100, Thomas Renninger wrote:
> 
> > (BTW, I recently saw a BIOS with _BCQ function. They said they are going to 
> > fix it, but it may be more widespread, e.g. this also is often the case 
> > (missing _BQC) on Samsung). I found it by luck disassembling and 
> > recompiling the DSDT, a runtime warning would be nice (if it does not 
> > already exist).
> 
> It's not that uncommon - there's a few machines with _BCQ. I actually 
> thought we handled it already, but it seems not. Just adding a cap._BCQ 
> and using it if there's no _BQC sounds like a safe idea.
As said, the current brightness must be initialized if there is
no _BQC and Rui seem to have been removed that.

Also a:
printk (KERN_WARN FW_BUG PREFIX "ACPI brightness control misses _BQC function\n");
should be added.
Rui, if you are there already, do you mind to add such test.
I found by pure luck that a vendor mixed up
_BQC and _BCQ by getting one single warning recompiling the DSDT:
"_BCQ not a predefined function" (or similar). They are now adding it,
but a warning is appropriate IMO in _BQC missing case.
Not adding _BQC and doing brightness switching through ACPI brightness
functions is a really bad idea in general.

    Thomas
