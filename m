From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 1/1] ACPI: pci_irq, add PRT_ quirk for IBM Bartolo
Date: Mon, 19 Jul 2010 18:29:33 +0200
Message-ID: <4C447D6D.5060801@suse.cz>
References: <1277673679-21458-1-git-send-email-jslaby@suse.cz>	<4C27E965.80508@gmail.com>	<4C283D84.6080504@suse.cz>	<20100628171410.GA27367@srcf.ucam.org>	<4C290245.2040001@suse.cz>	<20100628204820.GA32503@srcf.ucam.org>	<AANLkTil-sdbojCXBp6sR_4xL3JIe6ZENqXuueB61VJ8c@mail.gmail.com>	<4C2A3E27.4060407@suse.cz> <AANLkTimkElR1u-iRyFfCEQR5VTZvcyEIGQodfmFNtbC_@mail.gmail.com> <4C2B0C73.9050200@suse.cz> <4C3278C8.60503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <4C3278C8.60503@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, lenb@kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-acpi@vger.kernel.org

On 07/06/2010 02:28 AM, Robert Hancock wrote:
> On 06/30/2010 03:20 AM, Jiri Slaby wrote:
>> On 06/30/2010 01:23 AM, Robert Hancock wrote:
>>> What kind of slot is it, and what kind of device was being used,
>>> something designed for this machine or just some random card?
>>
>> It's a netmos 9835 serial card with 2 ports. PCI, there is no PCIe in
>> the machine as far as I can see.
>>
>>> Can they
>>> tell what IRQ the device is reportedly using in Windows and if it
>>> matches what Linux reports?
>>
>> I can ask them. What I know is that with acpi=noirq (or with the quirk)
>> the IRQ number is 10, with acpi without the quirk, it's 11:
>>
>> PCI: setting IRQ 2 as level-triggered
>> serial 0000:00:09.0: found PCI INT A ->  IRQ 2
>> 0000:00:09.0: ttyS4 at I/O 0x1898 (irq = 10) is a 16550A
>> 0000:00:09.0: ttyS5 at I/O 0x1890 (irq = 10) is a 16550A
>>
>> ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
>> PCI: setting IRQ 11 as level-triggered
>> serial 0000:00:09.0: PCI INT A ->  Link[LNKB] ->  GSI 11 (level, low) ->
>> IRQ 11
>> 0000:00:09.0: ttyS4 at I/O 0x1898 (irq = 11) is a 16550A
>> 0000:00:09.0: ttyS5 at I/O 0x1890 (irq = 11) is a 16550A
>>
>> I still no point in comparing this to Windows' setup. We can't find out
>> whether it is quirked or better (without some bug) handled there.
> 
> Well, you can see if Windows shows IRQ 10 or 11 for that device..

But how can I find out which link it is routed to in Windows? Without
that information the number is meaningless, no?

thanks,
-- 
js
suse labs
