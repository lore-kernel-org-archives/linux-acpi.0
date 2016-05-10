From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v2] mailbox: pcc: Support HW-Reduced Communication
 Subspace Type 2
Date: Tue, 10 May 2016 08:00:58 -0400
Message-ID: <CAJ5Y-ebMB79QrSb4WRXkq-vhJED+JmW8wC1Vqyc3pg9Mh-DMjg@mail.gmail.com>
References: <1462559914-28363-1-git-send-email-hotran@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:36495 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbcEJMBT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 May 2016 08:01:19 -0400
Received: by mail-qk0-f172.google.com with SMTP id x7so4818978qkd.3
        for <linux-acpi@vger.kernel.org>; Tue, 10 May 2016 05:01:18 -0700 (PDT)
In-Reply-To: <1462559914-28363-1-git-send-email-hotran@apm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hoan Tran <hotran@apm.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Alexey Klimov <alexey.klimov@arm.com>, lkml <linux-kernel@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, lho@apm.com, dhdang@apm.com

Hello,

On 6 May 2016 at 14:38, Hoan Tran <hotran@apm.com> wrote:
> From: hotran <hotran@apm.com>
>
> ACPI 6.1 has a PCC HW-Reduced Communication Subspace Type 2 intended for
> use on HW-Reduce ACPI Platform, which requires read-modify-write sequence
> to acknowledge doorbell interrupt. This patch provides the implementation
> for the Communication Subspace Type 2.
>
> This patch depends on patch [1] which supports PCC subspace type 2 header
> [1] https://lkml.org/lkml/2016/5/5/14
>  - [PATCH v2 03/13] ACPICA: ACPI 6.1: Support for new PCCT subtable
>
> v2
>  * Remove changes inside "actbl3.h". This file is taken care by ACPICA.
>  * Parse both subspace type 1 and subspace type 2
>  * Remove unnecessary variable initialization
>  * ISR returns IRQ_NONE in case of error
>
> v1
>  * Initial
>
> Signed-off-by: Hoan Tran <hotran@apm.com>
> ---
>  drivers/mailbox/pcc.c | 395 +++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 296 insertions(+), 99 deletions(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 043828d..58c9a67 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -59,6 +59,7 @@
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/init.h>
> +#include <linux/interrupt.h>
>  #include <linux/list.h>
>  #include <linux/platform_device.h>
>  #include <linux/mailbox_controller.h>
> @@ -68,27 +69,179 @@
>  #include "mailbox.h"
>
>  #define MAX_PCC_SUBSPACES      256
> +#define MBOX_IRQ_NAME          "pcc-mbox"
>
> -static struct mbox_chan *pcc_mbox_channels;
> +/**
> + * PCC mailbox channel information
> + *
> + * @chan:      Pointer to mailbox communication channel
> + * @pcc_doorbell_vaddr: PCC doorbell register address
> + * @pcc_doorbell_ack_vaddr: PCC doorbell ack register address
> + * @irq:       Interrupt number of the channel
> + */
> +struct pcc_mbox_chan {
> +       struct mbox_chan        *chan;
> +       void __iomem            *pcc_doorbell_vaddr;
> +       void __iomem            *pcc_doorbell_ack_vaddr;
> +       int                     irq;
> +};
>
> -/* Array of cached virtual address for doorbell registers */
> -static void __iomem **pcc_doorbell_vaddr;
> +/**
> + * PCC mailbox controller data
> + *
> + * @mb_ctrl:   Representation of the communication channel controller
> + * @mbox_chan: Array of PCC mailbox channels of the controller
> + * @chans:     Array of mailbox communication channels
> + */
> +struct pcc_mbox {
> +       struct mbox_controller  mbox_ctrl;
> +       struct pcc_mbox_chan    *mbox_chans;
> +       struct mbox_chan        *chans;
> +};
> +
> +static struct pcc_mbox pcc_mbox_ctx = {};

Im missing the idea behind creating this structure. Are you
registering multiple controllers somewhere?


[...]

>
> @@ -357,24 +534,44 @@ static int __init acpi_pcc_probe(void)
>         pcct_entry = (struct acpi_subtable_header *) (
>                 (unsigned long) pcct_tbl + sizeof(struct acpi_table_pcct));
>
> +       acpi_pcct_tbl = (struct acpi_table_pcct *) pcct_tbl;
> +       if (acpi_pcct_tbl->flags & ACPI_PCCT_DOORBELL)
> +               pcc_mbox_ctx.mbox_ctrl.txdone_irq = true;
> +
>         for (i = 0; i < count; i++) {
>                 struct acpi_generic_address *db_reg;
>                 struct acpi_pcct_hw_reduced *pcct_ss;
> -               pcc_mbox_channels[i].con_priv = pcct_entry;
> +
> +               pcc_mbox_ctx.chans[i].con_priv = pcct_entry;
> +               pcc_mbox_ctx.chans[i].mbox = &pcc_mbox_ctx.mbox_ctrl;
> +
> +               pcct_ss = (struct acpi_pcct_hw_reduced *) pcct_entry;
> +
> +               pcc_mbox_ctx.mbox_chans[i].chan = &pcc_mbox_ctx.chans[i];
> +               if (pcc_mbox_ctx.mbox_ctrl.txdone_irq) {
> +                       rc = pcc_parse_subspace_irq(&pcc_mbox_ctx.mbox_chans[i],
> +                                                   pcct_ss);
> +                       if (rc < 0)
> +                               return rc;
> +               }

I think we should parse the remaining entries and register them if
they are sane. Some other PCC clients can then continue to function.

>
>                 /* If doorbell is in system memory cache the virt address */
>                 pcct_ss = (struct acpi_pcct_hw_reduced *)pcct_entry;
>                 db_reg = &pcct_ss->doorbell_register;
> -               if (db_reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
> -                       pcc_doorbell_vaddr[i] = acpi_os_ioremap(db_reg->address,
> +               if (db_reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
> +                       pcc_mbox_ctx.mbox_chans[i].pcc_doorbell_vaddr =
> +                                       acpi_os_ioremap(db_reg->address,
>                                                         db_reg->bit_width/8);
> +               }
> +
>                 pcct_entry = (struct acpi_subtable_header *)
>                         ((unsigned long) pcct_entry + pcct_entry->length);
>         }
>
> -       pcc_mbox_ctrl.num_chans = count;
> +       pcc_mbox_ctx.mbox_ctrl.num_chans = count;
>
> -       pr_info("Detected %d PCC Subspaces\n", pcc_mbox_ctrl.num_chans);
> +       pr_info("Detected %d PCC Subspaces\n",
> +               pcc_mbox_ctx.mbox_ctrl.num_chans);
>
>         return 0;
>  }
> @@ -394,12 +591,12 @@ static int pcc_mbox_probe(struct platform_device *pdev)
>  {
>         int ret = 0;
>
> -       pcc_mbox_ctrl.chans = pcc_mbox_channels;
> -       pcc_mbox_ctrl.ops = &pcc_chan_ops;
> -       pcc_mbox_ctrl.dev = &pdev->dev;
> +       pcc_mbox_ctx.mbox_ctrl.chans = pcc_mbox_ctx.chans;
> +       pcc_mbox_ctx.mbox_ctrl.ops = &pcc_chan_ops;
> +       pcc_mbox_ctx.mbox_ctrl.dev = &pdev->dev;
>
>         pr_info("Registering PCC driver as Mailbox controller\n");
> -       ret = mbox_controller_register(&pcc_mbox_ctrl);
> +       ret = mbox_controller_register(&pcc_mbox_ctx.mbox_ctrl);

That pcc_mbox_ctx usage everywhere seems questionable to me. But its
also too early in the morning here. ;)

Regards,
Ashwin.
