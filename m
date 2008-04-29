From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: ACPI on Compaq 6715b - BIOS from the wrong end of the planet
Date: Tue, 29 Apr 2008 16:36:01 -0700
Message-ID: <4817B0E1.7080102@zytor.com>
References: <48144209.7080203@gmail.com>	 <1209476717.1784.853.camel@queen.suse.de>  <4817457C.6000103@gmail.com> <1209493771.1784.892.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:54054 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754591AbYD2XjS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 19:39:18 -0400
In-Reply-To: <1209493771.1784.892.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: Richard <tuxbox.guru@gmail.com>, linux-acpi@vger.kernel.org, "Langsdorf, Mark" <mark.langsdorf@amd.com>, andreas.herrmann3@amd.com

Thomas Renninger wrote:
>>>   
>> Thanks a Million..
>> noapictimer works perfectly ... BUT  .. only on 64Bit.  acpi_pm is not 
>> present on 32bit as a clocksource and it defaulted to jiffies. (tsc was 
>> marked as imreliable)
>>
>> I am really surprised that this Sempron notebook actually had 64Bit CPU 
>> compatibility :D
> 
> This one helps for my Turion.
> AFAIK, another Turion (very similar) does not need this, but I do not
> know for sure.
> 

Is the common denominator here the Turion (and if so, what model 
number), or is it the mainboard or BIOS?  If the latter, it should be 
keyed on a DMI signature instead of the CPU.

	-hpa
