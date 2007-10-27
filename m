From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [PATCH] 2.6.24-rc1: ensure "present" sysfs attribute even if
 battery is absent
Date: Sat, 27 Oct 2007 22:18:14 +0400
Message-ID: <472380E6.10304@gmail.com>
References: <200710272054.31160.arvidjaar@mail.ru> <47237255.9020001@gmail.com> <200710272150.29596.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:23843 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbXJ0SSj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 27 Oct 2007 14:18:39 -0400
Received: by ug-out-1314.google.com with SMTP id z38so820717ugc
        for <linux-acpi@vger.kernel.org>; Sat, 27 Oct 2007 11:18:37 -0700 (PDT)
In-Reply-To: <200710272150.29596.arvidjaar@mail.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, cbou@mail.ru, dwmw2@infradead.org

Andrey Borzenkov wrote:
> On Saturday 27 October 2007, Alexey Starikovskiy wrote:
>> Andrey Borzenkov wrote:
>>> I am not exactly sure about this one ... what other power_supply class
>>> drivers do? Should I fix HAL instead (but then, I do not know whether HAL
>>> is the only application that is using this interface).
>> Hm, do you need separate set of properties for that? You could register
>> either of existing two, and read function will not allow read of anything
>> but "present". IMHO, this is what other modules do (/drivers/power)
> 
> Do they have different set of properties depending on underlying hardware that 
> you can't query unless hardware is present? I'd rather avoid adding fake 
> attributes; but I do not actually care so which one do you prefer? :)
I prefer less code :) 
> 
>> One remaining trick here, you need to call unregister/register for
>> power_supply if you change attributes -- so please check if your patched
>> driver survives insertion of the battery.
>>
> 
> 
> Neither does your code (nor kpowersave :) ) Remove battery and set of 
> attributes is "stuck" instead of being reset to only fixed set of power 
> device attributes (basically "info"). The only call to power_supply_register 
> is in acpi_battery_add and as far as I can tell this is executed on adding 
> *slot* not when content of this slot changes.
Point is -- it does not break :) If you start to play with shorter length of 
attributes table and don't call unregister/register, power_supply may 
go past the end of table.





