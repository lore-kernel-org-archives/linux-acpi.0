From: john stultz <johnstul@us.ibm.com>
Subject: Re: System time drifts when processor idle.
Date: Fri, 27 Aug 2010 11:11:48 -0700
Message-ID: <1282932708.1946.8.camel@work-vm>
References: <AANLkTi=ivkOHRYwLy5FDg3RnK18+opjGd9XsxC7yZqi7@mail.gmail.com>
	 <AANLkTik0ZGs3i_mHtB0s6iT6X0cLgxMjRN7Hi9FK_ZLF@mail.gmail.com>
	 <AANLkTikTF9uvKw+48_jJKLAwqp7MJnypvvUsHN3qQ58+@mail.gmail.com>
	 <AANLkTin80q4tGPZ1FefWCUMmhpNKj3_-KZZB12gZvwSA@mail.gmail.com>
	 <AANLkTin5cLQG9ApxhCs92Twm958MP0J+u4GdBysJ3aNk@mail.gmail.com>
	 <AANLkTikWTLeDLbWWi-LJDD5SRAFN60v5065Vc_wGoY5N@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:52720 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751392Ab0H0SLz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 27 Aug 2010 14:11:55 -0400
In-Reply-To: <AANLkTikWTLeDLbWWi-LJDD5SRAFN60v5065Vc_wGoY5N@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: jean-philippe francois <jp.francois@cynove.com>
Cc: Lin Ming <lin@ming.vg>, venki@google.com, "H. Peter Anvin" <hpa@zytor.com>, linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, jslaby@suse.cz

On Fri, 2010-08-27 at 16:12 +0200, jean-philippe francois wrote:
> My Timekeeping bug is still present, here is an updated script and log.
> I am willing to make test, but I don't know what kind of debugging
> info is needed.
>
> cat /sys/devices/system/clocksource/clocksource0/available_clocksource
> hpet acpi_pm 
> cat /sys/devices/system/clocksource/clocksource0/current_clocksource
> hpet

Huh. hpet was not what I would have expected.


So first, two experiments: 

1) Does booting with "clock=acpi_pm" cause the issue to disappear?

2) Does booting with "nohz=off" cause the issue to disappear?


Venkatesh: You have any experience with HPETs that halt in idle?

thanks
-john


