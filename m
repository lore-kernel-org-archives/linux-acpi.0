From: "Eric Benton" <benton71@gmail.com>
Subject: Re: How ACPI is actually implemented?
Date: Mon, 27 Nov 2006 15:21:54 +0200
Message-ID: <29545330611270521l1e9f8bfdk6b513e874e2e560b@mail.gmail.com>
References: <29545330611270227y4200182bkc9dfffbc62ab8d65@mail.gmail.com>
	 <200611271107.kARB7INK020485@sana.init-main.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:59548 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1758193AbWK0NVz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Nov 2006 08:21:55 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1127845uga
        for <linux-acpi@vger.kernel.org>; Mon, 27 Nov 2006 05:21:54 -0800 (PST)
In-Reply-To: <200611271107.kARB7INK020485@sana.init-main.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Takanori Watanabe <takawata@init-main.com>
Cc: linux-acpi@vger.kernel.org

On 11/27/06, Takanori Watanabe <takawata@init-main.com> wrote:
> In message <29545330611270227y4200182bkc9dfffbc62ab8d65@mail.gmail.com>, "Eric
> Benton" wrote:
> >Yeah, ok ;-)
> >Can you please describe the process of what happens when you decide to
> >switch the graphic adapter's screen? This is a bit complicated
> >example, but it will really help me understanding. For example, In a
> >Laptop, when you decide to switch from the LCD to an external VGA
> >screen?
> >It starts by a software request... I know all the handlers are defined
> >in the dsdt but, a description of the process (the handlers
> >registering + what events are being caused by software/hardware and
> >how is the hardware is related to the story) will help me finally
> >comprehend this...
>
> It's not always true. If your laptop supports video card output switching,
> it is not always implemented in AML. It should be implemented by video card's
> driver, not AML bytecode. But some laptops has BIOS request to do it.
> The request is invoked by SMI when some specific I/O port is accessed.
> Laptop extras device entity , implemented by AML, provides some method
> to put calling paramater to BIOS and access I/O port.Though,
> of cource, it is possible to access VGA card's register in AML.

Thanks for the replay Takanori,

I stumbled upon this URL recently
http://www.microsoft.com/whdc/device/display/mobiledisplay.mspx and so
I asked for this example...


>
> And how laptop extra's hotkey works is as follows:
>
> ACPI events are invoked by SCI. When SCI occured, appropriate interrupts
> are request and deliverd to ACPI driver, and the driver interpritet
> the source of SCI.
>
> When SCI gets GPIO event, it invokes AML methods bind to
> the event, eventually.
>
> In the method, Notify() object may be evaluated. When it is evaluated,
> ACPI driver invokes handler bounded to target of Notify() object.
>
> The handler handles the Notify and may propagate event to user, as
> a driver of laptop extra.
>
> I hope it may help you.
>

Yes, thank you for the example!
Eric.
