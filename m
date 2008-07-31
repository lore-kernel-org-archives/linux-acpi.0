From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Check for ACPI backlight support otherwise use vendor ACPI
	drivers - version 2
Date: Thu, 31 Jul 2008 10:28:32 +0800
Message-ID: <1217471312.2969.68.camel@rzhang-dt>
References: <200807310035.m6V0ZLOU022072@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:1939 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754371AbYGaCap (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Jul 2008 22:30:45 -0400
In-Reply-To: <200807310035.m6V0ZLOU022072@turbo.physics.adelaide.edu.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: Thomas Renninger <trenn@suse.de>, Yves-Alexis Perez <corsac@debian.org>, ak@linux.intel.com, mjg59@srcf.ucam.org, hmh@hmh.eng.br, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it, nokos@gmx.net

On Thu, 2008-07-31 at 08:35 +0800, Jonathan Woithe wrote:
> Hi Thomas
>=20
> > > On mer, 2008-07-16 at 12:52 +0200, Thomas Renninger wrote:
> > > > It is highly recommended that these patches are tried out
> together with
> > > > Matthew's/Hong's IGD driver changes.
> > > > I do not know whether they are already in the dri tree or in
> linux-next,
> > > > whether they will be accepted for .27 etc. I hope Matthew will
> answer on
> > > > this mail and tell us.
> > > > AFAIK on thinkpads they already need an additional patch to
> work?
> > > > Chances are high that other laptop families also need a bit of =
a
> special
> > > > treatment to get the very new IGD parts to work.
> > > > If people test both patches together we could get a matrix like
> this:
> > >
> > > What is the status of those patches wrt. 2.6.27-rc1?
> >
> > Matthew and Rui accepted or signed them off AFAIK.
> > On Peter's system (nokos@gmx.de, fujitsu with IGD support) it
> returns that
> > there is no video support which looks wrong.
> > I contacted him a bit late, after getting pointed to acpidump it
> still looks
> > odd/wrong, and I need acpi.debug_level=3D0x1f log_buf_len=3D1677721=
6
> output to
> > hopefully see what it is.
> >
> > A comment from Andi/Len would be great.
> > Maybe this could already be sent to linux-next to make testing
> easier.
> > :
> > PS: and this is version 2, I already sent version 3 which had some
> cleanups.
>=20
> I'm trying to sort out the status of this myself.  Is the expectation
> that
> your patches *with* the IGD work from Matthew/Hong should mean that
> Fujitsus
> implementing IGD should not need fujitsu-laptop in order to provide
> working
> software backlight brightness control?
I think so.

>   Or shouldn't Matthew/Hong's
> patchset be necessary with your patch in theory?
Thomas' patch assigns the responsibility to acpi video driver or
platform drivers when a laptop supports brightness/display switch both
via ACPI video extension and vendor specific control methods.

brightness/display switch via ACPI video driver sometimes doesn't work
even if the ACPI control methods are available, and Matthew/Hong's patc=
h
fixes this problem, on platforms with intel integrated graphics cards.

And now, we should root cause why =EF=BB=BFacpi_video_backlight_support=
() failed
on this laptop.
>=20
> AFAIK even IGD Fujitsus will need fujitsu-laptop to support other
> hotkeys,

yes, this patch set just prevents fujitsu-laptop from the
brightness/display switch hotkeys.

> so allowing fujitsu-laptop to co-exist with video.ko handling the
> backlight
> (as your patches allow) is the right thing to do.

sure, they will co-exist, but I don't think fujitsu-laptop should handl=
e
the backlight stuff, unless it's explicitly stated via the boot
parameter "=EF=BB=BFacpi_backlight=3Dvendor".

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
