From: jason hu <huzhijiang@gmail.com>
Subject: Re: acpi_osi Linux report and questions
Date: Sun, 16 Dec 2007 00:35:30 +0530
Message-ID: <4764257A.6000806@gmail.com>
References: <4760BDDC.60602@gmail.com> <200712131606.58331.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:32831 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037AbXLOTQd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 15 Dec 2007 14:16:33 -0500
Received: by py-out-1112.google.com with SMTP id u77so2182517pyb.16
        for <linux-acpi@vger.kernel.org>; Sat, 15 Dec 2007 11:16:31 -0800 (PST)
In-Reply-To: <200712131606.58331.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

The bug number is 9574, reported to kernel bug tracker ACPI (acpi bios)
Thank you!


Len Brown wrote:
> On Thursday 13 December 2007 00:06, jason hu wrote:
>> Hi All,
>>
>> With acpi_osi=Linux, which dmesg suggested, I got something changed in 
>> the dmesg output(I just listed out the most important things):
>>
>>
>> diff !Linux Linux
>> 79c80
>> < Detected 1733.505 MHz processor.
>> ---
>>  > Detected 1733.456 MHz processor.
>> 95c96
>> < Calibrating delay using timer specific routine.. 3470.37 BogoMIPS 
>> (lpj=1735185)
>> ---
>>  > Calibrating delay using timer specific routine.. 3470.36 BogoMIPS 
>> (lpj=1735181)
>> 121c122
>> < Calibrating delay using timer specific routine.. 3466.35 BogoMIPS 
>> (lpj=1733178)
>> ---
>>  > Calibrating delay using timer specific routine.. 3466.36 BogoMIPS 
>> (lpj=1733183)
> 
> These are not important.
> 
>> < PCI: Cannot allocate resource region 7 of bridge 0000:00:06.0
>> < PCI: Cannot allocate resource region 8 of bridge 0000:00:06.0
>> 207c206
>> <   MEM window: disabled.
>> ---
>>  >   MEM window: c0100000-c01fffff
> 
> These may be important.
> 
>> It seems with acpi_osi=Linux, it mainly made the two processors equals 
>> in BogoMIPS and made a PCI device window available.
>>
>> I am not so familiar with ACPI, so can you tell me what is 
>> acpi_osi=Linux used for, and why it made such changes above? Thank you!
> 
> The BIOS uses it to figure out if the OS is compatible with the
> capabilities of Linux.  Unfortunately, the capabilities of Linux
> are changing over time, and mose BIOS detection of Linux leads
> to worse behaviour rather than better...
> 
> Please file a bug report.
> attach the output from acpidump, both dmesg, and the dmidecode output.
> 
> thanks,
> -Len
> 

