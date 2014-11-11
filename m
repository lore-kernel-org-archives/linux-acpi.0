From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH v10 1/1] Mailbox: Add support for Platform Communication Channel
Date: Tue, 11 Nov 2014 19:27:07 +0530
Message-ID: <CAJe_ZhcJzC1N4pESC-BTe=MXFJuOw2Pj61TaZEOs52QQHULhSg@mail.gmail.com>
References: <CAJ5Y-eYbXT4rfkSXKV+jbAp=LHSZf-CHPyLuPjVdKULixO4PZA@mail.gmail.com>
	<CAJe_ZhcMvQyxZTyD+My23-Bi5pbfybCUhxN6PF3KBt8RtAS2iA@mail.gmail.com>
	<CAJ5Y-eZq7+LsnQSyiJq+rK5ib7uqsJuyx8pJaRXn91ei2aObVA@mail.gmail.com>
	<CAJe_ZhcSTvY=eYx67z=HxQ=VfSYzeKhA3+yhGwvccb208R7UFQ@mail.gmail.com>
	<CAJ5Y-eaXOq0qYYxGvZafFEoYWpuq7b1xh3jMdCQBkYnpqBgFAw@mail.gmail.com>
	<CAJe_Zhd1q=3r6So7XRYuAi9NSQvabpiuLqPiLpReoiFzUjX9QA@mail.gmail.com>
	<CAJ5Y-eZa4zukM4ai3n7Ei86PLaaCoF_w4PqFzAdrojg_rOGdig@mail.gmail.com>
	<CAJe_Zhd5DO=5DoQDOJySTseXG97mCYQZvb=yOR5boPBQ5fLR2w@mail.gmail.com>
	<CAJ5Y-eZhU3wX1bc8NA1ocFj92N=gAvrMOFjcunqPUskLEOOTTA@mail.gmail.com>
	<CAJe_Zhen65HwdyBPcBCjX7uD9BGBesHbQJeHdRmz3Bw2DdB5sw@mail.gmail.com>
	<20141110201310.GQ3815@sirena.org.uk>
	<CAJe_ZhczyNPjohLErcN63xtc-LrS2DY_Zu9yvXt1xAdCazvjGA@mail.gmail.com>
	<CAJ5Y-eaaJW6NMSpt83onjDQ8Gr6GH-DbKg_aKxMcjqT=Hrt1sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:40945 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbaKKN5I (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Nov 2014 08:57:08 -0500
Received: by mail-qc0-f181.google.com with SMTP id w7so7644383qcr.12
        for <linux-acpi@vger.kernel.org>; Tue, 11 Nov 2014 05:57:08 -0800 (PST)
In-Reply-To: <CAJ5Y-eaaJW6NMSpt83onjDQ8Gr6GH-DbKg_aKxMcjqT=Hrt1sw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, "lv.zheng" <lv.zheng@intel.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>, linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>

On 11 November 2014 18:32, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
> On 10 November 2014 23:04, Jassi Brar <jaswinder.singh@linaro.org> wrote:

>
>> I don't mean that by 'bad design'.
>>  Ashwin asked what if a client wants the channel from, say, second
>> instance of PCC instead of first (both are same controllers because
>> they check for same signature).
>
> 2 channels from 2 "different" controllers. e.g. Non-PCC controllers,
> which don't have a "subspace" signature field like PCC does.
>
OK, even that I think I explained already, but here it goes again ...

For Mailbox framework, there already has be some direct understanding
between the client and controller driver. For ex, the controller
defines the format of the payload packet and the client simply
provides the pointer, to payload in SharedMemory, as "data" to mailbox
api to be transmitted. This packet structure will usually be defined
in a header common to client and controller driver.  [I almost feel
embarrassed to repeat this common rant]

 Just like payload format, the 'signature' will also be declared by
controller and used by clients. For PCC controller, we conveniently
use the signature (0x50434300 | Type) defined by the ACPI (we could
chose some other coding as well). Another controller of a different
class will choose a different signature, say (0xdead0000 |
16bitsCode).... much like we take care while defining a new DT binding
that the 'compatible' string doesn't collide with that of another
device.

  Since we don't have DT bindings to map clients onto
controller:channel, the client will have to convey the
controller:channel information itself... which will be 0x50434301 for
HW-Reduced-Comm(type-1) channel of PCC(0x50434300).
 So the responsibility lies with the client to specify correct
signature while requesting a channel. There is nothing to stop a
client from specifying a wrong signature, just like there is nothing
to stop it from executing BUG()

In even simpler terms.... I prefer controller specific
encoding(0x50434300) instead of controller specific api
(pcc_mbox_request_channel).  For a different class of controller, it
is much cleaner to define a new encoding as compared to another
xyz_mbox_request_channel() api.


>>
>>>  From an ACPI point of view the context is the fact
>>> that this is a PCC channel (there's a globally unique namespace for PCC
>>> channels) but Linux wants a struct device for the client to represent
>>> the context with a mapping table of some kind behind that to do the
>>> lookup.
>>>
>>> There's nothing in the ACPI description of the channel or controller to
>>> tie it to the client device, and there's nothing preventing some other
>>> mailbox mechanism that gets added to an ACPI system from reusing similar
>>> names (bear in mind that idiomatic naming for ACPI appears to be three
>>> or four character strings).  If we have a PCC channel "FOO" and some new
>>> mailbox type which also defines "FOO" the controllers aren't really
>>> going to be able to tell them apart just on the string.
>>>
>> ACPI does specify a PCC specific signature (0x50434300) for its
>> channels. Any channel is identified by doing OR of that signature and
>> the index of channel/subspace in the array of 256.
>
> This is true only for PCC. Another class of controllers may not even
> have such a signature. The only thing you can be sure of is that they
> will have the 4 letter table identifier string e.g. PCCT.
>
As I said, the PCC controller driver chooses to use ACPI defined
signature. Likewise a different class controller may take some value
from its specification or simply use random unique value... whatever
suits it.

-Jassi
