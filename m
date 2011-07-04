From: Marco Chiappero <marco@absence.it>
Subject: Re: Need help debugging Sony Vaio VPCY2 backlight control problem
Date: Mon, 04 Jul 2011 21:51:13 +0200
Message-ID: <4E1219B1.9050404@absence.it>
References: <4E0E2155.4070508@fedoraproject.org> <4E0E4637.7000902@absence.it> <4E117DF7.2000602@fedoraproject.org> <4E119CED.1060109@absence.it> <4E120DD9.9070506@fedoraproject.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <4E120DD9.9070506@fedoraproject.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Michel Alexandre Salim <salimma@fedoraproject.org>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86 <platform-driver-x86@vger.kernel.org>, Mattia Dongili <malattia@linux.it>
List-Id: linux-acpi@vger.kernel.org

Il 04/07/2011 21:00, Michel Alexandre Salim ha scritto:
> Hi Marco,

Hi,

> Unfortunately, the results are, again, rather confusing. With
> sony-laptop.ko, after running backlight_fix once, actual_brightness has
> a nonsensical value -- 55.

It looks reasonable, don't worry about it.

> I tried setting it to 5, and something
> actually happens this time - actual_brightness now reads 5 rather than
> -1, and the screen brightness actually changes -- but, alas, too much
> (if the brightness range is from 0 to 7, 5 should be rather bright,
> instead it looked more like a 2 to me).

This is weird, brightness level should be ~75%.

> Further attempts to adjust brightness produced no result --
> actual_brightness now tallies with brightness, like the video.ko's
> behavior, but the screen remained dim. Repeatedly running backlight_fix
> does not resolve matter either.

even more weird. I don't know if IGID has changed in the meantime, but 
there's something not working properly elsewhere. But definitely it's 
not a problem belonging to sony-laptop or video (which should be used 
because SBRT/GBRT methods, with 0 based values and 9 values range, pose 
problems with the current backlight device implementation in sony-laptop).

> Anything else I can try?

The patches attached by Rui. Sorry but I can't help further.
