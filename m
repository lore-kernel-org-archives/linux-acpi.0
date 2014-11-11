From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [Linaro-acpi] [PATCH v10 1/1] Mailbox: Add support for Platform
 Communication Channel
Date: Tue, 11 Nov 2014 10:30:32 +0000
Message-ID: <5461E548.2040204@arm.com>
References: <1415371964-4451-1-git-send-email-ashwin.chaugule@linaro.org> <1415371964-4451-2-git-send-email-ashwin.chaugule@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:57327 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbaKKKaW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Nov 2014 05:30:22 -0500
In-Reply-To: <1415371964-4451-2-git-send-email-ashwin.chaugule@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>, "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "arnd@arndb.de" <arnd@arndb.de>, "patches@linaro.org" <patches@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "lv.zheng@intel.com" <lv.zheng@intel.com>

Hi Ashwin,

On 07/11/14 14:52, Ashwin Chaugule wrote:
> ACPI 5.0+ spec defines a generic mode of communication
> between the OS and a platform such as the BMC. This medium
> (PCC) is typically used by CPPC (ACPI CPU Performance management),
> RAS (ACPI reliability protocol) and MPST (ACPI Memory power
> states).
>
> This patch adds PCC support as a Mailbox Controller.
>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> ---
>   drivers/mailbox/Kconfig   |  12 ++
>   drivers/mailbox/Makefile  |   2 +
>   drivers/mailbox/mailbox.c |   4 +-
>   drivers/mailbox/mailbox.h |  16 ++
>   drivers/mailbox/pcc.c     | 367 ++++++++++++++++++++++++++++++++++++++++++++++
>   5 files changed, 398 insertions(+), 3 deletions(-)
>   create mode 100644 drivers/mailbox/mailbox.h
>   create mode 100644 drivers/mailbox/pcc.c
>
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index 9fd9c67..c04fed9 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -33,4 +33,16 @@ config OMAP_MBOX_KFIFO_SIZE
>            Specify the default size of mailbox's kfifo buffers (bytes).
>            This can also be changed at runtime (via the mbox_kfifo_size
>            module parameter).
> +
> +config PCC
> +       bool "Platform Communication Channel Driver"
> +       depends on ACPI

I am bit confused here, though I prefer PCC to depend on ACPI, I have
seen discussion in this thread about using PCC without ACPI, how will
that work ?

> +       help
> +         ACPI 5.0+ spec defines a generic mode of communication
> +         between the OS and a platform such as the BMC. This medium
> +         (PCC) is typically used by CPPC (ACPI CPU Performance management),
> +         RAS (ACPI reliability protocol) and MPST (ACPI Memory power
> +         states). Select this driver if your platform implements the
> +         PCC clients mentioned above.
> +
>   endif

[...]

> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> new file mode 100644
> index 0000000..49074cd0
> --- /dev/null
> +++ b/drivers/mailbox/pcc.c
> @@ -0,0 +1,367 @@
> +/*
> + *     Copyright (C) 2014 Linaro Ltd.
> + *     Author: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  PCC (Platform Communication Channel) is defined in the ACPI 5.0+
> + *  specification. It is a mailbox like mechanism to allow clients
> + *  such as CPPC (Collaborative Processor Performance Control), RAS
> + *  (Reliability, Availability and Serviceability) and MPST (Memory
> + *  Node Power State Table) to talk to the platform (e.g. BMC) through
> + *  shared memory regions as defined in the PCC table entries. The PCC
> + *  specification supports a Doorbell mechanism for the PCC clients
> + *  to notify the platform about new data. This Doorbell information
> + *  is also specified in each PCC table entry. See pcc_send_data()
> + *  and pcc_tx_done() for basic mode of operation.
> + *
> + *  For more details about PCC, please see the ACPI specification from
> + *  http://www.uefi.org/ACPIv5.1 Section 14.
> + *
> + *  This file implements PCC as a Mailbox controller and allows for PCC
> + *  clients to be implemented as its Mailbox Client Channels.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/mailbox_client.h>
> +
> +#include "mailbox.h"
> +
> +#define MAX_PCC_SUBSPACES      256
> +#define PCCS_SS_SIG_MAGIC      0x50434300
> +#define PCC_CMD_COMPLETE       0x1
> +
> +static struct mbox_chan pcc_mbox_chan[MAX_PCC_SUBSPACES];

Really, do you want to allocate 256 structures of mbox_chan even on
systems with just 1 - 2 channels(typically that would be the case) ?

> +static struct mbox_controller pcc_mbox_ctrl = {};
> +

[...]

> +
> +/**
> + * pcc_tx_done - Callback from Mailbox controller code to
> + *             check if PCC message transmission completed.
> + * @chan: Pointer to Mailbox channel on which previous
> + *             transmission occurred.
> + *
> + * Return: TRUE if succeeded.
> + */
> +static bool pcc_tx_done(struct mbox_chan *chan)
> +{
> +       struct acpi_pcct_hw_reduced *pcct_ss = chan->con_priv;
> +       struct acpi_pcct_shared_memory *generic_comm_base =
> +               (struct acpi_pcct_shared_memory *) pcct_ss->base_address;

IIUC, the PCCT table has the physical base Address of the shared memory
range in the PCC subspace structures. Can you use that directly here ?
Or are you mapping that memory elsewhere and updating the mapped address
to the table ?

> +       u16 cmd_delay = pcct_ss->min_turnaround_time;
> +       unsigned int retries = 0;
> +
> +       /* Try a few times while waiting for platform to consume */
> +       while (!(readw_relaxed(&generic_comm_base->status)

This will explode if the pcct_ss->base_address is not mapped.

> +                   & PCC_CMD_COMPLETE)) {
> +
> +               if (retries++ < 5)
> +                       udelay(cmd_delay);
> +               else {
> +                       /*
> +                        * If the remote is dead, this will cause the Mbox
> +                        * controller to timeout after mbox client.tx_tout
> +                        * msecs.
> +                        */
> +                       pr_err("PCC platform did not respond.\n");
> +                       return false;
> +               }
> +       }
> +       return true;
> +}

