From: Richard <tuxbox.guru@gmail.com>
Subject: Re: 2.6.25 pci=noacpi
Date: Thu, 08 May 2008 08:23:32 +0100
Message-ID: <4822AA74.3080300@gmail.com>
References: <20080425183807.366134771@ldl.fc.hp.com>	 <200805010110.40709.lenb@kernel.org>	<48196CC5.6070704@gmail.com>	 <200805011159.38059.lenb@kernel.org>	<481AF995.3000305@gmail.com>	 <20080502054729.a91e601c.akpm@linux-foundation.org>	 <481B12FE.1050805@gmail.com> <1210155584.13141.22.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:16178 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755166AbYEHHXi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 May 2008 03:23:38 -0400
Received: by ug-out-1314.google.com with SMTP id h2so15721ugf.16
        for <linux-acpi@vger.kernel.org>; Thu, 08 May 2008 00:23:37 -0700 (PDT)
In-Reply-To: <1210155584.13141.22.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Jaroslav Kysela <perex@perex.cz>

Thomas Renninger wrote:
> On Fri, 2008-05-02 at 14:11 +0100, Richard wrote:
>   
>> Andrew Morton wrote:
>>     
>>> On Fri, 02 May 2008 12:23:01 +0100 Richard <tuxbox.guru@gmail.com> wrote:
>>>
>>>   
>>>       
>>>> Len Brown wrote:
>>>>     
>>>>         
>>>>> On Thursday 01 May 2008, Richard wrote:
>>>>>   
>>>>>       
>>>>>           
>>>>>> Len Brown wrote:
>>>>>>     
>>>>>>         
>>>>>>             
>>>>>>> On Tuesday 29 April 2008, Richard wrote:
>>>>>>>   
>>>>>>>       
>>>>>>>           
>>>>>>>               
>>>>>>>> Hi there,
>>>>>>>>
>>>>>>>> Now I am at a loss.. I cant get any logs from netconsole. With ACPI
>>>>>>>> enabled it drops dead just after the kernel hands control to Init. When
>>>>>>>> I reboot with acpi disabled there is no trace of the previous boot in
>>>>>>>> /var/log/message or kernel logs.
>>>>>>>>
>>>>>>>> The network card I have is a Tigon3 and its not initialised before the
>>>>>>>> system dies... or so it looks (altho I cant seem to get any netconsole
>>>>>>>> working - I suspect pebkac)
>>>>>>>>
>>>>>>>> I have tried to find an option where the kernel boot is logged
>>>>>>>> explicitly to disk, but I cant seem to find the option. There is so much
>>>>>>>> chaff I cant seem to get my brain to find the REAL options list thats up
>>>>>>>> to date.
>>>>>>>>
>>>>>>>> Any pointers are appreciated
>>>>>>>>     
>>>>>>>>         
>>>>>>>>             
>>>>>>>>                 
>>>>>>> go fishing with this bait:
>>>>>>>
>>>>>>> idle=poll
>>>>>>> acpi=noirq
>>>>>>>
>>>>>>> -Len
>>>>>>>
>>>>>>>   
>>>>>>>       
>>>>>>>           
>>>>>>>               
>>>>>> Thanks :-) With help from Thomas (and his team) , noapictimer seems to
>>>>>> have fixed the symptom.. now its to hunt for the cure :-)
>>>>>>     
>>>>>>         
>>>>>>             
>>>>> if the problem is the apic timer stopping during C-states,
>>>>> then you should find that idle=poll will also work around the problem.
>>>>> If idle=poll does not work around it but noapictimer does, then
>>>>> the problem is the apic timer when the system is non-idle.
>>>>>
>>>>> -Len
>>>>>
>>>>>   
>>>>>       
>>>>>           
>>>> Hi Len,
>>>>
>>>> thanks - the idle=poll works to fix the problem.
>>>>     
>>>>         
>>> Well, that's hardly a "fix".  The power consumption will be very high.
>>>
>>>   
>>>       
>> Hehehe, its a start. A booting kernel is definitely a good start (even 
>> one what drinks battery). I have some avenues in the source to 
>> investigate, but being a ACPI n00bie its trying to get my head around 
>> the mass of code thats a daunting task.
>>     
>
> Richard, could you try processor.max_cstate=2 (or even 1), pls (without
> noapictimer).
> Or you can double check whether you have cstates at all first(when
> booting with noapictimer):
> cat /proc/acpi/processor/*/power
>
> Vendors often invalidate deeper sleep states with an invalid latency.
> Maybe this has been forgotten here, Windows does not use deeper C-state
> or it works there for some reason.
> If this works for you, please send dmidecode output.
> IMO we should then blacklist this machine in
> drivers/acpi/processor_idle.c to not use the offending sleep state.
> There already is a blacklist.
>
> Thanks,
>
>    Thomas
>
>
>   
Hi Thomas (and all)

I tried the processor.max_cstate=2 to no avail.   on a 23, 24 and a .25 
kernel :-P   The machine shuts  down just after INIT  starts.


Richard


------------- This is reported when booted with noapictimer ----------------
cat /proc/acpi/processor/*/power
active state:            C0
max_cstate:              C8
bus master activity:     00000000
maximum allowed latency: 6666 usec
states:
    C1:                  type[C1] promotion[--] demotion[--] 
latency[000] usage[00082490] duration[00000000000000000000]
    C2:                  type[C2] promotion[--] demotion[--] 
latency[018] usage[00000000] duration[00000000000000000000]
    C3:                  type[C3] promotion[--] demotion[--] 
latency[083] usage[00000000] duration[00000000000000000000]
----------------------------------------------------------------------------------




