From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v10 1/1] Mailbox: Add support for Platform Communication Channel
Date: Mon, 10 Nov 2014 07:57:14 -0500
Message-ID: <CAJ5Y-eaXOq0qYYxGvZafFEoYWpuq7b1xh3jMdCQBkYnpqBgFAw@mail.gmail.com>
References: <1415371964-4451-1-git-send-email-ashwin.chaugule@linaro.org>
	<1415371964-4451-2-git-send-email-ashwin.chaugule@linaro.org>
	<CAJe_ZhcjXD0B9x_dqK8KvpQBUUX7FKZcxGV2MPGjsq2A0DV6Rw@mail.gmail.com>
	<CAJ5Y-eYbXT4rfkSXKV+jbAp=LHSZf-CHPyLuPjVdKULixO4PZA@mail.gmail.com>
	<CAJe_ZhcMvQyxZTyD+My23-Bi5pbfybCUhxN6PF3KBt8RtAS2iA@mail.gmail.com>
	<CAJ5Y-eZq7+LsnQSyiJq+rK5ib7uqsJuyx8pJaRXn91ei2aObVA@mail.gmail.com>
	<CAJe_ZhcSTvY=eYx67z=HxQ=VfSYzeKhA3+yhGwvccb208R7UFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:63074 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815AbaKJM5Q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Nov 2014 07:57:16 -0500
Received: by mail-wg0-f41.google.com with SMTP id k14so8690913wgh.14
        for <linux-acpi@vger.kernel.org>; Mon, 10 Nov 2014 04:57:15 -0800 (PST)
In-Reply-To: <CAJe_ZhcSTvY=eYx67z=HxQ=VfSYzeKhA3+yhGwvccb208R7UFQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, "lv.zheng" <lv.zheng@intel.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>, linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>

On 9 November 2014 23:13, Jassi Brar <jaswinder.singh@linaro.org> wrote:
> On 9 November 2014 22:52, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
>> On 9 November 2014 11:18, Jassi Brar <jaswinder.singh@linaro.org> wrote:
>>> On 9 November 2014 20:50, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
>>>> Hi Jassi,
>>>>
>>>> On 9 November 2014 08:48, Jassi Brar <jaswinder.singh@linaro.org> wrote:
>>>>> On 7 November 2014 20:22, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
>>>>>> +
>>>>>> +/**
>>>>>> + * pcc_mbox_request_channel - PCC clients call this function to
>>>>>> + *             request a pointer to their PCC subspace, from which they
>>>>>> + *             can get the details of communicating with the remote.
>>>>>> + * @cl: Pointer to Mailbox client, so we know where to bind the
>>>>>> + *             Channel.
>>>>>> + * @index: The PCC Subspace index as parsed in the PCC client
>>>>>> + *             ACPI package. This is used to lookup the array of PCC
>>>>>> + *             subspaces as parsed by the PCC Mailbox controller.
>>>>>> + *
>>>>>> + * Return: Pointer to the Mailbox Channel if successful or
>>>>>> + *             ERR_PTR.
>>>>>> + */
>>>>>> +struct mbox_chan *pcc_mbox_request_channel(struct mbox_client *cl,
>>>>>> +               int index)
>>>>>> +{
>>>>>> +       struct device *dev = pcc_mbox_ctrl.dev;
>>>>>> +       struct mbox_chan *chan;
>>>>>> +       unsigned long flags;
>>>>>> +
>>>>>> +       /*
>>>>>> +        * Each PCC Subspace is a Mailbox Channel.
>>>>>> +        * The PCC Clients get their PCC Subspace ID
>>>>>> +        * from their own tables and pass it here.
>>>>>> +        * This returns a pointer to the PCC subspace
>>>>>> +        * for the Client to operate on.
>>>>>> +        */
>>>>>> +       chan = &pcc_mbox_chan[index];
>>>>>> +
>>>>>> +       if (!chan || chan->cl) {
>>>>>> +               dev_err(dev, "%s: PCC mailbox not free\n", __func__);
>>>>>> +               return ERR_PTR(-EBUSY);
>>>>>> +       }
>>>>>> +
>>>>>> +       spin_lock_irqsave(&chan->lock, flags);
>>>>>> +       chan->msg_free = 0;
>>>>>> +       chan->msg_count = 0;
>>>>>> +       chan->active_req = NULL;
>>>>>> +       chan->cl = cl;
>>>>>> +       init_completion(&chan->tx_complete);
>>>>>> +
>>>>>> +       if (chan->txdone_method == TXDONE_BY_POLL && cl->knows_txdone)
>>>>>> +               chan->txdone_method |= TXDONE_BY_ACK;
>>>>>> +
>>>>>> +       spin_unlock_irqrestore(&chan->lock, flags);
>>>>>> +
>>>>>> +       return chan;
>>>>>> +}
>>>>>> +EXPORT_SYMBOL_GPL(pcc_mbox_request_channel);
>>>>>
>>>>> I have just sent out a patch https://lkml.org/lkml/2014/11/9/75 and
>>>>> kept same people in CC.
>>>>> That patch keeps the api same for DT and ACPI drivers.
>>>>
>>>> Thanks for taking a look.
>>>>
>>>> Your patch looks similar in concept to one of my earlier patches. But
>>>>
>>> Using ifdefs wasn't the right way to enable ACPI channel mapping. The
>>> mailbox core should be able to work with both DT and ACPI at the same
>>> time.
>>
>> Agreed. But my point there was to add an alternative to the DT
>> specific of_xlate, which is exactly what you've done in global_xlate.
>>
> We all have good intentions, the problem is the code :)
>
>>>> based on the discussions that followed since, we decided that its best
>>>> to add a separate PCC lookup and registration API. The main reason
>>>> being, we dont have a way to list all mbox providers in ACPI in a way
>>>> that DT does. e.g. in DT, the client->dev is used to look up mbox
>>>> controllers. In ACPI, a client cant specify which mbox controllers to
>>>> associate with, if it can attach to multiple. With the PCC specific
>>>> API, if the client calls it, the controller knows where to look,
>>>> because that lookup is PCC specific.
>>>>
>>>> In your patch, the assumption that PCC is the only ACPI mbox provider,
>>>> maybe true today, but that can change anytime.
>>>>
>>> Please read my patch again, we can have ACPI as well as DT populated
>>> clients. All that you intend to do with this patch can be done there
>>> and _without_ adding new apis.
>>
>> Read it again. Not arguing that your patch wont work for DT and ACPI,
>> but your assumption that ACPI supports PCC as the only mbox
>> controller, may not hold true. The global_xlate function will work
>> fine for PCC, but may not work for other ACPI (non-DT) mbox
>> controllers. Using the signature field/index byte works only for PCC.
>> We've already been through this discussion with Mark and Arnd and we
>> came up with the PCC API.
>>
> Please read it yet again. There is no assumption that PCC is the only
> mbox in ACPI (though I think that is very likely). The function and
> its argument are both named _global_. 'Signature' is mentioned only as
> an example in case of PCC. The PCC controller driver could expect the
> global_id to be 'signature' of the subspace, similarly another non-DT
> mailbox controller driver will expect its own different 'signature'
> (say 0xdead0000 | id_16bits). In the patch I submitted we try
> .global_xlate() of all such mboxes and only one, which finds its
> id-space specified, will return a channel.
>
> Ideally, global-id space isn't very clean, but for mailbox we anyway
> have to have a direct understanding between controller and client
> drivers. So having global IDs is a great tradeoff if we avoid messing
> up the api.

How is this different than expecting the client to pass a string name
of the mbox controller it wants?

Ashwin
