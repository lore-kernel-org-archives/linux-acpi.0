From: Luis Henriques <luis.henriques@canonical.com>
Subject: Re: BUG: using __this_cpu_write() in preemptible [00000000] code: systemd-udevd/497
Date: Thu, 17 Apr 2014 21:47:28 +0100
Message-ID: <8761m7lm3j.fsf@canonical.com>
References: <87mwfn4gah.fsf@canonical.com>
	<20140415155453.54d0ca97ca88905594b5100f@linux-foundation.org>
	<alpine.DEB.2.10.1404160958440.9704@gentwo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:33988 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbaDQUrh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Apr 2014 16:47:37 -0400
In-Reply-To: <alpine.DEB.2.10.1404160958440.9704@gentwo.org> (Christoph
	Lameter's message of "Wed, 16 Apr 2014 10:03:23 -0500 (CDT)")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christoph Lameter <cl@linux.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Eric Piel <eric.piel@tremplin-utc.net>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Peter Ziljstra <peterz@infradead.org>

Christoph Lameter <cl@linux.com> writes:

> On Tue, 15 Apr 2014, Andrew Morton wrote:
>
>> On Tue, 15 Apr 2014 00:55:50 +0100 Luis Henriques <luis.henriques@ca=
nonical.com> wrote:
>>
>> > (Cc'ing both lis3lv02d and ACPI maintainers)
>> >
>> > Since commit 188a81409ff7de1c5aae947a96356ddd8ff4aaa3 ("percpu: ad=
d
>> > preemption checks to __this_cpu ops") I've been seeing the followi=
ng:
>> >
>> > [   10.485588] hp_accel: hardware type HPB64xx found
>> > [   10.485772] BUG: using __this_cpu_write() in preemptible [00000=
000] code: systemd-udevd/497
>> > [   10.485777] caller is __this_cpu_preempt_check+0x13/0x20
>> > [   10.485781] CPU: 3 PID: 497 Comm: systemd-udevd Tainted: G     =
   W     3.15.0-rc1 #9
>> > [   10.485783] Hardware name: Hewlett-Packard HP EliteBook 8470p/1=
79B, BIOS 68ICF Ver. F.02 04/27/2012
>> > [   10.485785]  ffffffff81a14db5 ffff88022c80b8e0 ffffffff81604ba4=
 0000000000000003
>> > [   10.485789]  ffff88022c80b908 ffffffff81313431 0000000000000000=
 0000000000000032
>> > [   10.485793]  00000000000003e8 ffff88022c80b918 ffffffff81313473=
 ffff88022c80b928
>> > [   10.485796] Call Trace:
>> > [   10.485802]  [<ffffffff81604ba4>] dump_stack+0x4e/0x7a
>> > [   10.485805]  [<ffffffff81313431>] check_preemption_disabled+0xe=
1/0xf0
>> > [   10.485808]  [<ffffffff81313473>] __this_cpu_preempt_check+0x13=
/0x20
>> > [   10.485813]  [<ffffffff810e4eb8>] touch_nmi_watchdog+0x28/0x40
>>
>> Presumably touch_softlockup_watchdog() being called with preemption
>> enabled.  Which is a legitimate thing to do and there's no point in
>> disabling preemption just to squish a runtime warning.
>>
>> Christoph, this thing has iirc caught a couple of very minor bugs bu=
t
>> it is being quite a pain in the rear.   I'm inclined to revert?
>
> Well this preemption check functionality was strongly desired by Pete=
r
> Zilkstra and Ingo Molnar and made a precondition for more extensive u=
se of
> the this_cpu operations. My patches to various subsystems were reject=
ed
> because these operations were deemed unsafe without those checks.
>
> The simple thing to do in these cases is to use switch from __this_cp=
u_*
> to raw_cpu ops to squish these warnings.

=46WIW, I just gave the -mm tree patch
kernel-watchdogc-touch_softlockup_watchdog-use-raw_cpu_write.patch [1]
a try and it looks like it fixes this issue.

[1] http://ozlabs.org/~akpm/mmots/broken-out/kernel-watchdogc-touch_sof=
tlockup_watchdog-use-raw_cpu_write.patch

Cheers,
--=20
Lu=C3=ADs
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
