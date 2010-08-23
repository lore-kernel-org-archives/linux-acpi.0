From: jean-philippe francois <jp.francois@cynove.com>
Subject: Re: System time drifts when processor idle.
Date: Mon, 23 Aug 2010 10:46:03 +0200
Message-ID: <AANLkTikTF9uvKw+48_jJKLAwqp7MJnypvvUsHN3qQ58+@mail.gmail.com>
References: <AANLkTi=ivkOHRYwLy5FDg3RnK18+opjGd9XsxC7yZqi7@mail.gmail.com>
	<AANLkTik0ZGs3i_mHtB0s6iT6X0cLgxMjRN7Hi9FK_ZLF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43497 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641Ab0HWIqE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Aug 2010 04:46:04 -0400
In-Reply-To: <AANLkTik0ZGs3i_mHtB0s6iT6X0cLgxMjRN7Hi9FK_ZLF@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <lin@ming.vg>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

2010/8/21 Lin Ming <lin@ming.vg>:
> On Fri, Aug 20, 2010 at 8:55 AM, jean-philippe francois
> <jp.francois@cynove.com> wrote:
>> Hi,
>>
>> Please correct me if I am sending this to the wrong list.
>
> LKML is better for this issue. Added.
>

Thank you. I have been looking at the ML archives, and it seems there
has been issue related to timekeeping lately. So I tested my script
with a decently recent kernel : 2.6.36-rc1.

The timekeeping bug described below still exists.
>>
>> I would like to debug the following issue, which I suspect is relate=
d
>> to cpu losing track of time when going idle.
>>
>> When I run the following script :
>>
>> #!/bin/bash
>> # set hwclock to system clock to start
>> # the log file with the same time
>> hwclock -w
>> #start with a fresh logfile
>> touch clocktest.log
>> echo START > clocktest.log
>> while [[ true ]]
>> do
>> =A0 =A0systime=3D$(date)
>> =A0 =A0hwtime=3D$(hwclock -r)
>> =A0 =A0echo "$systime | $hwtime" >> clocktest.log
>> =A0 =A0sleep 20
>> done
>>
>> Expected output :
>> On each line, the system time (left) and hardware time (right)
>> should be roughly the same. Time delta between each line should be
>> around 20 seconds
>>
>> Observed output :
>> This is an edited version of the real logfile =A0so that it fits on =
one
>> line. the date was removed.
>> START
>> 15:09:43 (UTC+0200) | =A015:09:44 CEST -0.500555 secondes
>> 15:10:04 (UTC+0200) | =A015:10:05 CEST -1.001562 secondes
>> 15:10:25 (UTC+0200) | =A015:10:26 CEST -0.985944 secondes
>> 15:10:46 (UTC+0200) | =A015:15:46 CEST -0.032792 secondes <-- 5 minu=
te lag !
>> 15:11:06 (UTC+0200) | =A015:16:07 CEST -0.985926 secondes
>> 15:11:27 (UTC+0200) | =A015:16:28 CEST -1.001539 secondes
>> 15:11:48 (UTC+0200) | =A015:16:49 CEST -0.985969 secondes
>> 15:12:09 (UTC+0200) | =A015:17:10 CEST -0.985977 secondes
>> 15:12:30 (UTC+0200) | =A015:17:31 CEST -1.001544 secondes
>> 15:12:51 (UTC+0200) | =A015:17:52 CEST -0.985920 secondes
>> 15:13:12 (UTC+0200) | =A015:18:13 CEST -0.985939 secondes
>> 15:13:33 (UTC+0200) | =A015:18:34 CEST -1.001581 secondes
>> 15:13:54 (UTC+0200) | =A015:18:55 CEST -0.985917 secondes
>> 15:14:15 (UTC+0200) | =A015:29:15 CEST -0.079685 secondes <-- add
>> another 10 minute
>> 15:14:35 (UTC+0200) | =A015:29:36 CEST -1.001568 secondes
>> 15:14:56 (UTC+0200) | =A015:29:57 CEST -0.985952 secondes
>>
>> As you can see, after 20 minutes without touching the computer, the
>> system time is late by 15 minutes.
>> This was tested on ubuntu 10.04 with a 2.6.32 =A0"vanilla" kernel wh=
ere
>> "vanilla" means ubuntu packaged
>> upstream kernel =A0closest to the distribution shipped kernel.
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
