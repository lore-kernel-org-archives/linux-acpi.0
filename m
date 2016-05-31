From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v3] mailbox: pcc: Support HW-Reduced Communication
 Subspace type 2
Date: Tue, 31 May 2016 15:05:29 -0400
Message-ID: <CAJ5Y-eZaaK_pbfgPxDfqJgtUOpxrCvHngM4_VT9p-fzFaPz28Q@mail.gmail.com>
References: <1463704347-22550-1-git-send-email-hotran@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463704347-22550-1-git-send-email-hotran@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hoan Tran <hotran@apm.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Alexey Klimov <alexey.klimov@arm.com>, lkml <linux-kernel@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Loc Ho <lho@apm.com>, Duc Dang <dhdang@apm.com>
List-Id: linux-acpi@vger.kernel.org

Hi Hoan,

On 19 May 2016 at 20:32, Hoan Tran <hotran@apm.com> wrote:
> ACPI 6.1 has a PCC HW-Reduced Communication Subspace type 2 intended for
> use on HW-Reduce ACPI Platform, which requires read-modify-write sequence
> to acknowledge doorbell interrupt. This patch provides the implementation
> for the Communication Subspace Type 2.
>
> v3
>  * Remove 2 global structures
>  * Correct parsing subspace type 1 and subspace type 2
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
>  drivers/mailbox/pcc.c | 316 ++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 245 insertions(+), 71 deletions(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 043828d..c98bd94 100644
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
> @@ -68,11 +69,16 @@
>  #include "mailbox.h"
>
>  #define MAX_PCC_SUBSPACES      256
> +#define MBOX_IRQ_NAME          "pcc-mbox"
>
>  static struct mbox_chan *pcc_mbox_channels;
>
>  /* Array of cached virtual address for doorbell registers */
>  static void __iomem **pcc_doorbell_vaddr;
> +/* Array of cached virtual address for doorbell ack registers */
> +static void __iomem **pcc_doorbell_ack_vaddr;
> +/* Array of doorbell interrupts */
> +static int *pcc_doorbell_irq;
>
>  static struct mbox_controller pcc_mbox_ctrl = {};
>  /**
> @@ -91,6 +97,132 @@ static struct mbox_chan *get_pcc_channel(int id)
>         return &pcc_mbox_channels[id];
>  }
>
> +/*
> + * PCC can be used with perf critical drivers such as CPPC
> + * So it makes sense to locally cache the virtual address and
> + * use it to read/write to PCC registers such as doorbell register
> + *
> + * The below read_register and write_registers are used to read and
> + * write from perf critical registers such as PCC doorbell register
> + */
> +static int read_register(void __iomem *vaddr, u64 *val, unsigned int bit_width)
> +{
> +       int ret_val = 0;
> +
> +       switch (bit_width) {
> +       case 8:
> +               *val = readb(vaddr);
> +               break;
> +       case 16:
> +               *val = readw(vaddr);
> +               break;
> +       case 32:
> +               *val = readl(vaddr);
> +               break;
> +       case 64:
> +               *val = readq(vaddr);
> +               break;
> +       default:
> +               pr_debug("Error: Cannot read register of %u bit width",
> +                       bit_width);
> +               ret_val = -EFAULT;
> +               break;
> +       }
> +       return ret_val;
> +}
> +
> +static int write_register(void __iomem *vaddr, u64 val, unsigned int bit_width)
> +{
> +       int ret_val = 0;
> +
> +       switch (bit_width) {
> +       case 8:
> +               writeb(val, vaddr);
> +               break;
> +       case 16:
> +               writew(val, vaddr);
> +               break;
> +       case 32:
> +               writel(val, vaddr);
> +               break;
> +       case 64:
> +               writeq(val, vaddr);
> +               break;
> +       default:
> +               pr_debug("Error: Cannot write register of %u bit width",
> +                       bit_width);
> +               ret_val = -EFAULT;
> +               break;
> +       }
> +       return ret_val;
> +}
> +

Isn't this just reordering of function locations? I don't mean to be
nitpicky, but your cosmetic changes in this file make it harder to
review the meat of the patch.

> +/**
> + * pcc_map_interrupt - Map a PCC subspace GSI to a linux IRQ number
> + * @interrupt: GSI number.
> + * @flags: interrupt flags
> + *
> + * Returns: a valid linux IRQ number on success
> + *             0 or -EINVAL on failure
> + */
> +static int pcc_map_interrupt(u32 interrupt, u32 flags)
> +{
> +       int trigger, polarity;
> +
> +       if (!interrupt)
> +               return 0;
> +
> +       trigger = (flags & ACPI_PCCT_INTERRUPT_MODE) ? ACPI_EDGE_SENSITIVE
> +                       : ACPI_LEVEL_SENSITIVE;
> +
> +       polarity = (flags & ACPI_PCCT_INTERRUPT_POLARITY) ? ACPI_ACTIVE_LOW
> +                       : ACPI_ACTIVE_HIGH;
> +
> +       return acpi_register_gsi(NULL, interrupt, trigger, polarity);
> +}
> +
> +/**
> + * pcc_mbox_irq - PCC mailbox interrupt handler
> + */
> +static irqreturn_t pcc_mbox_irq(int irq, void *p)
> +{
> +       struct acpi_generic_address *doorbell_ack;
> +       struct acpi_pcct_hw_reduced *pcct_ss;
> +       struct mbox_chan *chan = p;
> +       u64 doorbell_ack_preserve;
> +       u64 doorbell_ack_write;
> +       u64 doorbell_ack_val;
> +       int ret;
> +
> +       pcct_ss = chan->con_priv;
> +
> +       mbox_chan_received_data(chan, NULL);

Does this really do anything? IIUC, your mbox controller rings
doorbell, platform sets cmd_completion and sends an IRQ to the OS.
This is the function where you field it to ACK the doorbell. But
you're not really consuming any new data sent by the platform, right?
i.e. this IRQ use case is not the same as the async notification from
platform as described in the ACPIv5+ spec. Or did I misunderstand the
bigger picture?


[...]

> +
> +/**
>   * acpi_pcc_probe - Parse the ACPI tree for the PCCT.
>   *
>   * Return: 0 for Success, else errno.
> @@ -316,7 +449,9 @@ static int __init acpi_pcc_probe(void)
>         acpi_size pcct_tbl_header_size;
>         struct acpi_table_header *pcct_tbl;
>         struct acpi_subtable_header *pcct_entry;
> -       int count, i;
> +       struct acpi_table_pcct *acpi_pcct_tbl;
> +       int count, i, rc;
> +       int sum = 0;
>         acpi_status status = AE_OK;
>
>         /* Search for PCCT */
> @@ -333,37 +468,66 @@ static int __init acpi_pcc_probe(void)
>                         sizeof(struct acpi_table_pcct),
>                         ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE,
>                         parse_pcc_subspace, MAX_PCC_SUBSPACES);
> +       sum += (count > 0)? count: 0;
> +
> +       count = acpi_table_parse_entries(ACPI_SIG_PCCT,
> +                       sizeof(struct acpi_table_pcct),
> +                       ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2,
> +                       parse_pcc_subspace, MAX_PCC_SUBSPACES);
> +       sum += (count > 0)? count: 0;
>
> -       if (count <= 0) {
> +       if (sum == 0 || sum >= MAX_PCC_SUBSPACES) {
>                 pr_err("Error parsing PCC subspaces from PCCT\n");
>                 return -EINVAL;
>         }
>
>         pcc_mbox_channels = kzalloc(sizeof(struct mbox_chan) *
> -                       count, GFP_KERNEL);
> -
> +                       sum, GFP_KERNEL);
>         if (!pcc_mbox_channels) {
>                 pr_err("Could not allocate space for PCC mbox channels\n");
>                 return -ENOMEM;
>         }
>
> -       pcc_doorbell_vaddr = kcalloc(count, sizeof(void *), GFP_KERNEL);
> +       pcc_doorbell_vaddr = kcalloc(sum, sizeof(void *), GFP_KERNEL);
>         if (!pcc_doorbell_vaddr) {
> -               kfree(pcc_mbox_channels);
> -               return -ENOMEM;
> +               rc = -ENOMEM;
> +               goto err_free_mbox;
> +       }
> +
> +       pcc_doorbell_ack_vaddr = kcalloc(sum, sizeof(void *), GFP_KERNEL);
> +       if (!pcc_doorbell_ack_vaddr) {
> +               rc = -ENOMEM;
> +               goto err_free_db_vaddr;
> +       }
> +
> +       pcc_doorbell_irq = kcalloc(sum, sizeof(int), GFP_KERNEL);
> +       if (!pcc_doorbell_irq) {
> +               rc = -ENOMEM;
> +               goto err_free_db_ack_vaddr;
>         }
>
>         /* Point to the first PCC subspace entry */
>         pcct_entry = (struct acpi_subtable_header *) (
>                 (unsigned long) pcct_tbl + sizeof(struct acpi_table_pcct));
>
> -       for (i = 0; i < count; i++) {
> +       acpi_pcct_tbl = (struct acpi_table_pcct *) pcct_tbl;
> +       if (acpi_pcct_tbl->flags & ACPI_PCCT_DOORBELL)
> +               pcc_mbox_ctrl.txdone_irq = true;
> +

This flag is still bothering me. Can't you have a system where one
client requires polling on the command completion bit and another can
send a command completion IRQ? Seems to me that you need a channel
specific flag to indicate this. Besides, this global flag seems to be
used for async platform notifications. i.e. when the OS sets the
Generate doorbell irq bit in the Command field (Section 14.2.1 in ACPI
v6.1).


Thanks,
Ashwin.
