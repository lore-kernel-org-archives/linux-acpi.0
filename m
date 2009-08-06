From: Danny Kukawka <danny.kukawka@web.de>
Subject: Re: Illuminated keyboard on ASUS U50VG laptop, backlight or led ?
Date: Thu, 6 Aug 2009 12:48:39 +0200
Message-ID: <200908061248.40340.danny.kukawka@web.de>
References: <71cd59b00907240034m5781fc4ciea2391d5fa17f85e@mail.gmail.com> <71cd59b00908020020p1f672529mf3cd403526005ed5@mail.gmail.com> <200908061207.12450.corentin.chary@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:44646 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752744AbZHFKsv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 6 Aug 2009 06:48:51 -0400
In-Reply-To: <200908061207.12450.corentin.chary@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: hal@lists.freedesktop.org
Cc: Corentin Chary <corentin.chary@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, acpi4asus-user@lists.sourceforge.net, Alan Jenkins <sourcejedi.lkml@googlemail.com>, linux acpi <linux-acpi@vger.kernel.org>

On Donnerstag, 6. August 2009, Corentin Chary wrote:
> Hi Danny,
> I was trying to add keyboard_backlight.num_levels support for your modified
> led-addon. But there is something I don't understand :-
> keyboard_backlight.num_levels is used in:
> - examples/light_sensors_and_keyboard_backlight.py
> - fdi/policy/10osvendor/10-macbookpro-utils.fdi
> - kde/solid/hal/halpower.cpp
> But it is not defined in doc/spec/hal-spec-properties.xml.
>
> Should I make another patch to fix hal-spec-properties ?

Can you please provide a "grep . */*" from /sys/class/leds/ with the affected 
device? If I read the kernel doc for leds (which this device is), we don't 
need a num_levels for it:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=Documentation/leds-class.txt;h=6399557cdab3d6542a0feea0c0cd2c6b2af5ffad;hb=HEAD

"... The brightness file will set the brightness of the LED (taking a value 
0-255). Most LEDs don't have hardware brightness support so will just be 
turned on for non-zero brightness settings. ..."

Danny

