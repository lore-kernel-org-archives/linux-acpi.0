From: Richard <tuxbox.guru@gmail.com>
Subject: Re: ACPI on Compaq 6715b - BIOS from the wrong end of the planet
Date: Wed, 30 Apr 2008 09:30:39 +0100
Message-ID: <48182E2F.4080000@gmail.com>
References: <48144209.7080203@gmail.com>	 <1209476717.1784.853.camel@queen.suse.de>  <4817457C.6000103@gmail.com> <1209493771.1784.892.camel@queen.suse.de> <4817B0E1.7080102@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:6508 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757297AbYD3Iax (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Apr 2008 04:30:53 -0400
Received: by nf-out-0910.google.com with SMTP id d3so192229nfc.21
        for <linux-acpi@vger.kernel.org>; Wed, 30 Apr 2008 01:30:48 -0700 (PDT)
In-Reply-To: <4817B0E1.7080102@zytor.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: trenn@suse.de, linux-acpi@vger.kernel.org, "Langsdorf, Mark" <mark.langsdorf@amd.com>, andreas.herrmann3@amd.com

H. Peter Anvin wrote:
> Thomas Renninger wrote:
>>>>   
>>> Thanks a Million..
>>> noapictimer works perfectly ... BUT  .. only on 64Bit.  acpi_pm is 
>>> not present on 32bit as a clocksource and it defaulted to jiffies. 
>>> (tsc was marked as imreliable)
>>>
>>> I am really surprised that this Sempron notebook actually had 64Bit 
>>> CPU compatibility :D
>>
>> This one helps for my Turion.
>> AFAIK, another Turion (very similar) does not need this, but I do not
>> know for sure.
>>
>
> Is the common denominator here the Turion (and if so, what model 
> number), or is it the mainboard or BIOS?  If the latter, it should be 
> keyed on a DMI signature instead of the CPU.
>
>     -hpa
>
I have all the grief on a Sempron/ATI  system

model name      : Mobile AMD Sempron(tm) Processor 3600+

If I specify nolapic,noapic or acpi=noirq on kernel boot, the machine  
goes  in  to VERY slow motion  (5 minutes to boot!)   the noapictimer 
option was the magic keyword in my case and I am going to dig in to the 
code to see what things this setting fudges with :-)

Best Regards
Richard


