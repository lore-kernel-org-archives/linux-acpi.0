From: Hoan Tran <hotran@apm.com>
Subject: Re: [PATCH] mailbox: PCC: Fix lockdep warning when request PCC channel
Date: Fri, 14 Oct 2016 17:49:06 -0700
Message-ID: <CAFHUOYxvG7zCyrCxjwV_DADDHNJTX__MSOymvO06ftME83QrOw@mail.gmail.com>
References: <1476485541-7273-1-git-send-email-hotran@apm.com> <a4863613-d63b-4e07-1793-5068492d73bf@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ua0-f176.google.com ([209.85.217.176]:36082 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751592AbcJOAtI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Oct 2016 20:49:08 -0400
Received: by mail-ua0-f176.google.com with SMTP id m11so1565552uab.3
        for <linux-acpi@vger.kernel.org>; Fri, 14 Oct 2016 17:49:08 -0700 (PDT)
In-Reply-To: <a4863613-d63b-4e07-1793-5068492d73bf@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Prakash, Prashanth" <pprakash@codeaurora.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Loc Ho <lho@apm.com>, Duc Dang <dhdang@apm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Jassi Brar <jassisinghbrar@gmail.com>

Hi Prashanth,



On Fri, Oct 14, 2016 at 4:44 PM, Prakash, Prashanth
<pprakash@codeaurora.org> wrote:
> Hi Hoan,
>
> On 10/14/2016 4:52 PM, Hoan Tran wrote:
>> This patch fixes the lockdep warning below
>>
>> [    7.229767] DEBUG_LOCKS_WARN_ON(irqs_disabled_flags(flags))
>> [    7.229776] ------------[ cut here ]------------
>> [    7.229787] WARNING: CPU: 1 PID: 1 at linux-next/kernel/locking/lockdep.c:2876 loc
>> kdep_trace_alloc+0xe0/0xf0
>> [    7.229790] Modules linked in:
>> [    7.229793]
>> [    7.229798] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.8.0-11756-g86c5152 #46
>> ...
>> [    7.229900] Call trace:
>> [    7.229903] Exception stack(0xffff8007da837890 to 0xffff8007da8379c0)
>> [    7.229906] 7880:                                   ffff8007da834000 0001000000000000
>> [    7.229909] 78a0: ffff8007da837a70 ffff0000081111a0 00000000600000c5 000000000000003d
>> [    7.229912] 78c0: 9374bc6a7f3c7832 0000000000381878 ffff000009db7ab8 000000000000002f
>> [    7.229915] 78e0: ffff00000811aabc ffff000008be2548 ffff8007da837990 ffff00000811adf8
>> [    7.229918] 7900: ffff8007da834000 00000000024080c0 00000000000000c0 ffff000009021000
>> [    7.229921] 7920: 0000000000000000 0000000000000000 ffff000008c8f7c8 ffff8007da579810
>> [    7.229923] 7940: 000000000000002f ffff8007da858000 0000000000000000 0000000000000001
>> [    7.229926] 7960: 0000000000000001 0000000000000000 ffff00000811a468 0000000000000002
>> [    7.229929] 7980: 656c62617369645f 0000000000038187 00000000000000ee ffff8007da837850
>> [    7.229932] 79a0: ffff000009db50c0 ffff000009db569d 0000000000000006 ffff000089db568f
>> [    7.229936] [<ffff0000081111a0>] lockdep_trace_alloc+0xe0/0xf0
>> [    7.229940] [<ffff0000081f4950>] __kmalloc_track_caller+0x50/0x250
>> [    7.229945] [<ffff00000857c088>] devres_alloc_node+0x28/0x60
>> [    7.229949] [<ffff0000081220e0>] devm_request_threaded_irq+0x50/0xe0
>> [    7.229955] [<ffff0000087e6220>] pcc_mbox_request_channel+0x110/0x170
>> [    7.229960] [<ffff0000084b2660>] acpi_cppc_processor_probe+0x264/0x414
>> [    7.229963] [<ffff0000084ae9f4>] __acpi_processor_start+0x28/0xa0
>> [    7.229966] [<ffff0000084aeab0>] acpi_processor_start+0x44/0x54
>> [    7.229970] [<ffff00000857897c>] driver_probe_device+0x1fc/0x2b0
>> [    7.229974] [<ffff000008578ae4>] __driver_attach+0xb4/0xc0
>> [    7.229977] [<ffff00000857683c>] bus_for_each_dev+0x5c/0xa0
>> [    7.229980] [<ffff000008578110>] driver_attach+0x20/0x30
>> [    7.229983] [<ffff000008577c20>] bus_add_driver+0x110/0x230
>> [    7.229987] [<ffff000008579320>] driver_register+0x60/0x100
>> [    7.229991] [<ffff000008d478b8>] acpi_processor_driver_init+0x2c/0xb0
>> [    7.229996] [<ffff000008083168>] do_one_initcall+0x38/0x130
>> [    7.230000] [<ffff000008d20d6c>] kernel_init_freeable+0x210/0x2b4
>> [    7.230004] [<ffff000008945d90>] kernel_init+0x10/0x110
>> [    7.230007] [<ffff000008082e80>] ret_from_fork+0x10/0x50
>>
>> It's because the spinlock inside pcc_mbox_request_channel() is
>> kept too long. Adding a mutex to protect critical section of this
>> function. Beside of that, spinlock is still used to protect the
>> data of channel.
>>
>> Signed-off-by: Hoan Tran <hotran@apm.com>
>> ---
>>  drivers/mailbox/pcc.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
>> index 08c87fa..b6cece0 100644
>> --- a/drivers/mailbox/pcc.c
>> +++ b/drivers/mailbox/pcc.c
>> @@ -81,6 +81,8 @@
>>  static int *pcc_doorbell_irq;
>>
>>  static struct mbox_controller pcc_mbox_ctrl = {};
>> +static DEFINE_MUTEX(pcc_con_mutex);
> I am not sure this will work. If we are not taking the channel lock, we don't have a good
> way to synchronize with the mailbox framework while we are accessing the same data.

It is still using the spinlock for accessing the channel data.

>
> Why don't we just move out the devm_request_irq and devm_free_irq outside the
> critical section? In pcc_mbox_request_channel, we can call devm_request_irq after
> releasing the spin_lock and in pcc_mbox_free_channel we can call devm_free_irq and
> then take the spin_lock to access the shared data.

It's maybe I worried about a channel can be requested multiple at the
same time. But this case does not occur when each channel is used for
a single client.
I'll move the spin_lock before request_irq and free_irq() instead.

Thanks
Hoan

>
> --
> Thanks,
> Prashanth
>
