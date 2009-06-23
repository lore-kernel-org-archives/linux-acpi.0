From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: acpi on sony vaio vgn-sz61mn
Date: Tue, 23 Jun 2009 17:23:11 +0800
Message-ID: <037F493892196B458CD3E193E8EBAD4F01E90EF8BB@pdsmsx502.ccr.corp.intel.com>
References: <4A38F2FA.5000207@uni-koblenz.de>
	 <1245286687.9076.101.camel@rzhang-dt>  <4A40928A.7000608@uni-koblenz.de>
	 <1245746655.15520.96.camel@rzhang-dt>  <4A40961D.50504@uni-koblenz.de>
 <1245746886.15520.98.camel@rzhang-dt> <4A409CEA.6040900@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55404 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751857AbZFWJZC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Jun 2009 05:25:02 -0400
In-Reply-To: <4A409CEA.6040900@uni-koblenz.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sebastian Pohl <sebastianp@uni-koblenz.de>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Mattia Dongili <malattia@linux.it>



>-----Original Message-----
>From: Sebastian Pohl [mailto:sebastianp@uni-koblenz.de]
>Sent: Tuesday, June 23, 2009 5:14 PM
>To: Zhang, Rui
>Cc: linux-acpi@vger.kernel.org; Mattia Dongili
>Subject: Re: acpi on sony vaio vgn-sz61mn
>>
>>
>Hi,
>
>this is before:
>
>/sys/firmware/acpi/interrupts/error:       0
>/sys/firmware/acpi/interrupts/ff_gbl_lock:       0    enabled
>/sys/firmware/acpi/interrupts/ff_pmtimer:       0    invalid
>/sys/firmware/acpi/interrupts/ff_pwr_btn:       0    invalid
[Rui] power button fixed event is invalid?
Please make sure CONFIG_ACPI_BUTTON=m/y

Thanks,
rui

