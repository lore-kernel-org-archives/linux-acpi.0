From: joeyli <jlee@suse.com>
Subject: Re: "Windows 2012" OSI causes backlight problems on current
 ThinkPad firmware
Date: Tue, 25 Dec 2012 07:05:03 +0800
Message-ID: <1356390303.6113.47.camel@linux-s257.site>
References: <50D8C9D1.2060801@bjencks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:54397 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753377Ab2LXXIH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Dec 2012 18:08:07 -0500
In-Reply-To: <50D8C9D1.2060801@bjencks.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ben Jencks <ben@bjencks.net>
Cc: linux-acpi@vger.kernel.org

=E6=96=BC =E4=B8=80=EF=BC=8C2012-12-24 =E6=96=BC 16:32 -0500=EF=BC=8CBe=
n Jencks =E6=8F=90=E5=88=B0=EF=BC=9A
> The addition of "Windows 2012" to the OSI strings in the 3.7 cycle ha=
s
> caused backlight brightness adjustment to break on my ThinkPad T530.
>=20
> Without "Windows 2012" _BCL returns the actual 16 brightness levels:
>=20
> 5, 10, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 90, 100
>=20
> When "Windows 2012" is present, it returns 101 levels 0-100, but _BCM
> rounds any value up to one of the real values above.
>=20
> This interacts badly with gnome-settings-daemon, which attempts to
> change brightness in increments of 5 (1/20 of 100). If brightness is
> currently 100, it attempts to decrement it to 95, but it gets rounded
> back up to 100, so it's impossible to decrease the brightness.
>=20
> Booting with acpi_osi=3D"!Windows 2012" fixes the problem, though I'm
> not
> sure if it introduces others; I see several other things depend on
> WIN8
> in DSDT.
>=20
> Perhaps this should be fixed in gnome-settings-daemon, but since it
> appears on the surface to be a kernel regression (3.6 works, 3.7
> broken)
> I thought I'd report it here first.=20

Yes, this is g-s-d's problem, g-s-d should adapt to more levels of
brightness:

plugins/power/gsd-power-manager.c

/* on ACPI machines we have 4-16 levels, on others it's ~150 */
#define BRIGHTNESS_STEP_AMOUNT(max) ((max) < 20 ? 1 : (max) / 20)



Thanks a lot!
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
