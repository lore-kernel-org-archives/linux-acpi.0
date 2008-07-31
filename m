From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Check for ACPI backlight support otherwise use vendor ACPI
Date: Thu, 31 Jul 2008 12:21:33 +0930 (CST)
Message-ID: <200807310251.m6V2pXDe027356@turbo.physics.adelaide.edu.au>
References: <1217471312.2969.68.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:43854 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758596AbYGaCwa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Jul 2008 22:52:30 -0400
In-Reply-To: <1217471312.2969.68.camel@rzhang-dt> from "Zhang Rui" at Jul 31, 2008 10:28:32 AM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Thomas Renninger <trenn@suse.de>, Yves-Alexis Perez <corsac@debian.org>, ak@linux.intel.com, mjg59@srcf.ucam.org, hmh@hmh.eng.br, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it, nokos@gmx.net

> > I'm trying to sort out the status of this myself.  Is the expectati=
on
> > that your patches *with* the IGD work from Matthew/Hong should mean=
 that
> > Fujitsus implementing IGD should not need fujitsu-laptop in order t=
o
> > provide working software backlight brightness control?
> I think so.

Ok.

> > Or shouldn't Matthew/Hong's patchset be necessary with your patch i=
n
> > theory?
> Thomas' patch assigns the responsibility to acpi video driver or
> platform drivers when a laptop supports brightness/display switch bot=
h
> via ACPI video extension and vendor specific control methods.
>=20
> brightness/display switch via ACPI video driver sometimes doesn't wor=
k
> even if the ACPI control methods are available, and Matthew/Hong's pa=
tch
> fixes this problem, on platforms with intel integrated graphics cards=
=2E

I see.

> And now, we should root cause why acpi_video_backlight_support() fail=
ed
> on this laptop.

Agreed.

> > so allowing fujitsu-laptop to co-exist with video.ko handling the
> > backlight (as your patches allow) is the right thing to do.
>=20
> sure, they will co-exist, but I don't think fujitsu-laptop should han=
dle
> the backlight stuff, unless it's explicitly stated via the boot
> parameter "=EF=BB=BFacpi_backlight=3Dvendor".

=46or laptops with both ACPI video extensions and vendor specific contr=
ol
methods I agree with this.  However, users of laptops which have only v=
endor
specific control methods (of which the S7020 is one AFAIK) should not h=
ave
to give any boot parameters for things to work for them.  In other word=
s,
"acpi_backlight=3Dvendor" should only come into play when the machine h=
as the
ACPI video extensions.  I am assuming that this is the intention since
that's what the current patches appear to do.

Is there a canonical source for Matthew/Hong's patch?  To totally wrap =
this
up I would like to try the S7020 with Matthew/Hong+Thomas.  I doubt
Matthew/Hong's work is relevant to the S7020 given that it's 3+ years o=
ld
now, but it's best to test these things early.

Regards
  jonathan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
