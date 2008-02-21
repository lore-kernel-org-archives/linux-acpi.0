From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: Kernel Version specific vendor override possibilities needed -
	Revert and provide osi=linux or provide a replacement
Date: Thu, 21 Feb 2008 12:15:01 -0500
Message-ID: <20080221171501.GA17592@mit.edu>
References: <1203471860.3358.177.camel@linux-2bdv.site> <200802210341.13809.lenb@kernel.org> <200802211641.22920.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:37539 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754412AbYBURPf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Feb 2008 12:15:35 -0500
Content-Disposition: inline
In-Reply-To: <200802211641.22920.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Starikovskiy, Alexey Y" <aystarik@gmail.com>

On Thu, Feb 21, 2008 at 04:41:21PM +0100, Thomas Renninger wrote:
> > OEMs that really want to modify the BIOS to recognize
> > OS interfaces that are in Linux should propose
> > new OSI strings that specify interfaces, not broad
> > categories of operating sytems; and in Linux we
> > shoudl use, or not use, those strings, as appropriate.
> > I've recently been in discussion with OEMs on exactly
> > this topic -- I'm sorry it didn't happen a year ago.
> So you mean "SLED 10 SP2", "UBUNTU supported version XY" strings?

No, no, no, no, no!

What part of "specify interfaces, not broad category of operating
sytems" didn't you understand?

So for example, if we if some vendor decides for some silly reason
that they must the Nvidia graphics chipsets, and Nvidia is the one
holdout which is lame about providing information so we can program
the video hardware correctly after a suspend/resume, maybe there is a
feature flag, OSI(LameNvidiaSuspendResume).  The suppose 6 months
later, someone manages to disassemble the Nvidia driver in some legal
jurisdiction where there is no DMCA nonsense, and so Linux is now
capable of dealing with the video card itself.  Now future kernels can
simply omit that very specific OSI string.

Just because we are saying that OSI(Linux) is bad, does not mean that
people are saying that OSI("SLED 10 SP2") is the right answer.  Hell,
no!  The right thing is something like OSI(LameNvidiaSusependResume).

					- Ted
