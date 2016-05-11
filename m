From: Hoan Tran <hotran@apm.com>
Subject: Re: [PATCH v2] mailbox: pcc: Support HW-Reduced Communication
 Subspace Type 2
Date: Wed, 11 May 2016 11:15:03 -0700
Message-ID: <CAFHUOYzDGZirZ-TfbQV-DDdZ7gmwGPUiQ1nZt_KS84=aOM-McA@mail.gmail.com>
References: <1462559914-28363-1-git-send-email-hotran@apm.com>
	<CAJ5Y-ebMB79QrSb4WRXkq-vhJED+JmW8wC1Vqyc3pg9Mh-DMjg@mail.gmail.com>
	<CAFHUOYxWe2VOjABGmm9bnqL8iKeLJ6maN-YDjp3bzWXogU2img@mail.gmail.com>
	<CAJ5Y-ebBmUHySP=wdeusACeM4wrTogVgWXNAkzc5p8jz_zbj2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJ5Y-ebBmUHySP=wdeusACeM4wrTogVgWXNAkzc5p8jz_zbj2g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Alexey Klimov <alexey.klimov@arm.com>, lkml <linux-kernel@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Loc Ho <lho@apm.com>, Duc Dang <dhdang@apm.com>
List-Id: linux-acpi@vger.kernel.org

Hi Ashwin,

