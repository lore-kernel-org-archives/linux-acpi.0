From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Check for ACPI backlight support otherwise use vendor ACPI
Date: Thu, 31 Jul 2008 13:22:51 +0800
Message-ID: <1217481771.2969.75.camel@rzhang-dt>
References: <200807310251.m6V2pXDe027356@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:35504 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752001AbYGaFZF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 Jul 2008 01:25:05 -0400
In-Reply-To: <200807310251.m6V2pXDe027356@turbo.physics.adelaide.edu.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: Thomas Renninger <trenn@suse.de>, Yves-Alexis Perez <corsac@debian.org>, ak@linux.intel.com, mjg59@srcf.ucam.org, hmh@hmh.eng.br, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it, nokos@gmx.net

On Thu, 2008-07-31 at 10:51 +0800, Jonathan Woithe wrote:
> > > I'm trying to sort out the status of this myself.  Is the
> expectation
> > > that your patches *with* the IGD work from Matthew/Hong should
> mean that
> > > Fujitsus implementing IGD should not need fujitsu-laptop in order
> to
> > > provide working software backlight brightness control?
> > I think so.
>=20
> Ok.
>=20
> > > Or shouldn't Matthew/Hong's patchset be necessary with your patch
> in
> > > theory?
> > Thomas' patch assigns the responsibility to acpi video driver or
> > platform drivers when a laptop supports brightness/display switch
> both
> > via ACPI video extension and vendor specific control methods.
> >
> > brightness/display switch via ACPI video driver sometimes doesn't
> work
> > even if the ACPI control methods are available, and Matthew/Hong's
> patch
> > fixes this problem, on platforms with intel integrated graphics
> cards.
>=20
> I see.
>=20
> > And now, we should root cause why acpi_video_backlight_support()
> failed
> > on this laptop.
>=20
> Agreed.
>=20
> > > so allowing fujitsu-laptop to co-exist with video.ko handling the
> > > backlight (as your patches allow) is the right thing to do.
> >
> > sure, they will co-exist, but I don't think fujitsu-laptop should
> handle
> > the backlight stuff, unless it's explicitly stated via the boot
> > parameter "=C3=AF=C2=BB=C2=BFacpi_backlight=3Dvendor".
>=20
> For laptops with both ACPI video extensions and vendor specific
> control
> methods I agree with this.  However, users of laptops which have only
> vendor
> specific control methods (of which the S7020 is one AFAIK) should not
> have
> to give any boot parameters for things to work for them.

sure.
In this case, =EF=BB=BFacpi_video_backlight_support() returns false,
and vendor driver will handle the backlight switching.

>   In other words,
> "acpi_backlight=3Dvendor" should only come into play when the machine
> has the
> ACPI video extensions.  I am assuming that this is the intention sinc=
e
> that's what the current patches appear to do.
Yes.
>=20
> Is there a canonical source for Matthew/Hong's patch?  To totally wra=
p
> this
> up I would like to try the S7020 with Matthew/Hong+Thomas.


>   I doubt
> Matthew/Hong's work is relevant to the S7020 given that it's 3+ years
> old
> now, but it's best to test these things early.

Agree.
I think Matthew/Hong's patch should have no effect on your laptops, and
fujistu-laptop should handle the backlight switch as before.

thanks,
rui


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