In general you can isolate all the access to the shared memory in the
protocol layer. In that case you might have to use mbox_client_txdone
instead of this pcc_tx_done.

> +
> +/**
> + * get_subspace_id - Given a Mailbox channel, find out the
> + *             PCC subspace id.
> + * @chan: Pointer to Mailbox Channel from which we want
> + *             the index.
> + * Return: Errno if not found, else positive index number.
> + */
> +static int get_subspace_id(struct mbox_chan *chan)
> +{
> +       int id = chan - pcc_mbox_chan;
> +
> +       if (id < 0 || id > pcc_mbox_ctrl.num_chans)
> +               return -ENOENT;
> +
> +       return id;
> +}
> +
> +/**
> + * pcc_send_data - Called from Mailbox Controller code to finally
> + *     transmit data over channel.
> + * @chan: Pointer to Mailbox channel over which to send data.
> + * @data: Actual data to be written over channel.
> + *
> + * Return: Err if something failed else 0 for success.
> + */
> +static int pcc_send_data(struct mbox_chan *chan, void *data)
> +{
> +       struct acpi_pcct_hw_reduced *pcct_ss = chan->con_priv;
> +       struct acpi_pcct_shared_memory *generic_comm_base =
> +               (struct acpi_pcct_shared_memory *) pcct_ss->base_address;
> +       struct acpi_generic_address doorbell;
> +       u64 doorbell_preserve;
> +       u64 doorbell_val;
> +       u64 doorbell_write;
> +       u16 cmd = *(u16 *) data;
> +       u16 ss_idx = -1;
> +
> +       ss_idx = get_subspace_id(chan);
> +
> +       if (ss_idx < 0) {
> +               pr_err("Invalid Subspace ID from PCC client\n");
> +               return -EINVAL;
> +       }
> +
> +       doorbell = pcct_ss->doorbell_register;
> +       doorbell_preserve = pcct_ss->preserve_mask;
> +       doorbell_write = pcct_ss->write_mask;
> +
> +       /* Write to the shared comm region. */
> +       writew(cmd, &generic_comm_base->command);
> +
> +       /* Write Subspace MAGIC value so platform can identify destination. */
> +       writel((PCCS_SS_SIG_MAGIC | ss_idx), &generic_comm_base->signature);
> +
> +       /* Flip CMD COMPLETE bit */
> +       writew(0, &generic_comm_base->status);
> +

IMO it's not clean to modify only first 3 elements namely: Signature,
Command and Status while the Communication Space is updated elsewhere.
It's better to have all of them in one place if possible as mentioned above.

> +       /* Sync notification from OSPM to Platform. */
> +       acpi_read(&doorbell_val, &doorbell);
> +       acpi_write((doorbell_val & doorbell_preserve) | doorbell_write,
> +                       &doorbell);
> +

Only the above 2 must be part of the controller driver, the remaining as
I mentioned can be move to the protocol/client layer, thoughts ?

> +       return 0;
> +}
> +
> +static struct mbox_chan_ops pcc_chan_ops = {
> +       .send_data = pcc_send_data,
> +       .last_tx_done = pcc_tx_done,
> +};
> +

[...]

> +/**
> + * acpi_pcc_probe - Parse the ACPI tree for the PCCT.
> + *
> + * Return: 0 for Success, else errno.
> + */
> +static int __init acpi_pcc_probe(void)
> +{
> +       acpi_status status = AE_OK;
> +       acpi_size pcct_tbl_header_size;
> +       int count;
> +       struct acpi_table_pcct *pcct_tbl;
> +
> +       /* Search for PCCT */
> +       status = acpi_get_table_with_size(ACPI_SIG_PCCT, 0,
> +                       (struct acpi_table_header **)&pcct_tbl,
> +                       &pcct_tbl_header_size);
> +
> +       if (ACPI_FAILURE(status) || !pcct_tbl) {
> +               pr_warn("PCCT header not found.\n");
> +               return -ENODEV;
> +       }
> +
> +       count = acpi_table_parse_entries(ACPI_SIG_PCCT,
> +                       sizeof(struct acpi_table_pcct),

s/struct acpi_table_pcct/*pcct_tbl/

In general, the interrupt part of the PCCT SS is not considered in this
patch. It's better to see/discuss how that can be fit into the mailbox
framework, though it could be follow up patch.

Regards,
Sudeep

