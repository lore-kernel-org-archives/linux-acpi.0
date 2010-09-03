From: jean-philippe francois <jp.francois@cynove.com>
Subject: Re: System time drifts when processor idle.
Date: Fri, 3 Sep 2010 14:23:32 +0200
Message-ID: <AANLkTina8xAwnGVuPKywsf1qEzpu+rWNbv7JjqAgLqp1@mail.gmail.com>
References: <AANLkTi=ivkOHRYwLy5FDg3RnK18+opjGd9XsxC7yZqi7@mail.gmail.com>
	<AANLkTik0ZGs3i_mHtB0s6iT6X0cLgxMjRN7Hi9FK_ZLF@mail.gmail.com>
	<AANLkTikTF9uvKw+48_jJKLAwqp7MJnypvvUsHN3qQ58+@mail.gmail.com>
	<AANLkTin80q4tGPZ1FefWCUMmhpNKj3_-KZZB12gZvwSA@mail.gmail.com>
	<AANLkTin5cLQG9ApxhCs92Twm958MP0J+u4GdBysJ3aNk@mail.gmail.com>
	<AANLkTikWTLeDLbWWi-LJDD5SRAFN60v5065Vc_wGoY5N@mail.gmail.com>
	<1282932708.1946.8.camel@work-vm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1282932708.1946.8.camel@work-vm>
Sender: linux-kernel-owner@vger.kernel.org
To: john stultz <johnstul@us.ibm.com>
Cc: Lin Ming <lin@ming.vg>, venki@google.com, "H. Peter Anvin" <hpa@zytor.com>, linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, jslaby@suse.cz
List-Id: linux-acpi@vger.kernel.org

2010/8/27 john stultz <johnstul@us.ibm.com>:
> On Fri, 2010-08-27 at 16:12 +0200, jean-philippe francois wrote:
>> My Timekeeping bug is still present, here is an updated script and l=
og.
>> I am willing to make test, but I don't know what kind of debugging
>> info is needed.
>>
>> cat /sys/devices/system/clocksource/clocksource0/available_clocksour=
ce
>> hpet acpi_pm
>> cat /sys/devices/system/clocksource/clocksource0/current_clocksource
>> hpet
>
> Huh. hpet was not what I would have expected.
>
>
> So first, two experiments:
>
> 1) Does booting with "clock=3Dacpi_pm" cause the issue to disappear?
>

Hi,

The same bug happens with clock=3Dacpi_pm.
My apologies for a previous mail where I said it was not hapenning with=
 acpi_pm.

With both clock, the timekeeping gap augments by amount of 5 minutes.

Jean-Philippe Fran=E7ois
