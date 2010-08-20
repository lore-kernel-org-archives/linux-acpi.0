From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: Fan runs full speed after S3 sometimes (regression)
Date: Fri, 20 Aug 2010 08:39:54 +0200
Message-ID: <4C6E233A.5000209@gmail.com>
References: <4C613619.30309@gmail.com> <4C619CF0.30609@gmail.com> <20100820063107.GB1607@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:32938 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905Ab0HTGj7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Aug 2010 02:39:59 -0400
In-Reply-To: <20100820063107.GB1607@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-acpi@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

On 08/20/2010 08:31 AM, Pavel Machek wrote:
> On Tue 2010-08-10 20:39:44, Jiri Slaby wrote:
>> On 08/10/2010 01:20 PM, Jiri Slaby wrote:
>>> Hi,
>>>
>>> till I was running on 2.6.34-rc5-mm1 (mmotm) and earlier everything was
>>> fine. Now, I'm running 2.6.35-rc6-mm1 (.35-rc5-mm1 was the same) and
>>> sometimes when the computer (desktop) returns from S3, the CPU fan is
>>> running at full speed making a big noise.
>>
>> Just to add, full power cycle is needed to get rid of that. Warm reboot
>> is not enough.
> 
> Seems like bios problem... Update bios?

I don't think so, it had been working for more than 2 years before this
issue appeared.

>>> I don't know how to debug that. Bisection is out of question -- it
>>> happens once in 10 or 20 cases. There are no fan entries in /sys.
> 
> Well, doing 20 suspends in a row from a script should not be too bad.

20 is just a guess. I haven't seen it for pretty few days until the day
before yesterday. And it looks like CPU1 is brought up a half way. When
the fan was at full speed I tried:
echo 0 > /sys/devices/system/cpu/cpu1/online
and whole system freezed. Otherwise this commands succeeds.

I'll load a crash kernel prior turning the CPU off next time.

thanks,
-- 
js
