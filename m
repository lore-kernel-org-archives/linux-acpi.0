From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: cpufreq doesn't seem to work in Intel Q9300
Date: Thu, 07 Aug 2008 20:24:19 +0100
Message-ID: <g7fi53$oqg$1@ger.gmane.org>
References: <514e099a0808030300u140a0ae7m92a2e7294f39f7b7@mail.gmail.com>	 <48958901.06a0100a.35d6.2df9@mx.google.com>	 <514e099a0808032206n192fc973u24b31def6555dbec@mail.gmail.com> <514e099a0808070235qd36628cta191018763875422@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755105AbYHHHaY@vger.kernel.org>
In-Reply-To: <514e099a0808070235qd36628cta191018763875422@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

S K wrote:
> 2008/8/3 S K <nospamnoham@gmail.com>:
>> On Sun, Aug 3, 2008 at 3:31 AM, none <aj504@student.cs.york.ac.uk> wrote:
>>> S K wrote:
>>>> Hi,
>>>>
>>>>   I have an Intel Core 2 Quad and running kernel
>>>> 2.6.25.11-97.fc9.i686. cpufreq doesn't seem to work. The cpufreq
>>>> scaling monitor in Gnome says CPU Freq scaling is not supported in my
>>>> CPU. The CPU can run at 2.0 and 2.5 GHz but mine always runs at 2.5
>>>> GHz in Linux.
>>>>
>>>> So I checked  /sys and there is no cpufreq dir in /sys/...
>>>>
>>>> # ls /sys/devices/system/cpu/
>>>> cpu0  cpu1  cpu2  cpu3  cpuidle  sched_mc_power_savings
>>>> # ls /sys/devices/system/cpu/cpuidle/
>>>> current_driver  current_governor_ro
>>>>
>>>> I have no clue what cpuidle directory is for.
>>>>
>>>> I added cpufreq.debug=7 in kernel boot params and saw the following in
>>>> the dmesg:
>>>>
>>>> speedstep-smi: No supported Intel CPU detected.
>>>> cpufreq-core: CPU 0: _PPC is 0 - frequency not limited
>>>> cpufreq-core: CPU 3: _PPC is 0 - frequency not limited
>>>> cpufreq-core: CPU 1: _PPC is 0 - frequency not limited
>>>> cpufreq-core: CPU 2: _PPC is 0 - frequency not limited
>>>> cpuidle: using governor ladder
>>>> cpuidle: using governor menu
>>>>
>>>> I looked at arch/x86/kernel/cpu/cpufreq/speedstep-smi.c and it seems
>>>> to detect only Pentium IIIs.
>>>>
>>>> Anyone know what files have the cpufreq code for Intel Core 2?
>>>> Does cpufreq support Intel Core 2 Quads? Especially the Q9300? If not,
>>>> anything I can do to help?
>>> I have an Intel Core 2 Duo and it uses the ACPI cpufreq driver; your
>>> Quad should do the same.  So this is likely an ACPI/BIOS issue.
>>>
>>> If you ask ACPI people they will ask you to post the output of acpidump.
>>> Also you should probably check if you have a BIOS option that needs to be
>>> enabled for this to work.
>>>
>>> BTW, cpuidle is something quite different, it is about how to save power
>>> when CPU is doing nothing (i.e. idle :-).  Cpu frequency scaling is how to
>>> save power when CPU is working (but doesn't need to run flat out).
>>>
>>> Alan
>>>
>> Hi,
>>
>>  I'm attaching the acpidump output. Can someone (ACPI guys??) please
>> me help figure this out?
>> Is there any other info that's needed to debug this?
>>
>> I can be a tester for this and even do some development within the
>> limits of my understanding.
>>
>> Thanks,
>> SK
>>
> Anyone care to help?
> 
> -SK

Please don't top-post!

According to the online ACPI spec, the BIOS should expose _PCT, _PSS and PPC objects if it supports multiple CPU performance states (aka P-states, cpufreq).  I ran your acpidump.txt through acpixtract to generate the DSDT, and decompiled it using iasl.  It did not contain any of _PCT, _PSS and _PPC.

Again, it is possible this is an option in your BIOS which is currently disabled.  You need to go into your BIOS setup screen and see if you can find any relevant options.

If possible, find out whether cpu frequency scaling works in windows.  If it doesn't work in windows, it's very unlikely to work on linux.  Linux ACPI aims for bug-for-bug compatibility with Windows, which is what manufacturers test their product against.

There may be other possibilities.  Your acpidump output did not appear to include a SSDT, which is another place these objects might be found.  My computer suffered from a bug where linux could not find the SSDT (<http://bugzilla.kernel.org/show_bug.cgi?id=8630>).  This bug was relatively simple and was fixed.  However there might be something similar going on.  IIRC from last time, SSDTs or similar can also be loaded dynamically by the AML code in the DSDT, so maybe something goes wrong there.

Regards
Alan
