From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v10 1/1] Mailbox: Add support for Platform Communication Channel
Date: Sun, 9 Nov 2014 10:20:58 -0500
Message-ID: <CAJ5Y-eYbXT4rfkSXKV+jbAp=LHSZf-CHPyLuPjVdKULixO4PZA@mail.gmail.com>
References: <1415371964-4451-1-git-send-email-ashwin.chaugule@linaro.org>
	<1415371964-4451-2-git-send-email-ashwin.chaugule@linaro.org>
	<CAJe_ZhcjXD0B9x_dqK8KvpQBUUX7FKZcxGV2MPGjsq2A0DV6Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:41195 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbaKIPVA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Nov 2014 10:21:00 -0500
Received: by mail-wi0-f169.google.com with SMTP id n3so7996911wiv.0
        for <linux-acpi@vger.kernel.org>; Sun, 09 Nov 2014 07:20:58 -0800 (PST)
In-Reply-To: <CAJe_ZhcjXD0B9x_dqK8KvpQBUUX7FKZcxGV2MPGjsq2A0DV6Rw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, "lv.zheng" <lv.zheng@intel.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>, linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>

Hi Jassi,

On 9 November 2014 08:48, Jassi Brar <jaswinder.singh@linaro.org> wrote:
> On 7 November 2014 20:22, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
>> +
>> +/**
>> + * pcc_mbox_request_channel - PCC clients call this function to
>> + *             request a pointer to their PCC subspace, from which they
>> + *             can get the details of communicating with the remote.
>> + * @cl: Pointer to Mailbox client, so we know where to bind the
>> + *             Channel.
>> + * @index: The PCC Subspace index as parsed in the PCC client
>> + *             ACPI package. This is used to lookup the array of PCC
>> + *             subspaces as parsed by the PCC Mailbox controller.
>> + *
>> + * Return: Pointer to the Mailbox Channel if successful or
>> + *             ERR_PTR.
>> + */
>> +struct mbox_chan *pcc_mbox_request_channel(struct mbox_client *cl,
>> +               int index)
>> +{
>> +       struct device *dev = pcc_mbox_ctrl.dev;
>> +       struct mbox_chan *chan;
>> +       unsigned long flags;
>> +
>> +       /*
>> +        * Each PCC Subspace is a Mailbox Channel.
>> +        * The PCC Clients get their PCC Subspace ID
>> +        * from their own tables and pass it here.
>> +        * This returns a pointer to the PCC subspace
>> +        * for the Client to operate on.
>> +        */
>> +       chan = &pcc_mbox_chan[index];
>> +
>> +       if (!chan || chan->cl) {
>> +               dev_err(dev, "%s: PCC mailbox not free\n", __func__);
>> +               return ERR_PTR(-EBUSY);
>> +       }
>> +
>> +       spin_lock_irqsave(&chan->lock, flags);
>> +       chan->msg_free = 0;
>> +       chan->msg_count = 0;
>> +       chan->active_req = NULL;
>> +       chan->cl = cl;
>> +       init_completion(&chan->tx_complete);
>> +
>> +       if (chan->txdone_method == TXDONE_BY_POLL && cl->knows_txdone)
>> +               chan->txdone_method |= TXDONE_BY_ACK;
>> +
>> +       spin_unlock_irqrestore(&chan->lock, flags);
>> +
>> +       return chan;
>> +}
>> +EXPORT_SYMBOL_GPL(pcc_mbox_request_channel);
>
> I have just sent out a patch https://lkml.org/lkml/2014/11/9/75 and
> kept same people in CC.
> That patch keeps the api same for DT and ACPI drivers.

Thanks for taking a look.

Your patch looks similar in concept to one of my earlier patches. But
based on the discussions that followed since, we decided that its best
to add a separate PCC lookup and registration API. The main reason
being, we dont have a way to list all mbox providers in ACPI in a way
that DT does. e.g. in DT, the client->dev is used to look up mbox
controllers. In ACPI, a client cant specify which mbox controllers to
associate with, if it can attach to multiple. With the PCC specific
API, if the client calls it, the controller knows where to look,
because that lookup is PCC specific.

In your patch, the assumption that PCC is the only ACPI mbox provider,
maybe true today, but that can change anytime.

