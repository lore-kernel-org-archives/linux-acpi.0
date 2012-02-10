From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [RFC PATCH v4 0/4] Consolidate cpuidle timekeeping and irq enabling
Date: Fri, 10 Feb 2012 12:06:01 -0800
Message-ID: <CAP245DWR98VyZurF5J-TL-2GCcT3cNdAUgMBg_WfqQiAcF8h1g@mail.gmail.com>
References: <1328065215-28108-1-git-send-email-rob.lee@linaro.org>
	<CAMXH7KEqeO4fV82PB9MSJg7tMPxqxUe5n=vc3jc6GttM0jKPtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:58059 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759959Ab2BJUGC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 10 Feb 2012 15:06:02 -0500
In-Reply-To: <CAMXH7KEqeO4fV82PB9MSJg7tMPxqxUe5n=vc3jc6GttM0jKPtw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rob Lee <rob.lee@linaro.org>
Cc: len.brown@intel.com, khilman@ti.com, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, robherring2@gmail.com, Baohua.Song@csr.com, s.hauer@pengutronix.de, shawn.guo@freescale.com, nicolas.ferre@atmel.com, linux@maxim.org.za, kgene.kim@samsung.com, amit.kachhap@linaro.org, magnus.damm@gmail.com, nsekhar@ti.com, daniel.lezcano@linaro.org, mturquette@linaro.org, vincent.guittot@linaro.org, arnd.bergmann@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, deepthi@linux.vnet.ibm.com, broonie@opensource.wolfsonmicro.com, nicolas.pitre@linaro.org, linux@arm.linux.org.uk, venki@google.com, shaohua.li@intel.com, abelay@novell.com

On Fri, Feb 10, 2012 at 11:32 AM, Rob Lee <rob.lee@linaro.org> wrote:
> Maintainers for drivers/cpuidle, do you have any comments/opinions
> about this patch?

Venki has changed employers (probably needs a patch to MAINTAINERS?).
Cc'ing his new email address.

> Intel cpuidle and acpi cpuidle maintainers, do you have any
> comments/opinions about this patch and the changes to your code?
>
> Any other review and comments welcome.
>
> Summary of positive and negatives as I understand them so far:
>
> version 1, 2, and 3 (Original "wrapper" method of consolidating
> timekeeping and interrupt enabling)
> + opportunistically provides consolidation for simple platform cpuidl=
e
> implementations without disturbing the more complex implementations.
> By simple, I mean those at can be wrapped in the time keeping calls
> and interrupt enabling calls without significantly affecting idle tim=
e
> keeping accuracy or interrupt latency
> - Does not provide consolidation for the more complex platform cpuidl=
e
> implementations
> - Adds an additional interface, perhaps unnecessarily if this
> consolidation could be done in cpuidle
>
> version 4 (modifications to drivers/cpuidle/cpuidle.c cpuidle_idle_ca=
ll)
> + Adds consolidation work to cpuidle_idle_call which allows all
> platform timekeeping / interrupt handling to be consolidated.
> - Requires splitting up of more complex platform cpuidle
> implementations, adding further complexity and risk of breaking
> something.
> ? Allows both pre_enter or enter to change the idle state. =A0Is ther=
e
> an objection to this?
> ? Splitting up the enter functions can require additional function
> calls. =A0Is there any concern that this is significant additional
> overhead?
>
> Thanks,
> Rob
>
>
> On Tue, Jan 31, 2012 at 7:00 PM, Robert Lee <rob.lee@linaro.org> wrot=
e:
>> This patch series moves the timekeeping and irq enabling from the pl=
atform
>> code to the core cpuidle driver. =A0Also, the platform irq disabling=
 was removed
>> as it appears that all calls into cpuidle_call_idle will have alread=
y called
>> local_irq_disable().
>>
>> To save reviewers time, only a few platforms which required the most=
 changes
>> are included in this version. =A0If these changes are approved, the =
next version
>> will include the remaining platform code which should require minima=
l changes.
>>
>> For those who have followed the previous patch versions, as you know=
, the
>> previous version of this patch series added some helper functionalit=
y which
>> used a wrapper function to remove the time keeping and irq enabling/=
disabling
>> from the platform code. =A0There was also initialization helper func=
tionality
>> which has now been removed from this version. =A0If the basic implem=
entation
>> in this version is approved, then a separate patch submission effort=
 can be
>> made to focus on consolidation of initialziation functionality.
>>
>> Based on 3.3-rc1
>>
>> v3 submission can be found here:
>> http://www.spinics.net/lists/arm-kernel/msg156751.html
>> Changes since v3:
>> * Removed drivers/cpuidle/common.c
>> ** Removed the initialization helper functions
>> ** Removed the wrapper used to consolidate time keeping and irq enab=
le/disable
>> * Add time keeping and local_irq_disable handling in cpuidle_call_id=
le().
>> * Made necessary modifications to a few platforms that required the =
most changes
>> ** Note on omap3: changed structure of omap3_idle_drvdata and added
>> =A0 per_next_state and per_saved_state vars to accomodate new framew=
ork.
>>
>> v2 submission can be found here:
>> http://comments.gmane.org/gmane.linux.ports.arm.kernel/144199
>>
>> Changes since v2:
>> * Made various code organization and style changes as suggested in v=
1 review.
>> * Removed at91 use of common code. =A0A separate effort is underway =
to clean
>> at91 code and the author has offered to convert to common interface =
as part
>> of those changes (if this common interface is accepted in time).
>> * Made platform cpuidle_driver objects __initdata and dynamically ad=
ded one
>> persistent instance of this object in common code.
>> * Removed imx5 pm usage of gpc_dvfs clock as it is no longer needed =
after
>> being enabled during clock initialization.
>> * Re-organized patches.
>>
>> v1 submission can be found here:
>> http://comments.gmane.org/gmane.linux.ports.arm.kernel/142791
>>
>> Changes since v1:
>> * Common interface moved to drivers/cpuidle and made non arch-specif=
ic.
>> * Made various fixes and suggested additions to the common cpuidle
>> code from v1 review.
>> * Added callback for filling in driver_data field as needed.
>> * Modified the various platforms with these changes.
>>
>> Robert Lee (4):
>> =A0cpuidle: Add time keeping and irq enabling
>> =A0ARM: omap: Remove cpuidle timekeeping and irq enable/disable
>> =A0acpi: Remove cpuidle timekeeping and irq enable/disable
>> =A0x86: Remove cpuidle timekeeping and irq enable/disable
>>
>> =A0arch/arm/mach-omap2/cpuidle34xx.c | =A0 96 ++++++++----------
>> =A0drivers/acpi/processor_idle.c =A0 =A0 | =A0203 ++++++++++++++++++=
++++---------------
>> =A0drivers/cpuidle/cpuidle.c =A0 =A0 =A0 =A0 | =A0 75 +++++++++++---
>> =A0drivers/idle/intel_idle.c =A0 =A0 =A0 =A0 | =A0110 ++++++++++++++=
------
>> =A0include/linux/cpuidle.h =A0 =A0 =A0 =A0 =A0 | =A0 26 +++--
>> =A05 files changed, 317 insertions(+), 193 deletions(-)
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
