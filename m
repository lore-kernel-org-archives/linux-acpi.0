From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: Regression: 20 ACPI interrupts per second on EEEPC 4G
Date: Sat, 11 Apr 2009 10:14:43 +0100
Message-ID: <49E05F83.2090500@tuffmail.co.uk>
References: <49DF6835.9040501@tuffmail.co.uk> <49DFE345.3010109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:12926 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754858AbZDKJKG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Apr 2009 05:10:06 -0400
In-Reply-To: <49DFE345.3010109@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kernel Testers List <kernel-testers@vger.kernel.org>

Alexey Starikovskiy wrote:
> Alan Jenkins wrote:
>> On latest git, powertop shows 20 ACPI interrupts per second.  
>> Previously, this was closer to 1 per second.  See attached output (a 
>> vs b, "a" is from 2.6.29-rc8).
>>
>> This is from a pretty sparse KDE desktop.  Normally I run 
>> gnome-power-manager, but I killed it to make sure that wasn't causing 
>> any problems.
>>

>> gpe18:   60975  enabled
>> gpe_all:   60975
>> sci:   60975
>>
>> which I presume means lots of EC interrupts.
>>
>> [    0.134068] ACPI: EC: GPE = 0x18, I/O: command/status = 0x66, data 
>> = 0x62
>>

> This patch looks to be a suspect: 
> 34ff4dbccccce54c83b1234d39b7ad9e548a75dd,
> Please check if reversing it helps

No, I still get 20 ACPI interrupts per second.

I tried without powertop, just in case that was provoking it, but it 
still happens:

alan@alan-eeepc:/sys/firmware/acpi/interrupts$ cat sci; sleep 5; cat sci
    2583
    2680

Thanks
Alan
