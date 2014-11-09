From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH v10 1/1] Mailbox: Add support for Platform Communication Channel
Date: Sun, 9 Nov 2014 21:48:52 +0530
Message-ID: <CAJe_ZhcMvQyxZTyD+My23-Bi5pbfybCUhxN6PF3KBt8RtAS2iA@mail.gmail.com>
References: <1415371964-4451-1-git-send-email-ashwin.chaugule@linaro.org>
	<1415371964-4451-2-git-send-email-ashwin.chaugule@linaro.org>
	<CAJe_ZhcjXD0B9x_dqK8KvpQBUUX7FKZcxGV2MPGjsq2A0DV6Rw@mail.gmail.com>
	<CAJ5Y-eYbXT4rfkSXKV+jbAp=LHSZf-CHPyLuPjVdKULixO4PZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:48742 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbaKIQSx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Nov 2014 11:18:53 -0500
Received: by mail-qg0-f53.google.com with SMTP id z107so4548177qgd.12
        for <linux-acpi@vger.kernel.org>; Sun, 09 Nov 2014 08:18:52 -0800 (PST)
In-Reply-To: <CAJ5Y-eYbXT4rfkSXKV+jbAp=LHSZf-CHPyLuPjVdKULixO4PZA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, "lv.zheng" <lv.zheng@intel.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>, linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>

On 9 November 2014 20:50, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
> Hi Jassi,
>
> On 9 November 2014 08:48, Jassi Brar <jaswinder.singh@linaro.org> wrote:
>> On 7 November 2014 20:22, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
>>> +
>>> +/**
>>> + * pcc_mbox_request_channel - PCC clients call this function to
>>> + *             request a pointer to their PCC subspace, from which they
>>> + *             can get the details of communicating with the remote.
>>> + * @cl: Pointer to Mailbox client, so we know where to bind the
>>> + *             Channel.
>>> + * @index: The PCC Subspace index as parsed in the PCC client
>>> + *             ACPI package. This is used to lookup the array of PCC
>>> + *             subspaces as parsed by the PCC Mailbox controller.
>>> + *
>>> + * Return: Pointer to the Mailbox Channel if successful or
>>> + *             ERR_PTR.
>>> + */
>>> +struct mbox_chan *pcc_mbox_request_channel(struct mbox_client *cl,
>>> +               int index)
>>> +{
>>> +       struct device *dev = pcc_mbox_ctrl.dev;
>>> +       struct mbox_chan *chan;
>>> +       unsigned long flags;
>>> +
>>> +       /*
>>> +        * Each PCC Subspace is a Mailbox Channel.
>>> +        * The PCC Clients get their PCC Subspace ID
>>> +        * from their own tables and pass it here.
>>> +        * This returns a pointer to the PCC subspace
>>> +        * for the Client to operate on.
>>> +        */
>>> +       chan = &pcc_mbox_chan[index];
>>> +
>>> +       if (!chan || chan->cl) {
>>> +               dev_err(dev, "%s: PCC mailbox not free\n", __func__);
>>> +               return ERR_PTR(-EBUSY);
>>> +       }
>>> +
>>> +       spin_lock_irqsave(&chan->lock, flags);
>>> +       chan->msg_free = 0;
>>> +       chan->msg_count = 0;
>>> +       chan->active_req = NULL;
>>> +       chan->cl = cl;
>>> +       init_completion(&chan->tx_complete);
>>> +
>>> +       if (chan->txdone_method == TXDONE_BY_POLL && cl->knows_txdone)
>>> +               chan->txdone_method |= TXDONE_BY_ACK;
>>> +
>>> +       spin_unlock_irqrestore(&chan->lock, flags);
>>> +
>>> +       return chan;
>>> +}
>>> +EXPORT_SYMBOL_GPL(pcc_mbox_request_channel);
>>
>> I have just sent out a patch https://lkml.org/lkml/2014/11/9/75 and
>> kept same people in CC.
>> That patch keeps the api same for DT and ACPI drivers.
>
> Thanks for taking a look.
>
> Your patch looks similar in concept to one of my earlier patches. But
>
Using ifdefs wasn't the right way to enable ACPI channel mapping. The
mailbox core should be able to work with both DT and ACPI at the same
time.

> based on the discussions that followed since, we decided that its best
> to add a separate PCC lookup and registration API. The main reason
> being, we dont have a way to list all mbox providers in ACPI in a way
> that DT does. e.g. in DT, the client->dev is used to look up mbox
> controllers. In ACPI, a client cant specify which mbox controllers to
> associate with, if it can attach to multiple. With the PCC specific
> API, if the client calls it, the controller knows where to look,
> because that lookup is PCC specific.
>
> In your patch, the assumption that PCC is the only ACPI mbox provider,
> maybe true today, but that can change anytime.
>
Please read my patch again, we can have ACPI as well as DT populated
clients. All that you intend to do with this patch can be done there
and _without_ adding new apis.

>>> +
>>> +       pcc_pdev = platform_create_bundle(&pcc_mbox_driver,
>>> +                       pcc_mbox_probe, NULL, 0, NULL, 0);
>>> +
>>> +       if (!pcc_pdev) {
>>> +               pr_err("Err creating PCC platform bundle\n");
>>> +               return -ENODEV;
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>> +device_initcall(pcc_init);
>>>
>> IMO the PCC platform_device should be populated by ACPI or DT core.
>> This PCC controller driver should parse the PCCT ... so it populates
>> .global_xlate() which expect the 'global_id' of channel requested to
>> be (0x50434300 | Client_Class_Code) as specified by ACPI.
>>
>> It should be possible to have same client and controller driver work
>> for both ACPI and DT.
>
> Any reason why this patch won't work with DT as well? (with the
> requisite DT bindings)
>
A PCC client would need to call pcc_mbox_request_channel() if
populated by ACPI, and mbox_request_channel() if by DT. We want any
client driver to call just mbox_request_channel()

-Jassi
