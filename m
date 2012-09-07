From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: CONFIG_NO_HZ + CONFIG_CPU_IDLE freeze the system (Was Re: [PATCH]
 acpi : remove power from acpi_processor_cx structure)
Date: Fri, 07 Sep 2012 23:35:28 +0200
Message-ID: <504A68A0.7010907@linaro.org>
References: <1343164349-28550-1-git-send-email-daniel.lezcano@linaro.org> <201209062204.11288.rjw@sisk.pl> <50490920.9070204@linaro.org> <201209062318.42874.rjw@sisk.pl> <504A02BD.4000805@linaro.org> <504A2D73.3010702@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:57797 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab2IGVfc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Sep 2012 17:35:32 -0400
Received: by mail-wi0-f172.google.com with SMTP id hi8so231518wib.1
        for <linux-acpi@vger.kernel.org>; Fri, 07 Sep 2012 14:35:32 -0700 (PDT)
In-Reply-To: <504A2D73.3010702@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, xen-devel@lists.xensource.com, linaro-dev@lists.linaro.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org, Frederic Weisbecker <fweisbec@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mingo@kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, richardcochran@gmail.com, prarit@redhat.com, Thomas Gleixner <tglx@linutronix.de>

On 09/07/2012 07:22 PM, John Stultz wrote:
> On 09/07/2012 07:20 AM, Daniel Lezcano wrote:
>> On 09/06/2012 11:18 PM, Rafael J. Wysocki wrote:
>>> On Thursday, September 06, 2012, Daniel Lezcano wrote:
>>>> On 09/06/2012 10:04 PM, Rafael J. Wysocki wrote:
>>>>> On Thursday, September 06, 2012, Daniel Lezcano wrote:
>>>>>> On 09/06/2012 09:54 AM, Daniel Lezcano wrote:
>>>>>> I fall into this issue because NETCONSOLE is set, disabling it
>>>>>> allowed
>>>>>> me to go further.
>>>>>>
>>>>>> Unfortunately I am facing to some random freeze on the system wh=
ich
>>>>>> seems to be related to CONFIG_NO_HZ=3Dy and CONFIG_CPU_IDLE=3Dy.
>>>>>>
>>>>>> Disabling one of them, make the freezes to disappear.
>>>>>>
>>>>>> Is it a known issue ?
>>>>> Well, there are systems having problems with this configuration,
>>>>> but they
>>>>> should be exceptional.  What system is that?
>>>> It is a laptop T61p with a Core 2 Duo T9500. Nothing exceptional I
>>>> believe. Maybe someone got the same issue ?
>>> Is it a regression for you?
>> Yes, I think so. The issue appears between v3.5 and v3.6-rc1.
>>
>> It is not easy to reproduce but after taking some time to dig, it se=
ems
>> to appear with this commit:
>>
>> 1e75fa8be9fb61e1af46b5b3b176347a4c958ca1 is the first bad commit
>> commit 1e75fa8be9fb61e1af46b5b3b176347a4c958ca1
>> Author: John Stultz <john.stultz@linaro.org>
>> Date:   Fri Jul 13 01:21:53 2012 -0400
>>
>>      time: Condense timekeeper.xtime into xtime_sec
>>
>>      The timekeeper struct has a xtime_nsec, which keeps the
>>      sub-nanosecond remainder.  This ends up being somewhat
>>      duplicative of the timekeeper.xtime.tv_nsec value, and we
>>      have to do extra work to keep them apart, copying the full
>>      nsec portion out and back in over and over.
>>
>>      This patch simplifies some of the logic by taking the timekeepe=
r
>>      xtime value and splitting it into timekeeper.xtime_sec and
>>      reuses the timekeeper.xtime_nsec for the sub-second portion
>>      (stored in higher res shifted nanoseconds).
>>
>>      This simplifies some of the accumulation logic. And will
>>      allow for more accurate timekeeping once the vsyscall code
>>      is updated to use the shifted nanosecond remainder.
>>
>>      Signed-off-by: John Stultz <john.stultz@linaro.org>
>>      Reviewed-by: Ingo Molnar <mingo@kernel.org>
>>      Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
>>      Cc: Richard Cochran <richardcochran@gmail.com>
>>      Cc: Prarit Bhargava <prarit@redhat.com>
>>      Link:
>> http://lkml.kernel.org/r/1342156917-25092-5-git-send-email-john.stul=
tz@linaro.org
>>
>>      Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>>
>> :040000 040000 4d6541ac1f6075d7adee1eef494b31a0cbda0934
>> dc5708bc738af695f092bf822809b13a1da104b6 M    kernel
>>
>> How to reproduce: with a laptop T61p, with a Core 2 Duo. I boot the
>> kernel in busybox and wait some minutes before writing something in =
the
>> console. At this moment, nothing appears to the console but the
>> characters are echo'ed several seconds later (could be 1, 5, or 10 s=
ecs
>> or more).
>>
>> That happens when CONFIG_CPU_IDLE and CONFIG_NO_HZ are set. Disablin=
g
>> one of them, the issue does not appear.
>=20
> Thanks for bisecting this down and the heads up!
>=20
> Right off I can't see what might be causing this.  Bunch of questions=
:
>=20
> Is this a 32 or 64 bit kernel?

It is a 32 bit kernel.

> By your description above, it sounds like the system is still
> functioning, but there's just a high latency for key-input. Is that r=
ight?

Yes that's correct but not only. During this freeze time, I can't ping
the host. When the output is echo'ed, the ping works again.

But if I ping the host indefinitely, it does not freeze and the console
is echo'ed without problem.

> Are other things on the system happening slowly?

I have a very minimal system but at the first glance when it is not fro=
zen

> Does generating interrupts by hitting/holding down the ctrl key make =
the
> system respond faster?

no.

> Is there any dmesg output near when it occurs?

no.

> If you don't wait that minute after boot before typing anything, does=
 it
> still trigger later? (or is it tied to early boot?)

That depends, that could happen immediately or later. It is more or les=
s
random.

> On a whim, does the patch below avoid the problem?

Nope, same issue :/

Thanks
  -- Daniel

>=20
> thanks
> -john
>=20
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 34e5eac..2fa0e52 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1179,6 +1179,7 @@ static void update_wall_time(void)
>      timekeeping_adjust(tk, offset);
> =20
> =20
> +#if 0
>      /*
>      * Store only full nanoseconds into xtime_nsec after rounding
>      * it up and add the remainder to the error difference.
> @@ -1192,6 +1193,7 @@ static void update_wall_time(void)
>      tk->xtime_nsec -=3D remainder;
>      tk->xtime_nsec +=3D 1ULL << tk->shift;
>      tk->ntp_error +=3D remainder << tk->ntp_error_shift;
> +#endif
> =20
>      /*
>       * Finally, make sure that after the rounding
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
