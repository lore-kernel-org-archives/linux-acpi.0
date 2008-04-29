From: Richard <tuxbox.guru@gmail.com>
Subject: Re: ACPI on Compaq 6715b - BIOS from the wrong end of the planet
Date: Tue, 29 Apr 2008 16:57:48 +0100
Message-ID: <4817457C.6000103@gmail.com>
References: <48144209.7080203@gmail.com> <1209476717.1784.853.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:58310 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbYD2P5z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 11:57:55 -0400
Received: by nf-out-0910.google.com with SMTP id d3so44033nfc.21
        for <linux-acpi@vger.kernel.org>; Tue, 29 Apr 2008 08:57:53 -0700 (PDT)
In-Reply-To: <1209476717.1784.853.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: linux-acpi@vger.kernel.org

Thomas Renninger wrote:
> On Sun, 2008-04-27 at 10:06 +0100, Richard wrote:
>   
>> Hi all,
>>
>> Pardon for the intrusion, I am trying to fault find a horrible wrong 
>> ACPI interface and fix it.
>>
>> the problem is as follows... 
>>
>> Kernel 2.6.23 works fine, except there is no stable clocksource.. 
>> acpi_pm, tsc doesnt work and jiffies .. well thats just jiffies. The 
>> kernel boots but time sources are erratic and this results in an 
>> unstable clock (Mp3's play at erratic speeds)
>>
>> Kernel 2.6.25 hangs the system if I enable ACPI Timer and rebuild/boot 
>> the new linux kernel. The only clock sources are tsc and jiffies and TSC 
>> is disables due to being erratic. If I totally disable ACPI, the kernel 
>> boots and works with stable clocks..  but obviously Power management is 
>> gone.
>>
>> The system is an ATI bridged AMD Sempron notebook. I have tried Millions 
>> of options in the kernel bootup and none seem to do clear the problem. 
>> This system seems to suffer from the Clocks fast bug. (the dmesg reports 
>> that the 8254 clock is disables, IO-APIC int0 fails and IO-APIC Vritual 
>> wire is OK.. if that means anything :D)
>>
>> Any pointers.. and if anyone wants the AML/ACPI stuff, please feel free 
>> to shout.
>>     
> Does:
> disable_timer_pin_1
> or
> noapictimer
> work?
>
>    Thomas
>
>
>   

Thanks a Million..
noapictimer works perfectly ... BUT  .. only on 64Bit.  acpi_pm is not 
present on 32bit as a clocksource and it defaulted to jiffies. (tsc was 
marked as imreliable)

I am really surprised that this Sempron notebook actually had 64Bit CPU 
compatibility :D

Richard

