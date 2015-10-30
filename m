From: Ben Gardner <gardner.ben@gmail.com>
Subject: Re: ACPI: Can I use I2cSerialBus with a PCI I2C controller?
Date: Fri, 30 Oct 2015 11:51:01 -0500
Message-ID: <CAE7DoPbPuHTEZGvRTPrUXVCWLHwWPow9_1W15kHLTgXWQtwXUw@mail.gmail.com>
References: <CAE7DoPZs69A5vLzDfrRXuC3q9fpkaXRYna2NQwHZk_BK9gLnvQ@mail.gmail.com>
	<20151021085056.GV1526@lahna.fi.intel.com>
	<CAE7DoPak939WjCWaGQw7W6aR0dZOcJCjcQK8gMa9iu+WRmnDDw@mail.gmail.com>
	<20151022080157.GI1526@lahna.fi.intel.com>
	<CAE7DoPY8+zw4xw0hWTmPoG4iPgC=2JRCT4bHqeqqaH+BywTWpw@mail.gmail.com>
	<CAE7DoPZfLDEBmeODQv3oEbs033gpq4oSA=Sx15wMajzVUbUinw@mail.gmail.com>
	<20151023082054.GP1526@lahna.fi.intel.com>
	<20151027211111.GA6011@cumulusnetworks.com>
	<20151028090140.GL1548@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:33344 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753517AbbJ3QvE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Oct 2015 12:51:04 -0400
Received: by iodd200 with SMTP id d200so85663842iod.0
        for <linux-acpi@vger.kernel.org>; Fri, 30 Oct 2015 09:51:01 -0700 (PDT)
In-Reply-To: <20151028090140.GL1548@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Dustin Byford <dustin@cumulusnetworks.com>, linux-acpi@vger.kernel.org

Hi,

On Wed, Oct 28, 2015 at 4:01 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Tue, Oct 27, 2015 at 02:11:11PM -0700, Dustin Byford wrote:
>> Hi Mika,
>>
>> On Fri Oct 23 11:20, Mika Westerberg wrote:
>>
>> > You should either use proper _HID/_CID for the device or put "PRP0001"
>> > to the _HID and let the match happen with DT .compatible strings. I've
>> > attached a hack that I use locally.
>>
>> I have a similar hack over here.  I have a question though:
>>
>> > The corresponding ASL fragment would look like:
>> >
>> >
>> >         Device (AT24)
>> >         {
>> >             Name (_HID, "PRP0001")
>> >
>> >             Method (_CRS, 0, Serialized) {
>> >                 Name (UBUF, ResourceTemplate () {
>> >                     I2cSerialBus (0x50, ControllerInitiated, 0x00061A80,
>> >                         AddressingMode7Bit, "\\_SB.I2C6",
>> >                         0x00, ResourceConsumer)
>> >                 })
>> >                 Return (UBUF)
>> >             }
>> >
>> >             Name (_DSD, Package () {
>> >                 ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>> >                 Package () {
>> >                     Package () {"compatible", "atmel,24c02"},
>>
>> The "c02" in 24c02 also indicates the size.  I've always found it a
>> little awkward when you could have a compatible string that disagrees
>> with firmware properties.  Should we do something about that?
>>
>> For example, is the more generic string, "atmel,at24" better?  I'm not
>> sure I like that approach in general, but it works well for the at24
>> devices.  at25 does it the same way.
>
> I think DT version actually identifies this if the device node is called
> "at24". I'm not sure if we can do that with ACPI though.
>
> I agree that we could use "atmel,at24" here but that requires
> corresponding binding to be added to
> Documentation/devicetree/bindings/i2c/trivial-devices.txt and review
> from DT folks. Definitely worth doing.

It looks like you are supposed to have the first compatible entry be
the exact manufacturer,model.
http://devicetree.org/Device_Tree_Usage#Understanding_the_compatible_Property

I am considering using a generic compatible entry ("linux,at24") to
match the Linux at24 driver.
In my case, I'm using a M24C02 from ST, so the compatible line would be:

  Package () {"compatible", Package () {"st,m24c02", "linux,at24"}},
  Package () {"size", 256},
  Package () {"pagesize", 16},

The "linux,at24" would require the other properties (size and
pagesize) to be present.
I've seen something similar done with a few other devices.

> Alternatively we may use the same _HID "INT3499" as Andy is doing in his
> series with the below properties.

The only issue with reusing INT3499 is that it is configured to be a
24C08 in the at24 driver.
Reusing the 24C08 HID for a 24C02 or other chip might be a bit confusing.

Ben
