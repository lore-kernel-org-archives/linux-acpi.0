From: Len Brown <lenb@kernel.org>
Subject: Re: Kernel Version specific vendor override possibilities needed - Revert and provide osi=linux or provide a replacement
Date: Fri, 22 Feb 2008 18:36:20 -0500
Message-ID: <200802221836.20421.lenb@kernel.org>
References: <1203471860.3358.177.camel@linux-2bdv.site> <200802211641.22920.trenn@suse.de> <20080221171501.GA17592@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43622 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751842AbYBVXhG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Feb 2008 18:37:06 -0500
In-Reply-To: <20080221171501.GA17592@mit.edu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
Cc: Thomas Renninger <trenn@suse.de>, linux-acpi <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Starikovskiy, Alexey Y" <aystarik@gmail.com>

On Thursday 21 February 2008 12:15, Theodore Tso wrote:
> On Thu, Feb 21, 2008 at 04:41:21PM +0100, Thomas Renninger wrote:
> > > OEMs that really want to modify the BIOS to recognize
> > > OS interfaces that are in Linux should propose
> > > new OSI strings that specify interfaces, not broad
> > > categories of operating sytems; and in Linux we
> > > shoudl use, or not use, those strings, as appropriate.
> > > I've recently been in discussion with OEMs on exactly
> > > this topic -- I'm sorry it didn't happen a year ago.
> > So you mean "SLED 10 SP2", "UBUNTU supported version XY" strings?
> 
> No, no, no, no, no!
> 
> What part of "specify interfaces, not broad category of operating
> sytems" didn't you understand?
> 
> So for example, if we if some vendor decides for some silly reason
> that they must the Nvidia graphics chipsets, and Nvidia is the one
> holdout which is lame about providing information so we can program
> the video hardware correctly after a suspend/resume, maybe there is a
> feature flag, OSI(LameNvidiaSuspendResume).  The suppose 6 months
> later, someone manages to disassemble the Nvidia driver in some legal
> jurisdiction where there is no DMCA nonsense, and so Linux is now
> capable of dealing with the video card itself.  Now future kernels can
> simply omit that very specific OSI string.
> 
> Just because we are saying that OSI(Linux) is bad, does not mean that
> people are saying that OSI("SLED 10 SP2") is the right answer.  Hell,
> no!  The right thing is something like OSI(LameNvidiaSusependResume).


Ted speaks the truth.

Indeed, this is exactly the issue with the Dell M4300.

Dell executes BIOS re-post on OSI(Linux) for the benefit of
text-mode video restore, and for the case where nv is used
instead of the binary nvidia driver that knows how to do this.

Why is that bad?
Well, consider why Dell doesn't execute that BIOS code unconditionally...
It is because it would make Windows resume speed uncompetitive.

So when Linux nv gets fixed (like i915 was) so that it can restore
video w/o the BIOS, how to you un-do the damage?
With OSI(Linux) you can't -- Linux will be at a permanent
disadvantage to Windows on that platform _forever_.

However, if nv were changed to call an I/F in Linux/ACPI
that says "please add OSI(LameNvidiaSusependResume)"
and Dell's BIOS executed the video BIOS restore only when
that was set, then a future smarter nv could stop using that crutch
and Linux would no longer be at a disadvantage.

-Len

