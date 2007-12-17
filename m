From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [PATCH 1/5] ACPI: WMI: Add ACPI-WMI mapping driver
Date: Mon, 17 Dec 2007 23:04:06 +0300
Message-ID: <4766D636.9010405@gmail.com>
References: <20071217002317.4980.71135.stgit@localhost> <20071217002322.4980.57591.stgit@localhost> <47664403.5060902@gmail.com> <200712171501.11885.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:48582 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936730AbXLQUD7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Dec 2007 15:03:59 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1622996fkz.5
        for <linux-acpi@vger.kernel.org>; Mon, 17 Dec 2007 12:03:57 -0800 (PST)
In-Reply-To: <200712171501.11885.carlos@strangeworlds.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Alexey Starikovskiy <ayastarik@gmail.com>

Carlos Corbacho wrote:
> On Monday 17 December 2007 09:40:19 Alexey Starikovskiy wrote:
>   
>>> +/*
>>> + * WMI can have EmbeddedControl access regions. In which case, we just
>>> want to + * hand these off to the EC driver.
>>> + */
>>> +static acpi_status
>>> +acpi_wmi_ec_space_handler(u32 function, acpi_physical_address address,
>>> +		      u32 bits, acpi_integer *value,
>>> +		      void *handler_context, void *region_context)
>>> +{
>>> +	int result = 0, i = 0;
>>> +	u8 temp = 0;
>>> +
>>> +	if ((address > 0xFF) || !value)
>>> +		return AE_BAD_PARAMETER;
>>> +
>>> +	if (function != ACPI_READ && function != ACPI_WRITE)
>>> +		return AE_BAD_PARAMETER;
>>> +
>>>       
>> You probably don't need to handle more than 1 byte here -- even in EC it
>> is legacy...
>>     
>
> So would putting back in something like:
>
> if (bits != 8)
> 	return AE_BAD_PARAMETER;
>
> Be the right solution? (acpi_strict test is removed compared to EC, since it's 
> no longer exported, and WMI can be built as a module)
>
> -Carlos
>   

Right
