From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [ACPI] [PATCH] restore _OS object to "Linux" for ia64
Date: Tue, 14 Sep 2004 08:00:00 -0700
Sender: linux-ia64-owner@vger.kernel.org
Message-ID: <37F890616C995246BE76B3E6B2DBE05501FB4E14@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ia64-owner@vger.kernel.org>
Content-class: urn:content-classes:message
To: Alex Williamson <alex.williamson@hp.com>
Cc: Gerald Pfeifer <gp@suse.de>, "Brown, Len" <len.brown@intel.com>, linux-ia64@vger.kernel.org, ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org


> 
>    But how can we be sure we're bug for bug and feature for feature
> compatible with an arbitrary version of Windows?  I got curious and
> looked at the DSDT on my home PC, generic VIA KM266 chipset.  Sure
> enough:

We aren't ever "sure".

All I can say is that MS is the "defacto" implementation and that we
attempt to both adhere to the ACPI spec and make some accommodations to
the MS implementation (such as supporting the control method "implicit
return")

The NT/XP MS implementation is their best version with the fewest bugs,
so this is the version that we are compatible with.

Given this, and the fact that most iA32 platform BIOSs are developed and
tested with XP, using the "Microsoft Windows NT" identification string
seems to be the best way to go.  By doing this, we have fixed at least
several machines (maybe more) that were not working properly under
Linux, and there haven't been any problems reported that I know of.

Bob


