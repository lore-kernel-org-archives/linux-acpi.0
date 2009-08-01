From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: Illuminated keyboard on ASUS U50VG laptop, backlight or led ?
Date: Sat, 1 Aug 2009 12:40:38 +0200
Message-ID: <71cd59b00908010340m2b48d581n4c8cb470921e4652@mail.gmail.com>
References: <71cd59b00907240034m5781fc4ciea2391d5fa17f85e@mail.gmail.com>
	 <71cd59b00907281251k7fc6cf7fga433531572394b99@mail.gmail.com>
	 <20090728200449.GA16330@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:60349 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607AbZHAKkj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 1 Aug 2009 06:40:39 -0400
Received: by bwz19 with SMTP id 19so1611245bwz.37
        for <linux-acpi@vger.kernel.org>; Sat, 01 Aug 2009 03:40:39 -0700 (PDT)
In-Reply-To: <20090728200449.GA16330@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, acpi4asus-user@lists.sourceforge.net

On Tue, Jul 28, 2009 at 10:04 PM, Matthew Garrett<mjg59@srcf.ucam.org> wrote:
> On Tue, Jul 28, 2009 at 09:51:09PM +0200, Corentin Chary wrote:
>
>> No answers.
>> I think I'll implement that as a backlight, because it is a backlight
>> even if it's not for a screen.
>
> I believe the SMC driver for the Apples does it via LED, so it might
> make sense to be consistent with that.
>
> --
> Matthew Garrett | mjg59@srcf.ucam.org
>

So it will be a led.
There is another problem, Fn+F3/F4 generate ACPI events

Fn+F3 : hotkey ATKD 000000c5 00000000
Fn+F4 : hotkey ATKD 000000c4 00000000

Fn+F3: decreases keyboard brightness
Fn+F4: increases keyboard brightness

Should we handle these events with acpi scripts or directly in the driver ?
IMHO it can be done directly in the driver, like LCD On/Off keys.

-- 
Corentin Chary
http://xf.iksaif.net - http://uffs.org
