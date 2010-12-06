From: jean-philippe francois <jp.francois@cynove.com>
Subject: Re: System time drifts when processor idle.
Date: Mon, 6 Dec 2010 13:55:07 +0100
Message-ID: <AANLkTikoyL96JDeXQ+OX7UBpzicZEj0nm6k9G1cKjJtz@mail.gmail.com>
References: <AANLkTi=ivkOHRYwLy5FDg3RnK18+opjGd9XsxC7yZqi7@mail.gmail.com>
	<AANLkTik0ZGs3i_mHtB0s6iT6X0cLgxMjRN7Hi9FK_ZLF@mail.gmail.com>
	<AANLkTikTF9uvKw+48_jJKLAwqp7MJnypvvUsHN3qQ58+@mail.gmail.com>
	<AANLkTin80q4tGPZ1FefWCUMmhpNKj3_-KZZB12gZvwSA@mail.gmail.com>
	<AANLkTin5cLQG9ApxhCs92Twm958MP0J+u4GdBysJ3aNk@mail.gmail.com>
	<AANLkTikWTLeDLbWWi-LJDD5SRAFN60v5065Vc_wGoY5N@mail.gmail.com>
	<1282932708.1946.8.camel@work-vm>
	<AANLkTina8xAwnGVuPKywsf1qEzpu+rWNbv7JjqAgLqp1@mail.gmail.com>
	<1284054125.2762.47.camel@localhost.localdomain>
	<AANLkTimCQnoY2FmRe4Gcf8vgxp4QanYXftRaD9gvrejy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57728 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893Ab0LFMzI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Dec 2010 07:55:08 -0500
In-Reply-To: <AANLkTimCQnoY2FmRe4Gcf8vgxp4QanYXftRaD9gvrejy@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: john stultz <johnstul@us.ibm.com>
Cc: Lin Ming <lin@ming.vg>, venki@google.com, "H. Peter Anvin" <hpa@zytor.com>, linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, jslaby@suse.cz

2010/9/13 jean-philippe francois <jp.francois@cynove.com>:
> 2010/9/9 john stultz <johnstul@us.ibm.com>:
>> On Fri, 2010-09-03 at 14:23 +0200, jean-philippe francois wrote:
>>> 2010/8/27 john stultz <johnstul@us.ibm.com>:
>>> > On Fri, 2010-08-27 at 16:12 +0200, jean-philippe francois wrote:
>>> >> My Timekeeping bug is still present, here is an updated script a=
nd log.
>>> >> I am willing to make test, but I don't know what kind of debuggi=
ng
>>> >> info is needed.
>>> >>
>>> >> cat /sys/devices/system/clocksource/clocksource0/available_clock=
source
>>> >> hpet acpi_pm
>>> >> cat /sys/devices/system/clocksource/clocksource0/current_clockso=
urce
>>> >> hpet
>>> >
>>> > Huh. hpet was not what I would have expected.
>>> >
>>> >
>>> > So first, two experiments:
>>> >
>>> > 1) Does booting with "clock=3Dacpi_pm" cause the issue to disappe=
ar?
>>> >
>>>
>>> Hi,
>>>
>>> The same bug happens with clock=3Dacpi_pm.
>>> My apologies for a previous mail where I said it was not hapenning =
with acpi_pm.
>>>
>>> With both clock, the timekeeping gap augments by amount of 5 minute=
s.
>>
>> Huh. So this still seems strange, but assuming we're still using the
>> hpet for irqs, its possible the event somehow gets pushed back 5 min=
utes
>> and we miss an timekeeping interval accumulation (with acpi_pm, the
>> counter wraps ever 5 seconds or so, so we could miss many accumulati=
on
>> intervals and still be 5 minutes off if the tick timer was late).
>>
>> Again, seeing if the issue goes away with nohz=3Doff would be helpfu=
l.
>>
>
> It =A0goes away witj nohz=3Doff
>
A little update on this time keeping bug :
- the system time drifts by amount of 5 minutes
- it happens with both hpet and acpi_pm as clock source
- it goes away when booting with nohz=3Doff
- it goes away when booting with processor.max_cstate=3D1

Jean-Philippe Fran=E7ois
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
