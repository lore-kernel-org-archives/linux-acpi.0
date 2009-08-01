From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: Illuminated keyboard on ASUS U50VG laptop, backlight or led ?
Date: Sat, 1 Aug 2009 17:50:32 +0200
Message-ID: <71cd59b00908010850w1e9b4d6p733481a4fba892e7@mail.gmail.com>
References: <71cd59b00907240034m5781fc4ciea2391d5fa17f85e@mail.gmail.com>
	 <4A7424A6.5080703@tuffmail.co.uk>
	 <71cd59b00908010540q2758ebc0xdae2a64dacad3fec@mail.gmail.com>
	 <200908011521.19672.danny.kukawka@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:49134 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908AbZHAPue (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 1 Aug 2009 11:50:34 -0400
Received: by fxm17 with SMTP id 17so1883254fxm.37
        for <linux-acpi@vger.kernel.org>; Sat, 01 Aug 2009 08:50:33 -0700 (PDT)
In-Reply-To: <200908011521.19672.danny.kukawka@web.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Danny Kukawka <danny.kukawka@web.de>
Cc: hal@lists.freedesktop.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Matthew Garrett <mjg59@srcf.ucam.org>, acpi4asus-user@lists.sourceforge.net, linux acpi <linux-acpi@vger.kernel.org>

On Sat, Aug 1, 2009 at 3:21 PM, Danny Kukawka<danny.kukawka@web.de> wrote:
> On Samstag, 1. August 2009, Corentin Chary wrote:
>> Maybe just *:kbd_backlight . The naming scheme is vendor:color:name
>> The problem is that hald-addon-generic-kbd-backlight is not merged
>> upstream.
>>
>> So, hal mailing list is now CC'ed
>> Is there any plan to merge hald-addon-generic-kbd-backlight ?
>> Patch can be found here:
>> http://lists.freedesktop.org/archives/hal/2008-October/012361.html
>
> This patch is not needed. There is a generic addon for the leds subsystem in
> HAL.
>
> Check out:
> http://people.freedesktop.org/~dkukawka/hal-spec-git/hal-spec.html#interface-device-leds
>
> If there is any problem with this addon, let me know.
>
> Danny

It seems there is also a KeyboardBacklight interface which is what we
want, but I didn't find how to use it
without an addon (like addon-macbookpro-backlight).

Summary of the thread:
Asus U50 provide a keyboard backlight, I didn't know how to expose
that to userspace.
Matthew told me that in Apples, the SMC driver expose the keyboard
backlight as a led.
Then Alan found hald-addon-generic-kbd-backlight to plug the led subsystem and
org.freedesktop.Hal.Device.KeyboardBacklight interface.

What we want to do is change the brightness when KEY_KBDILLUM* is pressed.

I believe that we need a keyboard backlight addon that respond to  KEY_KBDILLUM*
and update the corresponding /sys/class/vendor:color:kbd_backlight.

-- 
Corentin Chary
http://xf.iksaif.net - http://uffs.org
