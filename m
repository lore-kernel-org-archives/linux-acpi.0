From: Thomas Renninger <mail-smMupaH/RwJM7kwft8N7nw@public.gmane.org>
Subject: Re: passive cooling policy
Date: Sun, 12 Sep 2004 11:32:20 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <414417A4.3070009@renninger.de>
References: <413CA0D9.5030901@renninger.de> <20040908085423.GA7785@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040908085423.GA7785-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Dominik,

Dominik Brodowski wrote:
> Hi Thomas,
> 
>>3) If passive limit is reached, kernel throttles cpu and tries to set 
>>cpufreq to lowest step. Only way to find out whether machine is 
>>passively cooled is in polling /proc/acpi/thermal_zone/*/state.
>>(Is it right that cpufreq daemons poll this file to be informed of 
>>kernel forced cpufreq slow downs?)
> 
> Why do cpufreq daemons want to know that? And the ordering is important:
> first scale CPU frequency be means of cpufreq, _then_ throttle the CPU.
Maybe I miss some easy solution to work around this problem, but 
currently I have the problem that:

E.g. machine enters passive cooling mode, cpu usage is high, cpufreq 
daemon sets machine to highest cpufreq step, but it is ignored.
Processor cools down, cpu usage is still high, cpufreq is still in 
lowered step, because the daemon thinks it already set the frequency to 
highest step.

I did a short test some time ago and I thought that kernel does not 
remember userspace cpufreq settings while in passive mode.
I currently see three solutions for this:

Checking whether the cpufreq setting really took place.
Polling whether machine is in passive cooling mode.
Last and for my opinion most proper one is by just send a thermal event 
when entering/leaving passive cooling mode. I saw that some kind of 
hysteresis algorithm is implemented, so the event should not be thrown 
too often.

> 
>>1) inform userspace that cpu speed is increased/decreased through a 
>>thermal event.
>>-> avoid userspace progs polling /proc/acpi/thermal_zone/*/state to be 
>>informed whether the system is slowed down.
> 
> Again, I do not see a reason for why this needs to be exported to userspace.
My main concern is stated above, but it could also be convenient for 
informing the user or monitoring programs.
> 
>>2) Allow setting a passive trip point even BIOS does not export a 
>>passive trip point value and initialise tc1, tc2 and tsp with some 
>>sensible default values.
>>-> you could lower fan activity on every laptop/workstation that 
>>supports throttling/cpufreq regardless whether the BIOS exports any 
>>passive trip points/cooling mode (event most laptop vendors don't care 
>>about trip points).
> 
> As long as this allows an additional, probably lower "trip point" for
> _passive_ cooling, this sounds like a good idea. It cannot hurt as long as
> it doesn't disable the BIOS-initialized active cooling.
I currently have not much time, but I try to have a look at this soon.

     Thomas


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
