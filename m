From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: Illuminated keyboard on ASUS U50VG laptop, backlight or led ?
Date: Sat, 01 Aug 2009 12:19:02 +0100
Message-ID: <4A7424A6.5080703@tuffmail.co.uk>
References: <71cd59b00907240034m5781fc4ciea2391d5fa17f85e@mail.gmail.com>	 <71cd59b00907281251k7fc6cf7fga433531572394b99@mail.gmail.com>	 <20090728200449.GA16330@srcf.ucam.org> <71cd59b00908010340m2b48d581n4c8cb470921e4652@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f214.google.com ([209.85.219.214]:40308 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbZHALTG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 1 Aug 2009 07:19:06 -0400
Received: by ewy10 with SMTP id 10so2034802ewy.37
        for <linux-acpi@vger.kernel.org>; Sat, 01 Aug 2009 04:19:05 -0700 (PDT)
In-Reply-To: <71cd59b00908010340m2b48d581n4c8cb470921e4652@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux acpi <linux-acpi@vger.kernel.org>, acpi4asus-user@lists.sourceforge.net

Corentin Chary wrote:
> On Tue, Jul 28, 2009 at 10:04 PM, Matthew Garrett<mjg59@srcf.ucam.org> wrote:
>   
>> On Tue, Jul 28, 2009 at 09:51:09PM +0200, Corentin Chary wrote:
>>
>>     
>>> No answers.
>>> I think I'll implement that as a backlight, because it is a backlight
>>> even if it's not for a screen.
>>>       
>> I believe the SMC driver for the Apples does it via LED, so it might
>> make sense to be consistent with that.
>>
>> --
>> Matthew Garrett | mjg59@srcf.ucam.org
>>
>>     
>
> So it will be a led.
>   

I think you should also match the LED name used by the apple driver.  As
far as I know it's the only sensible way for userspace to identify the
LED.  The SMC driver uses "smc::kbd_backlight",  so something like
"eeepc::kbd_backlight".

> There is another problem, Fn+F3/F4 generate ACPI events
>
> Fn+F3 : hotkey ATKD 000000c5 00000000
> Fn+F4 : hotkey ATKD 000000c4 00000000
>
> Fn+F3: decreases keyboard brightness
> Fn+F4: increases keyboard brightness
>
> Should we handle these events with acpi scripts or directly in the driver ?
> IMHO it can be done directly in the driver, like LCD On/Off keys.
>   

Here's my opinion based on no experience and 10 minutes with google :-).

Userspace should take charge of changing the brightness.  It would be
good to generate input events (KEY_KBDILLUMUP etc) as well though.

Hopefully hald-addon-generic-kbd-backlight already responds to
KEY_KBDILLUM*.  If so, then one could use Hal along with an FDI file
like the apple one
(<http://lists.freedesktop.org/archives/hal/2008-October/012360.html>). 
That's close to what we should ultimately be aiming for, except for the
specific match on "smc::kbd_backlight".  It would be great to just have
one rule matching on *::kbd_backlight.

Alan
