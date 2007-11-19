From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [PATCH] Fix segfault when printing battery status
Date: Mon, 19 Nov 2007 14:09:51 +0300
Message-ID: <47416EFF.3070402@gmail.com>
References: <200711182049.33355.eike-kernel@sf-tec.de> <47415B46.4020709@gmail.com> <200711191129.35144.eike-kernel@sf-tec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.236]:30688 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbXKSLJZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Nov 2007 06:09:25 -0500
Received: by hu-out-0506.google.com with SMTP id 19so922842hue
        for <linux-acpi@vger.kernel.org>; Mon, 19 Nov 2007 03:09:23 -0800 (PST)
In-Reply-To: <200711191129.35144.eike-kernel@sf-tec.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, astarikovskiy@suse.de, kernel list <linux-kernel@vger.kernel.org>

Rolf Eike Beer wrote:
> Alexey Starikovskiy wrote:
>   
>> Rolf Eike Beer wrote:
>>     
>>> cat
>>> /sys/devices/LNXSYSTM:00/device:00/PNP0A08:00/device:19/PNP0C0A:00/power_
>>> supply/BAT1/status
>>>
>>> This leads to a stacktrace as acpi_battery_get_property() returns 0 for a
>>> case where it does not set val->intval. These value is used as an array
>>> index in
>>> drivers/power/power_supply_sysfs.c::power_supply_show_property(). I had a
>>> situation where the value was 4096 which caused a problem as the array
>>> only has 5 entries.
>>>
>>> Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>
>>>       
>> Rolf, thanks for remainding.
>>     
>
> Huh? This one is unrelated to the problem I reported two weeks ago...
>
> Eike
>   
You are second to send the same patch, first one I already acked.
But it seems that Len did not pick it up yet.
Look for "ACPI: Always return valid 'status' from 
acpi_battery_get_property()"
if interested...

Regards,
Alex.

