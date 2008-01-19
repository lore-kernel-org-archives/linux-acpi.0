From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode - Presario F500
Date: Fri, 18 Jan 2008 22:34:04 -0500
Message-ID: <200801182234.04941.lenb@kernel.org>
References: <213d94420708272103g50320df2l822486d904851d2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37489 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756263AbYASDeT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2008 22:34:19 -0500
In-Reply-To: <213d94420708272103g50320df2l822486d904851d2a@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Gomulka <r.gom1977@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Tuesday 28 August 2007 00:03, Robert Gomulka wrote:
> Hello,
> my name is Robert Gomulka. I have written to you before, but from
> different address (carramba@epf.pl) for which servers have some
> problems. This one should be better, I hope.
> I was playing around with kernel switches to get my kernel doing its best.
> Started from acpi=off, then noapic irqpoll. Now, during this writing,
> I am trying "pci=assign-busses". So far it works, so I will keep
> testing this configuration.
> However, to my surprise, when I switched from "noapic irqpoll" to
> "pci=assign-busses" Linux refused to start, demanding acpi_osi=!Linux
> and asking for sending dmidecode to you. I added the switch and it
> went fine. So hereby you can find dmidecode output in the attachment.
> By the way, I have searched internet a lot for some hints what would
> be the best way to cope with Linux on similar laptops. There were some
> hints, but in my opinion they shouldn't work. People claim they
> worked, but they are for different architecture or don't exist.
> For example: noirqdebug (only ia-32), assign-busses and irq-route (the
> latter I'm not sure, but both should take form of pci=... not the
> options alone, however they say that options worked in exactly that
> way).

Hello Robert

If Linux doesn't boot "out of the box" on your system
w/o any boot parameter workarounds, it is a Linux bug.
So if this is still true, please file it here:
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI

It sounds like you are seeing a big difference between
"acpi_osi=Linux"        (default for 2.6.22 and earlier)
vs.
"acpi_osi=!Linux"       (default for 2.6.23 and later)

Is this still true?
please send me the output from acpidump.

thanks,
-Len

ps
If you don't have acpidump, you can get it from pmtools here:
http://www.lesswatts.org/projects/acpi/utilities.php

System Information
        Manufacturer: Hewlett-Packard
        Product Name: Presario F500 (GF596UA#ABA)       
        Version: Rev 1
        Serial Number: CNF72342QC
        UUID: 434E4637-3233-3432-5143-001B244CFD1C
        Wake-up Type: Power Switch
        SKU Number: GF596UA#ABA
        Family: 103C_5335KV

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
        Manufacturer: Quanta
        Product Name: 30D3
