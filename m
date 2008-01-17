From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 5/5] ACPI: add DMI to enable OSI(Linux) on ThinkPad T61
Date: Thu, 17 Jan 2008 15:04:26 -0500
Message-ID: <200801171504.26361.lenb@kernel.org>
References: <a4d865fcfc9913f3d2428bc2b7ab1683227a6096.1200565331.git.len.brown@intel.com> <0bf08de2227cabeb40a6ea72b3fa188a2e325335.1200565331.git.len.brown@intel.com> <20080117122832.GB32133@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53045 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751558AbYAQUEm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Jan 2008 15:04:42 -0500
In-Reply-To: <20080117122832.GB32133@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

On Thursday 17 January 2008 07:28, Matthew Garrett wrote:
> On Thu, Jan 17, 2008 at 05:24:50AM -0500, Len Brown wrote:
> 
> > +	{
> > +	.callback = dmi_enable_osi_linux,
> > +	.ident = "Lenovo ThinkPad T61",
> > +	.matches = {
> > +		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> > +		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T61"),
> > +		},
> > +	},
> > +
> 
> If we add it for specific devices, aren't vendors going to assume that 
> future versions of that device will also be able to rely on this 
> behaviour?

When the new product comes out and they
try Linux on it, OSI(Linux) will return FALSE unless
somebody (later) adds the new product to the white-list.

So if a vendor really cares about Linux, they'll know
during development that they can't count on OSI(Linux) returning TRUE.

> I'm very reluctant to add whitelisting - I suspect it makes  
> more sense for us to just be compatible with Windows. My experiments 
> with the T61 suggested that it was possible to get everything working 
> without this, but I'll need to go back and check what the behaviour 
> actually was to be sure.

I agree that white-lists are horrible.
And I blame myself for not deleting OSI(Linux) before 2.6.23.
For pandora's box has been opened and when OSI(Linux)
went into a reference BIOS, and it will be difficult to close
it to get back on the "Windows compatible" track
that makes the most sense for Linux.

Happily, most of the cases I've seen are simply NOP code inherited
from a reference BIOS, but in some cases the OEM really
did test with (some version of) Linux and made firmware
changes to make their product function properly.
I think there are just a few of these cases, and
I think it is actually more common to see systems
where OSI(Linux) causes random  BIOS behaviour.
The later case is the one we need to fear, and
why we need to be dilligent about stamping out OSI(Linux)=TRUE.
But at the same time, I think we really need a whilte-list
to make some products ship.  I believe that we'll
see an example from Dell shortly on S3 video restore.
I may not have been noticed yet b/c they're running pre-2.6.23.

I expect most of the "white-list" entries will actually just
document the casese where OSI(Linux) is presnet, but has no effect.
The white-list action in that case is simply to disable the warnings
and request for testing.

-Len





