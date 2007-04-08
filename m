From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: daylight saving makes computer wake up late
Date: Sun, 8 Apr 2007 11:10:40 -0300
Message-ID: <20070408141040.GA14308@khazad-dum.debian.net>
References: <135ab3ff0704080512k2bcf3973m46c8153ff6a6f7df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:38426 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751205AbXDHOKp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 8 Apr 2007 10:10:45 -0400
Content-Disposition: inline
In-Reply-To: <135ab3ff0704080512k2bcf3973m46c8153ff6a6f7df@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Morten Friesgaard <friesgaard@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Sun, 08 Apr 2007, Morten Friesgaard wrote:
> I'm running a mythbox, and ever since we had our yearly change of
> daylight savings (summer time) my computer wakes up late. At first it
> was only an hour, then I set the time with hwclock (realised that
> CLOCK_SYSTOHC="no"), now it is 2 hours late. And it is really precise
> (1-2 hours later), and it is certainly because of daylight savings.
> 
> Any ideas?

My guess is that you have to set ACPI wake times to *exactly* the time zone
you use your RTC in.  Typically UTC, but semi-broken MS-compatible setups
use the local time zone.

The kernel can know the timezone, but almost nobody ever sets that right,
and it is not summer-time aware anyway (too complex).  It is best to just
keep everything UTC as far as the kernel goes, *including* the RTC.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
