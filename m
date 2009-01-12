From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] : ACPI : Use RSDT instead of XSDT by adding boot option of "acpi=rsdt"
Date: Mon, 12 Jan 2009 15:13:04 +0100
Message-ID: <200901121513.06126.trenn@suse.de>
References: <20081031184233.8588.42241.stgit@thinkpad> <200901091316.16334.trenn@suse.de> <20090109123416.GA31003@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:49572 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751016AbZALONK (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Mon, 12 Jan 2009 09:13:10 -0500
In-Reply-To: <20090109123416.GA31003@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, "Linux-acpi@vger.kernel.org" <Linux-acpi@vger.kernel.org>, me@markdoughty.co.uk, ibm-acpi-devel@lists.sourceforge.net

On Friday 09 January 2009 13:34:16 Matthew Garrett wrote:
> On Fri, Jan 09, 2009 at 01:16:15PM +0100, Thomas Renninger wrote:
> > IMO this cannot generally be done, because chances are high that machines
> > which do not support Windows likely will break.
> > Chances are high that a machine which does not support Windows uses 64
> > bit addresses and leaves the 32 bit ones uninitialized, a spec valid
> > configuration which will then break.
>
> Bear in mind that the values in the 32-bit entries are *io port*
> addresses, not physical memory addresses. There's only 16 bits of io
> ports, so the probability of the 64-bit values being programmed
> correctly and the 32-bit ones containing a valid but not-working set is
> tiny.
This is not about programming, but about a vendor just filling FADT values?
Why should someone fill up 32 bit values if the spec says that they get
ignored if you provide 64 bit ones (Because Windows is ..., but if you do
not support Windows and just follow the spec...)?

> If you know of any machines that behave this way, I'd be
> impressed - and it'll be far easier to dmi whitelist them than the other
> way around.
What do you mean with "easy"?

99.998% of all machines work fine with the current, spec conform 
implementation.
There are the two ThinkPads for which the vendor admitted that the BIOS is 
broken which work better with the rsdt blacklisted.

You want to change the default which is field tested and known to work on
all BIOSes (beside the two 5 year old broken ThinkPads)?

   Thomas

PS: Leave the ThinkPads broken..., I am tired of arguing about this ...
