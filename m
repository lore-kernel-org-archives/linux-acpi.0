From: aaron lwe <aaron.lwe@gmail.com>
Subject: Re: any way to evaluate a device's _PS0 method when its power state
 is at D0?
Date: Thu, 19 May 2011 23:05:24 +0800
Message-ID: <BANLkTimmDa55sgFgQbnD6sdNnvt8U+OXUQ@mail.gmail.com>
References: <BANLkTim-sswOsPZZzH7QOWQgqpwJ_EzeNQ@mail.gmail.com>
	<20110519124221.GA11831@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:40310 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932879Ab1ESPFZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 May 2011 11:05:25 -0400
Received: by ewy4 with SMTP id 4so807847ewy.19
        for <linux-acpi@vger.kernel.org>; Thu, 19 May 2011 08:05:24 -0700 (PDT)
In-Reply-To: <20110519124221.GA11831@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

On Thu, May 19, 2011 at 8:42 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Thu, May 19, 2011 at 06:06:47PM +0800, aaron lwe wrote:
>
>> So on init, this device's power state will be set to D0 due to ABPS is
>> 0, but its _PS0 never get called.
>> If later I want to evaluate its _PS0 control method, what should I do?
>> acpi_bus_set_power will return if it found the set state is the same
>> with the current state.
>
> Why do you want to evaluate its _PS0 method?

Hi Matthew,

The following is a simplified code that this device did by
disassembling the DSDT table.
When I put the device to D3, and later changed its state back to D0, I
got a problem due to HASD is never set to 1:
Device (xx)
{
        Name (ABPS, 0)
	Name (HASD, 0)

        Method (_PSC, 0, NotSerialized)
        {
                Return (ABPS)
        }

	Method (_PS0, 0, NotSerialized)
	{
		If (LOr (LEqual (HASD, 1), LAnd(LEqual(HASD, 0), LEqual(PORT, 1))))
		{
			// do things to re-power this device
			Store (1, HASD)
		}
	}
}

PORT is a bit field defined in an operation region, it's an io port
value which is used to detect if a device is there.
HASD is used to store if a device is there.

First I put the device to D3, and then put it back to D0, due to _PS0
is never evaluated before, HASD is 0.
And since the device is powered off, the PORT will also be 0. And
thus, I can't re-power this device.

This control method depends on it being evaluated once during boot, so
that it can set HASD to 1.

Since this device's state is set to D0 in acpi_bus_init_power without
evaluating _PS0 control method, and I need HASD to be set to 1 for
_PS0 to be evaluated effectively when I put the device back to D0 from
D3, I'll need to evaluate _PS0 when this device's power state is at
D0.

Thanks,
Aaron