>/sys/firmware/acpi/interrupts/ff_rt_clk:       0    disabled
>/sys/firmware/acpi/interrupts/ff_slp_btn:       0    invalid
>/sys/firmware/acpi/interrupts/gpe00:       0    invalid
>/sys/firmware/acpi/interrupts/gpe01:       0    enabled
>/sys/firmware/acpi/interrupts/gpe02:       0    enabled
>/sys/firmware/acpi/interrupts/gpe03:       0    disabled
>/sys/firmware/acpi/interrupts/gpe04:       0    disabled
>/sys/firmware/acpi/interrupts/gpe05:       0    disabled
>/sys/firmware/acpi/interrupts/gpe06:       0    enabled
>/sys/firmware/acpi/interrupts/gpe07:       0    enabled
>/sys/firmware/acpi/interrupts/gpe08:       0    invalid
>/sys/firmware/acpi/interrupts/gpe09:       0    disabled
>/sys/firmware/acpi/interrupts/gpe0A:       0    invalid
>/sys/firmware/acpi/interrupts/gpe0B:       0    enabled
>/sys/firmware/acpi/interrupts/gpe0C:       0    disabled
>/sys/firmware/acpi/interrupts/gpe0D:       0    disabled
>/sys/firmware/acpi/interrupts/gpe0E:       0    disabled
>/sys/firmware/acpi/interrupts/gpe0F:       0    invalid
>/sys/firmware/acpi/interrupts/gpe10:       0    invalid
>/sys/firmware/acpi/interrupts/gpe11:       0    invalid
>/sys/firmware/acpi/interrupts/gpe12:       0    invalid
>/sys/firmware/acpi/interrupts/gpe13:       0    invalid
>/sys/firmware/acpi/interrupts/gpe14:       0    invalid
>/sys/firmware/acpi/interrupts/gpe15:       0    invalid
>/sys/firmware/acpi/interrupts/gpe16:       0    invalid
>/sys/firmware/acpi/interrupts/gpe17:       0    enabled
>/sys/firmware/acpi/interrupts/gpe18:       0    enabled
>/sys/firmware/acpi/interrupts/gpe19:       0    invalid
>/sys/firmware/acpi/interrupts/gpe1A:       0    invalid
>/sys/firmware/acpi/interrupts/gpe1B:       0    invalid
>/sys/firmware/acpi/interrupts/gpe1C:       0    invalid
>/sys/firmware/acpi/interrupts/gpe1D:       0    invalid
>/sys/firmware/acpi/interrupts/gpe1E:       0    invalid
>/sys/firmware/acpi/interrupts/gpe1F:       0    invalid
>/sys/firmware/acpi/interrupts/gpe_all:       0
>/sys/firmware/acpi/interrupts/sci:       0
>
>
>and after 10 times pressing the power button and opening/closing the lid:
>
>/sys/firmware/acpi/interrupts/error:       0
>/sys/firmware/acpi/interrupts/ff_gbl_lock:       0    enabled
>/sys/firmware/acpi/interrupts/ff_pmtimer:       0    invalid
>/sys/firmware/acpi/interrupts/ff_pwr_btn:       0    invalid
>/sys/firmware/acpi/interrupts/ff_rt_clk:       0    disabled
>/sys/firmware/acpi/interrupts/ff_slp_btn:       0    invalid
>/sys/firmware/acpi/interrupts/gpe00:       0    invalid
>/sys/firmware/acpi/interrupts/gpe01:       0    enabled
>/sys/firmware/acpi/interrupts/gpe02:       0    enabled
>/sys/firmware/acpi/interrupts/gpe03:       0    disabled
>/sys/firmware/acpi/interrupts/gpe04:       0    disabled
>/sys/firmware/acpi/interrupts/gpe05:       0    disabled
>/sys/firmware/acpi/interrupts/gpe06:       0    enabled
>/sys/firmware/acpi/interrupts/gpe07:       0    enabled
>/sys/firmware/acpi/interrupts/gpe08:       0    invalid
>/sys/firmware/acpi/interrupts/gpe09:       0    disabled
>/sys/firmware/acpi/interrupts/gpe0A:       0    invalid
>/sys/firmware/acpi/interrupts/gpe0B:       0    enabled
>/sys/firmware/acpi/interrupts/gpe0C:       0    disabled
>/sys/firmware/acpi/interrupts/gpe0D:       0    disabled
>/sys/firmware/acpi/interrupts/gpe0E:       0    disabled
>/sys/firmware/acpi/interrupts/gpe0F:       0    invalid
>/sys/firmware/acpi/interrupts/gpe10:       0    invalid
>/sys/firmware/acpi/interrupts/gpe11:       0    invalid
>/sys/firmware/acpi/interrupts/gpe12:       0    invalid
>/sys/firmware/acpi/interrupts/gpe13:       0    invalid
>/sys/firmware/acpi/interrupts/gpe14:       0    invalid
>/sys/firmware/acpi/interrupts/gpe15:       0    invalid
>/sys/firmware/acpi/interrupts/gpe16:       0    invalid
>/sys/firmware/acpi/interrupts/gpe17:       0    enabled
>/sys/firmware/acpi/interrupts/gpe18:       0    enabled
>/sys/firmware/acpi/interrupts/gpe19:       0    invalid
>/sys/firmware/acpi/interrupts/gpe1A:       0    invalid
>/sys/firmware/acpi/interrupts/gpe1B:       0    invalid
>/sys/firmware/acpi/interrupts/gpe1C:       0    invalid
>/sys/firmware/acpi/interrupts/gpe1D:       0    invalid
>/sys/firmware/acpi/interrupts/gpe1E:       0    invalid
>/sys/firmware/acpi/interrupts/gpe1F:       0    invalid
>/sys/firmware/acpi/interrupts/gpe_all:       0
>/sys/firmware/acpi/interrupts/sci:       0
>
>I cant see any difference...
>
>regards
>
>     sebastian
>>> regards
>>>
>>>     sebastian
>>>
>>>
>>>>> sony/hotkey SPIC 00000001 00000021
>>>>>
>>>>>
>>>>>> run "cat /proc/interrupts" both before and after pressing these buttons,
>>>>>> does the number of ACPI or sony interrupts increase?
>>>>>> If ACPI interrupts increases, please run
>>>>>> "grep . /sys/firmware/acpi/interrupts/*" and tell us which GPE/Fixed
>>>>>> event is fired.
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>> Only the stamina switch and the s2 button increase any interrupts but
>>>>> only sony interrupts are generated.
>>>>>
>>>>>
>>>>>> 
>>>>>>
>>>>>>
>>>>>>
>>>>>>> Should i post them to bugtrackter or
>>>>>>> something else?
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>> please file a new bug report at
>>>>>> http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
>>>>>> and attach all the request info there.
>>>>>> please also attach the acpidump output.
>>>>>>
>>>>>> thanks,
>>>>>> rui
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>> thank you!
>>>>>
>>>>> regards
>>>>>
>>>>>      sebastian
>>>>>
>>>>>
>>>>
>>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

