From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [PATCH 3/3] ACPI: battery: register power_supply subdevice even
 when battery not present
Date: Sun, 01 Nov 2009 18:03:37 +0000
Message-ID: <4AEDCD79.5090008@tuffmail.co.uk>
References: <4A098D0A.6090509@tuffmail.co.uk>	 <1252291027.4627.2.camel@maxim-laptop>  <4AA4FCC3.2090805@tuffmail.co.uk>	 <1256954298.9681.14.camel@maxim-laptop>  <4AEC15E2.9040004@tuffmail.co.uk> <1256995251.11609.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:58384 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047AbZKASDj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 1 Nov 2009 13:03:39 -0500
Received: by fg-out-1718.google.com with SMTP id 16so2413141fgg.1
        for <linux-acpi@vger.kernel.org>; Sun, 01 Nov 2009 10:03:42 -0800 (PST)
In-Reply-To: <1256995251.11609.4.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>

Maxim Levitsky wrote:
> On Sat, 2009-10-31 at 10:48 +0000, Alan Jenkins wrote:
>   
>> Maxim Levitsky wrote:
>>     
>>> On Mon, 2009-09-07 at 13:29 +0100, Alan Jenkins wrote: 
>>>   
>>>       
>>>> Maxim Levitsky wrote:
>>>>     
>>>>         
>>>>> On Tue, 2009-05-12 at 15:51 +0100, Alan Jenkins wrote:
>>>>>   
>>>>>       
>>>>>           
>>>>>> Keeping this device around lets userspace know that we have a battery
>>>>>> bay, even if there is nothing in it at the moment.  This is what every
>>>>>> other battery driver does, so ACPI should do it as well.
>>>>>>
>>>>>> There is no reason to preserve the old behaviour.  We now correctly
>>>>>> provide the "present" attribute, which will return "0" when the battery
>>>>>> is removed.  HAL was already trying to check this attribute, so
>>>>>> it should be fine.
>>>>>>
>>>>>> Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
>>>>>>     
>>>>>>         
>>>>>>             
>>>>> What happened to this patch?
>>>>>
>>>>> I still get the issue this patch attempts to fix:
>>>>>
>>>>> maxim@maxim-laptop:~/software/kernel/linux-2.6$
>>>>> ls /sys/class/power_supply/
>>>>> AC
>>>>> maxim@maxim-laptop:~/software/kernel/linux-2.6$
>>>>> ls /sys/class/power_supply/
>>>>> AC  BAT0
>>>>> maxim@maxim-laptop:~/software/kernel/linux-2.6$
>>>>> ls /sys/class/power_supply/
>>>>> AC
>>>>> maxim@maxim-laptop:~/software/kernel/linux-2.6$ uname -r
>>>>> 2.6.31-rc8-next-20090904-next
>>>>> maxim@maxim-laptop:~/software/kernel/linux-2.6$ 
>>>>>
>>>>>
>>>>> When I unplug the battery, its sysfs entry disappears.
>>>>> Thus if system was booted without battery, there will be no way to know
>>>>> system has one.
>>>>>
>>>>> This patch doesn't apply.
>>>>>   
>>>>>       
>>>>>           
>>>> I rebased these patches a while back
>>>>
>>>> http://patchwork.kernel.org/patch/33118/
>>>> http://patchwork.kernel.org/patch/33119/
>>>> http://patchwork.kernel.org/patch/33120/
>>>>
>>>> you should find these will still apply.
>>>>
>>>> Regards
>>>> Alan
>>>>     
>>>>         
>>> Any progress on adding special battery bay device?
>>>
>>> Best regards,
>>> Maxim Levitsky
>>>   
>>>       
>> No, sorry.
>>
>> I did think of one complication - suspend/resume.  (That's not blocking
>> me though, it's just a matter of time).  Assume the obvious device tree:
>>
>>     ACPI BAT0 -> battery bay device -> [ battery device ]
>>
>> The user might suspend with the battery removed, and then add the
>> battery and resume.  But
>>
>>     1) Parent devices are resumed before their children.
>>     2) The device core won't let you add a child device to a device
>>     which is currently suspended.
>>
>> So when BAT0 resumes, the battery bay device is still suspended. 
>> Therefore the resume handler for BAT0 cannot directly create the battery
>> device. 
>>
>> So we either need to
>>
>> a) provide some sort of resume mechanism attached to the battery bay
>> device, or
>> b) use a different device tree and use symlinks to represent the
>> relationship i.e.
>>
>> ACPI BAT0 -> battery bay device (with "battery" symlink)
>>                    -> battery device (with "bay" symlink)
>>
>> I favour b).
>>
>> Regards
>> Alan
>>     
>
> Me too.
>
> In fact, I don't think there is need for relationship between bay and
> battery.
>
> All I need is some way for kernel to notify that batteries might became
> present,  so it would be enough to create a dummy child of the BAT0
> exactly like you said.
>
> Probably even it is possible not to use symlinks.
>
>
> Best regards,
> 	Maxim Levitsky
>   

I believe there are systems with more than one battery.  I think we 
should be able to tell userspace "there is one battery present, called 
BAT0, and one empty battery bay, called BAT1".  The symlinks would 
provide a reasonably clean way to indicate which battery bay is empty.

Regards
Alan
