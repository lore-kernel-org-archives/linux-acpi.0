From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH v10 1/1] Mailbox: Add support for Platform Communication Channel
Date: Tue, 11 Nov 2014 20:42:01 +0530
Message-ID: <CAJe_ZhdbFrsY=SbcwE2Qg7g_N0ddMpEF-3kk7wGhz1OrQi=4vA@mail.gmail.com>
References: <1415371964-4451-1-git-send-email-ashwin.chaugule@linaro.org>
	<1415371964-4451-2-git-send-email-ashwin.chaugule@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:64196 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbaKKPMD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Nov 2014 10:12:03 -0500
Received: by mail-qc0-f176.google.com with SMTP id x3so7637174qcv.7
        for <linux-acpi@vger.kernel.org>; Tue, 11 Nov 2014 07:12:02 -0800 (PST)
In-Reply-To: <1415371964-4451-2-git-send-email-ashwin.chaugule@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, "lv.zheng" <lv.zheng@intel.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>, linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>

On 7 November 2014 20:22, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:

> +struct mbox_chan *pcc_mbox_request_channel(struct mbox_client *cl,
> +               int index)
> +{
> +       struct device *dev = pcc_mbox_ctrl.dev;
> +       struct mbox_chan *chan;
> +       unsigned long flags;
> +
> +       /*
> +        * Each PCC Subspace is a Mailbox Channel.
> +        * The PCC Clients get their PCC Subspace ID
> +        * from their own tables and pass it here.
> +        * This returns a pointer to the PCC subspace
> +        * for the Client to operate on.
> +        */
> +       chan = &pcc_mbox_chan[index];
> +
You are mapping 'Type' of a client directly onto SubSpace-ID of the
channel allocated.
If two clients need an instance of, say,
Generic-Communications-Channel i.e, Type-0, this will not work.
If no two clients can ask the same channel, MAX_PCC_SUBSPACES should
be limited to max 'Type' value defined in ACPI specs (just 2 in
ACPI-5.1).

> +       if (!chan || chan->cl) {
> +               dev_err(dev, "%s: PCC mailbox not free\n", __func__);
> +               return ERR_PTR(-EBUSY);
> +       }
> +
> +       spin_lock_irqsave(&chan->lock, flags);
> +       chan->msg_free = 0;
> +       chan->msg_count = 0;
> +       chan->active_req = NULL;
> +       chan->cl = cl;
> +       init_completion(&chan->tx_complete);
> +
> +       if (chan->txdone_method == TXDONE_BY_POLL && cl->knows_txdone)
> +               chan->txdone_method |= TXDONE_BY_ACK;
> +
> +       spin_unlock_irqrestore(&chan->lock, flags);
> +
> +       return chan;
> +}
> +EXPORT_SYMBOL_GPL(pcc_mbox_request_channel);
>
Nothing PCC specific here. All you have done is define a new api just
to pick an element from the array. You simply needed the
mbox_request_channel() let you through to controller.

> +void pcc_mbox_free_channel(struct mbox_chan *chan)
> +{
> +       unsigned long flags;
> +
> +       if (!chan || !chan->cl)
> +               return;
> +
> +       spin_lock_irqsave(&chan->lock, flags);
> +       chan->cl = NULL;
> +       chan->active_req = NULL;
> +       if (chan->txdone_method == (TXDONE_BY_POLL | TXDONE_BY_ACK))
> +               chan->txdone_method = TXDONE_BY_POLL;
> +
> +       spin_unlock_irqrestore(&chan->lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
> +
Ditto, nothing PCC in this new PCC specific api.


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
> +       /* Sync notification from OSPM to Platform. */
> +       acpi_read(&doorbell_val, &doorbell);
> +       acpi_write((doorbell_val & doorbell_preserve) | doorbell_write,
> +                       &doorbell);
> +
> +       return 0;
> +}
> +
> +static struct mbox_chan_ops pcc_chan_ops = {
> +       .send_data = pcc_send_data,
> +       .last_tx_done = pcc_tx_done,
> +};
> +
> +/**
> + * parse_pcc_subspace - Parse the PCC table and extract PCC subspace
> + *             entries. There should be one entry per PCC client.
> + * @header: Pointer to the ACPI subtable header under the PCCT.
> + * @end: End of subtable entry.
> + *
> + * Return: 0 for Success, else errno.
> + *
> + * This gets called for each entry in the PCC table.
> + */
> +static int parse_pcc_subspace(struct acpi_subtable_header *header,
> +               const unsigned long end)
> +{
> +       struct acpi_pcct_hw_reduced *pcct_ss;
> +
> +       if (pcc_mbox_ctrl.num_chans <= MAX_PCC_SUBSPACES) {
> +               pcct_ss = (struct acpi_pcct_hw_reduced *) header;
> +
> +               if (pcct_ss->header.type !=
> +                               ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE) {
> +                       pr_err("Incorrect PCC Subspace type detected\n");
> +                       return -EINVAL;
> +               }
> +
The driver supports only ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE client ?!

-Jassi
