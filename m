From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: acpi 'video' driver, and issues with
 'brightness_switch_enabled=0'
Date: Wed, 29 Apr 2009 14:15:31 +0300
Message-ID: <1241003731.26698.0.camel@maxim-laptop>
References: <1240855052.11237.7.camel@maxim-laptop>
	 <1240886605.4639.19.camel@rzhang-dt>
	 <1240912731.29860.11.camel@maxim-laptop>
	 <1240974500.4639.54.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760248AbZD2LPw@vger.kernel.org>
In-Reply-To: <1240974500.4639.54.camel@rzhang-dt>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2009-04-29 at 11:08 +0800, Zhang Rui wrote:
> On Tue, 2009-04-28 at 17:58 +0800, Maxim Levitsky wrote:
> > On Tue, 2009-04-28 at 10:43 +0800, Zhang Rui wrote:
> > > On Tue, 2009-04-28 at 01:57 +0800, Maxim Levitsky wrote:
> > > > I have a notebook which handles brightness keys in hardware, bu=
t tells
> > > > loudly when it does so.
> > > >=20
> > > if you boot into console mode w/o ACPI video driver, does the bri=
ghtness
> > > still change when you press the hotkeys?
> > They always work.
> > For s while, due to buggy ACPI table, acpi 'video' driver won't wor=
k, so
> > I blacklisted it, and yet hw keys did work.
> >=20
> so if you kill acpid, and run "cat /proc/acpi/event", there are some
> ACPI video events popping up when you press the hotkeys, right?
>=20
> this is bad, because these events are "Used to notify OSPM that the
> output device brightness should be increased/decreased by one level.
> Used to notify OSPM that the user pressed a button or key that is
> associated with cycling brightness." according to the ACPI spec.
> So, if BIOS changes the brightness for OS, it should not issue an eve=
nt
> any more.
>=20
> > >=20
> > > > Currently, acpi 'video' also sets the brightness, which result =
in double
> > > > setting, and on top of that it emits a key that makes gpm set b=
rightness
> > > > again.
> > > >=20
> > > we need to support the brightness control in console mode.
> > > and "=EF=BB=BFbrightness_switch_enabled" should be cleared in gra=
phics mode to
> > > prevent the ACPI video driver action upon hotkey events.
> > How gnome power manager can do that, use /sys/module iface?
> >=20
> > >=20
> > > > And (yes...) on top of that keyboard emits a brightness up/down=
 even,
> > > > which (you guessed...) sets brightness again.
> > > >=20
> > > > I found out that it is possible to tell gnome-power-manager not=
 to set
> > > > brightness, but yet in kernel driver still sets it.
> > > >=20
> > > > I found out even earlier that I can use brightness_switch_enabl=
ed=3D0,
> > > > which supposed to make inkernel driver not touch the brightness=
=2E
> > > > But I found out that this driver won't update the brightness, i=
n /sys
> > > > interface when I set this param.
> > > >=20
> > > No, when =EF=BB=BF"=EF=BB=BFbrightness_switch_enabled" is cleared=
, gdm should still use
> > > the ACPI backlight sysfs I/F if available to change the backlight=
,
> > > i.e. /sys/class/backlight/acpi_video0/...
> > Indeed it does, but I don't like it, hardware already changed the
> > brightness, but it receives another two events about brightness up/=
down.
> >=20
> well, this is rather a hardware problem to me.
> Because OS should change the brightness upon such a notification, eit=
her
> in ACPI video driver, or in user space.
> IMO, if BIOS doesn't want OS to change the backlight, it should not
> issue such events at all.
>=20
> > It (and I too) can change the brightness, but it doesn't update to
> > reflect current brightness
> > (/sys/class/backlight/acpi_video0/brightness) shows cached value fr=
om
> > last time it was set.
> >=20
> > there is also the actual_brightness, but I think it isn't used by g=
pm.
> >=20
> =EF=BB=BF/sys/class/backlight/acpi_video0/brightness doesn't reflect =
the actual
> brightness level, gdm should use actual_brightness instead.
>=20
> But if gdm uses the sysfs backlight I/F, the value of these two files
> should be the same.
>=20
> can you do this test please?
> 1. attach the output of "grep . /sys/class/backlight/acpi_video0/*"
> 2. press the hotkey
> 3. redo step 1.
>=20
> >=20
> > >=20
> > > what's the model name of your laptop?
> > acer aspire 5720G
>=20
> hah, I know this laptop.
> > > are you using Intel graphics?
> > no, nvidia 8400GS
> >=20
> > > please attach the output of acpidump and lspci.
> >=20
> > > It would be great if you can file a bug report about this issue a=
t
> > > bugzilla.kernel.org.
> > No problem.
> And I know you're good at reporting bugs. :p
>=20
> why not move this discussion to the bugzilla so that I can better tra=
ck
> this bug?
>=20
> thanks,
> rui
>=20
>=20

I''ll check this.

Best regards,
	Maxim Levitsky
