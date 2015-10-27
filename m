From: Dustin Byford <dustin@cumulusnetworks.com>
Subject: Re: ACPI: Can I use I2cSerialBus with a PCI I2C controller?
Date: Tue, 27 Oct 2015 14:11:11 -0700
Message-ID: <20151027211111.GA6011@cumulusnetworks.com>
References: <CAE7DoPZs69A5vLzDfrRXuC3q9fpkaXRYna2NQwHZk_BK9gLnvQ@mail.gmail.com>
 <20151021085056.GV1526@lahna.fi.intel.com>
 <CAE7DoPak939WjCWaGQw7W6aR0dZOcJCjcQK8gMa9iu+WRmnDDw@mail.gmail.com>
 <20151022080157.GI1526@lahna.fi.intel.com>
 <CAE7DoPY8+zw4xw0hWTmPoG4iPgC=2JRCT4bHqeqqaH+BywTWpw@mail.gmail.com>
 <CAE7DoPZfLDEBmeODQv3oEbs033gpq4oSA=Sx15wMajzVUbUinw@mail.gmail.com>
 <20151023082054.GP1526@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33140 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810AbbJ0VLM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Oct 2015 17:11:12 -0400
Received: by pabla5 with SMTP id la5so40196405pab.0
        for <linux-acpi@vger.kernel.org>; Tue, 27 Oct 2015 14:11:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20151023082054.GP1526@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Ben Gardner <gardner.ben@gmail.com>, linux-acpi@vger.kernel.org

Hi Mika,

On Fri Oct 23 11:20, Mika Westerberg wrote:

> You should either use proper _HID/_CID for the device or put "PRP0001"
> to the _HID and let the match happen with DT .compatible strings. I've
> attached a hack that I use locally.

I have a similar hack over here.  I have a question though:

> The corresponding ASL fragment would look like:
> 
> 
>         Device (AT24)
>         {
>             Name (_HID, "PRP0001")
> 
>             Method (_CRS, 0, Serialized) {
>                 Name (UBUF, ResourceTemplate () {
>                     I2cSerialBus (0x50, ControllerInitiated, 0x00061A80,
>                         AddressingMode7Bit, "\\_SB.I2C6",
>                         0x00, ResourceConsumer)
>                 })
>                 Return (UBUF)
>             }
> 
>             Name (_DSD, Package () {
>                 ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>                 Package () {
>                     Package () {"compatible", "atmel,24c02"},

The "c02" in 24c02 also indicates the size.  I've always found it a
little awkward when you could have a compatible string that disagrees
with firmware properties.  Should we do something about that?

For example, is the more generic string, "atmel,at24" better?  I'm not
sure I like that approach in general, but it works well for the at24
devices.  at25 does it the same way.

>                     Package () {"size", 256},
>                     Package () {"pagesize", 32},
>                     Package () {"abs-value", 1},
>                 },
>             })
> 
>             Method (_STA, 0, NotSerialized)
>             {
>                 Return (0xF)
>             }
>         }

		--Dustin
