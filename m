From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 5/5] ACPI: add DMI to enable OSI(Linux) on ThinkPad T61
Date: Sat, 19 Jan 2008 02:40:45 -0500
Message-ID: <200801190240.45718.lenb@kernel.org>
References: <a4d865fcfc9913f3d2428bc2b7ab1683227a6096.1200565331.git.len.brown@intel.com> <200801171504.26361.lenb@kernel.org> <20080117213135.GF5547@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57754 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751645AbYASHlY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 19 Jan 2008 02:41:24 -0500
In-Reply-To: <20080117213135.GF5547@mit.edu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org

On Thursday 17 January 2008 16:31, Theodore Tso wrote:
> On Thu, Jan 17, 2008 at 03:04:26PM -0500, Len Brown wrote:
> > On Thursday 17 January 2008 07:28, Matthew Garrett wrote:
> > > On Thu, Jan 17, 2008 at 05:24:50AM -0500, Len Brown wrote:
> > > 
> > > > +	{
> > > > +	.callback = dmi_enable_osi_linux,
> > > > +	.ident = "Lenovo ThinkPad T61",
> > > > +	.matches = {
> > > > +		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> > > > +		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T61"),
> > > > +		},
> > > > +	},
> > > > +
> > > 
> > > If we add it for specific devices, aren't vendors going to assume that 
> > > future versions of that device will also be able to rely on this 
> > > behaviour?
> > 
> > When the new product comes out and they
> > try Linux on it, OSI(Linux) will return FALSE unless
> > somebody (later) adds the new product to the white-list.
> > 
> > So if a vendor really cares about Linux, they'll know
> > during development that they can't count on OSI(Linux) returning TRUE.
> 
> Maye the whitelist should use very specific BIOS version numbers as
> part of the DMI_MATCH, and we encourage the vendors to remove the
> OSI(Linux) specific hacks moving forward?  After all, the workarounds
> are only needed for the very latest BIOS versions, and if we can
> manage to convince vendors to make them go away, then maybe after some
> particular BIOS version, we won't need to do anything special.

I don't really want to get bogged down on individual BIOS Versions.
I don't expect vendors would want to change mid-course anyway --
and if they did, nobody updates their bios anyway.

> Perhaps if there was a well documented, "this is what we want" from
> the Linux community, which can then get communicated to Lenovo, HP,
> Dell, etc.?  This document could include a request that Laptop vendors
> document how various things work when they do vendor-specific things,
> and also documenting what Linux is doing today because we believe it's
> what is the Windows-compatible behaviour.

vendors who care about Linux run this:

http://linuxfirmwarekit.org/

So I think if shout there, then it we'll be heard.

thanks,
-Len



