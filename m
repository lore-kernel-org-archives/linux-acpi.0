From: Hoan Tran <hotran@apm.com>
Subject: Re: [PATCH] mailbox: pcc: Support HW-Reduced Communication Subspace
 Type 2
Date: Tue, 19 Apr 2016 13:40:13 -0700
Message-ID: <CAFHUOYzWVQ0chPrYcPd+fzFww_a4atO6pdyyaNrKw2Pbg+LOJw@mail.gmail.com>
References: <1459894447-15400-1-git-send-email-hotran@apm.com>
	<20160419190234.GA11479@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:35204 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754235AbcDSUkP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Apr 2016 16:40:15 -0400
Received: by mail-vk0-f53.google.com with SMTP id t129so34833592vkg.2
        for <linux-acpi@vger.kernel.org>; Tue, 19 Apr 2016 13:40:14 -0700 (PDT)
In-Reply-To: <20160419190234.GA11479@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Klimov <alexey.klimov@arm.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, Loc Ho <lho@apm.com>, Duc Dang <dhdang@apm.com>

Hi Alexey,


On Tue, Apr 19, 2016 at 12:02 PM, Alexey Klimov <alexey.klimov@arm.com> wrote:
> Hi Hoan,
>
> On Tue, Apr 5, 2016 at 11:14 PM, hotran <hotran@apm.com> wrote:
>> ACPI 6.1 has a HW-Reduced Communication Subspace Type 2 intended for
>> use on HW-Reduce ACPI Platform, which requires read-modify-write sequence
>> to acknowledge doorbell interrupt. This patch provides the implementation
>> for the Communication Subspace Type 2.
>>
>> Signed-off-by: Hoan Tran <hotran@apm.com>
>> ---
>>  drivers/mailbox/pcc.c | 384 +++++++++++++++++++++++++++++++++++++-------------
>>  include/acpi/actbl3.h |   8 +-
>>  2 files changed, 294 insertions(+), 98 deletions(-)
>>
>> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
>> index 0ddf638..4ed8153 100644
>> --- a/drivers/mailbox/pcc.c
>> +++ b/drivers/mailbox/pcc.c
>> @@ -59,6 +59,7 @@
>>  #include <linux/delay.h>
>>  #include <linux/io.h>
>>  #include <linux/init.h>
>> +#include <linux/interrupt.h>
>>  #include <linux/list.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/mailbox_controller.h>
>> @@ -68,27 +69,178 @@
>>  #include "mailbox.h"
>>
>>  #define MAX_PCC_SUBSPACES      256
>> +#define MBOX_IRQ_NAME          "pcc-mbox"
>>
>> -static struct mbox_chan *pcc_mbox_channels;
>> +/**
>> + * PCC mailbox channel information
>> + *
>> + * @chan:      Pointer to mailbox communication channel
>> + * @pcc_doorbell_vaddr: PCC doorbell register address
>> + * @pcc_doorbell_ack_vaddr: PCC doorbell ack register address
>> + * @irq:       Interrupt number of the channel
>> + */
>> +struct pcc_mbox_chan {
>> +       struct mbox_chan        *chan;
>> +       void __iomem            *pcc_doorbell_vaddr;
>> +       void __iomem            *pcc_doorbell_ack_vaddr;
>> +       int                     irq;
>> +};
>>
>> -/* Array of cached virtual address for doorbell registers */
>> -static void __iomem **pcc_doorbell_vaddr;
>> +/**
>> + * PCC mailbox controller data
>> + *
>> + * @mb_ctrl:   Representation of the communication channel controller
>> + * @mbox_chan: Array of PCC mailbox channels of the controller
>> + * @chans:     Array of mailbox communication channels
>> + */
>> +struct pcc_mbox {
>> +       struct mbox_controller  mbox_ctrl;
>> +       struct pcc_mbox_chan    *mbox_chans;
>> +       struct mbox_chan        *chans;
>> +};
>> +
>> +static struct pcc_mbox pcc_mbox_ctx = {};
>>
>> -static struct mbox_controller pcc_mbox_ctrl = {};
>>  /**
>>   * get_pcc_channel - Given a PCC subspace idx, get
>> - *     the respective mbox_channel.
>> + *     the respective pcc mbox_channel.
>>   * @id: PCC subspace index.
>>   *
>>   * Return: ERR_PTR(errno) if error, else pointer
>> - *     to mbox channel.
>> + *     to pcc mbox channel.
>>   */
>> -static struct mbox_chan *get_pcc_channel(int id)
>> +static struct pcc_mbox_chan *get_pcc_channel(int id)
>>  {
>> -       if (id < 0 || id > pcc_mbox_ctrl.num_chans)
>> +       if (id < 0 || id > pcc_mbox_ctx.mbox_ctrl.num_chans)
>>                 return ERR_PTR(-ENOENT);
>>
>> -       return &pcc_mbox_channels[id];
>> +       return &pcc_mbox_ctx.mbox_chans[id];
>> +}
>> +
>> +/*
>> + * PCC can be used with perf critical drivers such as CPPC
>> + * So it makes sense to locally cache the virtual address and
>> + * use it to read/write to PCC registers such as doorbell register
>> + *
>> + * The below read_register and write_registers are used to read and
>> + * write from perf critical registers such as PCC doorbell register
>> + */
>> +static int read_register(void __iomem *vaddr, u64 *val, unsigned int bit_width)
>> +{
>> +       int ret_val = 0;
>> +
>> +       switch (bit_width) {
>> +       case 8:
>> +               *val = readb(vaddr);
>> +               break;
>> +       case 16:
>> +               *val = readw(vaddr);
>> +               break;
>> +       case 32:
>> +               *val = readl(vaddr);
>> +               break;
>> +       case 64:
>> +               *val = readq(vaddr);
>> +               break;
>> +       default:
>> +               pr_debug("Error: Cannot read register of %u bit width",
>> +                       bit_width);
>> +               ret_val = -EFAULT;
>> +               break;
>> +       }
>> +       return ret_val;
>> +}
>> +
>> +static int write_register(void __iomem *vaddr, u64 val, unsigned int bit_width)
>> +{
>> +       int ret_val = 0;
>> +
>> +       switch (bit_width) {
>> +       case 8:
>> +               writeb(val, vaddr);
>> +               break;
>> +       case 16:
>> +               writew(val, vaddr);
>> +               break;
>> +       case 32:
>> +               writel(val, vaddr);
>> +               break;
>> +       case 64:
>> +               writeq(val, vaddr);
>> +               break;
>> +       default:
>> +               pr_debug("Error: Cannot write register of %u bit width",
>> +                       bit_width);
>> +               ret_val = -EFAULT;
>> +               break;
>> +       }
>> +       return ret_val;
>> +}
>> +
>> +/**
>> + * pcc_map_interrupt - Map a PCC subspace GSI to a linux IRQ number
>> + * @interrupt: GSI number.
>> + * @flags: interrupt flags
>> + *
>> + * Returns: a valid linux IRQ number on success
>> + *             0 or -EINVAL on failure
>> + */
>> +static int pcc_map_interrupt(u32 interrupt, u32 flags)
>> +{
>> +       int trigger, polarity;
>> +
>> +       if (!interrupt)
>> +               return 0;
>> +
>> +       trigger = (flags & ACPI_PCCT_INTERRUPT_MODE) ? ACPI_EDGE_SENSITIVE
>> +                       : ACPI_LEVEL_SENSITIVE;
>> +
>> +       polarity = (flags & ACPI_PCCT_INTERRUPT_POLARITY) ? ACPI_ACTIVE_LOW
>> +                       : ACPI_ACTIVE_HIGH;
>> +
>> +       return acpi_register_gsi(NULL, interrupt, trigger, polarity);
>> +}
>> +
>> +/**
>> + * pcc_mbox_irq - PCC mailbox interrupt handler
>> + */
>> +static irqreturn_t pcc_mbox_irq(int irq, void *id)
>> +{
>> +       struct acpi_generic_address *doorbell_ack;
>> +       struct acpi_pcct_hw_reduced *pcct_ss;
>> +       struct pcc_mbox_chan *pcc_chan = id;
>> +       u64 doorbell_ack_preserve;
>> +       struct mbox_chan *chan;
>> +       u64 doorbell_ack_write;
>> +       u64 doorbell_ack_val;
>> +       int ret = 0;
>
> Could you please check that you really need this initialization?
OK, will remove it
>
>> +       chan = pcc_chan->chan;
>> +       pcct_ss = chan->con_priv;
>> +
>> +       /* Clear interrupt status */
>> +       if (pcct_ss->header.type == ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2) {
>> +               doorbell_ack = &pcct_ss->doorbell_ack_register;
>> +               doorbell_ack_preserve = pcct_ss->ack_preserve_mask;
>> +               doorbell_ack_write = pcct_ss->ack_write_mask;
>> +
>> +               ret = read_register(pcc_chan->pcc_doorbell_ack_vaddr,
>> +                                   &doorbell_ack_val,
>> +                                   doorbell_ack->bit_width);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               ret = write_register(pcc_chan->pcc_doorbell_ack_vaddr,
>> +                                    (doorbell_ack_val & doorbell_ack_preserve)
>> +                                       | doorbell_ack_write,
>> +                                    doorbell_ack->bit_width);
>> +               if (ret)
>> +                       return ret;
>
> Could you please check that really need to return -EFAULT here in case of error?
> Looking through irqreturn values it looks like IRQ_NONE is more proper value.
OK, change to return IRQ_NONE
>
>
>> +       }
>> +
>> +       mbox_chan_received_data(chan, NULL);
>> +
>> +       return IRQ_HANDLED;
>>  }
>>
>
> [...]
>
>>  /**
>> + * pcc_parse_subspace_irq - Parse the PCC IRQ and PCC ACK register
>> + *             There should be one entry per PCC client.
>> + * @mbox_chans: Pointer to the PCC mailbox channel data
>> + * @pcct_ss: Pointer to the ACPI subtable header under the PCCT.
>> + *
>> + * Return: 0 for Success, else errno.
>> + *
>> + * This gets called for each entry in the PCC table.
>> + */
>> +static int pcc_parse_subspace_irq(struct pcc_mbox_chan *mbox_chans,
>> +               struct acpi_pcct_hw_reduced *pcct_ss)
>> +{
>> +       mbox_chans->irq = pcc_map_interrupt(pcct_ss->doorbell_interrupt,
>> +                                           (u32)pcct_ss->flags);
>> +       if (mbox_chans->irq <= 0) {
>> +               pr_err("PCC GSI %d not registered\n",
>> +                      pcct_ss->doorbell_interrupt);
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (pcct_ss->header.type
>> +               == ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2) {
>> +               mbox_chans->pcc_doorbell_ack_vaddr = acpi_os_ioremap(
>> +                               pcct_ss->doorbell_ack_register.address,
>> +                               pcct_ss->doorbell_ack_register.bit_width / 8);
>> +               if (!mbox_chans->pcc_doorbell_ack_vaddr) {
>> +                       pr_err("Failed to ioremap PCC ACK register\n");
>> +                       return -ENOMEM;
>> +               }
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +/**
>>   * acpi_pcc_probe - Parse the ACPI tree for the PCCT.
>>   *
>>   * Return: 0 for Success, else errno.
>> @@ -316,7 +479,8 @@ static int __init acpi_pcc_probe(void)
>>         acpi_size pcct_tbl_header_size;
>>         struct acpi_table_header *pcct_tbl;
>>         struct acpi_subtable_header *pcct_entry;
>> -       int count, i;
>> +       struct acpi_table_pcct *acpi_pcct_tbl;
>> +       int count, i, rc;
>>         acpi_status status = AE_OK;
>>
>>         /* Search for PCCT */
>> @@ -335,21 +499,29 @@ static int __init acpi_pcc_probe(void)
>>                         parse_pcc_subspace, MAX_PCC_SUBSPACES);
>>
>>         if (count <= 0) {
>> +               count = acpi_table_parse_entries(ACPI_SIG_PCCT,
>> +                               sizeof(struct acpi_table_pcct),
>> +                               ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2,
>> +                               parse_pcc_subspace, MAX_PCC_SUBSPACES);
>> +       }
>> +
>> +       if (count <= 0) {
>
> Do I understand this change correctly: in case type1 is present code flow doesn't try to parse type2 tables?
> Is presence of both type2 and type1 prohibited by specs?
Yes, it should parse all the subspace types then return error if
subspace count is <= 0.

Thanks and Regards
Hoan
>
>>                 pr_err("Error parsing PCC subspaces from PCCT\n");
>>                 return -EINVAL;
>>         }
>
> [...]
>
> Best regards,
> Alexey



-- 

CONFIDENTIALITY NOTICE: This e-mail message, including any attachments,
is for the sole use of the intended recipient(s) and contains information
that is confidential and proprietary to AppliedMicro Corporation or
its subsidiaries.
It is to be used solely for the purpose of furthering the parties'
business relationship.
All unauthorized review, use, disclosure or distribution is prohibited.
If you are not the intended recipient, please contact the sender by reply e-mail
and destroy all copies of the original message.

-- 
CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
for the sole use of the intended recipient(s) and contains information that 
is confidential and proprietary to Applied Micro Circuits Corporation or 
its subsidiaries. It is to be used solely for the purpose of furthering the 
parties' business relationship. All unauthorized review, use, disclosure or 
distribution is prohibited. If you are not the intended recipient, please 
contact the sender by reply e-mail and destroy all copies of the original 
message.
