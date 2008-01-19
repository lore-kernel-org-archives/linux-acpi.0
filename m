From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: [PATCH 5/5] ACPI: add DMI to enable OSI(Linux) on ThinkPad T61
Date: Sat, 19 Jan 2008 18:19:16 -0500
Message-ID: <20080119231916.GK28387@mit.edu>
References: <a4d865fcfc9913f3d2428bc2b7ab1683227a6096.1200565331.git.len.brown@intel.com> <200801171504.26361.lenb@kernel.org> <20080117213135.GF5547@mit.edu> <200801190240.45718.lenb@kernel.org> <20080119120830.GA16308@khazad-dum.debian.net> <20080119141727.GJ28387@mit.edu> <20080119153304.GA27060@khazad-dum.debian.net> <20080119154328.GA11024@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:64023 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752900AbYASXTh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 19 Jan 2008 18:19:37 -0500
Content-Disposition: inline
In-Reply-To: <20080119154328.GA11024@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Sat, Jan 19, 2008 at 03:43:28PM +0000, Matthew Garrett wrote:
> 
> The only way to get it done properly is to ensure that we're compatible 
> with Windows, and to get vendors to tell us when we're not. Offering 
> them any mechanism that allows them to special-case Linux will just lead 
> to them doing so and ignoring the problem, which will probably then trip 
> up other systems that don't special-case Linux. Let's not go down this 
> path. The fact that we're even having to have this conversation should 
> indicate that it's not a good idea.
> 

Sure, and that means they have to *tell* *us* what they are doing so
we can be compatible with Windows.  The concern is that they may be
doing stuff that isn't in the standard ACPI spec, but which needs to
be a certain way in order to be compatible with their proprietary
Windows drivers.  

The real problem comes when they decide to do things in a rush.  That
is, Dell deciding they want to make their laptops compatible with an
already existing Ubuntu kernel, or Lenovo deciding they want to make
their laptops compatible with an already existing SUSE kernel.  And,
so they decide to do a quick and dirty firmware release rather than
negotiating with the distribution to do an Errata kernel.  If we don't
agressive move to nip this in the bud, even if a particular Thinkpad
kernel isn't in the whitelist, I can see them simply documenting a
workaround of setting acpi_osi=Linux in the boot command line, because
it's easier than getting a distro to release a new kernel with a patch
needed to support some new laptop....

						- Ted
