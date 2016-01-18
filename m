From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: 4.5 regression: ACPI hangs when backlight hotkeys are pressed
Date: Tue, 19 Jan 2016 00:54:11 +0100
Message-ID: <8073679.7fv4DbcKla@vostro.rjw.lan>
References: <CALCETrXkN1=iT80Rv3J4ywJmkA8pMd7E+u1OytSZPwpPjr6y2A@mail.gmail.com> <1591964.NyM72FoSTm@vostro.rjw.lan> <CALCETrU4RoC5MQRdfx5eHbKvfRbPBBQ4YCPLS7nHwLC+sq=uag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52494 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754668AbcARXx3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Jan 2016 18:53:29 -0500
In-Reply-To: <CALCETrU4RoC5MQRdfx5eHbKvfRbPBBQ4YCPLS7nHwLC+sq=uag@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Adrien Schildknecht <adrien+dev@schischi.me>, Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Monday, January 18, 2016 03:04:28 PM Andy Lutomirski wrote:
> On Mon, Jan 18, 2016 at 2:25 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Monday, January 18, 2016 12:52:53 PM Andy Lutomirski wrote:
> >> I'm running 4.4 with the pm+acpi-4.5-rc1-1 merged in.  After pressing
> >> the backlight hotkeys a couple times, things start to break.  Poking
> >> at hung thread stacks, it appears that calls to
> >> acpi_video_handles_brightness_key_presses never return.
> >>
> >> It appears that the culprit is:
> >>
> >> commit aecbd9b1bff6afbe349921b406b99d285b412820
> >> Author: Adrien Schildknecht <adrien+dev@schischi.me>
> >> Date:   Mon Jan 4 23:22:28 2016 +0100
> >>
> >>     ACPI / video: driver must be registered before checking for keypresses
> >>
> >> Reverting that patch makes my laptop work again.
> >>
> >> I don't know what that patch is trying to do, but it looks highly
> >> questionable to me.  Why should an accessor wait for a potential
> >> different driver to register something?  I see no guarantee that it
> >> will eve happen.
> >>
> >> This is a Dell XPS 13 9350.
> >
> > Should be fixed in my linux-next branch, can you please try that one?
> >
> 
> To avoid churning my laptop tree too much, I cherry-picked:
> 
> ACPI / video: Add disable_backlight_sysfs_if quirk for the Toshiba
> Satellite R830
> ACPI / video: Revert "thinkpad_acpi: Use
> acpi_video_handles_brightness_key_presses()"
> ACPI / video: Document acpi_video_handles_brightness_key_presses() a bit
> ACPI / video: Fix using an uninitialized mutex / list_head in
> acpi_video_handles_brightness_key_presses()
> ACPI / video: Revert "ACPI / video: driver must be registered before
> checking for keypresses"
> 
> The result seems to work.  Are you planning on sending these for 4.5?

Yes, I am.

Most likely on Wednesday (or Thursday if anything urgent shows up in the meantime).

Thanks,
Rafael

