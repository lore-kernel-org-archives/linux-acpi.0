From: =?UTF-8?B?UGF3ZcWCIFN0YXN6ZXdza2k=?= <pstaszewski@itcare.pl>
Subject: Re: Strange CPU load - acpi_os_read_port
Date: Thu, 19 Aug 2010 11:11:50 +0200
Message-ID: <4C6CF556.7030301@itcare.pl>
References: <4C489E58.7020604@itcare.pl> <alpine.LFD.2.00.1008142331000.2294@localhost.localdomain> <4C67C092.8060808@itcare.pl> <alpine.LFD.2.00.1008150958320.2313@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from r242-33.iq.pl ([86.111.242.33]:34706 "EHLO smtp.iq.pl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751895Ab0HSJS2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Aug 2010 05:18:28 -0400
In-Reply-To: <alpine.LFD.2.00.1008150958320.2313@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

W dniu 2010-08-15 16:05, Len Brown pisze:
>>>>                2217.00 13.7% acpi_os_read_port
>>>>
>>>>          
>>> curious.
>>> does /proc/interrupts show you are receiving acpi interrupts?
>>> if yes, what do you see with 'grep . /sys/firmware/acpi/interrupts/*'?
>>>
>>>        
cat /proc/interrupts | grep acpi
    9:          0          0          0          0          0          
0          0          0          0          0          0          
0          0          0          0          0   IO-APIC-fasteoi   acpi

No interrupts

/sys/firmware/acpi/interrupts/error:       0
/sys/firmware/acpi/interrupts/ff_gbl_lock:       0      enabled
/sys/firmware/acpi/interrupts/ff_pmtimer:       0       invalid
/sys/firmware/acpi/interrupts/ff_pwr_btn:       0       enabled
/sys/firmware/acpi/interrupts/ff_rt_clk:       0        disabled
/sys/firmware/acpi/interrupts/ff_slp_btn:       0       invalid
/sys/firmware/acpi/interrupts/gpe00:       0    invalid
/sys/firmware/acpi/interrupts/gpe01:       0    invalid
/sys/firmware/acpi/interrupts/gpe02:       0    disabled
/sys/firmware/acpi/interrupts/gpe03:       0    disabled
/sys/firmware/acpi/interrupts/gpe04:       0    disabled
/sys/firmware/acpi/interrupts/gpe05:       0    disabled
/sys/firmware/acpi/interrupts/gpe06:       0    enabled
/sys/firmware/acpi/interrupts/gpe07:       0    invalid
/sys/firmware/acpi/interrupts/gpe08:       0    enabled
/sys/firmware/acpi/interrupts/gpe09:       0    disabled
/sys/firmware/acpi/interrupts/gpe0A:       0    enabled
/sys/firmware/acpi/interrupts/gpe0B:       0    disabled
/sys/firmware/acpi/interrupts/gpe0C:       0    disabled
/sys/firmware/acpi/interrupts/gpe0D:       0    disabled
/sys/firmware/acpi/interrupts/gpe0E:       0    disabled
/sys/firmware/acpi/interrupts/gpe0F:       0    invalid
/sys/firmware/acpi/interrupts/gpe10:       0    invalid
/sys/firmware/acpi/interrupts/gpe11:       0    invalid
/sys/firmware/acpi/interrupts/gpe12:       0    invalid
/sys/firmware/acpi/interrupts/gpe13:       0    invalid
/sys/firmware/acpi/interrupts/gpe14:       0    invalid
/sys/firmware/acpi/interrupts/gpe15:       0    invalid
/sys/firmware/acpi/interrupts/gpe16:       0    invalid
/sys/firmware/acpi/interrupts/gpe17:       0    invalid
/sys/firmware/acpi/interrupts/gpe18:       0    invalid
/sys/firmware/acpi/interrupts/gpe19:       0    invalid
/sys/firmware/acpi/interrupts/gpe1A:       0    invalid
/sys/firmware/acpi/interrupts/gpe1B:       0    invalid
/sys/firmware/acpi/interrupts/gpe1C:       0    invalid
/sys/firmware/acpi/interrupts/gpe1D:       0    invalid
/sys/firmware/acpi/interrupts/gpe1E:       0    enabled
/sys/firmware/acpi/interrupts/gpe1F:       0    invalid
/sys/firmware/acpi/interrupts/gpe20:       0    disabled
/sys/firmware/acpi/interrupts/gpe21:       0    invalid
/sys/firmware/acpi/interrupts/gpe22:       0    invalid
/sys/firmware/acpi/interrupts/gpe23:       0    invalid
/sys/firmware/acpi/interrupts/gpe24:       0    invalid
/sys/firmware/acpi/interrupts/gpe25:       0    invalid
/sys/firmware/acpi/interrupts/gpe26:       0    invalid
/sys/firmware/acpi/interrupts/gpe27:       0    invalid
/sys/firmware/acpi/interrupts/gpe28:       0    invalid
/sys/firmware/acpi/interrupts/gpe29:       0    invalid
/sys/firmware/acpi/interrupts/gpe2A:       0    invalid
/sys/firmware/acpi/interrupts/gpe2B:       0    invalid
/sys/firmware/acpi/interrupts/gpe2C:       0    invalid
/sys/firmware/acpi/interrupts/gpe2D:       0    invalid
/sys/firmware/acpi/interrupts/gpe2E:       0    invalid
/sys/firmware/acpi/interrupts/gpe2F:       0    invalid
/sys/firmware/acpi/interrupts/gpe30:       0    invalid
/sys/firmware/acpi/interrupts/gpe31:       0    invalid
/sys/firmware/acpi/interrupts/gpe32:       0    invalid
/sys/firmware/acpi/interrupts/gpe33:       0    invalid
/sys/firmware/acpi/interrupts/gpe34:       0    invalid
/sys/firmware/acpi/interrupts/gpe35:       0    invalid
/sys/firmware/acpi/interrupts/gpe36:       0    invalid
/sys/firmware/acpi/interrupts/gpe37:       0    invalid
/sys/firmware/acpi/interrupts/gpe38:       0    invalid
/sys/firmware/acpi/interrupts/gpe39:       0    invalid
/sys/firmware/acpi/interrupts/gpe3A:       0    invalid
/sys/firmware/acpi/interrupts/gpe3B:       0    invalid
/sys/firmware/acpi/interrupts/gpe3C:       0    invalid
/sys/firmware/acpi/interrupts/gpe3D:       0    invalid
/sys/firmware/acpi/interrupts/gpe3E:       0    invalid
/sys/firmware/acpi/interrupts/gpe3F:       0    invalid
/sys/firmware/acpi/interrupts/gpe_all:       0
/sys/firmware/acpi/interrupts/sci:       0
/sys/firmware/acpi/interrupts/sci_not:       0

>>> what do you see with
>>> grep . /sys/devices/system/cpu/cpu*/cpuidle/*/*
>>>
>>>        
ls /sys/devices/system/cpu/cpu0/
cache  crash_notes  node0  thermal_throttle  topology

no cpuidle dir.
grep . /sys/devices/system/cpu/cpuidle/*
/sys/devices/system/cpu/cpuidle/current_driver:acpi_idle
/sys/devices/system/cpu/cpuidle/current_governor_ro:ladder

>>> and if there are IO states, any change if you boot with "idle=halt" or
>>> "idle=mwait"?
>>>        
>    
>> I can try to reproduce this again but it will take some time.
>>
>> For now the solution for me was:
>>
>> Change configuration for this host and boot with processor.max_cstate=0
>>      
> likely it will come back when you remove processor.max_cstate=0,
> and it will go away if you use either idle=halt or idle=mwait or
> processor.max_cstate=1, which are effectively the same.
> (and all preferable to processor.max_cstate-0 from a power
> saving point of view)
>
> If this is true, then you should try processor.max_cstate=N
> where N is 2, 3 etc, depending on the states shown in the
> cpuidle grep above.
>
> If you open a bugzilla and attach the output from acpidump,
> that may also be helpful.  If this is due to c-states, the question
> is if for some reason we are not using them optimally.
> If we already are doing what the platform allows, the
> route might be to use PM_QOS to disable states that
> are too expensive.
> (Documentation/power/pm_qos_interface.txt)
>
> cheers,
> Len Brown, Intel Open Source Technology Center.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>    

