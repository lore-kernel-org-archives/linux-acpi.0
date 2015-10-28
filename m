From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: ACPI: Can I use I2cSerialBus with a PCI I2C controller?
Date: Wed, 28 Oct 2015 11:01:40 +0200
Message-ID: <20151028090140.GL1548@lahna.fi.intel.com>
References: <CAE7DoPZs69A5vLzDfrRXuC3q9fpkaXRYna2NQwHZk_BK9gLnvQ@mail.gmail.com>
 <20151021085056.GV1526@lahna.fi.intel.com>
 <CAE7DoPak939WjCWaGQw7W6aR0dZOcJCjcQK8gMa9iu+WRmnDDw@mail.gmail.com>
 <20151022080157.GI1526@lahna.fi.intel.com>
 <CAE7DoPY8+zw4xw0hWTmPoG4iPgC=2JRCT4bHqeqqaH+BywTWpw@mail.gmail.com>
 <CAE7DoPZfLDEBmeODQv3oEbs033gpq4oSA=Sx15wMajzVUbUinw@mail.gmail.com>
 <20151023082054.GP1526@lahna.fi.intel.com>
 <20151027211111.GA6011@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:55318 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932627AbbJ1JBy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Oct 2015 05:01:54 -0400
Content-Disposition: inline
In-Reply-To: <20151027211111.GA6011@cumulusnetworks.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dustin Byford <dustin@cumulusnetworks.com>
Cc: Ben Gardner <gardner.ben@gmail.com>, linux-acpi@vger.kernel.org

On Tue, Oct 27, 2015 at 02:11:11PM -0700, Dustin Byford wrote:
> Hi Mika,
> 
> On Fri Oct 23 11:20, Mika Westerberg wrote:
> 
> > You should either use proper _HID/_CID for the device or put "PRP0001"
> > to the _HID and let the match happen with DT .compatible strings. I've
> > attached a hack that I use locally.
> 
> I have a similar hack over here.  I have a question though:
> 
> > The corresponding ASL fragment would look like:
> > 
> > 
> >         Device (AT24)
> >         {
> >             Name (_HID, "PRP0001")
> > 
> >             Method (_CRS, 0, Serialized) {
> >                 Name (UBUF, ResourceTemplate () {
> >                     I2cSerialBus (0x50, ControllerInitiated, 0x00061A80,
> >                         AddressingMode7Bit, "\\_SB.I2C6",
> >                         0x00, ResourceConsumer)
> >                 })
> >                 Return (UBUF)
> >             }
> > 
> >             Name (_DSD, Package () {
> >                 ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> >                 Package () {
> >                     Package () {"compatible", "atmel,24c02"},
> 
> The "c02" in 24c02 also indicates the size.  I've always found it a
> little awkward when you could have a compatible string that disagrees
> with firmware properties.  Should we do something about that?
>
> For example, is the more generic string, "atmel,at24" better?  I'm not
> sure I like that approach in general, but it works well for the at24
> devices.  at25 does it the same way.

I think DT version actually identifies this if the device node is called
"at24". I'm not sure if we can do that with ACPI though.

I agree that we could use "atmel,at24" here but that requires
corresponding binding to be added to
Documentation/devicetree/bindings/i2c/trivial-devices.txt and review
from DT folks. Definitely worth doing.

Alternatively we may use the same _HID "INT3499" as Andy is doing in his
series with the below properties.

> >                     Package () {"size", 256},
> >                     Package () {"pagesize", 32},
> >                     Package () {"abs-value", 1},
> >                 },
> >             })
> > 
> >             Method (_STA, 0, NotSerialized)
> >             {
> >                 Return (0xF)
> >             }
> >         }
> 
> 		--Dustin
