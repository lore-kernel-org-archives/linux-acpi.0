From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: kpowersave stuck at battery charging
Date: Wed, 02 Jan 2008 19:18:33 +0300
Message-ID: <477BB959.1040207@gmail.com>
References: <200801021248.55844.arvidjaar@mail.ru> <477B6AA5.5020803@gmail.com> <200801021610.45582.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:26084 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754023AbYABQSq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jan 2008 11:18:46 -0500
Received: by nf-out-0910.google.com with SMTP id g13so347829nfb.21
        for <linux-acpi@vger.kernel.org>; Wed, 02 Jan 2008 08:18:44 -0800 (PST)
In-Reply-To: <200801021610.45582.arvidjaar@mail.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: hal@lists.freedesktop.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Andrey Borzenkov wrote:
> On Wednesday 02 January 2008, Alexey Starikovskiy wrote:
>   
>> Andrey Borzenkov wrote:
>>     
>>> This is did not happen before; I am not sure right now what caused this 
>>>       
> (i.e. 
>   
>>> battery aging or some software change) nor whether this is 
>>>       
> kernel/HAL/kpowersave 
>   
>>> issue.
>>>
>>> kpowersave is stuck at assuming battery is loading and at 94%. Sysfs 
>>>       
> displays 
>   
>>> battery state as Full:
>>>
>>>   
>>>       
>> Frequent battery charging shortens lifetime of the battery, so some (may 
>> be all now)
>> notebook manufacturers do not start charging  battery until it discharge 
>> to some degree (~90%).
>>     
>
> I thought Li-Ion batteries do not have memory effect. Actually I remember to 
> have read recommendation to avoid deep discharges of Li-Ion battery, it was 
> adviced to charge it as often as possible.
>   
IBM has advice to not re-charge battery until it discharged to 95%.
It was implemented in their batteries/notebooks.
There is no memory effect in Li-Ion batteries, there is only limited 
number of
charge cycles -- about 1000 times, thus "as often as possible" is advice
of the battery seller :)
>   
>> It could be your case. Please try to discharge battery to, say, 89% and 
>> then check if it charges to the
>> 100%.
>>     
>
> That is exactly the question - how do you compute 100%? As far as I can tell the 
> only possibility is - when battery stops charging. At this point you have to 
> assume battery is fully charged.
>   
Last charge would be good reference. Think of the battery as constantly
degrading resource.
> I tried to discharge battery (it was around 78%) and plug AC in again. It went 
> on Charging until the same limit after that state changed to Full (well, in case 
> of ACPI battery we really only can state - not (dis-)charging, there is no 
> special Full state flag); kpowersave still believes battery is not fully 
> charged. Main interface shows 84% (no Charging) - tooltip states it is being 
> charged.
>
>   
So, that is the state of your battery. If you buy new one, it will go 
high again.

Regards,
Alex.
