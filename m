From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.24-rc1-g74521c28: oops during boot [<ffffffff881c03e4>] :power_supply:power_supply_show_property+0x94/0x150
Date: Sun, 11 Nov 2007 20:19:21 +0100
Message-ID: <200711112019.21853.rjw@sisk.pl>
References: <472C5C2D.9010700@archlinux.org> <4736EE1C.3010500@archlinux.org> <473750B2.4060208@archlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:34898 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752543AbXKKTCS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Nov 2007 14:02:18 -0500
In-Reply-To: <473750B2.4060208@archlinux.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas =?iso-8859-15?q?B=E4chler?= <thomas@archlinux.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Sunday, 11 of November 2007, Thomas B=E4chler wrote:
> >>> http://bugzilla.kernel.org/show_bug.cgi?id=3D9299
> >=20
> > I just tested again (with 2.6.24-rc2-gecd744ee). If I only load the=
 'ac'
> > kernel module and not the 'battery' kernel module, then the system =
boots
> > fine. However, if I load the 'battery' module during boot or later,=
 I
> > still get the oops.
> >=20
> > I am running 2.6.24-rc2-gecd744ee right now, but without the batter=
y
> > module. I am forwarding this to the ACPI list as well.
> >=20
>=20
> Replying to myself again. Apparently, a fix for this bug was applied =
to
> the linux-acpi tree independently of my bug report, see here:
> http://git.kernel.org/?p=3Dlinux/kernel/git/lenb/linux-acpi-2.6.git;a=
=3Dcommit;h=3D4c41d3ad6544f1c9aec37c441af04f5d0ad3a731

I'm having some problems with accessing git.kernel.org right now.  I'll=
 have a
look when it works again.

Thanks,
Rafael
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
