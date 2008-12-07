From: Witold Szczeponik <Witold.Szczeponik@gmx.net>
Subject: Re: [PATCH] PNPACPI: Enable Power Management
Date: Sun, 07 Dec 2008 13:41:43 +0100
Message-ID: <493BC487.1050103@gmx.net>
References: <4929C66F.1040206@gmx.net> <200812011547.34660.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:41069 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753772AbYLGMlu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 7 Dec 2008 07:41:50 -0500
In-Reply-To: <200812011547.34660.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <abelay@mit.edu>, rjw@sisk.pl

Bjorn Helgaas wrote:

> On Sunday 23 November 2008 02:09:03 pm Witold Szczeponik wrote:
>> Subject: Enable PNPACI Power Management
> 
> Hi Witold,

Hi Bjorn,

> 
> Thanks for your patch.  I'm glad somebody is paying attention to
> PNP and power.  I CC'd Adam and Rafael because they care about this
> area, too, but might not read everything on linux-acpi.

thanks, since this was my first patch submission, I wasn't sure
who to send the patch to...

> 

[patch description removed...]

> 
> Do you know of anything that specifies the order of the _CRS/_PS0
> and the _PS3/_DIS evaluation?  I don't know much about power
> management, and I couldn't find anything obvious in the spec.
> It seems plausible that we should run _CRS before turning on
> the power, but I really don't know.
> 

There's some info the ACPI Specification that says a device needs
to be put to D3 before _DIS is called (section 6.2.2) but there
is no clear statement as to when to put a device to D0... :-(

I think it should be _SRS/_PS0 and _PS3/_DIS.

[patch description removed...]

> 
> Is pnpacpi_set_resources() the only place that needs this change?
> For active devices, we normally don't call pnpacpi_set_resources()
> at all.  So I suppose on these ThinkPads, we exercise this path
> because the serial ports are initially disabled?
> 

I'm not sure.  I would guess that we need to put any device that is
enabled (either via _SRS or by default) into D0.  My patch does that
for the _SRS case but the generic ACPI code does not.  On my 600E,
the serial port has power when the machine is booted but has no power
once GRUB kicks in.  It remains in this state until the 8250-pnp module
gets loaded, where my patch enables it.

The ACPI Specification says for _SRS: the device is enabled after the 
method has returned.  There is no statement as to when to call _PS0...

>> No regressions were observed on hardware that does not require
>> this patch.
>>
>> The patch is applied against 2.6.27.7 (vanilla).
>>
>>
>> Signed-off-by: Witold Szczeponik <Witold.Szczeponik@gmx.net>
>>
>>
>> Index: linux/drivers/pnp/pnpacpi/core.c
>> ===================================================================
>> --- linux.orig/drivers/pnp/pnpacpi/core.c
>> +++ linux/drivers/pnp/pnpacpi/core.c
>> @@ -98,18 +98,24 @@ static int pnpacpi_set_resources(struct
>>   	status = acpi_set_current_resources(handle, &buffer);
>>   	if (ACPI_FAILURE(status))
>>   		ret = -EINVAL;
>> +	else if (acpi_bus_power_manageable(handle))
>> +		ret = acpi_bus_set_power(handle, ACPI_STATE_D0);
> 
> I don't really like testing acpi_bus_power_manageable() first.
> I think we should just call acpi_bus_set_power() and let *it*
> bail out if the device doesn't support it.

Fair enough. :-) Will remove the test.

> 
>>   	kfree(buffer.pointer);
>>   	return ret;
>>   }
>>
>>   static int pnpacpi_disable_resources(struct pnp_dev *dev)
>>   {
>> +	acpi_handle handle = dev->data;
>> +	int ret = 0;
>>   	acpi_status status;
>>
>> -	/* acpi_unregister_gsi(pnp_irq(dev, 0)); */
> 
> Can you leave the "unregister_gsi" comment there, since it's not
> related to your patch?  It's a reminder that we need to think about
> how to handle interrupts when enabling/disabling devices.

I'd rather remove the comment as it is misleading, IMHO.  This call
should be made by a driver.  After all, the PNPACPI core does not
register any IRQs, either.  Otherwise, we need to think about
"pnp_irq(dev, 1)", too.  Either way, with my patch there should be
no IRQ handling possible.

> 
>> -	status = acpi_evaluate_object((acpi_handle) dev->data,
>> -				      "_DIS", NULL, NULL);
>> -	return ACPI_FAILURE(status) ? -ENODEV : 0;
>> +	if (acpi_bus_power_manageable(handle))
>> +		ret = acpi_bus_set_power(handle, ACPI_STATE_D3);
>> +	status = acpi_evaluate_object(handle, "_DIS", NULL, NULL);
>> +	if (ACPI_FAILURE(status))
>> +		ret = -ENODEV;
>> +	return ret;
>>   }

Will remove the test, too.

>>
>>   #ifdef CONFIG_ACPI_SLEEP
> 

