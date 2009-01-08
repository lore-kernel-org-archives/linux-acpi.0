From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] ACPI: disable the ACPI backlight control on laptops
	with buggy _BCL methods
Date: Thu, 08 Jan 2009 14:32:01 +0800
Message-ID: <1231396321.20746.79.camel@rzhang-dt>
References: <1231383496.20746.44.camel@rzhang-dt>
	 <20090108033250.GA2550@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:7506 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717AbZAHGap (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Jan 2009 01:30:45 -0500
In-Reply-To: <20090108033250.GA2550@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "trenn@suse.de" <trenn@suse.de>

On Thu, 2009-01-08 at 11:32 +0800, Matthew Garrett wrote:
> On Thu, Jan 08, 2009 at 10:58:16AM +0800, Zhang Rui wrote:
>=20
> > Some users used to control the backlight via the platform interface=
=2E
> > But commit c3d6de698c84efdbdd3781b7058bcc339ab43da8 disables the pl=
atform
> > backlight control if ACPI video backlight control is available.
> >=20
> > This breaks the laptops with buggy _BCL/_BCM/_BQC methods. i.e. onl=
y ACPI
> > backlight I/F are available on these laptops but they don't work.
> >=20
> > With this patch applied, the ACPI backlight control are disabled in=
stead
> > on these laptops.
>=20
> Why? These all seem to behave consistently, so I can't see any proble=
m=20
> with us simply adding support for this varient.
the problem is that the ACPI backlight I/F and the platform I/F coexist=
s
before commit =EF=BB=BFc3d6de698c84efdbdd3781b7058bcc339ab43da8 applied=
, and the
platform I/F is preferred.

>  Disabling the ACPI=20
> control when we have no idea whether there's a platform driver availa=
ble=20
> for the machine doesn't seem like the right fix.
>=20
But once we enable the ACPI backlight control, the platform backlight
control is not available any more.

In these bugs, the _BCL/_BCM/_BQC method is really not well implemented=
=2E

=EF=BB=BFin bug 12249 and 12037,
1. the first two elements in _BCL are NOT the backlight levels when the
platform is on AC or battery.
2. _BQC returns the index of the current brightness =EF=BB=BF=EF=BB=BFi=
n _BCL package
rather than the value, which surely breaks the ACPI video driver.
=EF=BB=BF
in bug 12302
=EF=BB=BF1. the first two elements in _BCL are NOT the backlight levels=
 when the
platform is on AC or battery.
2. every elements in the _BCL package is not a percentage of the maximu=
m
brightness, which is also a violation of ACPI spec.

yes, we can make the ACPI backlight control work by using customized
DSDT. But that's not the fix neither. I don't have any better ideas tha=
n
disable them.

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
