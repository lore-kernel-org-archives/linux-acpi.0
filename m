From: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Subject: Re: [v3.20]: Missing /sys/class/ACAD directory OR Cannot release Mutex
Date: Tue, 24 Feb 2015 14:29:30 +0100
Message-ID: <CADDKRnAjyy-KUAfwU-QfODmxVREhCfe=P4JzFbiYG33v-Zw60A@mail.gmail.com>
References: <CADDKRnDO7LAr5bg-5TJ-2=Va3kBw-cWqDvWoL3omWVJHUUd7tA@mail.gmail.com>
	<1643186.zN49pcFPny@vostro.rjw.lan>
	<CADDKRnCLUpqy+vxrWUHxkgMsaCfPpObD8CdU_6q0tEcBpyHj8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:46471 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbbBXN3c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Feb 2015 08:29:32 -0500
In-Reply-To: <CADDKRnCLUpqy+vxrWUHxkgMsaCfPpObD8CdU_6q0tEcBpyHj8w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

2015-02-24 12:03 GMT+01:00 J=C3=B6rg Otte <jrg.otte@gmail.com>:
> 2015-02-24 0:24 GMT+01:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
>> On Sunday, February 22, 2015 01:33:09 PM J=C3=B6rg Otte wrote:
>>> Starting with kernel 3.19.0-05184-g18320f2, I often find my noteboo=
k
>>> running with 'powersave' policy even if it is on AC.
>>>
>>> It turned out that /sys/class/ACAD directory is missing and in the
>>> logs I see:
>>>
>>> ACPI Error: Cannot release Mutex [MUT0], not acquired (20150204/exm=
utex-376)
>>> ACPI Error: Method parse/execution failed [\_SB_.ACAD._PSR] (Node
>>> ffff880216028d48), AE_AML_MUTEX_NOT_ACQUIRED (20150204/psparse-536)
>>> ACPI Exception: AE_AML_MUTEX_NOT_ACQUIRED, Error reading AC Adapter
>>> state (20150204/ac-131)
>>>
>>> At the last 25 startups since 3.19.0-05184-g18320f2 it occured 13 t=
imes.
>>>
>>> It does not occur with kernels older than 3.19.0-05184-g18320f2.
>>
>> Which mainline commit is that?
> 18320f2 Merge tag 'pm+acpi-3.20-rc1-2' of
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
>
>>
>> The only changes in 4.0-rc1 that can affect that are the ACPI EC upd=
ates IIRC.
>>
>> Is there a chance to try the acpi-ec branch from linux-pm.git and se=
e if the
>> problem is there?
> Should be no problem. I will give it a try.

I booted kernel 3.19.0-rc5-00560-g92e4b1b from linux-pm/acpi-ec 5 times
and it didn't occure.

Today I noticed 2 other things:
1) There are at least 2 slightly different error cases
     a) ACPI Error: Cannot release Mutex [MUT0], not acquired
     b) ACPI Error: Thread 370114560 cannot release Mutex [MUT0]
acquired by thread ..

2) Boot times are different between good and bad case, bad case takes
significally longer:
     a)  Good case
[    0.285892] intel_idle: MWAIT substates: 0x21120
[    0.285893] intel_idle: v0.4 model 0x3A
[    0.285894] intel_idle: lapic_timer_reliable_states 0xffffffff
[    0.288461] ACPI: AC Adapter [ACAD] (off-line)

     b) Bad case
[    0.284061] intel_idle: MWAIT substates: 0x21120
[    0.284062] intel_idle: v0.4 model 0x3A
[    0.284063] intel_idle: lapic_timer_reliable_states 0xffffffff
[    1.279089] tsc: Refined TSC clocksource calibration: 2494.334 MHz
[    2.280355] Switched to clocksource tsc
[    5.194933] ACPI Error: Thread 370114560 cannot release Mutex [MUT0]

Thanks, J=C3=B6rg
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
