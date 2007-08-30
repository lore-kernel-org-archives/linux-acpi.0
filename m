From: "Russ Dill" <russ.dill@gmail.com>
Subject: Attempting to patch DSDT to get HPET working
Date: Wed, 29 Aug 2007 22:20:47 -0700
Message-ID: <f9d2a5e10708292220n78e65f1ci9be27ee42e41ea6f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.186]:44208 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110AbXH3FUu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Aug 2007 01:20:50 -0400
Received: by mu-out-0910.google.com with SMTP id i10so597718mue
        for <linux-acpi@vger.kernel.org>; Wed, 29 Aug 2007 22:20:47 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I have an AMD SB460 southbridge (has HPET), but a BIOS with no HPET
support. I tried contacting ACER to see if they have plans for this:

> Thank you for contacting Acer America. I apologize in the delay in
> responding to your inquiry. At this time, Acer does not have any plans to
> offer a BIOS update to support HPET. Any BIOS updates for this computer
>will be posted at www.acerpanam.com, in the Drivers and Downloads section,
> as they become available.

So my two options are to hardcode it into the kernel (requires
recompilation) or modify my DSDT. Since the ubuntu kernel supports
loading an updated DSDT.aml in the initramfs, I'm trying this route.

I added this:

Device (HPET)
{
    Name (_HID, EisaId ("PNP0103"))
    Name (BUF0, ResourceTemplate ()
    {
        IRQNoFlags () {0}
        IRQNoFlags () {8}
        Memory32Fixed (ReadOnly, 0xFED00000, 0x00000400)
    })

    Method (_STA, 0, NotSerialized)
    {
         Return (0x0F)
    }

    Method (_CRS, 0, Serialized)
    {
        CreateDWordField (BUF0, 0x0A, HPT0)
        Store (0xFED01000, HPT0)
        Return (BUF0)
    }
}

between my Device (HMAC) stanza and my Device (MATH) stanza. On boot,
the kernel indicates that its loading an updated DSDT out of the
initramfs, and later on down the line, I get the following message:

hpet_acpi_add: no address or irqs in _CRS

So, good news, drivers/char/hpet.c is finding my PNP0103 entry. Bad
news, its having a problem with the resources. Any clue why?

(Machine is Acer Ferrari 5000, BIOS version 3225, ubuntu linux kernel 2.6.22-10)
