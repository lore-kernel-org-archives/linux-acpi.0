From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: halt does not shut the system down
Date: Fri, 12 Oct 2007 14:41:28 +0400
Message-ID: <470F4F58.4080900@gmail.com>
References: <470A58AF.9080402@free.fr> <470C9731.6030200@free.fr> <470F4535.3050004@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.228]:37626 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbXJLKlf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Oct 2007 06:41:35 -0400
Received: by hu-out-0506.google.com with SMTP id 19so457457hue
        for <linux-acpi@vger.kernel.org>; Fri, 12 Oct 2007 03:41:33 -0700 (PDT)
In-Reply-To: <470F4535.3050004@free.fr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: John Sigler <linux.kernel@free.fr>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, robert.moore@intel.com, len.brown@intel.com

Could you please open bug at bugzilla.kernel.org and put all these files there?

Thanks,
Alex.

John Sigler wrote:
> John Sigler wrote:
> 
>> When I run 'halt' the kernel prints:
>>
>> Halting.
>> Shutdown: hdc
>> ACPI: PCI interrupt for device 0000:01:05.0 disabled
>> ACPI: PCI interrupt for device 0000:01:04.0 disabled
>> ACPI: PCI interrupt for device 0000:01:03.0 disabled
>> ACPI: PCI interrupt for device 0000:01:02.0 disabled
>> Power down.
>> acpi_power_off called
>>
>> But the system does not shut down. (The fans keep spinning, the LEDs 
>> keep shining, the LCD keeps displaying.) Basically, the motherboard is 
>> still providing power to every component, as if the power supply had 
>> refused to stop.
>>
>> http://linux.kernel.free.fr/halt/config-2.6.22.1-rt9
>> http://linux.kernel.free.fr/halt/acpidump.txt
>> http://linux.kernel.free.fr/halt/dmesg.txt
>> http://linux.kernel.free.fr/halt/halt.txt
>> http://linux.kernel.free.fr/halt/lspci.txt
> 
> Is there something else I can provide that might help in identifying
> the problem?
> 
> Regards.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

