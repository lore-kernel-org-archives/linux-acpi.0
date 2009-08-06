From: Danny Kukawka <danny.kukawka@web.de>
Subject: Re: Illuminated keyboard on ASUS U50VG laptop, backlight or led ?
Date: Thu, 6 Aug 2009 18:20:19 +0200
Message-ID: <200908061820.23412.danny.kukawka@web.de>
References: <71cd59b00907240034m5781fc4ciea2391d5fa17f85e@mail.gmail.com> <200908061248.40340.danny.kukawka@web.de> <71cd59b00908060459y56448912od7f8914f3b44de0e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:55896 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752966AbZHFQUg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 6 Aug 2009 12:20:36 -0400
In-Reply-To: <71cd59b00908060459y56448912od7f8914f3b44de0e@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: hal@lists.freedesktop.org
Cc: Corentin Chary <corentin.chary@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, acpi4asus-user@lists.sourceforge.net, Alan Jenkins <sourcejedi.lkml@googlemail.com>, linux acpi <linux-acpi@vger.kernel.org>

On Donnerstag, 6. August 2009, Corentin Chary wrote:
> On Thu, Aug 6, 2009 at 12:48 PM, Danny Kukawka<danny.kukawka@web.de> wrote:
[...]
> > Can you please provide a "grep . */*" from /sys/class/leds/ with the
> > affected device? If I read the kernel doc for leds (which this device
> > is), we don't need a num_levels for it:
> >
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f
> >=Documentation/leds-class.txt;h=6399557cdab3d6542a0feea0c0cd2c6b2af5ffad;h
> >b=HEAD
> >
> > "... The brightness file will set the brightness of the LED (taking a
> > value 0-255). Most LEDs don't have hardware brightness support so will
> > just be turned on for non-zero brightness settings. ..."
>
> The documentation is probably out of date, the led class provide
> a max_brightness file. 255 is the default value, but it can be overridden.
>
> See:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=d
>rivers/leds/led-class.c;h=f2cc13d76810f457c752d6f92f53759980f465ea;hb=HEAD#l
>76
>
> leds-dac124s085.c define it to 0xFFF for example.
> And asus-laptop will soon use 3 as max_brightness for asus::kbd_backlight.
>
> But still, it seems that examples/light_sensors_and_keyboard_backlight.py
> and others are using something that is not defined in hal-spec-properties.

Thanks for the information. Please check out my latest commits:
http://cgit.freedesktop.org/~dkukawka/hal/log/

I hope this finally solve the problem.

Danny


