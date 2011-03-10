From: Wang Lei <f3d27b@gmail.com>
Subject: Re: [BUG] Fans keep running, first found since v2.6.38-rc7
Date: Thu, 10 Mar 2011 19:59:35 +0800
Message-ID: <4d78bd1c.231a8f0a.2e76.ffffcb63@mx.google.com>
References: <4d774c85.20f98e0a.2695.73ed@mx.google.com>
	<201103092125.43950.rjw@sisk.pl>
	<4d780a2f.231a8f0a.3b01.ffffa228@mx.google.com>
	<201103100106.36678.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:39483 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271Ab1CJL7Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2011 06:59:25 -0500
In-Reply-To: <201103100106.36678.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Thu, 10 Mar 2011 01:06:36 +0100")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Thursday, March 10, 2011, Wang Lei wrote:
>> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
>> 
>> > On Wednesday, March 09, 2011, Wang Lei wrote:
>> >> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
>> >> 
>> >> >
>> >> > There was only one commit in that area since 2.6.38-rc6, but it shouldn't
>> >> > affect the functionality this way.
>> >> >
>> >> > Is yout thermal management controlled by ACPI?
>> >> >
>> >> > Rafael
>> >> 
>> >> Thanks for your reply!
>> >> 
>> >> How could I know that?
>> >
>> > What does "ls -l /sys/class/thermal/cooling_device0/device" say?
>> >
>> > Rafael
>> 
>> [~]$ ls -l /sys/class/thermal/cooling_device0/device
>> lrwxrwxrwx 1 root root 0 Mar 10 07:13 /sys/class/thermal/cooling_device0/device -> ../../../LNXSYSTM:00/device:47/PNP0C0B:00
>> [~]$
>
> That's ACPI.
>
> I don't know, however, which change might cause the problem to happen.
>
> Can you bisect the commits between 2.6.38-rc6 and -rc7 to find the one that
> introduced the issue?
>
> Rafael
OK, I'll try.

-- 
Regards,
Lei