>
>> +
>> +/**
>> + * pcc_mbox_free_channel - Clients call this to free their Channel.
>> + *
>> + * @chan: Pointer to the mailbox channel as returned by
>> + *             pcc_mbox_request_channel()
>> + */
>> +void pcc_mbox_free_channel(struct mbox_chan *chan)
>> +{
>> +       unsigned long flags;
>> +
>> +       if (!chan || !chan->cl)
>> +               return;
>> +
>> +       spin_lock_irqsave(&chan->lock, flags);
>> +       chan->cl = NULL;
>> +       chan->active_req = NULL;
>> +       if (chan->txdone_method == (TXDONE_BY_POLL | TXDONE_BY_ACK))
>> +               chan->txdone_method = TXDONE_BY_POLL;
>> +
>> +       spin_unlock_irqrestore(&chan->lock, flags);
>> +}
>> +EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
>> +
>> +/**
>> + * pcc_tx_done - Callback from Mailbox controller code to
>> + *             check if PCC message transmission completed.
>> + * @chan: Pointer to Mailbox channel on which previous
>> + *             transmission occurred.
>> + *
>> + * Return: TRUE if succeeded.
>> + */
>> +static bool pcc_tx_done(struct mbox_chan *chan)
>> +{
>> +       struct acpi_pcct_hw_reduced *pcct_ss = chan->con_priv;
>> +       struct acpi_pcct_shared_memory *generic_comm_base =
>> +               (struct acpi_pcct_shared_memory *) pcct_ss->base_address;
>> +       u16 cmd_delay = pcct_ss->min_turnaround_time;
>> +       unsigned int retries = 0;
>> +
>> +       /* Try a few times while waiting for platform to consume */
>> +       while (!(readw_relaxed(&generic_comm_base->status)
>> +                   & PCC_CMD_COMPLETE)) {
>> +
>> +               if (retries++ < 5)
>> +                       udelay(cmd_delay);
>> +               else {
>> +                       /*
>> +                        * If the remote is dead, this will cause the Mbox
>> +                        * controller to timeout after mbox client.tx_tout
>> +                        * msecs.
>> +                        */
>> +                       pr_err("PCC platform did not respond.\n");
>> +                       return false;
>> +               }
>> +       }
>> +       return true;
>> +}
>> +
>> +/**
>> + * get_subspace_id - Given a Mailbox channel, find out the
>> + *             PCC subspace id.
>> + * @chan: Pointer to Mailbox Channel from which we want
>> + *             the index.
>> + * Return: Errno if not found, else positive index number.
>> + */
>> +static int get_subspace_id(struct mbox_chan *chan)
>> +{
>> +       int id = chan - pcc_mbox_chan;
>> +
>> +       if (id < 0 || id > pcc_mbox_ctrl.num_chans)
>> +               return -ENOENT;
>> +
>> +       return id;
>> +}
>> +
>> +/**
>> + * pcc_send_data - Called from Mailbox Controller code to finally
>> + *     transmit data over channel.
>> + * @chan: Pointer to Mailbox channel over which to send data.
>> + * @data: Actual data to be written over channel.
>> + *
>> + * Return: Err if something failed else 0 for success.
>> + */
>> +static int pcc_send_data(struct mbox_chan *chan, void *data)
>> +{
>> +       struct acpi_pcct_hw_reduced *pcct_ss = chan->con_priv;
>> +       struct acpi_pcct_shared_memory *generic_comm_base =
>> +               (struct acpi_pcct_shared_memory *) pcct_ss->base_address;
>> +       struct acpi_generic_address doorbell;
>> +       u64 doorbell_preserve;
>> +       u64 doorbell_val;
>> +       u64 doorbell_write;
>> +       u16 cmd = *(u16 *) data;
>> +       u16 ss_idx = -1;
>> +
>> +       ss_idx = get_subspace_id(chan);
>> +
>> +       if (ss_idx < 0) {
>> +               pr_err("Invalid Subspace ID from PCC client\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       doorbell = pcct_ss->doorbell_register;
>> +       doorbell_preserve = pcct_ss->preserve_mask;
>> +       doorbell_write = pcct_ss->write_mask;
>> +
>> +       /* Write to the shared comm region. */
>> +       writew(cmd, &generic_comm_base->command);
>> +
>> +       /* Write Subspace MAGIC value so platform can identify destination. */
>> +       writel((PCCS_SS_SIG_MAGIC | ss_idx), &generic_comm_base->signature);
>> +
>> +       /* Flip CMD COMPLETE bit */
>> +       writew(0, &generic_comm_base->status);
>> +
>> +       /* Sync notification from OSPM to Platform. */
>> +       acpi_read(&doorbell_val, &doorbell);
>> +       acpi_write((doorbell_val & doorbell_preserve) | doorbell_write,
>> +                       &doorbell);
>> +
>> +       return 0;
>> +}
>> +
>> +static struct mbox_chan_ops pcc_chan_ops = {
>> +       .send_data = pcc_send_data,
>> +       .last_tx_done = pcc_tx_done,
>> +};
>> +
>> +/**
>> + * parse_pcc_subspace - Parse the PCC table and extract PCC subspace
>> + *             entries. There should be one entry per PCC client.
>> + * @header: Pointer to the ACPI subtable header under the PCCT.
>> + * @end: End of subtable entry.
>> + *
>> + * Return: 0 for Success, else errno.
>> + *
>> + * This gets called for each entry in the PCC table.
>> + */
>> +static int parse_pcc_subspace(struct acpi_subtable_header *header,
>> +               const unsigned long end)
>> +{
>> +       struct acpi_pcct_hw_reduced *pcct_ss;
>> +
>> +       if (pcc_mbox_ctrl.num_chans <= MAX_PCC_SUBSPACES) {
>> +               pcct_ss = (struct acpi_pcct_hw_reduced *) header;
>> +
>> +               if (pcct_ss->header.type !=
>> +                               ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE) {
>> +                       pr_err("Incorrect PCC Subspace type detected\n");
>> +                       return -EINVAL;
>> +               }
>> +
>> +               /* New mbox channel entry for each PCC subspace detected. */
>> +               pcc_mbox_chan[pcc_mbox_ctrl.num_chans].con_priv = pcct_ss;
>> +               pcc_mbox_ctrl.num_chans++;
>> +
>> +       } else {
>> +               pr_err("No more space for PCC subspaces.\n");
>> +               return -ENOSPC;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +/**
>> + * acpi_pcc_probe - Parse the ACPI tree for the PCCT.
>> + *
>> + * Return: 0 for Success, else errno.
>> + */
>> +static int __init acpi_pcc_probe(void)
>> +{
>> +       acpi_status status = AE_OK;
>> +       acpi_size pcct_tbl_header_size;
>> +       int count;
>> +       struct acpi_table_pcct *pcct_tbl;
>> +
>> +       /* Search for PCCT */
>> +       status = acpi_get_table_with_size(ACPI_SIG_PCCT, 0,
>> +                       (struct acpi_table_header **)&pcct_tbl,
>> +                       &pcct_tbl_header_size);
>> +
>> +       if (ACPI_FAILURE(status) || !pcct_tbl) {
>> +               pr_warn("PCCT header not found.\n");
>> +               return -ENODEV;
>> +       }
>> +
>> +       count = acpi_table_parse_entries(ACPI_SIG_PCCT,
>> +                       sizeof(struct acpi_table_pcct),
>> +                       ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE,
>> +                       parse_pcc_subspace, MAX_PCC_SUBSPACES);
>> +
>> +       if (count <= 0) {
>> +               pr_err("Error parsing PCC subspaces from PCCT\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       pr_info("Detected %d PCC Subspaces\n", pcc_mbox_ctrl.num_chans);
>> +
>> +       return 0;
>> +}
>> +
>> +/**
>> + * pcc_mbox_probe - Called when we find a match for the
>> + *     PCCT platform device. This is purely used to represent
>> + *     the PCCT as a virtual device for registering with the
>> + *     generic Mailbox framework.
>> + *
>> + * @pdev: Pointer to platform device returned when a match
>> + *     is found.
>> + *
>> + *     Return: 0 for Success, else errno.
>> + */
>> +static int pcc_mbox_probe(struct platform_device *pdev)
>> +{
>> +       int ret = 0;
>> +
>> +       pcc_mbox_ctrl.chans = pcc_mbox_chan;
>> +       pcc_mbox_ctrl.ops = &pcc_chan_ops;
>> +       pcc_mbox_ctrl.txdone_poll = true;
>> +       pcc_mbox_ctrl.txpoll_period = 10;
>> +       pcc_mbox_ctrl.dev = &pdev->dev;
>> +
>> +       pr_info("Registering PCC driver as Mailbox controller\n");
>> +       ret = mbox_controller_register(&pcc_mbox_ctrl);
>> +
>> +       if (ret) {
>> +               pr_err("Err registering PCC as Mailbox controller: %d\n", ret);
>> +               ret = -ENODEV;
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>> +struct platform_driver pcc_mbox_driver = {
>> +       .probe = pcc_mbox_probe,
>> +       .driver = {
>> +               .name = "PCCT",
>> +               .owner = THIS_MODULE,
>> +       },
>> +};
>> +
>> +static int __init pcc_init(void)
>> +{
>> +       int ret;
>> +       struct platform_device *pcc_pdev;
>> +
>> +       if (acpi_disabled)
>> +               return -ENODEV;
>> +
>> +       /* Check if PCC support is available. */
>> +       ret = acpi_pcc_probe();
>> +
>> +       if (ret) {
>> +               pr_err("ACPI PCC probe failed.\n");
>> +               return -ENODEV;
>> +       }
>> +
>> +       pcc_pdev = platform_create_bundle(&pcc_mbox_driver,
>> +                       pcc_mbox_probe, NULL, 0, NULL, 0);
>> +
>> +       if (!pcc_pdev) {
>> +               pr_err("Err creating PCC platform bundle\n");
>> +               return -ENODEV;
>> +       }
>> +
>> +       return 0;
>> +}
>> +device_initcall(pcc_init);
>>
> IMO the PCC platform_device should be populated by ACPI or DT core.
> This PCC controller driver should parse the PCCT ... so it populates
> .global_xlate() which expect the 'global_id' of channel requested to
> be (0x50434300 | Client_Class_Code) as specified by ACPI.
>
> It should be possible to have same client and controller driver work
> for both ACPI and DT.

Any reason why this patch won't work with DT as well? (with the
requisite DT bindings)

Thanks,
Ashwin
