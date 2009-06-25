From: Sebastian Pohl <sebastianp@uni-koblenz.de>
Subject: Re: acpi on sony vaio vgn-sz61mn
Date: Thu, 25 Jun 2009 10:31:55 +0200
Message-ID: <4A4335FB.3030900@uni-koblenz.de>
References: <4A38F2FA.5000207@uni-koblenz.de>	 <1245286687.9076.101.camel@rzhang-dt>  <4A40928A.7000608@uni-koblenz.de>	 <1245746655.15520.96.camel@rzhang-dt>  <4A40961D.50504@uni-koblenz.de>	 <1245746886.15520.98.camel@rzhang-dt> <4A409CEA.6040900@uni-koblenz.de>	 <037F493892196B458CD3E193E8EBAD4F01E90EF8BB@pdsmsx502.ccr.corp.intel.com>	 <4A40A170.1050401@uni-koblenz.de> <1245805110.15520.101.camel@rzhang-dt>	 <4A41EE23.6040806@uni-koblenz.de> <1245893469.15520.123.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from deliver.uni-koblenz.de ([141.26.64.15]:29975 "EHLO
	deliver.uni-koblenz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531AbZFYIbz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Jun 2009 04:31:55 -0400
In-Reply-To: <1245893469.15520.123.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Mattia Dongili <malattia@linux.it>

Hi,

i opened a bug here http://bugzilla.kernel.org/show_bug.cgi?id=13607

and i will attach the dmesg output later when i get to my notebook.

regards

     sebastian

Zhang Rui schrieb:
> please attach the full dmesg output in the bugzilla.
> and let's move the discussion there. :)
>
> thanks,
> rui
>
> On Wed, 2009-06-24 at 17:13 +0800, Sebastian Pohl wrote:
>   
>> Zhang Rui wrote:
>>     
>>> On Tue, 2009-06-23 at 17:33 +0800, Sebastian Pohl wrote:
>>>   
>>>       
>>>> Zhang, Rui wrote:
>>>>     
>>>>         
>>>>>   
>>>>>       
>>>>>           
>>>>>> -----Original Message-----
>>>>>> From: Sebastian Pohl [mailto:sebastianp@uni-koblenz.de]
>>>>>> Sent: Tuesday, June 23, 2009 5:14 PM
>>>>>> To: Zhang, Rui
>>>>>> Cc: linux-acpi@vger.kernel.org; Mattia Dongili
>>>>>> Subject: Re: acpi on sony vaio vgn-sz61mn
>>>>>>     
>>>>>>         
>>>>>>             
>>>>>>>       
>>>>>>>           
>>>>>>>               
>>>>>> Hi,
>>>>>>
>>>>>> this is before:
>>>>>>
>>>>>> /sys/firmware/acpi/interrupts/error:       0
>>>>>> /sys/firmware/acpi/interrupts/ff_gbl_lock:       0    enabled
>>>>>> /sys/firmware/acpi/interrupts/ff_pmtimer:       0    invalid
>>>>>> /sys/firmware/acpi/interrupts/ff_pwr_btn:       0    invalid
>>>>>>     
>>>>>>         
>>>>>>             
>>>>> [Rui] power button fixed event is invalid?
>>>>> Please make sure CONFIG_ACPI_BUTTON=m/y
>>>>>
>>>>> Thanks,
>>>>> rui
>>>>>
>>>>>   
>>>>>       
>>>>>           
>>>> It was set to
>>>>
>>>> CONFIG_ACPI_BUTTON=m
>>>>
>>>> ist that right or should i change it?
>>>>
>>>>     
>>>>         
>>> please make sure it's loaded.
>>> please attach the output of "grep . /proc/acpi/button/*/*/*"
>>>
>>> thanks,
>>> rui
>>>   
>>>       
>> Hi,
>>
>> the output is
>>
>> /proc/acpi/button/lid/LID0/info:type:                    Lid Switch
>> /proc/acpi/button/lid/LID0/state:state:      open
>> /proc/acpi/button/power/PWRB/info:type:                    Power Button (CM)
>>
>> I found it interesting that theres a lid switch status listed. So i 
>> tried with a magnet to trigger it and it came out like this:
>>
>> /proc/acpi/button/lid/LID0/info:type:                    Lid Switch
>> /proc/acpi/button/lid/LID0/state:state:      closed
>> /proc/acpi/button/power/PWRB/info:type:                    Power Button (CM)
>>
>> So this makes me think that the lid-switch itself is somehow reporting 
>> its status but it doesnt have any effects.
>>
>>
>> regards
>>
>>         sebastian
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>     
>
>   

