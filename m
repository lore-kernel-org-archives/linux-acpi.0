From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v10 1/1] Mailbox: Add support for Platform Communication Channel
Date: Mon, 10 Nov 2014 09:47:44 -0500
Message-ID: <CAJ5Y-eZhU3wX1bc8NA1ocFj92N=gAvrMOFjcunqPUskLEOOTTA@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:39948 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856AbaKJOrq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Nov 2014 09:47:46 -0500
Received: by mail-wg0-f50.google.com with SMTP id z12so9019968wgg.37
        for <linux-acpi@vger.kernel.org>; Mon, 10 Nov 2014 06:47:44 -0800 (PST)
In-Reply-To: <CAJe_Zhd5DO=5DoQDOJySTseXG97mCYQZvb=yOR5boPBQ5fLR2w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, "lv.zheng" <lv.zheng@intel.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>, linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>

On 10 November 2014 09:16, Jassi Brar <jaswinder.singh@linaro.org> wrote:
> On 10 November 2014 19:23, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
>> On 10 November 2014 08:39, Jassi Brar <jaswinder.singh@linaro.org> wrote:
>>> On 10 November 2014 18:27, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
>>>> On 9 November 2014 23:13, Jassi Brar <jaswinder.singh@linaro.org> wrote:
>>>>>
>>>>>>>> based on the discussions that followed since, we decided that its best
>>>>>>>> to add a separate PCC lookup and registration API. The main reason
>>>>>>>> being, we dont have a way to list all mbox providers in ACPI in a way
>>>>>>>> that DT does. e.g. in DT, the client->dev is used to look up mbox
>>>>>>>> controllers. In ACPI, a client cant specify which mbox controllers to
>>>>>>>> associate with, if it can attach to multiple. With the PCC specific
>>>>>>>> API, if the client calls it, the controller knows where to look,
>>>>>>>> because that lookup is PCC specific.
>>>>>>>>
>>>>>>>> In your patch, the assumption that PCC is the only ACPI mbox provider,
>>>>>>>> maybe true today, but that can change anytime.
>>>>>>>>
>>>>>>> Please read my patch again, we can have ACPI as well as DT populated
>>>>>>> clients. All that you intend to do with this patch can be done there
>>>>>>> and _without_ adding new apis.
>>>>>>
>>>>>> Read it again. Not arguing that your patch wont work for DT and ACPI,
>>>>>> but your assumption that ACPI supports PCC as the only mbox
>>>>>> controller, may not hold true. The global_xlate function will work
>>>>>> fine for PCC, but may not work for other ACPI (non-DT) mbox
>>>>>> controllers. Using the signature field/index byte works only for PCC.
>>>>>> We've already been through this discussion with Mark and Arnd and we
>>>>>> came up with the PCC API.
>>>>>>
>>>>> Please read it yet again. There is no assumption that PCC is the only
>>>>> mbox in ACPI (though I think that is very likely). The function and
>>>>> its argument are both named _global_. 'Signature' is mentioned only as
>>>>> an example in case of PCC. The PCC controller driver could expect the
>>>>> global_id to be 'signature' of the subspace, similarly another non-DT
>>>>> mailbox controller driver will expect its own different 'signature'
>>>>> (say 0xdead0000 | id_16bits). In the patch I submitted we try
>>>>> .global_xlate() of all such mboxes and only one, which finds its
>>>>> id-space specified, will return a channel.
>>>>>
>>>>> Ideally, global-id space isn't very clean, but for mailbox we anyway
>>>>> have to have a direct understanding between controller and client
>>>>> drivers. So having global IDs is a great tradeoff if we avoid messing
>>>>> up the api.
>>>>
>>>> How is this different than expecting the client to pass a string name
>>>> of the mbox controller it wants?
>>>>
>>> Global-ID is ugly, string matching is uglier. String matching requires
>>> changes to client and provider structures as opposed to simple
>>> numerical comparison to find a suitable channel.
>>
>> And both have the problem that we cant guarantee uniqueness [1][2].
>>
> How? Please give some scenario.
>

What is there to stop two users from coming up with the same signature
(0xdeadbeef / "string") for their mbox controllers? Things can break
at run time, because with your patch, the first mbox controller with
the duplicate signature/name will return a channel. The client may be
expecting a channel from the "other" mbox.

>> Having a separate API solves this problem.
>>
> NO.
> You add new api for PCC. If another non-DT provider appears (another
> instance of PCC or some new non-DT non-PCC mbox device) .... do you
> plan add yet another api?

Yes. Unfortunately thats the only way as Arnd suggested [1]. Again,
the reason is that ACPI does NOT provide a way for client to mbox
mapping in a way DT does. [1] You were CC'd on that thread. This patch
has been under review for ~5months now and has undergone extensive
review from Mark, Arnd and Lv. We're really going around in circles
now.

>  By the way, your patch in this thread can't even cope with 2
> instances of PCC (assuming that's possible as you think).

It was never meant to be. There are no two instances of PCC. But there
could be another mbox provider(non-PCC) in ACPI in the future. Arnd
was guessing something to appear from the newer Intel designs.[2]

Ashwin

[1] - http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/265395.html

Please read the part where Arnd suggests the following:

"If you require drivers to put global data (e.g. the mbox->name, or the channel
number) in there, it's impossible to write a driver that works on
both DT and ACPI. If you want to use the mbox_request_channel()
interface from a driver, you need some form of lookup table in
the ACPI data to do the conversion."

[2] - https://patches.linaro.org/32299/

Please read the very first comments.

"It's mostly a matter of consistency: We can have multiple interrupt
controllers, pin controllers, clock controllers, dma engines, etc, and
in the DT case we use references to the nodes wherever we have other
devices referring to a mailbox name. I believe Intel's embedded chips
are moving in the same direction with their ACPI support. If the ACPI
spec gains support for mailbox devices, locking them into having only
a single device may be a problem later for them."
