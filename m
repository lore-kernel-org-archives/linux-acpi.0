From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] ACPI: disable the ACPI backlight control on laptops
	with buggy _BCL methods
Date: Fri, 09 Jan 2009 09:13:38 +0800
Message-ID: <1231463618.20746.93.camel@rzhang-dt>
References: <1231383496.20746.44.camel@rzhang-dt>
	 <20090108033250.GA2550@srcf.ucam.org> <1231396321.20746.79.camel@rzhang-dt>
	 <20090108124342.GA10458@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:48175 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752568AbZAIBMX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Jan 2009 20:12:23 -0500
In-Reply-To: <20090108124342.GA10458@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "trenn@suse.de" <trenn@suse.de>

On Thu, 2009-01-08 at 20:43 +0800, Matthew Garrett wrote:
> On Thu, Jan 08, 2009 at 02:32:01PM +0800, Zhang Rui wrote:
> > > Why? These all seem to behave consistently, so I can't see any pr=
oblem=20
> > > with us simply adding support for this varient.
> > the problem is that the ACPI backlight I/F and the platform I/F coe=
xists
> > before commit =EF=BB=BFc3d6de698c84efdbdd3781b7058bcc339ab43da8 app=
lied, and the
> > platform I/F is preferred.
>=20
> For the machines you've looked at - we don't know if that's true for =
all=20
> hardware that behaves this way.
>=20
> > =EF=BB=BFin bug 12249 and 12037,
> > 1. the first two elements in _BCL are NOT the backlight levels when=
 the
> > platform is on AC or battery.
>=20
> We can detect that easily and adjust behaviour accordingly.
yes.
we can fake two elements when evaluating _BCL package.
>=20
> > 2. _BQC returns the index of the current brightness =EF=BB=BF=EF=BB=
=BFin _BCL package
> > rather than the value, which surely breaks the ACPI video driver.
>=20
> And again, we can handle that.
No, we can not handle this one.
=46or example,
                    Name (PCTG, Package (0x10)
                    {
                        0x64,
                        0x5A,
                        0x55,
                        0x50,
                        0x4B,
                        0x46,
                        0x41,
                        0x3C,
                        0x37,
                        0x32,
                        0x2D,
                        0x28,
                        0x23,
                        0x1E,
                        0x19,
                        0x14
                    })

_BQC returns 3 when the actual backlight level is 0x50.
We only know that the value returned by _BQC is invalid but we never
know the value is an index until we see the _AML code.

thanks,
rui
>=20
> > 2. every elements in the _BCL package is not a percentage of the ma=
ximum
> > brightness, which is also a violation of ACPI spec.
>=20
> This seems pretty irrelevant - nothing in the code depends on these=20
> being percentages.
>=20
> > yes, we can make the ACPI backlight control work by using customize=
d
> > DSDT. But that's not the fix neither. I don't have any better ideas=
 than
> > disable them.
>=20
> Just fix up video.c to handle these cases.
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
