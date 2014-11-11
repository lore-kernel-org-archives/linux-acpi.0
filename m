From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [Linaro-acpi] [PATCH v10 1/1] Mailbox: Add support for Platform
 Communication Channel
Date: Tue, 11 Nov 2014 15:01:28 +0000
Message-ID: <546224C8.7050502@arm.com>
References: <1415371964-4451-1-git-send-email-ashwin.chaugule@linaro.org>	<1415371964-4451-2-git-send-email-ashwin.chaugule@linaro.org>	<5461E548.2040204@arm.com> <CAJ5Y-eZ+q2dHuuWwVjMCcVtXqSwg0o9Zj-kqQS95K40VakwReQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:42363 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbaKKPBL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Nov 2014 10:01:11 -0500
In-Reply-To: <CAJ5Y-eZ+q2dHuuWwVjMCcVtXqSwg0o9Zj-kqQS95K40VakwReQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>, "arnd@arndb.de" <arnd@arndb.de>, "patches@linaro.org" <patches@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "lv.zheng@intel.com" <lv.zheng@intel.com>

Hi Ashwin,

On 11/11/14 13:18, Ashwin Chaugule wrote:
> On 11 November 2014 05:30, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> On 07/11/14 14:52, Ashwin Chaugule wrote:
>
>>> +config PCC
>>> +       bool "Platform Communication Channel Driver"
>>> +       depends on ACPI
>>
>>
>> I am bit confused here, though I prefer PCC to depend on ACPI, I have
>> seen discussion in this thread about using PCC without ACPI, how will
>> that work ?
>
> Been discussed early on. DT users, if at all, will need to come up
> with their own DT bindings to make this work.
>
>

Thanks understood, I had not followed this thread earlier closely, so
asked to get clarified.

>>> +static struct mbox_chan pcc_mbox_chan[MAX_PCC_SUBSPACES];
>>
>>
>> Really, do you want to allocate 256 structures of mbox_chan even on
>> systems with just 1 - 2 channels(typically that would be the case) ?
>>
>
> Spec says, max of 256. Easier to support it this way.
>

I tend to disagree, you can allocate dynamically. And use exactly same
logic you use in get_subspace_id to populate con_priv later. When you
parse PCC Subspace, you can just validate header and not record them in
pcc_mbox_chan. You can get the exact count in acpi_table_parse_entries
and then do the required allocation.

>>> +
>>> +/**
>>> + * pcc_tx_done - Callback from Mailbox controller code to
>>> + *             check if PCC message transmission completed.
>>> + * @chan: Pointer to Mailbox channel on which previous
>>> + *             transmission occurred.
>>> + *
>>> + * Return: TRUE if succeeded.
>>> + */
>>> +static bool pcc_tx_done(struct mbox_chan *chan)
>>> +{
>>> +       struct acpi_pcct_hw_reduced *pcct_ss = chan->con_priv;
>>> +       struct acpi_pcct_shared_memory *generic_comm_base =
>>> +               (struct acpi_pcct_shared_memory *) pcct_ss->base_address;
>>
>>
>> IIUC, the PCCT table has the physical base Address of the shared memory
>> range in the PCC subspace structures. Can you use that directly here ?
>> Or are you mapping that memory elsewhere and updating the mapped address
>> to the table ?
>
> In the client side. Its really owned by the client. pcc_tx_done can
> never be called on a channel which doesn't have a mapped base address.
>

Yes but I don't like the way client has to read pcct_ss, read the
physical address, map it and replace it in the table before it's used
here. That could be issue especially for async notification when the
client is not ready. If all the shared memory access happens in one
place where it get's mapped, we can avoid such issues.

>>
>>> +       u16 cmd_delay = pcct_ss->min_turnaround_time;

I missed this last time, you should not use this here. As per the ACPI
spec, it is minimum amount of time that OSPM must wait after the
completion of a command before issuing the next command. So you need
this at the end of the function. IIUC you need to use nominal latency
instead here.

>>> +       unsigned int retries = 0;
>>> +
>>> +       /* Try a few times while waiting for platform to consume */
>>> +       while (!(readw_relaxed(&generic_comm_base->status)
>>
>>
>> This will explode if the pcct_ss->base_address is not mapped.
>
> It is. Client side. Called only _after_ client is done with its thing.
>

Yes for now, once you add interrupt handling that may not be true as I
mentioned earlier.

>>
>>> +                   & PCC_CMD_COMPLETE)) {
>>> +
>>> +               if (retries++ < 5)
>>> +                       udelay(cmd_delay);
>>> +               else {
>>> +                       /*
>>> +                        * If the remote is dead, this will cause the Mbox
>>> +                        * controller to timeout after mbox client.tx_tout
>>> +                        * msecs.
>>> +                        */
>>> +                       pr_err("PCC platform did not respond.\n");
>>> +                       return false;
>>> +               }
>>> +       }
>>> +       return true;
>>> +}
>>
>>
>> In general you can isolate all the access to the shared memory in the
>> protocol layer. In that case you might have to use mbox_client_txdone
>> instead of this pcc_tx_done.
>
> I dont see the problem in keeping this way though.
>

