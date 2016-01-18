From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: 4.5 regression: ACPI hangs when backlight hotkeys are pressed
Date: Mon, 18 Jan 2016 23:25:10 +0100
Message-ID: <1591964.NyM72FoSTm@vostro.rjw.lan>
References: <CALCETrXkN1=iT80Rv3J4ywJmkA8pMd7E+u1OytSZPwpPjr6y2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:48983 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932442AbcARWY3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Jan 2016 17:24:29 -0500
In-Reply-To: <CALCETrXkN1=iT80Rv3J4ywJmkA8pMd7E+u1OytSZPwpPjr6y2A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Adrien Schildknecht <adrien+dev@schischi.me>, Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Monday, January 18, 2016 12:52:53 PM Andy Lutomirski wrote:
> I'm running 4.4 with the pm+acpi-4.5-rc1-1 merged in.  After pressing
> the backlight hotkeys a couple times, things start to break.  Poking
> at hung thread stacks, it appears that calls to
> acpi_video_handles_brightness_key_presses never return.
> 
> It appears that the culprit is:
> 
> commit aecbd9b1bff6afbe349921b406b99d285b412820
> Author: Adrien Schildknecht <adrien+dev@schischi.me>
> Date:   Mon Jan 4 23:22:28 2016 +0100
> 
>     ACPI / video: driver must be registered before checking for keypresses
> 
> Reverting that patch makes my laptop work again.
> 
> I don't know what that patch is trying to do, but it looks highly
> questionable to me.  Why should an accessor wait for a potential
> different driver to register something?  I see no guarantee that it
> will eve happen.
> 
> This is a Dell XPS 13 9350.

Should be fixed in my linux-next branch, can you please try that one?

Rafael

