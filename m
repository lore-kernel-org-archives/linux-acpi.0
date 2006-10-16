From: Thomas Renninger <trenn@suse.de>
Subject: Re: powernow-k8 and scaling processor
Date: Mon, 16 Oct 2006 15:26:16 +0200
Message-ID: <1161005176.3639.34.camel@queen.suse.de>
References: <4525054F.1040503@free.fr>  <45337BEA.9030108@free.fr>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:33242 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750774AbWJPNPb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Oct 2006 09:15:31 -0400
In-Reply-To: <45337BEA.9030108@free.fr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Cyril SCETBON <cyril.scetbon@free.fr>
Cc: linux-acpi@vger.kernel.org

On Mon, 2006-10-16 at 14:32 +0200, Cyril SCETBON wrote:
> Scetbon Cyril wrote:
> > Hi people,
> > 
> > My processor is a sempron 3100+ :
> > 
> > cat /proc/cpuinfo
> > 
> > processor       : 0
> > vendor_id       : AuthenticAMD
> > cpu family      : 15
> > model           : 44
> > model name      : Mobile AMD Sempron(tm) 3100+
> > stepping        : 2
> > cpu MHz         : 800.000
> > cache size      : 256 KB
> > fdiv_bug        : no
> > hlt_bug         : no
> > f00f_bug        : no
> > coma_bug        : no
> > fpu             : yes
> > fpu_exception   : yes
> > cpuid level     : 1
> > wp              : yes
> > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
> > mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext fxsr_opt 
> > 3dnowext 3dnow pni lahf_lm ts fid vid ttp tm stc
> > bogomips        : 1598.67
> > 
> > I'm using powernow-k8 module to scale my processor on userspace demand.
> > The frequence of my CPU is 1800MHz but it can't be scaled at more than 
> > 1600MHz :
> > 
> > cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq
> > 
> > 1800000
> > 
> > cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
> > 
> > 1600000
> > 
> > Sometimes the value above is set to 1800000 but I don't know why it's 
> > not always set to cpuinfo_max_freq.
> > 
You might want to monitor your temperature, compare it with the provided
trip points and a have a look whether the machine exceeds a passive trip
point:
"watch -n1
cat /proc/acpi/thermal_zone/*/{temperature,trip_points} /sys/devices/system/cpu/cpu*/cpufreq/{scaling_cur_freq,scaling_max_freq}"

Best is you switch to lowest freq before doing this, then switch to
highest freq (also put 100% load on the CPU e.g. - cat /dev/zero
>/dev/null or glxgears) while having a look at the temperature.

If there is a passive trip point defined and freq is lowered when it's
exceeded, that's normal behaviour. The highest freq should get available
as soon as the machine cooled down a bit again (stop load and reduce
frequency, scaling_max_freq should be highest freq again after a while).
Get your machine a better or additional fan then.

If the machine lowers freq and temperature is not that high, this might
be a bug in BIOS or kernel.

Ahh, if max_freq is lowered because passive temperature has been reached
and is set to highest freq again when machine is cool again and your
userspace application does not switch up to highest speed even you are
on full load, this might be a bug in your userspace cpufreq controlling
program which got confused by temporarily modified max_freq (which one
do you use?) - to verify use ondemand governor, this one should go up
again.

   Thomas

