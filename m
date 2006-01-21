From: Janosch Machowinski <scotch@tzi.de>
Subject: Re: Strange interpreter behaviour
Date: Sat, 21 Jan 2006 19:55:59 +0100
Message-ID: <43D283BF.9000004@tzi.de>
References: <43BFF7DE.1000909@tzi.de> <20060116171932.GF25115@poupinou.org> <43CC0FC0.9090806@tzi.de> <20060117103043.GA2154@poupinou.org> <43CCE603.3010600@tzi.de> <20060117132435.GB2154@poupinou.org> <43CCFF1C.4000309@tzi.de> <20060117154742.GD2154@poupinou.org> <43D10176.302@tzi.de> <20060120193248.GD21264@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from m1.informatik.uni-bremen.de ([134.102.201.18]:54712 "EHLO
	informatik.uni-bremen.de") by vger.kernel.org with ESMTP
	id S1750838AbWAUSys (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 21 Jan 2006 13:54:48 -0500
In-Reply-To: <20060120193248.GD21264@poupinou.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bruno Ducrot <ducrot@poupinou.org>
Cc: linux-acpi@vger.kernel.org

> On Fri, Jan 20, 2006 at 04:27:50PM +0100, Janosch Machowinski wrote:
> 
>>>Sometimes I'm stupid.  Try this version instead.
>>>
>>
>>Okay, this worked,
>>the outprut from your little programm was 0x500,
>>but it should be
>>GPE0_BLK:         0x00000428
>>GPE1_BLK:         0x00000000
>>
>>So is this an error in ACPI-CA or in my DSDT ?
>>
> 
> 
>>From the ich4-m specification (see
> ftp://download.intel.com/design/mobile/datashts/25233701.pdf
> )
> and the lspci -xxx I've requested, we can look that, for the isa
> bridge, we can see that 0x500 is the base address for the GPIO
> configuration registers.
> 
> The lspci show us:
> 00:1f.0 ISA bridge: Intel Corporation 82801DBM (ICH4-M) LPC Interface
> Bridge (rev 03)
> Flags: bus master, medium devsel, latency 0
> 00: 86 80 cc 24 0f 01 80 02 03 00 01 06 00 00 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: 01 04 00 00 10 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 01 05 00 00 10 00 00 00
> 60: 0b 04 0a 05 90 00 00 00 80 80 80 0a 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: ff fc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 28 03 00 00 00 00 00 00 0d 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 80 02 02 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 02 28 00 00 02 cf 00 00 04 00 00 00 00 00 00 00
> e0: 12 00 00 c0 00 00 06 34 33 22 11 00 00 00 67 45
> f0: 00 00 01 00 00 00 00 00 60 0f 03 00 00 00 80 02
> 
> 
> The GPIO base address is at 0x58-0x5b (see page 305).
> 
>>From page 396 (9.10 General Purpose I/O Registers) we'll
> learn that the ACPI node INV7 correspond to the
> 8th bit of the 'GPIO signal invert (GPI_INV)' register.
> 
> Therefore actually INV7 control somehow we'll treat
> what happens under the GPE0_BLK, but do not modify it.
> (I must confess I don't see why the ODM designed
> that stuff like this).
> 
> At the description of this register, and for bit 8, we'll
> see that setting this bit will have no effect if the
> corresponding GPIO is set as an output.  We'll therefore
> shall check if that is the problem.
> 
> Could you please (again, sorry!) 
Don't be sorry to debug my notebook ;-)
run the next tool attached?
> This would help to progress a little bit further.
> 

scotchmobil pmtools # ./scan_gpio_ctl
      00 01 02 03 04 05 06 07   08 09 0a 0b 0c 0d 0e 0f
0500 bf 39 00 1a ff ff 00 00   00 00 00 00 00 00 01 08
0510 00 00 00 00 00 00 00 00   00 00 00 02 00 00 00 00
0520 00 00 00 00 00 00 00 00   00 00 00 00 88 39 00 00
0530 ff 0f 00 00 06 04 00 00   8f 04 00 00 00 00 00 00

