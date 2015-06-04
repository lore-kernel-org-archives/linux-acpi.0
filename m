From: Pan Xinhui <xinhuix.pan@intel.com>
Subject: Re: [PATCH] ACPI / osl: add acpi_os_down_wait to avoid a schedule
 BUG
Date: Thu, 04 Jun 2015 11:49:01 +0800
Message-ID: <556FCAAD.7060307@intel.com>
References: <5566B6BE.3050303@intel.com> <556E7319.9020006@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:5304 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739AbbFCDvB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Jun 2015 23:51:01 -0400
In-Reply-To: <556E7319.9020006@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>, "mnipxh@163.com" <mnipxh@163.com>

hello tianyu
	sorry for mistake, this issue did not happened in the latest codes.
thanks for your reply.
I noticed this panic is already fixed, so I port upstream patch into in=
tel's branch. see https://android.intel.com/#/c/374113/

thanks,
xinhui

On 2015=E5=B9=B406=E6=9C=8803=E6=97=A5 11:23, Lan Tianyu wrote:
> On 2015=E5=B9=B405=E6=9C=8828=E6=97=A5 14:33, Pan, XinhuiX wrote:
>> acpi_os_wait_semaphore can be called in local/hard irq disabled path=
=2E like in cpu up/down callback.
>> So when dirver try to acquire the semaphore, current code may call d=
own_wait which might sleep.
>> Then hit panic as we can't schedule here. So introduce acpi_os_down_=
wait to cover such case.
>> acpi_os_down_wait use down_trylock, and use cpu_relax to wait the se=
maphore signalled if preempt is disabled.
>>
>> below is the panic.
>
> Hi Xinhui:
>
> Does this issue happen in the latest upstream kernel?
> In the latest code, acpi_cpu_soft_notify() doesn't detail with CPU_DY=
ING
> event and return directly. The issue should not take place.
>
>>
>> [ 1148.230132, 1]smpboot: CPU 3 is now offline
>> [ 1148.277288, 0]smpboot: CPU 2 is now offline
>> [ 1148.322385, 1]BUG: scheduling while atomic: migration/1/13/0x0000=
0002
>> [ 1148.329604, 1]Modules linked in: hid_sensor_hub sens_col_core hid=
_heci_ish heci_ish heci vidt_driver atomisp_css2401a0_v21 lm3642 8723bs=
(O) cfg80211 gc2235 bt_lpm videobuf_vmalloc 6lowpan_iphc i        p6tab=
le_raw iptable_raw videobuf_core rfkill_gpio atmel_mxt_ts
>> [ 1148.355276, 1]CPU: 1 PID: 13 Comm: migration/1 Tainted: G        =
W  O 3.14.37-x86_64-L1-R409-g73e8207 #25
>> [ 1148.365983, 1]Hardware name: Intel Corporation CHERRYVIEW C0 PLAT=
=46ORM/Cherry Trail CR, BIOS CH2TCR.X64.0004.R48.1504211851 04/21/2015
>> [ 1148.379397, 1] ffff880077801140 ffff880073233a58 ffffffff819eec6c=
 ffff8800732303d0
>> [ 1148.387914, 1] ffff880073233a70 ffffffff819eb0e0 ffff88007ac92240=
 ffff880073233ad0
>> [ 1148.396430, 1] ffffffff819f790a ffff8800732303d0 ffff880073233fd8=
 0000000000012240
