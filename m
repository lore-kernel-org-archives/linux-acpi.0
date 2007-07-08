From: David Brownell <david-b@pacbell.net>
Subject: Re: rtc-cmos not supporting RTC_AIE?
Date: Sat, 7 Jul 2007 22:26:49 -0700
Message-ID: <200707072226.50069.david-b@pacbell.net>
References: <20070330235759.GC4252@cosmic.amd.com> <20070402165511.GD5024@cosmic.amd.com> <20070708034633.GA19633@dmt>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:37742 "HELO
	smtp110.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751522AbXGHF0y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 8 Jul 2007 01:26:54 -0400
In-Reply-To: <20070708034633.GA19633@dmt>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marcelo Tosatti <marcelo@kvack.org>
Cc: Jordan Crouse <jordan.crouse@amd.com>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, devel@laptop.org, rtc-linux@googlegroups.com

On Saturday 07 July 2007, Marcelo Tosatti wrote:

> 
> David,
> 
> Is there any reason why programs using RTC_AIE/RTC_ALM_SET ioctls are    
> unable to arm alarm irq's?                                              

The ALM_SET request never did!  And I'm pretty sure AIE_ON does
indeed set it ... the test cases use ALM_SET then AIE_ON, which
is the "traditional" idiom (i.e. legacy drivers/char/rtc.c idiom).


> I'm aware of the new RTC_WKALM_SET... but shouldnt backward
> compatibility be kept?

According to <linux/rtc.h> the ALM_SET ioctl takes an rtc_time,
while WKALM_SET takes an rtc_wkalm ... which differs from the
former by including the flag controlling wheter the alarm will
be enabled (or not) when setting the alarm.  (Model inherited
from EFI.)

 
> The code seems to imply that its not supported anymore, however ioctl
> returns success but no alarm is fired (for instance alarm.enabled is set
> to 0):
> 
>         case RTC_ALM_SET:
>                 if (copy_from_user(&alarm.time, uarg, sizeof(tm)))
>                         return -EFAULT;
> 
>                 alarm.enabled = 0;
>                 alarm.pending = 0;
>                 alarm.time.tm_wday = -1;
>                 alarm.time.tm_yday = -1;
>                 alarm.time.tm_isdst = -1;

That code is generic RTC framework code (rtc-dev.c), and not
code specific to rtc-cmos ... the comment immediately following
that (2.6.22-rc7 and previous) should clarify many of the issues.

I think the current manpage does the same.  (If it mentions the
/dev/rtc0, /dev/rtc1, etc files, it should be current enough.)

What it does is just stuff the rtc_time into the expanded
rtc_wkalm.  The idea is that the RTC drivers only support one
alarm-setting method, but the /dev/rtcN ioctl interface uses
it in two modes:

 - "legacy", up to 24 hours in the future, and requiring
   the alarm to be enabled later with AIE_ON;

 - "EFI-style", into the arbitrary future, and bundling the
   flag saying whether to enable the alarm.

Since ALM_SET is the legacy mode, it requires separate AIE_ON
(from the RTC driver directly).  But RTC_WKALM_SET doesn't.

- Dave


