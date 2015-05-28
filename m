From: Pan Xinhui <xinhuix.pan@intel.com>
Subject: Re: [PATCH] ACPI / osl: add acpi_os_down_wait to avoid a schedule
 BUG
Date: Thu, 28 May 2015 14:39:33 +0800
Message-ID: <5566B825.8070700@intel.com>
References: <5566B6BE.3050303@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5566B6BE.3050303@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, yanmin_zhang@linux.intel.com, mnipxh@163.com
List-Id: linux-acpi@vger.kernel.org

hi, all
     there is another panic from cpu up. we are doing cpu hotplug tests=
=2E We can hit it nearly 10 times in 24 hours.

[  721.608765, 0]smpboot: CPU 3 is now offline
[  721.652604, 0]smpboot: CPU 2 is now offline
[  721.688519, 0]smpboot: CPU 1 is now offline
[  721.770008, 0]smpboot: Booting Node 0 Processor 3 APIC 0x6
[  721.803724, 0]Skipped synchronization checks as TSC is reliable.
[  721.815739, 3]smpboot: Booting Node 0 Processor 2 APIC 0x4
[  721.838680, 2]BUG: scheduling while atomic: swapper/2/0/0x00000002
[  721.845593, 2]Modules linked in: hid_sensor_hub sens_col_core hid_he=
ci_ish heci_ish heci vidt_driver atomisp_css2401a0_v21 lm3642 8723bs(O)=
 cfg80211 gc2235 videobuf_vmalloc videobuf_core bt_lpm         6lowpan_=
iphc ip6table_raw iptable_raw rfkill_gpio atmel_mxt_ts
[  721.871101, 2]CPU: 2 PID: 0 Comm: swapper/2 Tainted: G        W  O 3=
=2E14.37-x86_64-L1-R409-g73e8207 #25
[  721.881493, 2]Hardware name: Intel Corporation CHERRYVIEW C0 PLATFOR=
M/Cherry Trail CR, BIOS CH2TCR.X64.0004.R48.1504211851 04/21/2015
[  721.894905, 2] ffff880077801140 ffff880073225c28 ffffffff819eec6c ff=
ff880073222310
[  721.903392, 2] ffff880073225c40 ffffffff819eb0e0 ffff88007ad12240 ff=
ff880073225ca0
[  721.911884, 2] ffffffff819f790a ffff880073222310 ffff880073225fd8 00=
00000000012240
[  721.920376, 2]Call Trace:
[  721.923313, 2] [<ffffffff819eec6c>] dump_stack+0x4e/0x7a
[  721.929250, 2] [<ffffffff819eb0e0>] __schedule_bug+0x58/0x67
[  721.935577, 2] [<ffffffff819f790a>] __schedule+0x67a/0x7b0
[  721.941709, 2] [<ffffffff819f7a69>] schedule+0x29/0x70
[  721.947450, 2] [<ffffffff819f6ce9>] schedule_timeout+0x269/0x310
[  721.954165, 2] [<ffffffff819fae59>] __down_common+0x91/0xd6
[  721.960392, 2] [<ffffffff819faf11>] __down_timeout+0x16/0x18
[  721.966720, 2] [<ffffffff810d21cc>] down_timeout+0x4c/0x60
[  721.972854, 2] [<ffffffff813f1cf9>] acpi_os_wait_semaphore+0x43/0x57
[  721.979958, 2] [<ffffffff81419ad8>] acpi_ut_acquire_mutex+0x48/0x88
[  721.986953, 2] [<ffffffff813f54e7>] ? acpi_match_device+0x4d/0x4d
[  721.993766, 2] [<ffffffff814119fe>] acpi_get_data+0x35/0x77
[  721.999993, 2] [<ffffffff813f547d>] acpi_bus_get_device+0x21/0x3e
[  722.006805, 2] [<ffffffff8141e52b>] acpi_cpu_soft_notify+0x3d/0xd3
[  722.013713, 2] [<ffffffff81a00223>] notifier_call_chain+0x53/0xa0
[  722.020525, 2] [<ffffffff810b082e>] __raw_notifier_call_chain+0xe/0x=
10
[  722.027821, 2] [<ffffffff81088963>] cpu_notify+0x23/0x50
[  722.033757, 2] [<ffffffff81089068>] notify_cpu_starting+0x28/0x30
[  722.040569, 2] [<ffffffff8102fcff>] start_secondary+0x15f/0x2d0
[  722.047185, 2]bad: scheduling from the idle thread!

