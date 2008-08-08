From: "S K" <nospamnoham@gmail.com>
Subject: Re: cpufreq doesn't seem to work in Intel Q9300
Date: Thu, 7 Aug 2008 21:53:05 -0700
Message-ID: <514e099a0808072153w2e944037gbfbdf8e9156d7df0@mail.gmail.com>
References: <514e099a0808030300u140a0ae7m92a2e7294f39f7b7@mail.gmail.com>
	 <48958901.06a0100a.35d6.2df9@mx.google.com>
	 <514e099a0808032206n192fc973u24b31def6555dbec@mail.gmail.com>
	 <514e099a0808070235qd36628cta191018763875422@mail.gmail.com>
	 <1218159124.6671.32.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:17132 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327AbYHHExG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Aug 2008 00:53:06 -0400
Received: by wr-out-0506.google.com with SMTP id 69so618382wri.5
        for <linux-acpi@vger.kernel.org>; Thu, 07 Aug 2008 21:53:05 -0700 (PDT)
In-Reply-To: <1218159124.6671.32.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: none <aj504@student.cs.york.ac.uk>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Hi,

I already did the cpufreq.debug thing and it was using the
smi_speedstep driver instread of the acpi_speedstep (or whatever is
the right name).

Alan already told me this is likely an ACPI issue. So, I already sent
the acpidump in a prev email (Aug 3rd 08). I'm don't have access to my
home machine right now. Will send it again later if you can't get my
prev email from the archives.

Is lspci output needed for this?

Thanks,
SK

On 8/7/08, Zhao Yakui <yakui.zhao@intel.com> wrote:
> On Thu, 2008-08-07 at 02:35 -0700, S K wrote:
>  > Anyone care to help?
>  >
>  Will you please confirm whether the acpi_cpufreq driver is used on your
>  machine?
>  Please enable CONFIG_CPUFREQ_DEBUG in kernel configuration and boot the
>  system with "cpufreq.debug=7".
>  After the system is booted, please attach the output of dmesg.
>
>  please attach the output of acpidump using the latest pmtools at
>   http://www.lesswatts.org/patches/linux_acpi/
>
>  Of course you can open a new bug in bugzilla and attach the output of
>  dmesg, acpidump, lspci -vxxx.
>
>  http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
>
>  Thanks.
>
> > -SK
>  >
>  > 2008/8/3 S K <nospamnoham@gmail.com>:
>  > > Hi,
>  > >
>  > >  I'm attaching the acpidump output. Can someone (ACPI guys??) please
>  > > me help figure this out?
>  > > Is there any other info that's needed to debug this?
>  > >
>  > > I can be a tester for this and even do some development within the
>  > > limits of my understanding.
>  > >
>  > > Thanks,
>  > > SK
>  > >
>  > > On Sun, Aug 3, 2008 at 3:31 AM, none <aj504@student.cs.york.ac.uk> wrote:
>  > >> S K wrote:
>  > >>> Hi,
>  > >>>
>  > >>>   I have an Intel Core 2 Quad and running kernel
>  > >>> 2.6.25.11-97.fc9.i686. cpufreq doesn't seem to work. The cpufreq
>  > >>> scaling monitor in Gnome says CPU Freq scaling is not supported in my
>  > >>> CPU. The CPU can run at 2.0 and 2.5 GHz but mine always runs at 2.5
>  > >>> GHz in Linux.
>  > >>>
>  > >>> So I checked  /sys and there is no cpufreq dir in /sys/...
>  > >>>
>  > >>> # ls /sys/devices/system/cpu/
>  > >>> cpu0  cpu1  cpu2  cpu3  cpuidle  sched_mc_power_savings
>  > >>> # ls /sys/devices/system/cpu/cpuidle/
>  > >>> current_driver  current_governor_ro
>  > >>>
>  > >>> I have no clue what cpuidle directory is for.
>  > >>>
>  > >>> I added cpufreq.debug=7 in kernel boot params and saw the following in
>  > >>> the dmesg:
>  > >>>
>  > >>> speedstep-smi: No supported Intel CPU detected.
>  > >>> cpufreq-core: CPU 0: _PPC is 0 - frequency not limited
>  > >>> cpufreq-core: CPU 3: _PPC is 0 - frequency not limited
>  > >>> cpufreq-core: CPU 1: _PPC is 0 - frequency not limited
>  > >>> cpufreq-core: CPU 2: _PPC is 0 - frequency not limited
>  > >>> cpuidle: using governor ladder
>  > >>> cpuidle: using governor menu
>  > >>>
>  > >>> I looked at arch/x86/kernel/cpu/cpufreq/speedstep-smi.c and it seems
>  > >>> to detect only Pentium IIIs.
>  > >>>
>  > >>> Anyone know what files have the cpufreq code for Intel Core 2?
>  > >>> Does cpufreq support Intel Core 2 Quads? Especially the Q9300? If not,
>  > >>> anything I can do to help?
>  > >>
>  > >> I have an Intel Core 2 Duo and it uses the ACPI cpufreq driver; your
>  > >> Quad should do the same.  So this is likely an ACPI/BIOS issue.
>  > >>
>  > >> If you ask ACPI people they will ask you to post the output of acpidump.
>  > >> Also you should probably check if you have a BIOS option that needs to be
>  > >> enabled for this to work.
>  > >>
>  > >> BTW, cpuidle is something quite different, it is about how to save power
>  > >> when CPU is doing nothing (i.e. idle :-).  Cpu frequency scaling is how to
>  > >> save power when CPU is working (but doesn't need to run flat out).
>  > >>
>  > >> Alan
>  > >>
>  > >
>
> > --
>  > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>  > the body of a message to majordomo@vger.kernel.org
>  > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