On Wed, May 11, 2016 at 4:57 AM, Ashwin Chaugule
<ashwin.chaugule@linaro.org> wrote:
> On 11 May 2016 at 00:21, Hoan Tran <hotran@apm.com> wrote:
>> Hi Ashwin,
>
> Hi,
>
>> On Tue, May 10, 2016 at 5:00 AM, Ashwin Chaugule
>>> On 6 May 2016 at 14:38, Hoan Tran <hotran@apm.com> wrote:
>>>> From: hotran <hotran@apm.com>
>>>>
>>>> ACPI 6.1 has a PCC HW-Reduced Communication Subspace Type 2 intended for
>>>> use on HW-Reduce ACPI Platform, which requires read-modify-write sequence
>>>> to acknowledge doorbell interrupt. This patch provides the implementation
>>>> for the Communication Subspace Type 2.
>>>>
>>>> This patch depends on patch [1] which supports PCC subspace type 2 header
>>>> [1] https://lkml.org/lkml/2016/5/5/14
>>>>  - [PATCH v2 03/13] ACPICA: ACPI 6.1: Support for new PCCT subtable
>>>>
>>>> v2
>>>>  * Remove changes inside "actbl3.h". This file is taken care by ACPICA.
>>>>  * Parse both subspace type 1 and subspace type 2
>>>>  * Remove unnecessary variable initialization
>>>>  * ISR returns IRQ_NONE in case of error
>>>>
>>>> v1
>>>>  * Initial
>>>>
>>>> Signed-off-by: Hoan Tran <hotran@apm.com>
>>>> ---
>>>>  drivers/mailbox/pcc.c | 395 +++++++++++++++++++++++++++++++++++++-------------
>>>>  1 file changed, 296 insertions(+), 99 deletions(-)
>>>>
>>>> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
>>>> index 043828d..58c9a67 100644
>>>> --- a/drivers/mailbox/pcc.c
>>>> +++ b/drivers/mailbox/pcc.c
>>>> @@ -59,6 +59,7 @@
>>>>  #include <linux/delay.h>
>>>>  #include <linux/io.h>
>>>>  #include <linux/init.h>
>>>> +#include <linux/interrupt.h>
>>>>  #include <linux/list.h>
>>>>  #include <linux/platform_device.h>
>>>>  #include <linux/mailbox_controller.h>
>>>> @@ -68,27 +69,179 @@
>>>>  #include "mailbox.h"
>>>>
>>>>  #define MAX_PCC_SUBSPACES      256
>>>> +#define MBOX_IRQ_NAME          "pcc-mbox"
>>>>
>>>> -static struct mbox_chan *pcc_mbox_channels;
>>>> +/**
>>>> + * PCC mailbox channel information
>>>> + *
>>>> + * @chan:      Pointer to mailbox communication channel
>>>> + * @pcc_doorbell_vaddr: PCC doorbell register address
>>>> + * @pcc_doorbell_ack_vaddr: PCC doorbell ack register address
>>>> + * @irq:       Interrupt number of the channel
>>>> + */
>>>> +struct pcc_mbox_chan {
>>>> +       struct mbox_chan        *chan;
>>>> +       void __iomem            *pcc_doorbell_vaddr;
>>>> +       void __iomem            *pcc_doorbell_ack_vaddr;
>>>> +       int                     irq;
>>>> +};
>>>>
>>>> -/* Array of cached virtual address for doorbell registers */
>>>> -static void __iomem **pcc_doorbell_vaddr;
>>>> +/**
>>>> + * PCC mailbox controller data
>>>> + *
>>>> + * @mb_ctrl:   Representation of the communication channel controller
>>>> + * @mbox_chan: Array of PCC mailbox channels of the controller
>>>> + * @chans:     Array of mailbox communication channels
>>>> + */
>>>> +struct pcc_mbox {
>>>> +       struct mbox_controller  mbox_ctrl;
>>>> +       struct pcc_mbox_chan    *mbox_chans;
>>>> +       struct mbox_chan        *chans;
>>>> +};
>>>> +
>>>> +static struct pcc_mbox pcc_mbox_ctx = {};
>>>
>>> Im missing the idea behind creating this structure. Are you
>>> registering multiple controllers somewhere?
>> No, I just want to use a structure to store all global variables into
>>>
>
> I dont see how it makes things better. The functionality added by this
> patchset is actually much smaller without this cosmetic change. So I'd
> prefer if you could only introduce the IRQ related changes for now and
> we'll deal with cosmetic cleanups later if needed. As it stands even
> with this new structure, the "pcc_mbox::chans" and
> "pcc_mbox_chan::chan" are quite confusing already.
Ok, I'll remove these 2 structures and create 2 global array
variables: "pcc_doorbell_ack_vaddr" and "irq"
>
>
>>>
>>> [...]
>>>
>>>>
>>>> @@ -357,24 +534,44 @@ static int __init acpi_pcc_probe(void)
>>>>         pcct_entry = (struct acpi_subtable_header *) (
>>>>                 (unsigned long) pcct_tbl + sizeof(struct acpi_table_pcct));
>>>>
>>>> +       acpi_pcct_tbl = (struct acpi_table_pcct *) pcct_tbl;
>>>> +       if (acpi_pcct_tbl->flags & ACPI_PCCT_DOORBELL)
>>>> +               pcc_mbox_ctx.mbox_ctrl.txdone_irq = true;
>>>> +
>>>>         for (i = 0; i < count; i++) {
>>>>                 struct acpi_generic_address *db_reg;
>>>>                 struct acpi_pcct_hw_reduced *pcct_ss;
>>>> -               pcc_mbox_channels[i].con_priv = pcct_entry;
>>>> +
>>>> +               pcc_mbox_ctx.chans[i].con_priv = pcct_entry;
>>>> +               pcc_mbox_ctx.chans[i].mbox = &pcc_mbox_ctx.mbox_ctrl;
>>>> +
>>>> +               pcct_ss = (struct acpi_pcct_hw_reduced *) pcct_entry;
>>>> +
>>>> +               pcc_mbox_ctx.mbox_chans[i].chan = &pcc_mbox_ctx.chans[i];
>>>> +               if (pcc_mbox_ctx.mbox_ctrl.txdone_irq) {
>>>> +                       rc = pcc_parse_subspace_irq(&pcc_mbox_ctx.mbox_chans[i],
>>>> +                                                   pcct_ss);
>>>> +                       if (rc < 0)
>>>> +                               return rc;
>>>> +               }
>>>
>>> I think we should parse the remaining entries and register them if
>>> they are sane. Some other PCC clients can then continue to function.
>> I think, it could be an error of PCCT table and need to be returned.
>>>
>
> Well, that could be dealt with a pr_err/warn() for that specific entry
> ?
But what happens if the PCC client requests this failed PCC subspace.
"pcc_parse_subspace_irq" function does "pr_err" for error cases.

> IIRC not all subspaces require IRQ's. Its optional, isnt it?
Maybe I misunderstood: if "doorbell interrupt" bit of "platform
communications channel global flags" is set, the platform is capable
of generating an interrupt to indicate completion of a command. And if
this bit is set, "doorbell interrupt" and "doorbell interrupt flags"
fields of each subspace are active
Could you correct me, thanks
>
>>>>
>>>>                 /* If doorbell is in system memory cache the virt address */
>>>>                 pcct_ss = (struct acpi_pcct_hw_reduced *)pcct_entry;
>>>>                 db_reg = &pcct_ss->doorbell_register;
>>>> -               if (db_reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
>>>> -                       pcc_doorbell_vaddr[i] = acpi_os_ioremap(db_reg->address,
>>>> +               if (db_reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
>>>> +                       pcc_mbox_ctx.mbox_chans[i].pcc_doorbell_vaddr =
>>>> +                                       acpi_os_ioremap(db_reg->address,
>>>>                                                         db_reg->bit_width/8);
>>>> +               }
>>>> +
>>>>                 pcct_entry = (struct acpi_subtable_header *)
>>>>                         ((unsigned long) pcct_entry + pcct_entry->length);
>>>>         }
>>>>
>>>> -       pcc_mbox_ctrl.num_chans = count;
>>>> +       pcc_mbox_ctx.mbox_ctrl.num_chans = count;
>>>>
>>>> -       pr_info("Detected %d PCC Subspaces\n", pcc_mbox_ctrl.num_chans);
>>>> +       pr_info("Detected %d PCC Subspaces\n",
>>>> +               pcc_mbox_ctx.mbox_ctrl.num_chans);
>>>>
>>>>         return 0;
>>>>  }
>>>> @@ -394,12 +591,12 @@ static int pcc_mbox_probe(struct platform_device *pdev)
>>>>  {
>>>>         int ret = 0;
>>>>
>>>> -       pcc_mbox_ctrl.chans = pcc_mbox_channels;
>>>> -       pcc_mbox_ctrl.ops = &pcc_chan_ops;
>>>> -       pcc_mbox_ctrl.dev = &pdev->dev;
>>>> +       pcc_mbox_ctx.mbox_ctrl.chans = pcc_mbox_ctx.chans;
>>>> +       pcc_mbox_ctx.mbox_ctrl.ops = &pcc_chan_ops;
>>>> +       pcc_mbox_ctx.mbox_ctrl.dev = &pdev->dev;
>>>>
>>>>         pr_info("Registering PCC driver as Mailbox controller\n");
>>>> -       ret = mbox_controller_register(&pcc_mbox_ctrl);
>>>> +       ret = mbox_controller_register(&pcc_mbox_ctx.mbox_ctrl);
>>>
>>> That pcc_mbox_ctx usage everywhere seems questionable to me. But its
>>> also too early in the morning here. ;)
>> As the same with previous comments, I would like to move all global
>> variables into a structure
>>
>
> Unfortunately, it doesn't add any value to the functionality you are
> introducing. So please revert that back and add only the IRQ changes.
Yes, I'll do it

Thanks and Regards
Hoan
>
> Regards,
> Ashwin.

-- 
CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
for the sole use of the intended recipient(s) and contains information that 
is confidential and proprietary to Applied Micro Circuits Corporation or 
its subsidiaries. It is to be used solely for the purpose of furthering the 
parties' business relationship. All unauthorized review, use, disclosure or 
distribution is prohibited. If you are not the intended recipient, please 
contact the sender by reply e-mail and destroy all copies of the original 
message.
