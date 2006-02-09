From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] acpi: make message more descriptive/meaningful
Date: Thu, 09 Feb 2006 19:30:23 +0100
Message-ID: <43EB8A3F.20303@suse.de>
References: <20060206192910.66cb9c86.rdunlap@xenotime.net> <20060207181809.GA3692@linux.intel.com> <Pine.LNX.4.58.0602071017430.12589@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:48532 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965247AbWBISa0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Feb 2006 13:30:26 -0500
In-Reply-To: <Pine.LNX.4.58.0602071017430.12589@shark.he.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Patrick Mochel <mochel@linux.intel.com>, linux-acpi@vger.kernel.org, len.brown@intel.com

Randy.Dunlap wrote:
> On Tue, 7 Feb 2006, Patrick Mochel wrote:
> 
>> On Mon, Feb 06, 2006 at 07:29:10PM -0800, Randy.Dunlap wrote:
>>
>>> Identify which device is not power-manageable to make
>>> the message more useful.
>>
>>> --- linux-2615-rc6g4.orig/drivers/acpi/bus.c
>>> +++ linux-2615-rc6g4/drivers/acpi/bus.c
>>> @@ -198,7 +198,8 @@ int acpi_bus_set_power(acpi_handle handl
>>>
>>>  	if (!device->flags.power_manageable) {
>>>  		ACPI_DEBUG_PRINT((ACPI_DB_WARN,
>>> -				  "Device is not power manageable\n"));
>>> +				  "Device '%s' is not power manageable\n",
>>> +					device->kobj.name));
>>
>> This is good information, but does it have to come in such a scary message?
>> It appears that something is wrong with the device, when in fact, it just
>> doesn't support an optional capability.
>>
>> Could we demote the message to e.g. ACPI_DB_INFO?
> 
I already moved this one with the big debug to error/warn ... patch.
It should now be ACPI_DB_INFO, but I did not add the device name though...

   Thomas
