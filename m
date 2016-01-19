From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: 4.5 regression: ACPI hangs when backlight hotkeys are pressed
Date: Tue, 19 Jan 2016 01:20:22 +0100
Message-ID: <13973280.p4fhCg3bGF@vostro.rjw.lan>
References: <CALCETrXkN1=iT80Rv3J4ywJmkA8pMd7E+u1OytSZPwpPjr6y2A@mail.gmail.com> <1541559.QSyCfx8pKj@vostro.rjw.lan> <CALCETrUYq8ZhNrCkVkxk_P6X2XJHihbpdUzaxmc0ZXs-CST1fA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59994 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754668AbcASATl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Jan 2016 19:19:41 -0500
In-Reply-To: <CALCETrUYq8ZhNrCkVkxk_P6X2XJHihbpdUzaxmc0ZXs-CST1fA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Adrien Schildknecht <adrien+dev@schischi.me>, Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Monday, January 18, 2016 04:09:27 PM Andy Lutomirski wrote:
> On Mon, Jan 18, 2016 at 4:01 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Monday, January 18, 2016 03:57:49 PM Andy Lutomirski wrote:
> >> On Mon, Jan 18, 2016 at 3:54 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> > On Monday, January 18, 2016 03:04:28 PM Andy Lutomirski wrote:
> >> >> On Mon, Jan 18, 2016 at 2:25 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> >> > On Monday, January 18, 2016 12:52:53 PM Andy Lutomirski wrote:
> >> >> >> I'm running 4.4 with the pm+acpi-4.5-rc1-1 merged in.  After pressing
> >> >> >> the backlight hotkeys a couple times, things start to break.  Poking
> >> >> >> at hung thread stacks, it appears that calls to
> >> >> >> acpi_video_handles_brightness_key_presses never return.
> >> >> >>
> >> >> >> It appears that the culprit is:
> >> >> >>
> >> >> >> commit aecbd9b1bff6afbe349921b406b99d285b412820
> >> >> >> Author: Adrien Schildknecht <adrien+dev@schischi.me>
> >> >> >> Date:   Mon Jan 4 23:22:28 2016 +0100
> >> >> >>
> >> >> >>     ACPI / video: driver must be registered before checking for keypresses
> >> >> >>
> >> >> >> Reverting that patch makes my laptop work again.
> >> >> >>
> >> >> >> I don't know what that patch is trying to do, but it looks highly
> >> >> >> questionable to me.  Why should an accessor wait for a potential
> >> >> >> different driver to register something?  I see no guarantee that it
> >> >> >> will eve happen.
> >> >> >>
> >> >> >> This is a Dell XPS 13 9350.
> >> >> >
> >> >> > Should be fixed in my linux-next branch, can you please try that one?
> >> >> >
> >> >>
> >> >> To avoid churning my laptop tree too much, I cherry-picked:
> >> >>
> >> >> ACPI / video: Add disable_backlight_sysfs_if quirk for the Toshiba
> >> >> Satellite R830
> >> >> ACPI / video: Revert "thinkpad_acpi: Use
> >> >> acpi_video_handles_brightness_key_presses()"
> >> >> ACPI / video: Document acpi_video_handles_brightness_key_presses() a bit
> >> >> ACPI / video: Fix using an uninitialized mutex / list_head in
> >> >> acpi_video_handles_brightness_key_presses()
> >> >> ACPI / video: Revert "ACPI / video: driver must be registered before
> >> >> checking for keypresses"
> >> >>
> >> >> The result seems to work.  Are you planning on sending these for 4.5?
> >> >
> >> > Yes, I am.
> >> >
> >> > Most likely on Wednesday (or Thursday if anything urgent shows up in the meantime).
> >> >
> >>
> >> Sounds good.  I'll keep testing.
> >>
> >> Some day my laptop will Just Work on a distro kernel :)
> >
> > Well, even then it'll help a lot if you run the mainline on it, so we know that
> > it doesn't regress.
> >
> 
> So far the only other change I noticed is that I stopped seeing
> warnings about S1 and S2 being missing.

That's intentional. :-)

Thanks,
Rafael

