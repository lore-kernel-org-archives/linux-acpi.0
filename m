From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 5/5] ACPI: add DMI to enable OSI(Linux) on ThinkPad T61
Date: Mon, 18 Feb 2008 17:58:22 +0100
Message-ID: <1203353902.6019.119.camel@queen.suse.de>
References: <a4d865fcfc9913f3d2428bc2b7ab1683227a6096.1200565331.git.len.brown@intel.com>
	 <200801171504.26361.lenb@kernel.org> <20080117213135.GF5547@mit.edu>
	 <200801190240.45718.lenb@kernel.org>
	 <20080119120830.GA16308@khazad-dum.debian.net>
	 <20080119141727.GJ28387@mit.edu>
	 <20080119153304.GA27060@khazad-dum.debian.net>
	 <20080119154328.GA11024@srcf.ucam.org> <20080119231916.GK28387@mit.edu>
	 <20080120194919.GE19295@khazad-dum.debian.net>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46911 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755593AbYBRQ60 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 18 Feb 2008 11:58:26 -0500
In-Reply-To: <20080120194919.GE19295@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Theodore Tso <tytso@MIT.EDU>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

Hi,

On Sun, 2008-01-20 at 17:49 -0200, Henrique de Moraes Holschuh wrote:
> On Sat, 19 Jan 2008, Theodore Tso wrote:
> > Sure, and that means they have to *tell* *us* what they are doing so
> > we can be compatible with Windows.  The concern is that they may be
> > doing stuff that isn't in the standard ACPI spec, but which needs to
> > be a certain way in order to be compatible with their proprietary
> > Windows drivers.  
> 
> Or to be compatible with both Windows XP and Vista ACPI subsystems, *and*
> the Windows XP and Vista versions of their proprietary drivers.  This is
> probably where half the weirdness in Lenovo ThinkPads come from, IMHO.

The problem is that OSI is used by Windows to pass the exact Windows
(not OS) version they are running, this function should be called WOSI.
We of course want to run on the latest fix-ups here and should pass
"Windows 2006" (or whatever latest string there exists).

IMO we need the same for Linux.
We even have the advantage, that the string in LOSI(String) makes some
sense, e.g. 2.6.24, so why not use LOSI(int, int, int)
How the exact interface might look like I am not sure, just an idea.

> > The real problem comes when they decide to do things in a rush.  That
> > is, Dell deciding they want to make their laptops compatible with an
> > already existing Ubuntu kernel, or Lenovo deciding they want to make
> > their laptops compatible with an already existing SUSE kernel.  And,
> > so they decide to do a quick and dirty firmware release rather than
> > negotiating with the distribution to do an Errata kernel.  If we don't
> > agressive move to nip this in the bud, even if a particular Thinkpad
> > kernel isn't in the whitelist, I can see them simply documenting a
> > workaround of setting acpi_osi=Linux in the boot command line, because
> > it's easier than getting a distro to release a new kernel with a patch
> > needed to support some new laptop....
> 
> Well, in defense of Lenovo, at least they seem to be quite open to changing
> future BIOSes if we are really clear on what we request *and* we provide a
> solution that won't cause total breakage on the kernels already in the Wild.
> 
> But asking any hardware vendor to do something that will work right with the
> next version of Linux but will break hideously what distros have been
> shipping already just won't fly.  Anything we do has to work well on both
> past and current kernels, unfortunately.
I disagree.
AML is a whole language, you can add stuff like:
if (losi < 2.6.24)
   Store (0x1, ecxy)
else if (losi > 2.6.25)
   Store (0x3, ecxy)

A)
Vendors *must* have a flag for Linux to be able to provide proper
support for multiple kernels and to be able to provide easy and riskless
fixes for Linux at all.

B)
ACPI interpreter patches are mostly very intrusive and distros cannot
backport them. E.g. you don't want to add an EC fix which fixes all ASUS
machines, but possibly breaks some others..., you don't want to backport
suspend reordering, or a simple sizeOf (part of AML) enhancement which
fixes some machines, might break some very other specific ones. You
should nearly never ever backport an AML fix, better let vendors do
kernel specific workarounds if they are willing to.

I expect we now have this problem because nobody (including myself)
never dreamed of that it could ever happen that a vendor adds Linux
specific AML code.

But now that it happens we should react quickly and come up with a
robust interface for the future...

> Now, the real test will be if we ask for something that would require
> changing their Windows drivers.  I sure hope they would do it, but...
Yep nobody would ever do this.
But it's no problem for vendors at all to add a hotfix like that to
their BIOS:
if (linux)
  ..
else if (windows)
  ..

    Thomas

