From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v5 1/2] Mailbox: Add support for Platform Communication Channel
Date: Thu, 4 Sep 2014 10:48:00 -0400
Message-ID: <CAJ5Y-eaBMX_YGxL69AwKdq3y5n+XFsbD2J7AfHq197ST6AgCjQ@mail.gmail.com>
References: <1409782760-3958-1-git-send-email-ashwin.chaugule@linaro.org>
	<1409782760-3958-2-git-send-email-ashwin.chaugule@linaro.org>
	<5470309.KpxVtJyk9p@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:50831 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbaIDOsG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Sep 2014 10:48:06 -0400
Received: by mail-wg0-f52.google.com with SMTP id m15so10205829wgh.35
        for <linux-acpi@vger.kernel.org>; Thu, 04 Sep 2014 07:48:01 -0700 (PDT)
In-Reply-To: <5470309.KpxVtJyk9p@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux acpi <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Brown <broonie@kernel.org>

Hi Arnd,

On 4 September 2014 04:56, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 03 September 2014 18:19:19 Ashwin Chaugule wrote:
>> ACPI 5.0+ spec defines a generic mode of communication
>> between the OS and a platform such as the BMC. This medium
>> (PCC) is typically used by CPPC (ACPI CPU Performance management),
>> RAS (ACPI reliability protocol) and MPST (ACPI Memory power
>> states).
>
> Ok, the interaction with the mailbox subsystem looks much nicer now!

Cool. Thanks for the help!

>
> Some comments on the actual driver:
>
>> +struct mbox_chan *pcc_mbox_request_channel(struct mbox_client *cl,
>> +             int index)
>> +{
>> +     struct device *dev = pcc_mbox_ctrl.dev;
>> +     struct mbox_chan *chan;
>> +     unsigned long flags;
>> +
>> +     /*
>> +      * Each PCC Subspace is a Mailbox Channel.
>> +      * The PCC Clients get their PCC Subspace ID
>> +      * from their own tables and pass it here.
>> +      * This returns a pointer to the PCC subspace
>> +      * for the Client to operate on.
>> +      */
>> +     chan = &pcc_mbox_chan[index];
>> +
>> +     if (!chan || chan->cl || !try_module_get(dev->driver->owner)) {
>> +             dev_err(dev, "%s: PCC mailbox not free\n", __func__);
>> +             return ERR_PTR(-EBUSY);
>> +     }
>
> The try_module_get is now pointless, since dev->driver->owner is
> the current module.

:) Yea, it occurred to me as well, but I wasn't too sure.

>
>> +static int get_subspace_id(struct mbox_chan *chan)
>> +{
>> +     unsigned int i;
>> +
>> +     for (i = 0; i < pcc_mbox_ctrl.num_chans; i++) {
>> +             if (chan == &pcc_mbox_chan[i])
>> +                     return i;
>> +     }
>> +
>> +     return -ENOENT;
>> +}
>
> Isn't this the same as this?
>
>         int id = chan - pcc_mbox_chan;
>         if (id < 0 || id > pcc_mbox_ctrl.num_chans
>                 return -ENOENT;
>         return id;

Seems better.

>
>> +/* Channel lock is already held by mbox controller code. */
>> +static int pcc_send_data(struct mbox_chan *chan, void *data)
>> +{
>> +     struct acpi_pcct_subspace *pcct_ss = chan->con_priv;
>> +     struct acpi_pcct_shared_memory *generic_comm_base =
>> +             (struct acpi_pcct_shared_memory *) pcct_ss->base_address;
>> +     struct acpi_generic_address doorbell;
>> +     u64 doorbell_preserve;
>> +     u64 doorbell_val;
>> +     u64 doorbell_write;
>> +     u16 cmd = 0;
>> +     u16 ss_idx = -1;
>> +     int ret = 0;
>> +
>> +     /* Get PCC CMD */
>> +     ret = kstrtou16((char*)data, 0, &cmd);
>
> What is this supposed to do? Why would a client pass data as a string?
> Just make it a u16 pointer and force the client to do the conversion
> so you have a proper format.
>
> Mailbox drivers should generally have a fixed-format mailbox data pointer.
>

Ok.

>> +     /* Write to the shared comm region. */
>> +     iowrite16(cmd, &generic_comm_base->command);
>> +
>> +     /* Write Subspace MAGIC value so platform can identify destination. */
>> +     iowrite32((PCCS_SS_SIG_MAGIC | ss_idx), &generic_comm_base->signature);
>> +
>> +     /* Flip CMD COMPLETE bit */
>> +     iowrite16(0, &generic_comm_base->status);
>
> using writel_relaxed/writew_relaxed should be more efficient here.
>

Ok.

>> + * Create a virtual device to back the PCCT, so
>> + * that the generic Mailbox framework can do its
>> + * ref counting.
>> + */
>> +struct platform_device pcc_pdev = {
>> +     .name = "PCCT",
>> +};
>
> Don't declare platform devices statically in C code, just
> use platform_create_bundle() here to create the device dynamically
> and bind it to the driver. That will also simplify the driver
> initalization.
>

Nice. Didn't know about this.

>> diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
>> index 9ee195b..956cc06 100644
>> --- a/include/linux/mailbox_controller.h
>> +++ b/include/linux/mailbox_controller.h
>> @@ -15,6 +15,10 @@
>>
>>  struct mbox_chan;
>>
>> +#define TXDONE_BY_IRQ        BIT(0) /* controller has remote RTR irq */
>> +#define TXDONE_BY_POLL       BIT(1) /* controller can read status of last TX */
>> +#define TXDONE_BY_ACK        BIT(2) /* S/W ACK recevied by Client ticks the TX */
>> +
>>  /**
>>   * struct mbox_chan_ops - methods to control mailbox channels
>>   * @send_data:       The API asks the MBOX controller driver, in atomic
>>
>
> I don't think we want these in a global header file. Better put them in
> a local header file in drivers/mailbox/.
>

Ok.

Thanks,
Ashwin
