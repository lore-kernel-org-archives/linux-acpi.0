From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH v10 1/1] Mailbox: Add support for Platform Communication Channel
Date: Mon, 10 Nov 2014 23:14:48 +0530
Message-ID: <CAJe_Zhen65HwdyBPcBCjX7uD9BGBesHbQJeHdRmz3Bw2DdB5sw@mail.gmail.com>
References: <1415371964-4451-1-git-send-email-ashwin.chaugule@linaro.org>
	<1415371964-4451-2-git-send-email-ashwin.chaugule@linaro.org>
	<CAJe_ZhcjXD0B9x_dqK8KvpQBUUX7FKZcxGV2MPGjsq2A0DV6Rw@mail.gmail.com>
	<CAJ5Y-eYbXT4rfkSXKV+jbAp=LHSZf-CHPyLuPjVdKULixO4PZA@mail.gmail.com>
	<CAJe_ZhcMvQyxZTyD+My23-Bi5pbfybCUhxN6PF3KBt8RtAS2iA@mail.gmail.com>
	<CAJ5Y-eZq7+LsnQSyiJq+rK5ib7uqsJuyx8pJaRXn91ei2aObVA@mail.gmail.com>
	<CAJe_ZhcSTvY=eYx67z=HxQ=VfSYzeKhA3+yhGwvccb208R7UFQ@mail.gmail.com>
	<CAJ5Y-eaXOq0qYYxGvZafFEoYWpuq7b1xh3jMdCQBkYnpqBgFAw@mail.gmail.com>
	<CAJe_Zhd1q=3r6So7XRYuAi9NSQvabpiuLqPiLpReoiFzUjX9QA@mail.gmail.com>
	<CAJ5Y-eZa4zukM4ai3n7Ei86PLaaCoF_w4PqFzAdrojg_rOGdig@mail.gmail.com>
	<CAJe_Zhd5DO=5DoQDOJySTseXG97mCYQZvb=yOR5boPBQ5fLR2w@mail.gmail.com>
	<CAJ5Y-eZhU3wX1bc8NA1ocFj92N=gAvrMOFjcunqPUskLEOOTTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:65181 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753257AbaKJRot (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Nov 2014 12:44:49 -0500
Received: by mail-qg0-f50.google.com with SMTP id a108so5785355qge.37
        for <linux-acpi@vger.kernel.org>; Mon, 10 Nov 2014 09:44:48 -0800 (PST)
In-Reply-To: <CAJ5Y-eZhU3wX1bc8NA1ocFj92N=gAvrMOFjcunqPUskLEOOTTA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, "lv.zheng" <lv.zheng@intel.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>, linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>

On 10 November 2014 20:17, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
> On 10 November 2014 09:16, Jassi Brar <jaswinder.singh@linaro.org> wrote:
>> On 10 November 2014 19:23, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
>>> On 10 November 2014 08:39, Jassi Brar <jaswinder.singh@linaro.org> wrote:
>>>> On 10 November 2014 18:27, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
>>>>> On 9 November 2014 23:13, Jassi Brar <jaswinder.singh@linaro.org> wrote:
>>>>>>
>>>>>>>>> based on the discussions that followed since, we decided that its best
>>>>>>>>> to add a separate PCC lookup and registration API. The main reason
>>>>>>>>> being, we dont have a way to list all mbox providers in ACPI in a way
>>>>>>>>> that DT does. e.g. in DT, the client->dev is used to look up mbox
>>>>>>>>> controllers. In ACPI, a client cant specify which mbox controllers to
>>>>>>>>> associate with, if it can attach to multiple. With the PCC specific
>>>>>>>>> API, if the client calls it, the controller knows where to look,
>>>>>>>>> because that lookup is PCC specific.
>>>>>>>>>
>>>>>>>>> In your patch, the assumption that PCC is the only ACPI mbox provider,
>>>>>>>>> maybe true today, but that can change anytime.
>>>>>>>>>
>>>>>>>> Please read my patch again, we can have ACPI as well as DT populated
>>>>>>>> clients. All that you intend to do with this patch can be done there
>>>>>>>> and _without_ adding new apis.
>>>>>>>
>>>>>>> Read it again. Not arguing that your patch wont work for DT and ACPI,
>>>>>>> but your assumption that ACPI supports PCC as the only mbox
>>>>>>> controller, may not hold true. The global_xlate function will work
>>>>>>> fine for PCC, but may not work for other ACPI (non-DT) mbox
>>>>>>> controllers. Using the signature field/index byte works only for PCC.
>>>>>>> We've already been through this discussion with Mark and Arnd and we
>>>>>>> came up with the PCC API.
>>>>>>>
>>>>>> Please read it yet again. There is no assumption that PCC is the only
>>>>>> mbox in ACPI (though I think that is very likely). The function and
>>>>>> its argument are both named _global_. 'Signature' is mentioned only as
>>>>>> an example in case of PCC. The PCC controller driver could expect the
>>>>>> global_id to be 'signature' of the subspace, similarly another non-DT
>>>>>> mailbox controller driver will expect its own different 'signature'
>>>>>> (say 0xdead0000 | id_16bits). In the patch I submitted we try
>>>>>> .global_xlate() of all such mboxes and only one, which finds its
>>>>>> id-space specified, will return a channel.
>>>>>>
>>>>>> Ideally, global-id space isn't very clean, but for mailbox we anyway
>>>>>> have to have a direct understanding between controller and client
>>>>>> drivers. So having global IDs is a great tradeoff if we avoid messing
>>>>>> up the api.
>>>>>
>>>>> How is this different than expecting the client to pass a string name
>>>>> of the mbox controller it wants?
>>>>>
>>>> Global-ID is ugly, string matching is uglier. String matching requires
>>>> changes to client and provider structures as opposed to simple
>>>> numerical comparison to find a suitable channel.
>>>
>>> And both have the problem that we cant guarantee uniqueness [1][2].
>>>
>> How? Please give some scenario.
>>
>
> What is there to stop two users from coming up with the same signature
> (0xdeadbeef / "string") for their mbox controllers? Things can break
> at run time, because with your patch, the first mbox controller with
> the duplicate signature/name will return a channel. The client may be
> expecting a channel from the "other" mbox.
>
Two channels with same signature are supposed to be _identical_ i.e,
either channel could serve any client asking for a channel with that
signature. So even if an "unexpected" instance of the channel is
assigned, the client should still be happy.

If a client differentiates between 2 instances of a channel, that's
probably a sign of bad design. The knowledge behind client's
preference of instance should actually lie on the provider(controller)
side. I am open to some example on the contrary.

> Again, the reason is that ACPI does NOT provide a way for client to mbox
> mapping in a way DT does. [1] You were CC'd on that thread.
>
That patch was obviously wrong and outright rejected by Arnd. I didn't
have to object.

> This patch has been under review for ~5months now and has undergone extensive
> review from Mark, Arnd and Lv. We're really going around in circles
> now.
>
You kept me out of CC for the last 9 revisions(~5months). I am not
sure if I am at fault for proposing a better solution at this stage.

BTW, I think Arnd will find I have take care of most(if not all) of
his concerns.

-Jassi
