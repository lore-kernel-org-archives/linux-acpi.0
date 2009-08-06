From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: Illuminated keyboard on ASUS U50VG laptop, backlight or led ?
Date: Thu, 6 Aug 2009 13:59:48 +0200
Message-ID: <71cd59b00908060459y56448912od7f8914f3b44de0e@mail.gmail.com>
References: <71cd59b00907240034m5781fc4ciea2391d5fa17f85e@mail.gmail.com>
	 <71cd59b00908020020p1f672529mf3cd403526005ed5@mail.gmail.com>
	 <200908061207.12450.corentin.chary@gmail.com>
	 <200908061248.40340.danny.kukawka@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f228.google.com ([209.85.220.228]:39237 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754432AbZHFL7t (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Aug 2009 07:59:49 -0400
Received: by fxm28 with SMTP id 28so688074fxm.17
        for <linux-acpi@vger.kernel.org>; Thu, 06 Aug 2009 04:59:48 -0700 (PDT)
In-Reply-To: <200908061248.40340.danny.kukawka@web.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Danny Kukawka <danny.kukawka@web.de>
Cc: hal@lists.freedesktop.org, Matthew Garrett <mjg59@srcf.ucam.org>, acpi4asus-user@lists.sourceforge.net, Alan Jenkins <sourcejedi.lkml@googlemail.com>, linux acpi <linux-acpi@vger.kernel.org>

On Thu, Aug 6, 2009 at 12:48 PM, Danny Kukawka<danny.kukawka@web.de> wrote:
> On Donnerstag, 6. August 2009, Corentin Chary wrote:
>> Hi Danny,
>> I was trying to add keyboard_backlight.num_levels support for your modified
>> led-addon. But there is something I don't understand :-
>> keyboard_backlight.num_levels is used in:
>> - examples/light_sensors_and_keyboard_backlight.py
>> - fdi/policy/10osvendor/10-macbookpro-utils.fdi
>> - kde/solid/hal/halpower.cpp
>> But it is not defined in doc/spec/hal-spec-properties.xml.
>>
>> Should I make another patch to fix hal-spec-properties ?
>
> Can you please provide a "grep . */*" from /sys/class/leds/ with the affected
> device? If I read the kernel doc for leds (which this device is), we don't
> need a num_levels for it:
>
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=Documentation/leds-class.txt;h=6399557cdab3d6542a0feea0c0cd2c6b2af5ffad;hb=HEAD
>
> "... The brightness file will set the brightness of the LED (taking a value
> 0-255). Most LEDs don't have hardware brightness support so will just be
> turned on for non-zero brightness settings. ..."
>

The documentation is probably out of date, the led class provide
a max_brightness file. 255 is the default value, but it can be overridden.

See: http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=drivers/leds/led-class.c;h=f2cc13d76810f457c752d6f92f53759980f465ea;hb=HEAD#l76

leds-dac124s085.c define it to 0xFFF for example.
And asus-laptop will soon use 3 as max_brightness for asus::kbd_backlight.

But still, it seems that examples/light_sensors_and_keyboard_backlight.py
and others are using something that is not defined in hal-spec-properties.

Thanks,
-- 
Corentin Chary
http://xf.iksaif.net - http://uffs.org
