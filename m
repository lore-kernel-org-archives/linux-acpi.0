From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [Linaro-acpi] [PATCH v10 1/1] Mailbox: Add support for Platform
 Communication Channel
Date: Tue, 11 Nov 2014 08:18:13 -0500
Message-ID: <CAJ5Y-eZ+q2dHuuWwVjMCcVtXqSwg0o9Zj-kqQS95K40VakwReQ@mail.gmail.com>
References: <1415371964-4451-1-git-send-email-ashwin.chaugule@linaro.org>
	<1415371964-4451-2-git-send-email-ashwin.chaugule@linaro.org>
	<5461E548.2040204@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:52504 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbaKKNSP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Nov 2014 08:18:15 -0500
Received: by mail-wg0-f45.google.com with SMTP id x12so11531370wgg.4
        for <linux-acpi@vger.kernel.org>; Tue, 11 Nov 2014 05:18:13 -0800 (PST)
In-Reply-To: <5461E548.2040204@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>, "arnd@arndb.de" <arnd@arndb.de>, "patches@linaro.org" <patches@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "lv.zheng@intel.com" <lv.zheng@intel.com>

On 11 November 2014 05:30, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On 07/11/14 14:52, Ashwin Chaugule wrote:

>> +config PCC
>> +       bool "Platform Communication Channel Driver"
>> +       depends on ACPI
>
>
> I am bit confused here, though I prefer PCC to depend on ACPI, I have
> seen discussion in this thread about using PCC without ACPI, how will
> that work ?

Been discussed early on. DT users, if at all, will need to come up
with their own DT bindings to make this work.


>> +static struct mbox_chan pcc_mbox_chan[MAX_PCC_SUBSPACES];
>
>
> Really, do you want to allocate 256 structures of mbox_chan even on
> systems with just 1 - 2 channels(typically that would be the case) ?
>

Spec says, max of 256. Easier to support it this way.

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
>
>
> IIUC, the PCCT table has the physical base Address of the shared memory
> range in the PCC subspace structures. Can you use that directly here ?
> Or are you mapping that memory elsewhere and updating the mapped address
> to the table ?

In the client side. Its really owned by the client. pcc_tx_done can
never be called on a channel which doesn't have a mapped base address.

>
>> +       u16 cmd_delay = pcct_ss->min_turnaround_time;
>> +       unsigned int retries = 0;
>> +
>> +       /* Try a few times while waiting for platform to consume */
>> +       while (!(readw_relaxed(&generic_comm_base->status)
>
>
> This will explode if the pcct_ss->base_address is not mapped.

It is. Client side. Called only _after_ client is done with its thing.

>
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
>
>
> In general you can isolate all the access to the shared memory in the
> protocol layer. In that case you might have to use mbox_client_txdone
> instead of this pcc_tx_done.

I dont see the problem in keeping this way though.


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
>> +       /* Write Subspace MAGIC value so platform can identify
>> destination. */
>> +       writel((PCCS_SS_SIG_MAGIC | ss_idx),
>> &generic_comm_base->signature);
>> +
>> +       /* Flip CMD COMPLETE bit */
>> +       writew(0, &generic_comm_base->status);
>> +
>
>
> IMO it's not clean to modify only first 3 elements namely: Signature,
> Command and Status while the Communication Space is updated elsewhere.
> It's better to have all of them in one place if possible as mentioned above.

The access sequence for first 3 elements is the same for each channel.
Thats all the controller is expected to do on behalf of the client. So
this function reduces code duplication in all client sites.

>
>> +       /* Sync notification from OSPM to Platform. */
>> +       acpi_read(&doorbell_val, &doorbell);
>> +       acpi_write((doorbell_val & doorbell_preserve) | doorbell_write,
>> +                       &doorbell);
>> +
>
>
> Only the above 2 must be part of the controller driver, the remaining as
> I mentioned can be move to the protocol/client layer, thoughts ?

I'd really prefer for it to be separate. Once client is done writing,
it calls this and lets the controller driver take over the rest. Its
not racy.


>> +
>> +       count = acpi_table_parse_entries(ACPI_SIG_PCCT,
>> +                       sizeof(struct acpi_table_pcct),
>
>
> s/struct acpi_table_pcct/*pcct_tbl/
>
> In general, the interrupt part of the PCCT SS is not considered in this
> patch. It's better to see/discuss how that can be fit into the mailbox
> framework, though it could be follow up patch.

The IRQ part of the spec seems to be under discussion (single irq per
subspace / common IRQ across all) and as you may be aware we're
working on trying it out on Juno. That'll guide the design. What I
have here is good enough to start off with and has been tested. I dont
think we should have a problem using the mailbox API for asyn tx
though, but I'd really^n prefer if we get something out there first.

Thanks,
Ashwin
