From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Linux 3.11-rc2 [backlight] [ASUS N56VZ]
Date: Wed, 24 Jul 2013 21:39:38 +0200
Message-ID: <17420057.BAULu67LQ3@vostro.rjw.lan>
References: <BLU0-SMTP125E791F01E26C3D60D7353A6680@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:38329 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753600Ab3GXT3g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Jul 2013 15:29:36 -0400
In-Reply-To: <BLU0-SMTP125E791F01E26C3D60D7353A6680@phx.gbl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: * =?ISO-8859-1?Q?SAM=CD?= * <miaousami@hotmail.com>
Cc: linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Aaron Lu <aaron.lu@intel.com>, Igor Gnatenko <i.gnatenko.brain@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx <intel-gfx@lists.freedesktop.org>

On Wednesday, July 24, 2013 08:43:00 PM * SAM=C3=8D * wrote:
> Hi,
>=20
> it seems a lot of people are complaining about the backlight pull=20
> request of RC2.
>=20
> This is to tell you how it saved my life:
> - Changing brightness from Fn keys does work
> - Writing to /sys/class/backlight/intel_backlight/brightness does wor=
k
> - Changing brightness from gnome brightness settings does work
> --> It seems everything is now working (it wasn't before).
> --> I appreciate your patch and I am going to be sad if you revert it=
 :-)

Well, there seems to be a number of people who'll be equally unhappy if=
 I don't
do that.  Unfortunately for you, things work for them without that patc=
h.

The source of the problem seems to be that the i915's backlight support=
 doesn't
work for all those people, although it should work anyway in principle.=
  So to
me the way to go seems to be to revert the patch for now, fix the i915
backlight interface for them and try to apply it again when we're more
confident about the i915 backlight.

Thanks,
Rafael


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
