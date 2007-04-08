From: "Morten Friesgaard" <friesgaard@gmail.com>
Subject: Re: daylight saving makes computer wake up late
Date: Sun, 8 Apr 2007 20:18:28 +0200
Message-ID: <135ab3ff0704081118g3bebd25bj7394483a50549dea@mail.gmail.com>
References: <135ab3ff0704080512k2bcf3973m46c8153ff6a6f7df@mail.gmail.com>
	 <20070408141040.GA14308@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.246]:62349 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbXDHSS3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 8 Apr 2007 14:18:29 -0400
Received: by an-out-0708.google.com with SMTP id b33so1412754ana
        for <linux-acpi@vger.kernel.org>; Sun, 08 Apr 2007 11:18:28 -0700 (PDT)
In-Reply-To: <20070408141040.GA14308@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org

I'm not sure what to do, how do I make these changes?

when I run the following it gives me somewhat the same values, but it
seems the BIOS clock i different (?!)
# hwclock ; date
Sun Apr  8 20:13:56 2007  -0.069330 seconds
Sun Apr  8 20:13:55 CEST 2007

it worked before daylight savings, is it something I can ignore and
still get it to wake up the corret time?

should I change
TIMEZONE="Europe/Copenhagen"

to
TIMEZONE="UTC"
??

/Morten


On 08/04/07, Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:
> On Sun, 08 Apr 2007, Morten Friesgaard wrote:
> > I'm running a mythbox, and ever since we had our yearly change of
> > daylight savings (summer time) my computer wakes up late. At first it
> > was only an hour, then I set the time with hwclock (realised that
> > CLOCK_SYSTOHC="no"), now it is 2 hours late. And it is really precise
> > (1-2 hours later), and it is certainly because of daylight savings.
> >
> > Any ideas?
>
> My guess is that you have to set ACPI wake times to *exactly* the time zone
> you use your RTC in.  Typically UTC, but semi-broken MS-compatible setups
> use the local time zone.
>
> The kernel can know the timezone, but almost nobody ever sets that right,
> and it is not summer-time aware anyway (too complex).  It is best to just
> keep everything UTC as far as the kernel goes, *including* the RTC.
>
> --
>   "One disk to rule them all, One disk to find them. One disk to bring
>   them all and in the darkness grind them. In the Land of Redmond
>   where the shadows lie." -- The Silicon Valley Tarot
>   Henrique Holschuh
>
