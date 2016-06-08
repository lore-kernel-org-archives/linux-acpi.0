From: Hoan Tran <hotran@apm.com>
Subject: Re: [PATCH v3] mailbox: pcc: Support HW-Reduced Communication
 Subspace type 2
Date: Wed, 8 Jun 2016 09:24:42 -0700
Message-ID: <CAFHUOYxV8Jj_wUXqA7jqj3SZ4uqCSSgKuYmsC2k1MxvVyX3EfQ@mail.gmail.com>
References: <1463704347-22550-1-git-send-email-hotran@apm.com>
	<CAJ5Y-eZaaK_pbfgPxDfqJgtUOpxrCvHngM4_VT9p-fzFaPz28Q@mail.gmail.com>
	<CAFHUOYy0TEqdHzwXCTNtK+UVF_PhMHfr-gPTOkUwRks=MgTaVg@mail.gmail.com>
	<CAJ5Y-eYV+vf_GDCX6iX53Q5jLtOTzRktRHBfmZzW-yd5ffu2jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:34423 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757561AbcFHQYn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Jun 2016 12:24:43 -0400
Received: by mail-vk0-f45.google.com with SMTP id e4so18542784vkb.1
        for <linux-acpi@vger.kernel.org>; Wed, 08 Jun 2016 09:24:43 -0700 (PDT)
In-Reply-To: <CAJ5Y-eYV+vf_GDCX6iX53Q5jLtOTzRktRHBfmZzW-yd5ffu2jg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Alexey Klimov <alexey.klimov@arm.com>, lkml <linux-kernel@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Loc Ho <lho@apm.com>, Duc Dang <dhdang@apm.com>, Prashanth Prakash <pprakash@codeaurora.org>

Hi Ashwin,

On Wed, Jun 8, 2016 at 5:18 AM, Ashwin Chaugule
<ashwin.chaugule@linaro.org> wrote:
> + Prashanth (Can you please have a look as well?)
>
> On 31 May 2016 at 15:35, Hoan Tran <hotran@apm.com> wrote:
>> Hi Ashwin,
>
> Hi,
>
> Sorry about the delay. I'm in the middle of switching jobs and
> locations, so its been a bit crazy lately.

It's ok and hope you're doing well.

> I dont have any major
> concerns with this code, although there could be subtle issues with
> this IRQ thing. In this patchset, your intent is to add support for
> PCC subspace type 2. But you're also adding support for tx command
> completion which is not specific to Type 2. We could support that even
> in Type 1. Hence I wanted to separate the two, not just for review,
> but also the async IRQ completion has subtle issues esp. in the case
> of async platform notification, where you could have a PCC client in
> the OS writing to the cmd bit and the platform sending an async
> notification by writing to some bits in the same 8byte address as the
> cmd bit. So we need some mutual exclusivity there, otherwise the OS
> and platform could step on each other. Perhaps Prashanth has better
> insight into this.

I think, this mutual exclusivity could be in another patch.

