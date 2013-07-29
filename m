From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Intel-gfx] Linux 3.11-rc2 [backlight] [ASUS N56VZ]
Date: Mon, 29 Jul 2013 22:03:31 +0200
Message-ID: <1472278.oeeviaMfXH@vostro.rjw.lan>
References: <BLU0-SMTP125E791F01E26C3D60D7353A6680@phx.gbl> <5730704.o2aLKRMvVz@vostro.rjw.lan> <BLU0-SMTP272CC1C4BE207873BCD0CFFA6550@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:46383 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751410Ab3G2Tx0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Jul 2013 15:53:26 -0400
In-Reply-To: <BLU0-SMTP272CC1C4BE207873BCD0CFFA6550@phx.gbl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: * =?ISO-8859-1?Q?SAM=CD?= * <miaousami@hotmail.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Aaron Lu <aaron.lu@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Igor Gnatenko <i.gnatenko.brain@gmail.com>

On Monday, July 29, 2013 09:36:31 PM * SAM=C3=8D * wrote:
> Hi Rafael,
>=20
>=20
> did you commit a full revert?

Yes, but I left acpi_video_backlight_quirks() (in drivers/acpi/video_de=
tect.c)
that is used to decide what to do with _DOS.

Can you please check if making that function always return 'false' make=
s any
difference?

Rafael


> Because I am experiencing quite weird things in rc3.
> Do we have a bug opened to discuss about it?
>=20
> Here is what I can observe:
> 1) During boot, probably when loading the driver, backlight gets off =
(or=20
> to a level low enough to make me feel it is off)
> 2) When I am playing with my Fn+x keys, I am getting a completely ful=
l /=20
> completely low brightness with no intermediate steps
> 3) When I am playing with my Fn+x keys while gnome brightness setting=
s=20
> panel is open, I am recovering intermediate steps but the Fn+x keys=20
> behavior is inverted (the key supposed to lower the brightness make i=
t=20
> increase and vice-versa. Note that the gnome brightness indicator als=
o=20
> gets inverted).
> 4) Playing with the mouse on gnome brightness settings is working,=20
> except that on the minimum level, backlight gets off
> 5) Writing to /sys/class/backlight/intel_backlight/brightness works
>=20
>=20
> Regards
>=20
> On 07/25/2013 02:57 PM, Rafael J. Wysocki wrote:
> > On Thursday, July 25, 2013 03:34:10 PM Jani Nikula wrote:
> >> On Thu, 25 Jul 2013, "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >>> On Thursday, July 25, 2013 11:09:27 AM Jani Nikula wrote:
> >>>> On Thu, 25 Jul 2013, "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >>>>> Well, I wonder what about the appended (untested) patch?
> >>>> Rafael, before going there, I've been trying to wrap my (poor, r=
usty
> >>>> after vacation) head around
> >>>>
> >>>> commit 8c5bd7adb2ce47e6aa39d17b2375f69b0c0aa255
> >>>> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>> Date:   Thu Jul 18 02:08:06 2013 +0200
> >>>>
> >>>>      ACPI / video / i915: No ACPI backlight if firmware expects =
Windows 8
> >>>>
> >>>> and I can't see how it could work.
> >>> Well, if it didn't work, people wouldn't see either improvement o=
r breakage
> >>> from it, but they do see that, so it evidently works. :-)
> >> I didn't claim it didn't work, just that *I* didn't see how it cou=
ld. ;)
> >>
> >>>> First, the ACPI_VIDEO_SKIP_BACKLIGHT flag seems to be checked be=
fore
> >>>> it's actually set anywhere.
> >>> Are you sure about that?
> >>>
> >>> acpi_video_bus_add() is the .add() callback routine for acpi_vide=
o_bus which
> >>> in fact is an ACPI driver (the naming sucks, but I didn't invent =
it).  This
> >>> means that acpi_video_bus_add() can only be called *after* acpi_v=
ideo_bus
> >>> has been registered with the ACPI subsystem (and the driver core)=
=2E  That
> >>> is done by acpi_bus_register_driver() and, guess what?, this happ=
ens in
> >>> __acpi_video_register().  So clearly, acpi_video_bus_add() *canno=
t* run before
> >>> __acpi_video_register().
> >> Right. I totally missed the call within the ternary operator. Than=
ks for
> >> the explanation, and apologies for the noise.
> >>
> >>>> Second, with i915 that has opregion support, __acpi_video_regist=
er()
> >>>> should only ever get called once. Which means the acpi_walk_name=
space()
> >>>> with video_unregister_backlight() should never get called in reg=
ister.
> >>>>
> >>>> Please enlighten me.
> >>> Actually, that's correct, so we don't need the whole
> >>> video_unregister_backlight() thing, calling acpi_video_backlight_=
quirks() would
> >>> be sufficient.
> >>>
> >>> Ah, one more reason to do a full revert.  I'm thinking, though, t=
hat I'll leave
> >>> acpi_video_backlight_quirks() as is so that it can be used by
> >>> acpi_video_bus_(start)|(stop)_devices(), because that doesn't see=
m to cause
> >>> problems to happen.
> >> I observe that for the regular non-quirk acpi_video_register() cal=
l,
> >> acpi_video_backlight_quirks() won't be called during register, but=
 it
> >> will get called later. This might have subtle effects later on, do=
n't
> >> you think?
> > Yes, it might, but after dropping ACPI_VIDEO_SKIP_BACKLIGHT it shou=
ld be OK.
> >
> >> As to the original problem, and your patch in this thread, what do=
 you
> >> think about having another value in acpi_backlight kernel paramete=
r for
> >> it? Having an i915 module parameter to tell acpi to use or not use
> >> quirks seems odd, since the i915 is not really taking over
> >> anything. It's just passing the info on to acpi.
> > I agree, I'm going to send a full revert in a while and we'll think=
 what to
> > do about all that later.
> >
> > Thanks,
> > Rafael
> >
> >
>=20
--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
