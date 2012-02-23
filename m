From: Rob Lee <rob.lee@linaro.org>
Subject: Re: [RFC PATCH v4 0/4] Consolidate cpuidle timekeeping and irq enabling
Date: Thu, 23 Feb 2012 00:39:22 -0600
Message-ID: <CAMXH7KFEmOFiU4MR7Bcr60ji5DWRUJE8Yh816ZXHoq5XrH5+Kg@mail.gmail.com>
References: <1328065215-28108-1-git-send-email-rob.lee@linaro.org>
	<CAMXH7KEqeO4fV82PB9MSJg7tMPxqxUe5n=vc3jc6GttM0jKPtw@mail.gmail.com>
	<CAMbhsRSSS-M2axk8fP_Atuw2kookv+pQhxU1N0zZ_kXXEL8uyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40104 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786Ab2BWGjZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Feb 2012 01:39:25 -0500
Received: by mail-iy0-f174.google.com with SMTP id b35so1106965iac.19
        for <linux-acpi@vger.kernel.org>; Wed, 22 Feb 2012 22:39:24 -0800 (PST)
In-Reply-To: <CAMbhsRSSS-M2axk8fP_Atuw2kookv+pQhxU1N0zZ_kXXEL8uyw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Colin Cross <ccross@google.com>
Cc: len.brown@intel.com, khilman@ti.com, nicolas.pitre@linaro.org, daniel.lezcano@linaro.org, linaro-dev@lists.linaro.org, nicolas.ferre@atmel.com, linux@arm.linux.org.uk, kgene.kim@samsung.com, mturquette@linaro.org, linux-pm@vger.kernel.org, magnus.damm@gmail.com, linux-acpi@vger.kernel.org, abelay@novell.com, shawn.guo@freescale.com, arnd.bergmann@linaro.org, patches@linaro.org, nsekhar@ti.com, s.hauer@pengutronix.de, Baohua.Song@csr.com, vincent.guittot@linaro.org, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, deepthi@linux.vnet.ibm.com, broonie@opensource.wolfsonmicro.com, amit.kucheria@linaro.org, amit.kachhap@linaro.org, venkatesh.pallipadi@intel.com, shaohua.li@intel.com

On Wed, Feb 22, 2012 at 2:52 PM, Colin Cross <ccross@google.com> wrote:
> On Fri, Feb 10, 2012 at 11:32 AM, Rob Lee <rob.lee@linaro.org> wrote:
>> Maintainers for drivers/cpuidle, do you have any comments/opinions
>> about this patch?
>>
>> Intel cpuidle and acpi cpuidle maintainers, do you have any
>> comments/opinions about this patch and the changes to your code?
>>
>> Any other review and comments welcome.
>>
>> Summary of positive and negatives as I understand them so far:
>>
>> version 1, 2, and 3 (Original "wrapper" method of consolidating
>> timekeeping and interrupt enabling)
>> + opportunistically provides consolidation for simple platform cpuid=
le
>> implementations without disturbing the more complex implementations.
>> By simple, I mean those at can be wrapped in the time keeping calls
>> and interrupt enabling calls without significantly affecting idle ti=
me
>> keeping accuracy or interrupt latency
>> - Does not provide consolidation for the more complex platform cpuid=
le
>> implementations
>> - Adds an additional interface, perhaps unnecessarily if this
>> consolidation could be done in cpuidle
>>
>> version 4 (modifications to drivers/cpuidle/cpuidle.c cpuidle_idle_c=
all)
>> + Adds consolidation work to cpuidle_idle_call which allows all
>> platform timekeeping / interrupt handling to be consolidated.
>
> I think the question of what the timekeeping means needs to be
> considered. =A0If the timekeeping is supposed to be a very accurate
> measurement of the time spent in the low power idle state, only the
> cpuidle driver can guarantee that - there may be significant time
> spent in the hardware transition or the very low level power code tha=
t
> cannot be split into pre_enter, but should not be counted in the
> timekeeping. =A0Or there may be a long boot time out of the low power
> state that should not be counted. =A0If it is just a rough estimate o=
f
> how often the cpu is getting to idle, there is no need to split out
> the pre_enter time - just measure the time around the entire driver
> enter call. =A0Either way, pre_enter doesn't seem useful.
>
>> - Requires splitting up of more complex platform cpuidle
>> implementations, adding further complexity and risk of breaking
>> something.
>> ? Allows both pre_enter or enter to change the idle state. =A0Is the=
re
>> an objection to this?
>
> pre_enter (if it is kept) would probably have to support state
> demotion, because its actions may depend on the final state. =A0For
> coupled SMP cpuidle, enter also has to support state demotion, becaus=
e
> the final state will depend on actions of the other cpu after idle ha=
s
> been entered.
>
>> ? Splitting up the enter functions can require additional function
>> calls. =A0Is there any concern that this is significant additional
>> overhead?
>
> I don't think so, especially if you support NULL pre_enter and
> post_enter functions to allow drivers that care to skip them.

Colin, thanks for your comments.  For now, my plan is to release a v5
buy the end of this week that is a continuation of v3 (using an
optional wrapper for consolidation of time keeping and irq enabling).
The slightly non-positive feedback for the OMAP3 changes and the lack
of feedback from the intel and acpi cpuidle maintainers have swayed me
toward this direction.  I can continue working towards a solution in
cpuidle_idle_call after this patch series if folks voice a preference
for doing so.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
