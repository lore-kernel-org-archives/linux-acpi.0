From: "S K" <nospamnoham@gmail.com>
Subject: Re: cpufreq doesn't seem to work in Intel Q9300
Date: Thu, 7 Aug 2008 02:35:02 -0700
Message-ID: <514e099a0808070235qd36628cta191018763875422@mail.gmail.com>
References: <514e099a0808030300u140a0ae7m92a2e7294f39f7b7@mail.gmail.com>
	 <48958901.06a0100a.35d6.2df9@mx.google.com>
	 <514e099a0808032206n192fc973u24b31def6555dbec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755234AbYHGMZA@vger.kernel.org>
In-Reply-To: <514e099a0808032206n192fc973u24b31def6555dbec@mail.gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: none <aj504@student.cs.york.ac.uk>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Anyone care to help?

-SK

2008/8/3 S K <nospamnoham@gmail.com>:
> Hi,
>
>  I'm attaching the acpidump output. Can someone (ACPI guys??) please
> me help figure this out?
> Is there any other info that's needed to debug this?
>
> I can be a tester for this and even do some development within the
> limits of my understanding.
>
> Thanks,
> SK
>
> On Sun, Aug 3, 2008 at 3:31 AM, none <aj504@student.cs.york.ac.uk> wrote:
>> S K wrote:
>>> Hi,
>>>
>>>   I have an Intel Core 2 Quad and running kernel
>>> 2.6.25.11-97.fc9.i686. cpufreq doesn't seem to work. The cpufreq
>>> scaling monitor in Gnome says CPU Freq scaling is not supported in my
>>> CPU. The CPU can run at 2.0 and 2.5 GHz but mine always runs at 2.5
>>> GHz in Linux.
>>>
>>> So I checked  /sys and there is no cpufreq dir in /sys/...
>>>
>>> # ls /sys/devices/system/cpu/
>>> cpu0  cpu1  cpu2  cpu3  cpuidle  sched_mc_power_savings
>>> # ls /sys/devices/system/cpu/cpuidle/
>>> current_driver  current_governor_ro
>>>
>>> I have no clue what cpuidle directory is for.
>>>
>>> I added cpufreq.debug=7 in kernel boot params and saw the following in
>>> the dmesg:
>>>
>>> speedstep-smi: No supported Intel CPU detected.
>>> cpufreq-core: CPU 0: _PPC is 0 - frequency not limited
>>> cpufreq-core: CPU 3: _PPC is 0 - frequency not limited
>>> cpufreq-core: CPU 1: _PPC is 0 - frequency not limited
>>> cpufreq-core: CPU 2: _PPC is 0 - frequency not limited
>>> cpuidle: using governor ladder
>>> cpuidle: using governor menu
>>>
>>> I looked at arch/x86/kernel/cpu/cpufreq/speedstep-smi.c and it seems
>>> to detect only Pentium IIIs.
>>>
>>> Anyone know what files have the cpufreq code for Intel Core 2?
>>> Does cpufreq support Intel Core 2 Quads? Especially the Q9300? If not,
>>> anything I can do to help?
>>
>> I have an Intel Core 2 Duo and it uses the ACPI cpufreq driver; your
>> Quad should do the same.  So this is likely an ACPI/BIOS issue.
>>
>> If you ask ACPI people they will ask you to post the output of acpidump.
>> Also you should probably check if you have a BIOS option that needs to be
>> enabled for this to work.
>>
>> BTW, cpuidle is something quite different, it is about how to save power
>> when CPU is doing nothing (i.e. idle :-).  Cpu frequency scaling is how to
>> save power when CPU is working (but doesn't need to run flat out).
>>
>> Alan
>>
>
