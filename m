From: Yves-Alexis Perez <corsac@debian.org>
Subject: Re: Check for ACPI backlight support otherwise use vendor
	ACPIdrivers - version 4
Date: Mon, 4 Aug 2008 12:39:30 +0200
Message-ID: <20080804103929.GC28887@corsac.net>
References: <1217605083-31003-1-git-send-email-trenn@suse.de> <1217812580.2969.184.camel@rzhang-dt> <1217830192.4580.8.camel@hidalgo> <200808041220.29892.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from molly.corsac.net ([81.57.48.219]:34110 "EHLO molly.corsac.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751626AbYHDKjc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Aug 2008 06:39:32 -0400
Content-Disposition: inline
In-Reply-To: <200808041220.29892.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Zhang Rui <rui.zhang@intel.com>, ak@linux.intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org, hmh@debian.org

On Mon, Aug 04, 2008 at 12:20:28PM +0200, Thomas Renninger wrote:
> > But when in user mode, brightness keys doesn't do anything either.
> > Echo'ing to /proc/acpi/ibm/brightness doesn't work, but echoing
> > to /sys/class/backlight/thinkpad_screen/brightness works.
> That /proc/acpi/ibm/brightness does not and
> /sys/class/backlight/thinkpad_screen/brightness=20
> works is strange, this should be a bug?

I guess so, but I don't really know how to check.

>=20
> I wonder whether /proc/acpi/ibm/brightness can be removed soon, peopl=
e had
> some time to make use of the generic interface.

I'm not using it usually anyway.
>=20
> What you describe very much reminds me when I tested on a ThinkPad wi=
th an IGD
> device. I removed the check for IGD devices in favour of a working IG=
D driver.
>=20
> Attached patch might help you (with acpi_backlight=3Dvendor)?
> You should be able to apply this on my latest patchset, but use this =
patch
> instead of the thinkpad_acpi one.

Ok, will try tonight. But I remember Henrique saying my thinkpad
shouldnt use thinkpad-acpi but rather video.ko for brightness
management, so I'm a bit puzzled.

> > Cat'ing /proc/acpi/events still gives:
> > video LCD0 00000086 00000000
> > video LCD0 00000087 00000000
> >
> > At one time I get the 750ms delay, but I don't have the
> > ibm/hotkey HKEY 00000080 00005010 at all.
> Hmm, on my machine it was 1010 and 1011 key event values for up/down
> brightness. If you do not see those, the patch might not work.

And I do remember that the key changed (but can't remember when). Maybe
that's due to a bios upgrade.

> > In X, same thing, no brightness keys, but xbacklight does work in
> > standard mode (=E2=80=9Ckernel=E2=80=9D).
> >
> > (btw it seems my mails don't reach linux-acpi, I don't really know =
why
> > and postmaster don't answer, maybe they didn't have my mail either)=
=2E
>=20
> I expect you have an IGD device and this should by default be served =
by
> Matthew's/Hong's patches. Matthew said something about a needed peace
> that came in in latest BIOSes? But I expect you already run on the la=
test?

I run Bios 2.19 and EC 1.08 which are the latest available on
lenovo.com.

The kernel I'm testing on is a pure linux-acpi-2.6/test so i'm not sure
I have Matthew's patches.

Cheers,
--=20
Yves-Alexis
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
