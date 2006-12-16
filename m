From: "Lincoln Baxter, III" <lincolnbaxter@gmail.com>
Subject: Re: HP nc6400 v.03 or v.05 laptop ACPI fails after reboot, works
 again after booting windows
Date: Sat, 16 Dec 2006 02:59:53 -0500
Message-ID: <4583A779.3000902@gmail.com>
References: <457F37C0.3090003@gmail.com> <1165966936.29844.37.camel@pcjc2lap> <457FB1A1.2030602@gmail.com> <1166012707.22903.4.camel@pcjc2lap> <4582A607.8040302@gmail.com> <1166191807.7459.16.camel@pcjc2lap> <45832339.3050307@gmail.com> <20061216043002.GA29560@tangens.sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.230]:25509 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030714AbWLPH75 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 Dec 2006 02:59:57 -0500
Received: by wx-out-0506.google.com with SMTP id h27so882392wxd
        for <linux-acpi@vger.kernel.org>; Fri, 15 Dec 2006 23:59:57 -0800 (PST)
In-Reply-To: <20061216043002.GA29560@tangens.sinus.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Troller <patrol@sinus.cz>, linux-acpi@vger.kernel.org

Pavel Troller wrote:
> Hi!
>   
> Try the following:
>   cat /proc/acpi/processor/*/power in the following situations:
>   1) After loading the processor module being on the battery,
>   2) After loading the processor module being on AC,
>   3) After disconnecting the AC,
> and compare the results. I think that for 1), you will see more C-states than
> for 2) and that possibly the missing C-states are not added for 3).
>   
Yes, this is correct. The states are not being added for scenario 3).
Here is the output for 1):

sharktop ~ # cat /proc/acpi/processor/CPU1/power
active state:            C3
max_cstate:              C8
bus master activity:     00000000
states:
    C1:                  type[C1] promotion[C2] demotion[--] 
latency[000] usage[00000010] duration[00000000000000000000]
    C2:                  type[C2] promotion[C3] demotion[C1] 
latency[001] usage[00003956] duration[00000000000010489906]
   *C3:                  type[C3] promotion[--] demotion[C2] 
latency[057] usage[00335124] duration[00000000001056908436]


For 2 and 3):

sharktop ~ # cat /proc/acpi/processor/CPU1/power
active state:            C2
max_cstate:              C8
bus master activity:     00000000
states:
    C1:                  type[C1] promotion[C2] demotion[--] 
latency[000] usage[00000010] duration[00000000000000000000]
   *C2:                  type[C2] promotion[--] demotion[C1] 
latency[001] usage[00131021] duration[00000000000232665865]




And the reason the hum seems to go away when AC is plugged back in, is 
because it switches to C2.

I have this question, however. While the CPU is powered down, 
/proc/cpuinfo still shows the full frequency of the chip, at 1823Mhz. 
When I enable cpufrequtils, and clock down the processor, there is no 
change in noise or power consumption, it's still noisy, and it's still . 
If this is the case, then why bother with cpufrequtils in the first 
place... also... I still have the question of why doesn't this happen in 
windows? What power state is windows running in to get as much or more 
battery life, and still have no humming noise?

It seems like the processor module must be doing something that isn't 
quite right. I heard that there's supposed to be a C0, and a C4 power 
state for the core duo processor, but I don't see those in the list of 
options. Any ideas as to why they don't show up?

> It looks that when your machine doesn't hum, it doesn't save so much power.
> Try to change the timer frequency, I suspect that frequency of the hum tracks
> it. Try to set it at 1000 Hz if it's not already there; possibly at this
> frequency, capacitors will do better work and filter the peaks on the power
> bus better. You can also use 100 Hz - maybe the hum will go lower and will be
> less hearable.
>           With regards, Pavel Troller
>   

Yeah. I tried doing this but the result was the same.
Thanks for your help.

