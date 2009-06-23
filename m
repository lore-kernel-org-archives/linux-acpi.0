From: Sebastian Pohl <sebastianp@uni-koblenz.de>
Subject: Re: acpi on sony vaio vgn-sz61mn
Date: Tue, 23 Jun 2009 11:33:36 +0200
Message-ID: <4A40A170.1050401@uni-koblenz.de>
References: <4A38F2FA.5000207@uni-koblenz.de>	 <1245286687.9076.101.camel@rzhang-dt>  <4A40928A.7000608@uni-koblenz.de>	 <1245746655.15520.96.camel@rzhang-dt>  <4A40961D.50504@uni-koblenz.de> <1245746886.15520.98.camel@rzhang-dt> <4A409CEA.6040900@uni-koblenz.de> <037F493892196B458CD3E193E8EBAD4F01E90EF8BB@pdsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from deliver.uni-koblenz.de ([141.26.64.15]:18596 "EHLO
	deliver.uni-koblenz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536AbZFWJdb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Jun 2009 05:33:31 -0400
In-Reply-To: <037F493892196B458CD3E193E8EBAD4F01E90EF8BB@pdsmsx502.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Mattia Dongili <malattia@linux.it>

Zhang, Rui wrote:
>   
>> -----Original Message-----
>> From: Sebastian Pohl [mailto:sebastianp@uni-koblenz.de]
>> Sent: Tuesday, June 23, 2009 5:14 PM
>> To: Zhang, Rui
>> Cc: linux-acpi@vger.kernel.org; Mattia Dongili
>> Subject: Re: acpi on sony vaio vgn-sz61mn
>>     
>>>       
>> Hi,
>>
>> this is before:
>>
>> /sys/firmware/acpi/interrupts/error:       0
>> /sys/firmware/acpi/interrupts/ff_gbl_lock:       0    enabled
>> /sys/firmware/acpi/interrupts/ff_pmtimer:       0    invalid
>> /sys/firmware/acpi/interrupts/ff_pwr_btn:       0    invalid
>>     
> [Rui] power button fixed event is invalid?
> Please make sure CONFIG_ACPI_BUTTON=m/y
>
> Thanks,
> rui
>
>   
It was set to

CONFIG_ACPI_BUTTON=m

ist that right or should i change it?

regards 

     sebastian

>>
>>>> regards
>>>>
>>>>     sebastian
>>>>
>>>>
>>>>         
>>>>>> sony/hotkey SPIC 00000001 00000021
>>>>>>
>>>>>>
>>>>>>             
>>>>>>> run "cat /proc/interrupts" both before and after pressing these buttons,
>>>>>>> does the number of ACPI or sony interrupts increase?
>>>>>>> If ACPI interrupts increases, please run
>>>>>>> "grep . /sys/firmware/acpi/interrupts/*" and tell us which GPE/Fixed
>>>>>>> event is fired.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>               
>>>>>> Only the stamina switch and the s2 button increase any interrupts but
>>>>>> only sony interrupts are generated.
>>>>>>
>>>>>>
>>>>>>             
>>>>>>>
>>>>>>>
>>>>>>>               
>>>>>>>> Should i post them to bugtrackter or
>>>>>>>> something else?
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>                 
>>>>>>> please file a new bug report at
>>>>>>> http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
>>>>>>> and attach all the request info there.
>>>>>>> please also attach the acpidump output.
>>>>>>>
>>>>>>> thanks,
>>>>>>> rui
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>               
>>>>>> thank you!
>>>>>>
>>>>>> regards
>>>>>>
>>>>>>      sebastian
>>>>>>
>>>>>>
>>>>>>             
>>>>>           
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>       
>
>   

