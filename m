From: Ben Gardner <gardner.ben@gmail.com>
Subject: Re: ACPI: Can I use I2cSerialBus with a PCI I2C controller?
Date: Mon, 26 Oct 2015 14:56:09 -0500
Message-ID: <CAE7DoPb1kzPNuPbzbG8A2gzSLP0GHVbgZAnXeMZ3=rVCXvkS8w@mail.gmail.com>
References: <CAE7DoPZs69A5vLzDfrRXuC3q9fpkaXRYna2NQwHZk_BK9gLnvQ@mail.gmail.com>
	<20151021085056.GV1526@lahna.fi.intel.com>
	<CAE7DoPak939WjCWaGQw7W6aR0dZOcJCjcQK8gMa9iu+WRmnDDw@mail.gmail.com>
	<20151022080157.GI1526@lahna.fi.intel.com>
	<CAE7DoPY8+zw4xw0hWTmPoG4iPgC=2JRCT4bHqeqqaH+BywTWpw@mail.gmail.com>
	<CAE7DoPZfLDEBmeODQv3oEbs033gpq4oSA=Sx15wMajzVUbUinw@mail.gmail.com>
	<20151023082054.GP1526@lahna.fi.intel.com>
	<CAE7DoPbsc28tp9oOYnasTqtREOx=yNAk-xJV7q=jUHBPCPctNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:37372 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043AbbJZT4J (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Oct 2015 15:56:09 -0400
Received: by igbhv6 with SMTP id hv6so64540386igb.0
        for <linux-acpi@vger.kernel.org>; Mon, 26 Oct 2015 12:56:09 -0700 (PDT)
In-Reply-To: <CAE7DoPbsc28tp9oOYnasTqtREOx=yNAk-xJV7q=jUHBPCPctNg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org

On Fri, Oct 23, 2015 at 12:24 PM, Ben Gardner <gardner.ben@gmail.com> wrote:
> On Fri, Oct 23, 2015 at 3:20 AM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
>> On Thu, Oct 22, 2015 at 12:17:58PM -0500, Ben Gardner wrote:
>>> > The next issue is that the I2C-core isn't matching the device to the
>>> > "at24" driver, which has the alias "24c02".
>>>
>>> Here is what I found.
>>> i2c-core is creating the device with the ACPI name "24C02:00".
>>> The at24 driver uses "24c02" as the alias.
>>> i2c-code is matching devices to drivers using strcmp().
>>>
>>> Result: no match. ("24c02" != "24C02:00").
>>>
>>> If I modify acpi_i2c_add_device() to cut off the name at the ':' and
>>> covert to lowercase when populating info.type, it matches and works.
>>> I must be missing something here, because this would have never worked as-is.
>>> I'll ask on the I2C mailing list.
>>
>> You should either use proper _HID/_CID for the device or put "PRP0001"
>> to the _HID and let the match happen with DT .compatible strings. I've
>> attached a hack that I use locally.
>>
>> The corresponding ASL fragment would look like:
>>
>>
>>         Device (AT24)
>>         {
>>             Name (_HID, "PRP0001")
>>
>>             Method (_CRS, 0, Serialized) {
>>                 Name (UBUF, ResourceTemplate () {
>>                     I2cSerialBus (0x50, ControllerInitiated, 0x00061A80,
>>                         AddressingMode7Bit, "\\_SB.I2C6",
>>                         0x00, ResourceConsumer)
>>                 })
>>                 Return (UBUF)
>>             }
>>
>>             Name (_DSD, Package () {
>>                 ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>>                 Package () {
>>                     Package () {"compatible", "atmel,24c02"},
>>                     Package () {"size", 256},
>>                     Package () {"pagesize", 32},
>>                     Package () {"abs-value", 1},
>>                 },
>>             })
>>
>>             Method (_STA, 0, NotSerialized)
>>             {
>>                 Return (0xF)
>>             }
>>         }
>
> I like this approach, as one change to the driver will support all ACPI devices.
> I'll give it a try.

This approach works well enough.

Would you mind if I cleaned up the patch and submitted it for inclusion?
Or is there a reason why this isn't upstream?

Thanks,
Ben