any comments are welcome. :)

thanks,
xinhui

On 2015=E5=B9=B405=E6=9C=8828=E6=97=A5 14:33, Pan Xinhui wrote:
> acpi_os_wait_semaphore can be called in local/hard irq disabled path.=
 like in cpu up/down callback.
> So when dirver try to acquire the semaphore, current code may call do=
wn_wait which might sleep.
> Then hit panic as we can't schedule here. So introduce acpi_os_down_w=
ait to cover such case.
> acpi_os_down_wait use down_trylock, and use cpu_relax to wait the sem=
aphore signalled if preempt is disabled.
>
> below is the panic.
>
> [ 1148.230132, 1]smpboot: CPU 3 is now offline
> [ 1148.277288, 0]smpboot: CPU 2 is now offline
> [ 1148.322385, 1]BUG: scheduling while atomic: migration/1/13/0x00000=
002
> [ 1148.329604, 1]Modules linked in: hid_sensor_hub sens_col_core hid_=
heci_ish heci_ish heci vidt_driver atomisp_css2401a0_v21 lm3642 8723bs(=
O) cfg80211 gc2235 bt_lpm videobuf_vmalloc 6lowpan_iphc i        p6tabl=
e_raw iptable_raw videobuf_core rfkill_gpio atmel_mxt_ts
> [ 1148.355276, 1]CPU: 1 PID: 13 Comm: migration/1 Tainted: G        W=
  O 3.14.37-x86_64-L1-R409-g73e8207 #25
