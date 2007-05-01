From: "Alexey Starikovskiy" <aystarik@gmail.com>
Subject: Re: EC notifications not dispatched?
Date: Tue, 1 May 2007 11:43:38 +0400
Message-ID: <8f8ff01d0705010043q687d4673y52aa45880e6e18f5@mail.gmail.com>
References: <20070501045038.GA6940@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.245]:42583 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965483AbXEAHnj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 May 2007 03:43:39 -0400
Received: by an-out-0708.google.com with SMTP id b33so1537147ana
        for <linux-acpi@vger.kernel.org>; Tue, 01 May 2007 00:43:38 -0700 (PDT)
In-Reply-To: <20070501045038.GA6940@inferi.kami.home>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>

acpi_ec_gpe_query in ec.c is a function which should query the
execution of _Qxx events of
EC. You could try to insert some printk()s around...

On 5/1/07, Mattia Dongili <malattia@linux.it> wrote:
> Hello,
>
> some new Vaio models are notifing hotkeys to the SNC device through the
> EC (dsdt snippet[1]):
>
> Device (EC)
> {
>     Name (_HID, EisaId ("PNP0C09"))
>     ...
>     Name (HF5P, 0x85)
>     Name (HF5R, 0x05)
>     ...
>     Method (_Q50, 0, NotSerialized)
>     {
>         P8XH (Zero, 0x50)
>         SECR (HF5P)
>         Notify (SNC, 0x92)
>     }
>
>     Method (_Q51, 0, NotSerialized)
>     {
>         P8XH (Zero, 0x51)
>         SECR (HF5R)
>         Notify (SNC, 0x92)
>     }
> ...
> }
> and a kernel log[2] while pressing FnF5 with
> /proc/acpi/debug_layer=0xFFFF0004
> /proc/acpi/debug_level=0xffffffff
> is appended below. I would expect to find some traces of the _Q50/_Q51
> evaluation and sequent notification. And yes, sony-laptop (which handles
> the SNC) registers a notify_handler (line 771 in current code) this way:
>
>         acpi_install_notify_handler(sony_nc_acpi_handle,
>                                              ACPI_DEVICE_NOTIFY,
>                                              sony_acpi_notify, NULL);
>
> any clues why I don't get anything from that?
> BTW: I'm Cc-ing one such vaio owner so that he can help answering some
> questions if necessary.
>
> [1]: full DSDT -> http://www.linux.it/~malattia/sony-laptop/DSDT.c1s.dsl
> [2]: full dmesg -> http://www.linux.it/~malattia/logs/pressing-Fn5-Fn6-full.txt
>
> Thanks,
> Mattia
>
