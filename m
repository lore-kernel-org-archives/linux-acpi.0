From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: [PATCH 5/5] ACPI: add DMI to enable OSI(Linux) on ThinkPad T61
Date: Thu, 17 Jan 2008 16:31:35 -0500
Message-ID: <20080117213135.GF5547@mit.edu>
References: <a4d865fcfc9913f3d2428bc2b7ab1683227a6096.1200565331.git.len.brown@intel.com> <0bf08de2227cabeb40a6ea72b3fa188a2e325335.1200565331.git.len.brown@intel.com> <20080117122832.GB32133@srcf.ucam.org> <200801171504.26361.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:33545 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751300AbYAQVcH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Jan 2008 16:32:07 -0500
Content-Disposition: inline
In-Reply-To: <200801171504.26361.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

On Thu, Jan 17, 2008 at 03:04:26PM -0500, Len Brown wrote:
> On Thursday 17 January 2008 07:28, Matthew Garrett wrote:
> > On Thu, Jan 17, 2008 at 05:24:50AM -0500, Len Brown wrote:
> > 
> > > +	{
> > > +	.callback = dmi_enable_osi_linux,
> > > +	.ident = "Lenovo ThinkPad T61",
> > > +	.matches = {
> > > +		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> > > +		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T61"),
> > > +		},
> > > +	},
> > > +
> > 
> > If we add it for specific devices, aren't vendors going to assume that 
> > future versions of that device will also be able to rely on this 
> > behaviour?
> 
> When the new product comes out and they
> try Linux on it, OSI(Linux) will return FALSE unless
> somebody (later) adds the new product to the white-list.
> 
> So if a vendor really cares about Linux, they'll know
> during development that they can't count on OSI(Linux) returning TRUE.

Maye the whitelist should use very specific BIOS version numbers as
part of the DMI_MATCH, and we encourage the vendors to remove the
OSI(Linux) specific hacks moving forward?  After all, the workarounds
are only needed for the very latest BIOS versions, and if we can
manage to convince vendors to make them go away, then maybe after some
particular BIOS version, we won't need to do anything special.

Perhaps if there was a well documented, "this is what we want" from
the Linux community, which can then get communicated to Lenovo, HP,
Dell, etc.?  This document could include a request that Laptop vendors
document how various things work when they do vendor-specific things,
and also documenting what Linux is doing today because we believe it's
what is the Windows-compatible behaviour.

						- Ted