> [ 1148.365983, 1]Hardware name: Intel Corporation CHERRYVIEW C0 PLATF=
ORM/Cherry Trail CR, BIOS CH2TCR.X64.0004.R48.1504211851 04/21/2015
> [ 1148.379397, 1] ffff880077801140 ffff880073233a58 ffffffff819eec6c =
ffff8800732303d0
> [ 1148.387914, 1] ffff880073233a70 ffffffff819eb0e0 ffff88007ac92240 =
ffff880073233ad0
> [ 1148.396430, 1] ffffffff819f790a ffff8800732303d0 ffff880073233fd8 =
0000000000012240
> [ 1148.404948, 1]Call Trace:
> [ 1148.407912, 1] [<ffffffff819eec6c>] dump_stack+0x4e/0x7a
> [ 1148.413872, 1] [<ffffffff819eb0e0>] __schedule_bug+0x58/0x67
> [ 1148.420219, 1] [<ffffffff819f790a>] __schedule+0x67a/0x7b0
> [ 1148.426369, 1] [<ffffffff819f7a69>] schedule+0x29/0x70
> [ 1148.432123, 1] [<ffffffff819f6ce9>] schedule_timeout+0x269/0x310
> [ 1148.438860, 1] [<ffffffff810c519c>] ? update_group_power+0x16c/0x2=
60
> [ 1148.445988, 1] [<ffffffff819fae59>] __down_common+0x91/0xd6
> [ 1148.452236, 1] [<ffffffff810bff00>] ? update_cfs_rq_blocked_load+0=
xc0/0x130
> [ 1148.460036, 1] [<ffffffff819faf11>] __down_timeout+0x16/0x18
> [ 1148.466380, 1] [<ffffffff810d21cc>] down_timeout+0x4c/0x60
> [ 1148.472534, 1] [<ffffffff813f1cf9>] acpi_os_wait_semaphore+0x43/0x=
57
> [ 1148.479658, 1] [<ffffffff81419ad8>] acpi_ut_acquire_mutex+0x48/0x8=
8
> [ 1148.486683, 1] [<ffffffff813f54e7>] ? acpi_match_device+0x4d/0x4d
> [ 1148.493516, 1] [<ffffffff814119fe>] acpi_get_data+0x35/0x77
> [ 1148.499761, 1] [<ffffffff813f547d>] acpi_bus_get_device+0x21/0x3e
> [ 1148.506593, 1] [<ffffffff8141e52b>] acpi_cpu_soft_notify+0x3d/0xd3
> [ 1148.513522, 1] [<ffffffff81a00223>] notifier_call_chain+0x53/0xa0
> [ 1148.520356, 1] [<ffffffff8110b701>] ? cpu_stop_park+0x51/0x70
> [ 1148.526801, 1] [<ffffffff810b082e>] __raw_notifier_call_chain+0xe/=
0x10
> [ 1148.534118, 1] [<ffffffff81088963>] cpu_notify+0x23/0x50
> [ 1148.540075, 1] [<ffffffff819e64f7>] take_cpu_down+0x27/0x40
> [ 1148.546322, 1] [<ffffffff8110b831>] multi_cpu_stop+0xc1/0x110
> [ 1148.552763, 1] [<ffffffff8110b770>] ? cpu_stop_should_run+0x50/0x5=
0
> [ 1148.559776, 1] [<ffffffff8110ba48>] cpu_stopper_thread+0x78/0x150
> [ 1148.566608, 1] [<ffffffff819fc1ee>] ? _raw_spin_unlock_irq+0x1e/0x=
40
> [ 1148.573730, 1] [<ffffffff810b4257>] ? finish_task_switch+0x57/0xd0
> [ 1148.580646, 1] [<ffffffff819f760e>] ? __schedule+0x37e/0x7b0
> [ 1148.586991, 1] [<ffffffff810b2f7d>] smpboot_thread_fn+0x17d/0x2b0
> [ 1148.593819, 1] [<ffffffff810b2e00>] ? SyS_setgroups+0x160/0x160
> [ 1148.600455, 1] [<ffffffff810ab9b4>] kthread+0xe4/0x100
> [ 1148.606208, 1] [<ffffffff810ab8d0>] ? kthread_create_on_node+0x190=
/0x190
> [ 1148.613721, 1] [<ffffffff81a044c8>] ret_from_fork+0x58/0x90
> [ 1148.619967, 1] [<ffffffff810ab8d0>] ? kthread_create_on_node+0x190=
/0x190
>
> Signed-off-by: Pan Xinhui <xinhuix.pan@intel.com>
> ---
>   drivers/acpi/osl.c | 28 +++++++++++++++++++++++++++-
>   1 file changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 7ccba39..57a1812 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -1195,6 +1195,32 @@ void acpi_os_wait_events_complete(void)
>       flush_workqueue(kacpi_notify_wq);
>   }
>
> +static int acpi_os_down_wait(struct semaphore *sem, long jiffies_tim=
eout)
> +{
> +    unsigned long deadline_time;
> +    int ret =3D 0;
> +
> +    if (down_trylock(sem)) {
> +        if (unlikely(preempt_count())) {
> +            deadline_time =3D jiffies + jiffies_timeout;
> +            while (true) {
> +                cpu_relax();
> +
> +                if (!down_trylock(sem))
> +                    break;
> +
> +                if (time_after(jiffies, deadline_time)) {
> +                    ret =3D -ETIME;
> +                    break;
> +                }
> +            }
> +        } else
> +            ret =3D down_timeout(sem, jiffies_timeout);
> +    }
> +
> +    return ret;
> +}
> +
>   struct acpi_hp_work {
>       struct work_struct work;
>       struct acpi_device *adev;
> @@ -1309,7 +1335,7 @@ acpi_status acpi_os_wait_semaphore(acpi_handle =
handle, u32 units, u16 timeout)
>       else
>           jiffies =3D msecs_to_jiffies(timeout);
>
> -    ret =3D down_timeout(sem, jiffies);
> +    ret =3D acpi_os_down_wait(sem, jiffies);
>       if (ret)
>           status =3D AE_TIME;
>