For the reasons mentioned above, I prefer isolating the access to shared
memory region from the control part(this driver).

>>> +
>>> +/**
>>> + * pcc_send_data - Called from Mailbox Controller code to finally
>>> + *     transmit data over channel.
>>> + * @chan: Pointer to Mailbox channel over which to send data.
>>> + * @data: Actual data to be written over channel.
>>> + *
>>> + * Return: Err if something failed else 0 for success.
>>> + */
>>> +static int pcc_send_data(struct mbox_chan *chan, void *data)
>>> +{
>>> +       struct acpi_pcct_hw_reduced *pcct_ss = chan->con_priv;
>>> +       struct acpi_pcct_shared_memory *generic_comm_base =
>>> +               (struct acpi_pcct_shared_memory *) pcct_ss->base_address;
>>> +       struct acpi_generic_address doorbell;
>>> +       u64 doorbell_preserve;
>>> +       u64 doorbell_val;
>>> +       u64 doorbell_write;
>>> +       u16 cmd = *(u16 *) data;
>>> +       u16 ss_idx = -1;
>>> +
>>> +       ss_idx = get_subspace_id(chan);
>>> +
>>> +       if (ss_idx < 0) {
>>> +               pr_err("Invalid Subspace ID from PCC client\n");
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       doorbell = pcct_ss->doorbell_register;
>>> +       doorbell_preserve = pcct_ss->preserve_mask;
>>> +       doorbell_write = pcct_ss->write_mask;
>>> +
>>> +       /* Write to the shared comm region. */
>>> +       writew(cmd, &generic_comm_base->command);
>>> +
>>> +       /* Write Subspace MAGIC value so platform can identify
>>> destination. */
>>> +       writel((PCCS_SS_SIG_MAGIC | ss_idx),
>>> &generic_comm_base->signature);
>>> +
>>> +       /* Flip CMD COMPLETE bit */
>>> +       writew(0, &generic_comm_base->status);
>>> +
>>
>>
>> IMO it's not clean to modify only first 3 elements namely: Signature,
>> Command and Status while the Communication Space is updated elsewhere.
>> It's better to have all of them in one place if possible as mentioned above.
>
> The access sequence for first 3 elements is the same for each channel.
> Thats all the controller is expected to do on behalf of the client. So
> this function reduces code duplication in all client sites.
>

You can have a helper or a macro to avoid duplication.

>>
>>> +       /* Sync notification from OSPM to Platform. */
>>> +       acpi_read(&doorbell_val, &doorbell);
>>> +       acpi_write((doorbell_val & doorbell_preserve) | doorbell_write,
>>> +                       &doorbell);
>>> +
>>
>>
>> Only the above 2 must be part of the controller driver, the remaining as
>> I mentioned can be move to the protocol/client layer, thoughts ?
>
> I'd really prefer for it to be separate. Once client is done writing,
> it calls this and lets the controller driver take over the rest. Its
> not racy.
>

I think otherwise, so would like to see others' opinion on this :)

>>> +
>>> +       count = acpi_table_parse_entries(ACPI_SIG_PCCT,
>>> +                       sizeof(struct acpi_table_pcct),
>>
>>
>> s/struct acpi_table_pcct/*pcct_tbl/
>>
>> In general, the interrupt part of the PCCT SS is not considered in this
>> patch. It's better to see/discuss how that can be fit into the mailbox
>> framework, though it could be follow up patch.
>
> The IRQ part of the spec seems to be under discussion (single irq per
> subspace / common IRQ across all) and as you may be aware we're
> working on trying it out on Juno. That'll guide the design. What I
> have here is good enough to start off with and has been tested. I dont
> think we should have a problem using the mailbox API for asyn tx
> though, but I'd really^n prefer if we get something out there first.
>

That's the different and still under discussion. But you need to support
Type 1 subspace as it stands in ACPI v5.1

Regards,
Sudeep

