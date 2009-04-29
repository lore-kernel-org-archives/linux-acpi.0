From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: acpi 'video' driver, and issues with
	'brightness_switch_enabled=0'
Date: Wed, 29 Apr 2009 11:08:20 +0800
Message-ID: <1240974500.4639.54.camel@rzhang-dt>
References: <1240855052.11237.7.camel@maxim-laptop>
	 <1240886605.4639.19.camel@rzhang-dt>
	 <1240912731.29860.11.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:59049 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752717AbZD2DHz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Apr 2009 23:07:55 -0400
In-Reply-To: <1240912731.29860.11.camel@maxim-laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, 2009-04-28 at 17:58 +0800, Maxim Levitsky wrote:
> On Tue, 2009-04-28 at 10:43 +0800, Zhang Rui wrote:
> > On Tue, 2009-04-28 at 01:57 +0800, Maxim Levitsky wrote:
> > > I have a notebook which handles brightness keys in hardware, but =
tells
> > > loudly when it does so.
> > >=20
> > if you boot into console mode w/o ACPI video driver, does the brigh=
tness
> > still change when you press the hotkeys?
> They always work.
> For s while, due to buggy ACPI table, acpi 'video' driver won't work,=
 so
> I blacklisted it, and yet hw keys did work.
>=20
so if you kill acpid, and run "cat /proc/acpi/event", there are some
ACPI video events popping up when you press the hotkeys, right?

this is bad, because these events are "Used to notify OSPM that the
output device brightness should be increased/decreased by one level.
Used to notify OSPM that the user pressed a button or key that is
associated with cycling brightness." according to the ACPI spec.
So, if BIOS changes the brightness for OS, it should not issue an event
any more.

> >=20
> > > Currently, acpi 'video' also sets the brightness, which result in=
 double
> > > setting, and on top of that it emits a key that makes gpm set bri=
ghtness
> > > again.
> > >=20
> > we need to support the brightness control in console mode.
> > and "=EF=BB=BFbrightness_switch_enabled" should be cleared in graph=
ics mode to
> > prevent the ACPI video driver action upon hotkey events.
> How gnome power manager can do that, use /sys/module iface?
>=20
> >=20
> > > And (yes...) on top of that keyboard emits a brightness up/down e=
ven,
> > > which (you guessed...) sets brightness again.
> > >=20
> > > I found out that it is possible to tell gnome-power-manager not t=
o set
> > > brightness, but yet in kernel driver still sets it.
> > >=20
> > > I found out even earlier that I can use brightness_switch_enabled=
=3D0,
> > > which supposed to make inkernel driver not touch the brightness.
> > > But I found out that this driver won't update the brightness, in =
/sys
> > > interface when I set this param.
> > >=20
> > No, when =EF=BB=BF"=EF=BB=BFbrightness_switch_enabled" is cleared, =
gdm should still use
> > the ACPI backlight sysfs I/F if available to change the backlight,
> > i.e. /sys/class/backlight/acpi_video0/...
> Indeed it does, but I don't like it, hardware already changed the
> brightness, but it receives another two events about brightness up/do=
wn.
>=20
well, this is rather a hardware problem to me.
Because OS should change the brightness upon such a notification, eithe=
r
in ACPI video driver, or in user space.
IMO, if BIOS doesn't want OS to change the backlight, it should not
issue such events at all.

> It (and I too) can change the brightness, but it doesn't update to
> reflect current brightness
> (/sys/class/backlight/acpi_video0/brightness) shows cached value from
> last time it was set.
>=20
> there is also the actual_brightness, but I think it isn't used by gpm=
=2E
>=20
=EF=BB=BF/sys/class/backlight/acpi_video0/brightness doesn't reflect th=
e actual
brightness level, gdm should use actual_brightness instead.

But if gdm uses the sysfs backlight I/F, the value of these two files
should be the same.

can you do this test please?
1. attach the output of "grep . /sys/class/backlight/acpi_video0/*"
2. press the hotkey
3. redo step 1.

>=20
> >=20
> > what's the model name of your laptop?
> acer aspire 5720G

hah, I know this laptop.
> > are you using Intel graphics?
> no, nvidia 8400GS
>=20
> > please attach the output of acpidump and lspci.
>=20
> > It would be great if you can file a bug report about this issue at
> > bugzilla.kernel.org.
> No problem.
And I know you're good at reporting bugs. :p

why not move this discussion to the bugzilla so that I can better track
this bug?

thanks,
rui


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
