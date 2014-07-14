From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [BISECTED 3.16-rc REGREGRESSION] backlight control stopped working
Date: Mon, 14 Jul 2014 15:14:43 +0200
Message-ID: <53C3D7C3.7090505@redhat.com>
References: <87pph8kse7.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59807 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755561AbaGNNOy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Jul 2014 09:14:54 -0400
In-Reply-To: <87pph8kse7.fsf@nemi.mork.no>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?UTF-8?B?QmrDuHJuIE1vcms=?= <bjorn@mork.no>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Hi,

On 07/14/2014 02:59 PM, Bj=C3=B8rn Mork wrote:
> Yes, I actually bisected this just to get
>=20
> 886129a8eebebec260165741fe31421482371006 is the first bad commit
> commit 886129a8eebebec260165741fe31421482371006
> Author: Hans de Goede <hdegoede@redhat.com>
> Date:   Tue May 6 14:46:23 2014 +0200
>=20
>     ACPI / video: change acpi-video brightness_switch_enabled default=
 to 0
>    =20
>     acpi-video is unique in that it not only generates brightness up/=
down
>     keypresses, but also (sometimes) actively changes the brightness =
itself.
>    =20
>     This presents an inconsistent kernel interface to userspace, basi=
cally there
>     are 2 different scenarios, depending on the laptop model:
>    =20
>      1) On some laptops a brightness up/down keypress means: show a b=
rightness osd
>      with the current brightness, iow it is a brightness has changed =
notification.
>    =20
>      2) Where as on (a lot of) other laptops it means a brightness up=
/down key was
>      pressed, deal with it.
>    =20
>     Most of the desktop environments interpret any press as in scenar=
io 2, and
>     change the brightness up / down as a response to the key events, =
causing it
>     to be changed twice, once by acpi-video and once by the DE.
>    =20
>     With the new default for video.use_native_backlight we will be mo=
ving even
>     more laptops over to behaving as in scenario 2. Making the remain=
ing laptops
>     even more of a weird exception. Also note that it is hard to dete=
ct scenario
>     1 properly in userspace, and AFAIK none of the DE-s deals with it=
=2E
>    =20
>     Therefor this commit changes the default of brightness_switch_ena=
bled to 0
>     making its behavior consistent with all the other backlight drive=
rs.
>    =20
>     Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>     Reviewed-by: Aaron Lu <aaron.lu@intel.com>
>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> :040000 040000 5bbac8c4f3e9fd5421daf84289004c32c3217f2a 82c99a358bda6=
360f845b6063182d3e707ff90f0 M      Documentation
> :040000 040000 81ed56a41130bbbea980620114ff11e3bb23ee63 a9870ba1d046b=
de69796060304c78dfbb1d00a1f M      drivers
>=20
>=20
>=20
> The fact that this seems to be an *intentional* breakage does not hel=
p a
> lot.  Yes, I understand that you believe the choice of default was
> incorrect for some reason.  You might even be right about that.  But
> that is still not a valid reason to break existing configurations for
> end users!  Please do not do that.

This *not* a regression, it is an intended behavior change which can be
flipped back to its old behavior with a single cmdline argument (add
video.brightness_switch_enabled=3D1 to the kernel commandline).

Yes this may break existing configurations for some users, most likely
users running some custom setup, who thus should be able to fix things
by adding one more customization to there setup.

OTOH this will also unbreak a lot of existing setups, likely an amount
of setups which is at least one order of magnitude bigger then the
amount it will break.

Most users will be running a desktop environment which will react
to the keypresses (which are always generated in cases where
brightness_switch_enabled does anything) by changing the brightness
a second time. This happens at least in gnome, kde, xfce, unity and
probably in a few smaller desktop environments as configured ootb too.

If you've a backlight control which only has 8 steps taking 2 steps
at a time is a bug issue, see e.g. :

https://bugs.launchpad.net/gnome-settings-daemon/+bug/527157
http://askubuntu.com/questions/173921/why-does-my-thinkpad-brightness-c=
ontrol-skip-steps

TL;DR: This change really is for the better and is here to stay.

> Note that NO USER cares about "some laptops" or "other laptops".  The=
y
> care about their own systems, which either
>  a) depend on the old default and therefore breaks with your change, =
or
>  b) have a user modified setting and therefore are unaffected by your
>     change

This is not how it works, sometimes we *must* look at the bigger pictur=
e,
e.g. when the Linux kernel first started advertising to acpi that it
was "Windows 2012" (aka win8), this causes some breakage, still we went
ahead with the change, because in the end we must advertise "Windows 20=
12"
support to be able to get support for certain features from the firmwar=
e.

Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
