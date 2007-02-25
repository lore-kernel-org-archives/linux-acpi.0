From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: breakage in current git-acpi
Date: Sun, 25 Feb 2007 17:20:58 +0300
Message-ID: <45E19B4A.2000303@linux.intel.com>
References: <20070216223956.d04af327.akpm@linux-foundation.org>	<200702170225.07774.lenb@kernel.org>	<20070216234948.6bf2ed82.akpm@linux-foundation.org>	<200702172159.03332.lenb@kernel.org>	<20070217190755.e708effd.akpm@linux-foundation.org> <20070225005417.a9e2245a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:35335 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964865AbXBYOVE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 25 Feb 2007 09:21:04 -0500
In-Reply-To: <20070225005417.a9e2245a.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

Andrew Morton wrote:
>> On Sat, 17 Feb 2007 19:07:55 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:
>> On Sat, 17 Feb 2007 21:59:02 -0500 Len Brown <lenb@kernel.org> wrote:
>>
>>     
>>> Assuming there is exactly 1 event for each press,
>>> then the kernel part of this is healthy.
>>>
>>> Assuming the failure is that the lid event fails
>>> to trigger the STD after a few iterations,
>>> and you did this after the failure started;
>>> then it seems the failure isn't the event
>>> at all, but perhaps the inability to re-invoke STD.
>>>
>>> What happens if you invoke STD manually with
>>> # echo disk > /sys/power/state
>>>       
>> That works OK.
>>
>>     
>>>> 9:       1344   IO-APIC-fasteoi   acpi
>>>>
>>>> it's increasing even while the machine is just sitting there.
>>>>         
>>> That's okay -- it is common -- particularly
>>> laptops, which are likely to have a number of events ticking away.
>>> thermal and fan control, and battery state, in particular.
>>>  
>>>       
>>>>> Also, you should be able to see the state of the lid in a file under /proc/acpi/button/*/
>>>>>           
>>>> sony:/home/akpm# cat /proc/acpi/button/lid/LID0/state
>>>> state:      closed
>>>> sony:/home/akpm# cat /proc/acpi/button/lid/LID0/state
>>>> state:      open
>>>>
>>>> all seems well.
>>>>
>>>> Stopping and restarting acpid doesn't fix it.
>>>>         
>>> Yeah, it must be suspend-to-disk itself refusing to suspend.
>>> Probably when automatically invoked any errors or warnings
>>> get sent to /dev/null.
>>> Are there any dmesg associated with the failed suspend attempt?
>>>       
>> No messages come out when I shut the lid.
>>
>> Manually suspending works normally.
>>
>>     
>>> How many suspend cycles can you survive before git-acpi is applied?
>>>       
>> I tested up to five or six times once.
>>     
>
> So..  I went from 2.6.20-mm1 back to 2.6.21-rc1 the other day and have
> since been happily suspending via lid closure maybe ten times a day.
>
> Any more suggestions about how to debug this?
>
> How does the suspend happen, anyway?  Is it acpid's job to read the
> LID0/state file and to then poke /sys/power/state?  Or is that linkage
> in-kernel?
>   
It is done by userspace utilities, either acpid (if there is action 
/etc/acpid/) or hald and desktop...
Last changes to buttons was export their events into input layer. May by 
this confuses hald which can
see same event twice -- once from acpid and the other from input layer...
button.c sends event into /proc/acpi/events and _now_ into input layer
acpid reads /proc/acpi/events and either performs action from /etc/acpid 
or sends them higher (hald)
someone reads event from input layer or hald and then writes into 
/sys/power/state...
The patch to insert input layer into buttons is from Dmitry Torokhov, 
may be he can give some more explanations...
May be you could revert the patch in question and see if it helps. It is 
not dependent to any other ACPI changes.

Regards,
    Alex.
