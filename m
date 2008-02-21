From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: Kernel Version specific vendor override possibilities needed -
	Revert and provide osi=linux or provide a replacement
Date: Thu, 21 Feb 2008 08:51:32 -0500
Message-ID: <20080221135132.GE14614@mit.edu>
References: <1203471860.3358.177.camel@linux-2bdv.site> <20080220173248.GA22709@srcf.ucam.org> <20080220182339.GC17648@khazad-dum.debian.net> <20080220184954.GB23679@srcf.ucam.org> <20080221031324.GB6344@khazad-dum.debian.net> <20080221091532.GA3091@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:44112 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751866AbYBUNwI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Feb 2008 08:52:08 -0500
Content-Disposition: inline
In-Reply-To: <20080221091532.GA3091@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "Starikovskiy, Alexey Y" <aystarik@gmail.com>

On Thu, Feb 21, 2008 at 09:15:32AM +0000, Matthew Garrett wrote:
> 
> Offering OSI(Linux) makes a statement about our implementation - we're 
> telling the firmware that it behaves in a certain way. That lets vendors 
> start depending on that behaviour, and if that behaviour turns out to be 
> different to Windows then we never get to fix that behaviour. Fine for 
> vendors that have special-cased their firmware, bad for the vast 
> majority of systems.

Exactly, that's the problem.  Suppose we put in an OSI(Linux), and
Lenovo, thanks to the fact that they are working with Novell, puts in
a special case hack just for whatever version of SLES they happen to
be testing with.  Well, great.  Now suppose that three other laptops
from different manufacturers (say, Sony, Fujitsu, and Asus) do things
differently, the Windows way, and someone posts a patch to the ACPI
drivers (and it might not and probably won't be the Thinkpad specific
thinkpad_acpi.c file) which changes things so that it works for Sony,
Fujitsu, et. al. --- and in the process, it breaks things for Lenovo,
because the Lenovo is doing something special based on OSI(Linux)
thanks to their special collaboration with Thomas Renniger and Novell.
Oops.  Now we have a mess, and we have to start having special
DMI-based blacklists and whitelists, and life generally sucks.

It would be much better if we define feature-specific OSI() strings
that have well defined meanings for each place where Lenovo has to do
something different than What Happens With Windows --- especially for
stuff which is generic, since all laptop manufactuers need to
interoperate with whatever cr*p Windows ship.  At the end of the day,
since Intel was originally too lazy to ship an ACPI conformance test
suite, like it or not, Windows *has* become the APCI conformance test
suite, and all laptop manufacturers (at least for today) must bow to
the might and power which is the market share of Microsoft.

						- Ted