>
>>
>> On Tue, May 31, 2016 at 12:05 PM, Ashwin Chaugule
>> <ashwin.chaugule@linaro.org> wrote:
>>> On 19 May 2016 at 20:32, Hoan Tran <hotran@apm.com> wrote:
>>>> ACPI 6.1 has a PCC HW-Reduced Communication Subspace type 2 intended for
>>>> use on HW-Reduce ACPI Platform, which requires read-modify-write sequence
>>>> to acknowledge doorbell interrupt. This patch provides the implementation
>>>> for the Communication Subspace Type 2.
>>>>
>>>> v3
>>>>  * Remove 2 global structures
>>>>  * Correct parsing subspace type 1 and subspace type 2
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
>>>>  drivers/mailbox/pcc.c | 316 ++++++++++++++++++++++++++++++++++++++------------
>>>>  1 file changed, 245 insertions(+), 71 deletions(-)
>>>>
>>>> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
>>>> index 043828d..c98bd94 100644
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
>>>> @@ -68,11 +69,16 @@
>>>>  #include "mailbox.h"
>>>>
>>>>  #define MAX_PCC_SUBSPACES      256
>>>> +#define MBOX_IRQ_NAME          "pcc-mbox"
>>>>
>>>>  static struct mbox_chan *pcc_mbox_channels;
>>>>
>>>>  /* Array of cached virtual address for doorbell registers */
>>>>  static void __iomem **pcc_doorbell_vaddr;
>>>> +/* Array of cached virtual address for doorbell ack registers */
>>>> +static void __iomem **pcc_doorbell_ack_vaddr;
>>>> +/* Array of doorbell interrupts */
>>>> +static int *pcc_doorbell_irq;
>>>>
>>>>  static struct mbox_controller pcc_mbox_ctrl = {};
>>>>  /**
>>>> @@ -91,6 +97,132 @@ static struct mbox_chan *get_pcc_channel(int id)
>>>>         return &pcc_mbox_channels[id];
>>>>  }
>>>>
>>>> +/*
>>>> + * PCC can be used with perf critical drivers such as CPPC
>>>> + * So it makes sense to locally cache the virtual address and
>>>> + * use it to read/write to PCC registers such as doorbell register
>>>> + *
>>>> + * The below read_register and write_registers are used to read and
>>>> + * write from perf critical registers such as PCC doorbell register
>>>> + */
>>>> +static int read_register(void __iomem *vaddr, u64 *val, unsigned int bit_width)
>>>> +{
>>>> +       int ret_val = 0;
>>>> +
>>>> +       switch (bit_width) {
>>>> +       case 8:
>>>> +               *val = readb(vaddr);
>>>> +               break;
>>>> +       case 16:
>>>> +               *val = readw(vaddr);
>>>> +               break;
>>>> +       case 32:
>>>> +               *val = readl(vaddr);
>>>> +               break;
>>>> +       case 64:
>>>> +               *val = readq(vaddr);
>>>> +               break;
>>>> +       default:
>>>> +               pr_debug("Error: Cannot read register of %u bit width",
>>>> +                       bit_width);
>>>> +               ret_val = -EFAULT;
>>>> +               break;
>>>> +       }
>>>> +       return ret_val;
>>>> +}
>>>> +
>>>> +static int write_register(void __iomem *vaddr, u64 val, unsigned int bit_width)
>>>> +{
>>>> +       int ret_val = 0;
>>>> +
>>>> +       switch (bit_width) {
>>>> +       case 8:
>>>> +               writeb(val, vaddr);
>>>> +               break;
>>>> +       case 16:
>>>> +               writew(val, vaddr);
>>>> +               break;
>>>> +       case 32:
>>>> +               writel(val, vaddr);
>>>> +               break;
>>>> +       case 64:
>>>> +               writeq(val, vaddr);
>>>> +               break;
>>>> +       default:
>>>> +               pr_debug("Error: Cannot write register of %u bit width",
>>>> +                       bit_width);
>>>> +               ret_val = -EFAULT;
>>>> +               break;
>>>> +       }
>>>> +       return ret_val;
>>>> +}
>>>> +
>>>
>>> Isn't this just reordering of function locations? I don't mean to be
>>> nitpicky, but your cosmetic changes in this file make it harder to
>>> review the meat of the patch.
>>
>> Yes, it is. As I would like to call these functions but actually, they
>> are declared quite late.
>> Do you have a any suggestion? Thanks
>>
>
> No this is fine. I missed the place where you needed to call these.
>
>>>
>>>> +/**
>>>> + * pcc_map_interrupt - Map a PCC subspace GSI to a linux IRQ number
>>>> + * @interrupt: GSI number.
>>>> + * @flags: interrupt flags
>>>> + *
>>>> + * Returns: a valid linux IRQ number on success
>>>> + *             0 or -EINVAL on failure
>>>> + */
>>>> +static int pcc_map_interrupt(u32 interrupt, u32 flags)
>>>> +{
>>>> +       int trigger, polarity;
>>>> +
>>>> +       if (!interrupt)
>>>> +               return 0;
>>>> +
>>>> +       trigger = (flags & ACPI_PCCT_INTERRUPT_MODE) ? ACPI_EDGE_SENSITIVE
>>>> +                       : ACPI_LEVEL_SENSITIVE;
>>>> +
>>>> +       polarity = (flags & ACPI_PCCT_INTERRUPT_POLARITY) ? ACPI_ACTIVE_LOW
>>>> +                       : ACPI_ACTIVE_HIGH;
>>>> +
>>>> +       return acpi_register_gsi(NULL, interrupt, trigger, polarity);
>>>> +}
>>>> +
>>>> +/**
>>>> + * pcc_mbox_irq - PCC mailbox interrupt handler
>>>> + */
>>>> +static irqreturn_t pcc_mbox_irq(int irq, void *p)
>>>> +{
>>>> +       struct acpi_generic_address *doorbell_ack;
>>>> +       struct acpi_pcct_hw_reduced *pcct_ss;
>>>> +       struct mbox_chan *chan = p;
>>>> +       u64 doorbell_ack_preserve;
>>>> +       u64 doorbell_ack_write;
>>>> +       u64 doorbell_ack_val;
>>>> +       int ret;
>>>> +
>>>> +       pcct_ss = chan->con_priv;
>>>> +
>>>> +       mbox_chan_received_data(chan, NULL);
>>>
>>> Does this really do anything? IIUC, your mbox controller rings
>>> doorbell, platform sets cmd_completion and sends an IRQ to the OS.
>>> This is the function where you field it to ACK the doorbell. But
>>> you're not really consuming any new data sent by the platform, right?
>>> i.e. this IRQ use case is not the same as the async notification from
>>> platform as described in the ACPIv5+ spec. Or did I misunderstand the
>>> bigger picture?
>>>
>>
>> The purpose of this function call is
>> 1./ Notify the completion of a command to OSPM.
>> For example, instead of using polling with udelay, CPPC could use this
>> call to complete a "completion".
>> I'm preparing to post a version to support it for CPPC.
>>
>
> I see. This is the part I was missing. Seems like you could call the
> mbox_chan_received_data() only after you add support for this.
>
>> 2./ Notify OSPM about a notification message sent by Platform
>
> This will require adding some sort of rx_callback to field the notification.
>
>>>
>>> [...]
>>>
>>>> +
>>>> +/**
>>>>   * acpi_pcc_probe - Parse the ACPI tree for the PCCT.
>>>>   *
>>>>   * Return: 0 for Success, else errno.
>>>> @@ -316,7 +449,9 @@ static int __init acpi_pcc_probe(void)
>>>>         acpi_size pcct_tbl_header_size;
>>>>         struct acpi_table_header *pcct_tbl;
>>>>         struct acpi_subtable_header *pcct_entry;
>>>> -       int count, i;
>>>> +       struct acpi_table_pcct *acpi_pcct_tbl;
>>>> +       int count, i, rc;
>>>> +       int sum = 0;
>>>>         acpi_status status = AE_OK;
>>>>
>>>>         /* Search for PCCT */
>>>> @@ -333,37 +468,66 @@ static int __init acpi_pcc_probe(void)
>>>>                         sizeof(struct acpi_table_pcct),
>>>>                         ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE,
>>>>                         parse_pcc_subspace, MAX_PCC_SUBSPACES);
>>>> +       sum += (count > 0)? count: 0;
>>>> +
>>>> +       count = acpi_table_parse_entries(ACPI_SIG_PCCT,
>>>> +                       sizeof(struct acpi_table_pcct),
>>>> +                       ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2,
>>>> +                       parse_pcc_subspace, MAX_PCC_SUBSPACES);
>>>> +       sum += (count > 0)? count: 0;
>>>>
>>>> -       if (count <= 0) {
>>>> +       if (sum == 0 || sum >= MAX_PCC_SUBSPACES) {
>>>>                 pr_err("Error parsing PCC subspaces from PCCT\n");
>>>>                 return -EINVAL;
>>>>         }
>>>>
>>>>         pcc_mbox_channels = kzalloc(sizeof(struct mbox_chan) *
>>>> -                       count, GFP_KERNEL);
>>>> -
>>>> +                       sum, GFP_KERNEL);
>>>>         if (!pcc_mbox_channels) {
>>>>                 pr_err("Could not allocate space for PCC mbox channels\n");
>>>>                 return -ENOMEM;
>>>>         }
>>>>
>>>> -       pcc_doorbell_vaddr = kcalloc(count, sizeof(void *), GFP_KERNEL);
>>>> +       pcc_doorbell_vaddr = kcalloc(sum, sizeof(void *), GFP_KERNEL);
>>>>         if (!pcc_doorbell_vaddr) {
>>>> -               kfree(pcc_mbox_channels);
>>>> -               return -ENOMEM;
>>>> +               rc = -ENOMEM;
>>>> +               goto err_free_mbox;
>>>> +       }
>>>> +
>>>> +       pcc_doorbell_ack_vaddr = kcalloc(sum, sizeof(void *), GFP_KERNEL);
>>>> +       if (!pcc_doorbell_ack_vaddr) {
>>>> +               rc = -ENOMEM;
>>>> +               goto err_free_db_vaddr;
>>>> +       }
>>>> +
>>>> +       pcc_doorbell_irq = kcalloc(sum, sizeof(int), GFP_KERNEL);
>>>> +       if (!pcc_doorbell_irq) {
>>>> +               rc = -ENOMEM;
>>>> +               goto err_free_db_ack_vaddr;
>>>>         }
>>>>
>>>>         /* Point to the first PCC subspace entry */
>>>>         pcct_entry = (struct acpi_subtable_header *) (
>>>>                 (unsigned long) pcct_tbl + sizeof(struct acpi_table_pcct));
>>>>
>>>> -       for (i = 0; i < count; i++) {
>>>> +       acpi_pcct_tbl = (struct acpi_table_pcct *) pcct_tbl;
>>>> +       if (acpi_pcct_tbl->flags & ACPI_PCCT_DOORBELL)
>>>> +               pcc_mbox_ctrl.txdone_irq = true;
>>>> +
>>>
>>> This flag is still bothering me. Can't you have a system where one
>>> client requires polling on the command completion bit and another can
>>> send a command completion IRQ? Seems to me that you need a channel
>>> specific flag to indicate this. Besides, this global flag seems to be
>>> used for async platform notifications. i.e. when the OS sets the
>>> Generate doorbell irq bit in the Command field (Section 14.2.1 in ACPI
>>> v6.1).
>>
>> I thought this bit is the global configuration for PCC.
>> We still can support the polling mode if this flag is ON. Just don't
>> set "Generate Doorbell Interrupt" bit inside Command Field.
>>
>
> From the spec point of view it would seem so, but does the mbox
> controller code allow for that?  i.e. let individual PCC channels
> decide whether to use txdone irq or poll? Seems like
> pcc_mbox_ctrl.txdone_irq is a global setting for all mbox channels.

I think for PCC, it's depend on the PCC client not mbox controller.
Client can decide to send a command in polling or interrupt mode by
configuring "Generate Doorbell Interrupt" bit.
For the txdone_irq flag, it is a global setting for all mbox channels.
If txdone_irq is enabled, the client has to use mbox_chan_txdone()
function to notify the framework that the last command has completed.

Thanks and Regards
Hoan

>
> I apologize again, going forward my replies could be further delayed.
> In process of relocating to a new job and role to a different city
> which is several time zones away. :)
>
> Thanks,
> Ashwin.