>> [ 1148.404948, 1]Call Trace:
>> [ 1148.407912, 1] [<ffffffff819eec6c>] dump_stack+0x4e/0x7a
>> [ 1148.413872, 1] [<ffffffff819eb0e0>] __schedule_bug+0x58/0x67
>> [ 1148.420219, 1] [<ffffffff819f790a>] __schedule+0x67a/0x7b0
>> [ 1148.426369, 1] [<ffffffff819f7a69>] schedule+0x29/0x70
>> [ 1148.432123, 1] [<ffffffff819f6ce9>] schedule_timeout+0x269/0x310
>> [ 1148.438860, 1] [<ffffffff810c519c>] ? update_group_power+0x16c/0x=
260
>> [ 1148.445988, 1] [<ffffffff819fae59>] __down_common+0x91/0xd6
>> [ 1148.452236, 1] [<ffffffff810bff00>] ? update_cfs_rq_blocked_load+=
0xc0/0x130
>> [ 1148.460036, 1] [<ffffffff819faf11>] __down_timeout+0x16/0x18
>> [ 1148.466380, 1] [<ffffffff810d21cc>] down_timeout+0x4c/0x60
>> [ 1148.472534, 1] [<ffffffff813f1cf9>] acpi_os_wait_semaphore+0x43/0=
x57
>> [ 1148.479658, 1] [<ffffffff81419ad8>] acpi_ut_acquire_mutex+0x48/0x=
88
>> [ 1148.486683, 1] [<ffffffff813f54e7>] ? acpi_match_device+0x4d/0x4d
>> [ 1148.493516, 1] [<ffffffff814119fe>] acpi_get_data+0x35/0x77
>> [ 1148.499761, 1] [<ffffffff813f547d>] acpi_bus_get_device+0x21/0x3e
>> [ 1148.506593, 1] [<ffffffff8141e52b>] acpi_cpu_soft_notify+0x3d/0xd=
3
>> [ 1148.513522, 1] [<ffffffff81a00223>] notifier_call_chain+0x53/0xa0
>> [ 1148.520356, 1] [<ffffffff8110b701>] ? cpu_stop_park+0x51/0x70
>> [ 1148.526801, 1] [<ffffffff810b082e>] __raw_notifier_call_chain+0xe=
/0x10
>> [ 1148.534118, 1] [<ffffffff81088963>] cpu_notify+0x23/0x50
>> [ 1148.540075, 1] [<ffffffff819e64f7>] take_cpu_down+0x27/0x40
>> [ 1148.546322, 1] [<ffffffff8110b831>] multi_cpu_stop+0xc1/0x110
>> [ 1148.552763, 1] [<ffffffff8110b770>] ? cpu_stop_should_run+0x50/0x=
50
>> [ 1148.559776, 1] [<ffffffff8110ba48>] cpu_stopper_thread+0x78/0x150
>> [ 1148.566608, 1] [<ffffffff819fc1ee>] ? _raw_spin_unlock_irq+0x1e/0=
x40
>> [ 1148.573730, 1] [<ffffffff810b4257>] ? finish_task_switch+0x57/0xd=
0
>> [ 1148.580646, 1] [<ffffffff819f760e>] ? __schedule+0x37e/0x7b0
>> [ 1148.586991, 1] [<ffffffff810b2f7d>] smpboot_thread_fn+0x17d/0x2b0
>> [ 1148.593819, 1] [<ffffffff810b2e00>] ? SyS_setgroups+0x160/0x160
>> [ 1148.600455, 1] [<ffffffff810ab9b4>] kthread+0xe4/0x100
>> [ 1148.606208, 1] [<ffffffff810ab8d0>] ? kthread_create_on_node+0x19=
0/0x190
>> [ 1148.613721, 1] [<ffffffff81a044c8>] ret_from_fork+0x58/0x90
>> [ 1148.619967, 1] [<ffffffff810ab8d0>] ? kthread_create_on_node+0x19=
0/0x190
>>
>> Signed-off-by: Pan Xinhui <xinhuix.pan@intel.com>
>> ---
>>    drivers/acpi/osl.c | 28 +++++++++++++++++++++++++++-
>>    1 file changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
>> index 7ccba39..57a1812 100644
>> --- a/drivers/acpi/osl.c
>> +++ b/drivers/acpi/osl.c
>> @@ -1195,6 +1195,32 @@ void acpi_os_wait_events_complete(void)
>>          flush_workqueue(kacpi_notify_wq);
>>    }
>>
>> +static int acpi_os_down_wait(struct semaphore *sem, long jiffies_ti=
meout)
>> +{
>> +       unsigned long deadline_time;
>> +       int ret =3D 0;
>> +
>> +       if (down_trylock(sem)) {
>> +               if (unlikely(preempt_count())) {
>> +                       deadline_time =3D jiffies + jiffies_timeout;
>> +                       while (true) {
>> +                               cpu_relax();
>> +
>> +                               if (!down_trylock(sem))
>> +                                       break;
>> +
>> +                               if (time_after(jiffies, deadline_tim=
e)) {
>> +                                       ret =3D -ETIME;
>> +                                       break;
>> +                               }
>> +                       }
>> +               } else
>> +                       ret =3D down_timeout(sem, jiffies_timeout);
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>>    struct acpi_hp_work {
>>          struct work_struct work;
>>          struct acpi_device *adev;
>> @@ -1309,7 +1335,7 @@ acpi_status acpi_os_wait_semaphore(acpi_handle=
 handle, u32 units, u16 timeout)
>>          else
>>                  jiffies =3D msecs_to_jiffies(timeout);
>>
>> -       ret =3D down_timeout(sem, jiffies);
>> +       ret =3D acpi_os_down_wait(sem, jiffies);
>>          if (ret)
>>                  status =3D AE_TIME;
>>
>> --
>> 1.9.1
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
