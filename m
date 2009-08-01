From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: Illuminated keyboard on ASUS U50VG laptop, backlight or led ?
Date: Sat, 1 Aug 2009 20:47:03 +0100
Message-ID: <9b2b86520908011247g6341866cu7da61504a6477683@mail.gmail.com>
References: <71cd59b00907240034m5781fc4ciea2391d5fa17f85e@mail.gmail.com>
	 <71cd59b00908010850w1e9b4d6p733481a4fba892e7@mail.gmail.com>
	 <9b2b86520908010930n4b47c6c2uc5608ae7d81b0b6b@mail.gmail.com>
	 <200908011921.23990.danny.kukawka@web.de>
	 <9b2b86520908011243r47f39f14t3ef991180927274a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:59579 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089AbZHATrE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 1 Aug 2009 15:47:04 -0400
Received: by bwz19 with SMTP id 19so1760157bwz.37
        for <linux-acpi@vger.kernel.org>; Sat, 01 Aug 2009 12:47:03 -0700 (PDT)
In-Reply-To: <9b2b86520908011243r47f39f14t3ef991180927274a@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Danny Kukawka <danny.kukawka@web.de>
Cc: hal@lists.freedesktop.org, Corentin Chary <corentin.chary@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, acpi4asus-user@lists.sourceforge.net, linux acpi <linux-acpi@vger.kernel.org>

On 8/1/09, Alan Jenkins <sourcejedi.lkml@googlemail.com> wrote:
> On 8/1/09, Danny Kukawka <danny.kukawka@web.de> wrote:
>> On Samstag, 1. August 2009, Alan Jenkins wrote:
>>> I
>>> think the idea is to use an FDI file to match our LED device (or
>>> possibly create it as a hal device... I'm still really fuzzy on hal),
>>> and then mark it as having the "keyboard_backlight" capability.
>>
>> No, it wouldn't work this way. At least not with the current key.
>>
>> I changed the led addon in my repo to check if a led has
>> leds.function=kbd_backlight and provide then the
>> org.freedesktop.Hal.Device.KeyboardBacklight interface instead of
>> org.freedesktop.Hal.Device.Leds. Please check if this helps.
>>
>> see:
>> http://cgit.freedesktop.org/~dkukawka/hal/commit/?id=c900d0e5012b1dd0e0fa6e20fd0d92a59b3de093
>>
>> [...]
>>> > I believe that we need a keyboard backlight addon that respond to
>>> > KEY_KBDILLUM*
>>> > and update the corresponding /sys/class/vendor:color:kbd_backlight.
>>>
>>> Oops, thats not the addons job.  It's for something like the gnome
>>> power manager.  It looks like g-p-m already picks up the device with a
>>> "keyboard_backlight" capability, and react to keyboard brightness key
>>> events.
>>
>> Correct. It's not the job of the addon to react on keyevents. This is up
>> to
>> a
>> desktop application which listen to the events and call then the
>> interface.
>> The same way it work for e.g. the brightness of your laptop panel.
>>
>> Danny
>
> Thanks!  It's not my hardware, but I think I see an issue:
>
> Don't you also need to set "keyboard_backlight.num_levels"?  According
> to Documentation/leds-class.txt, valid led values are 0-255, so I
> expect num_levels should be set to 256.
>
> Yuck... I think the backlight interface is better in that it exports
> the available granularity.
^
Sorry, to avoid confusion I was moaning about the _kernel_ backlight
interface.  Apologies for being obscure.

Thanks again
Alan
