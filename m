From: "Patrizio Bassi" <patrizio.bassi@gmail.com>
Subject: Re: ACPI cpufreq broken on 2.6.22 for core2 duo
Date: Tue, 17 Jul 2007 10:00:58 +0200
Message-ID: <742b1fb30707170100p6ed81c7dq40ed8c56b5331196@mail.gmail.com>
References: <742b1fb30707170026k382ea0enb033c6be62eecc33@mail.gmail.com>
	 <823A93EED437D048963A3697DB0E35DE781EA7@pdsmsx414.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:13547 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757046AbXGQIA7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jul 2007 04:00:59 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1886143wah
        for <linux-acpi@vger.kernel.org>; Tue, 17 Jul 2007 01:00:58 -0700 (PDT)
In-Reply-To: <823A93EED437D048963A3697DB0E35DE781EA7@pdsmsx414.ccr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org

2007/7/17, Zhang, Rui <rui.zhang@intel.com>:
> Hi, Patrizio,
>
> > > ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device
> is
> > > not present [20070126]
> > > ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device
> is
> > > not present [20070126]
> This is just a debug message output and should have no impact on the
> cpufreq driver.
> Please try the patch at
> http://bugzilla.kernel.org/show_bug.cgi?id=8570#c21
>
> >Seems the issue was somehow related to my bios, but i don't understand
> >why windows worked. Now it's working ok,
> So the cpufreq problem is already fixed, right?
>
> Thanks,
> Rui
>
> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org
> [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Patrizio Bassi
> Sent: Tuesday, July 17, 2007 3:26 PM
> To: Andrew Morton
> Cc: linux-acpi@vger.kernel.org
> Subject: Re: ACPI cpufreq broken on 2.6.22 for core2 duo
>
> 2007/7/17, Andrew Morton <akpm@linux-foundation.org>:
> > On Sat, 14 Jul 2007 13:55:24 +0200 Patrizio Bassi
> <patrizio.bassi@gmail.com> wrote:
> >
> > > With linux 2.6.21 and 22 i cannot get cpufreq working anymore while
> it
> > > worked in previous versions
> > >
> > > ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device
> is
> > > not present [20070126]
> > > ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device
> is
> > > not present [20070126]
> > >
> > > i'm in 64bit profile.
> > > Bios updated to latest version.
> > >
> > > CC me as i'm not subscribed.
> > >
> > >
> > > cat /proc/cpuinfo
> > > processor       : 0
> > > vendor_id       : GenuineIntel
> > > cpu family      : 6
> > > model           : 15
> > > model name      : Intel(R) Core(TM)2 CPU          6300  @ 1.86GHz
> > > stepping        : 6
> > > cpu MHz         : 1866.667
> > > cache size      : 2048 KB
> > > physical id     : 0
> > > siblings        : 2
> > > core id         : 0
> > > cpu cores       : 2
> > > fpu             : yes
> > > fpu_exception   : yes
> > > cpuid level     : 10
> > > wp              : yes
> > > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
> pge
> > > mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
> syscall
> > > nx lm constant_tsc pni monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr
> lahf_lm
> > > bogomips        : 3735.47
> > > clflush size    : 64
> > > cache_alignment : 64
> > > address sizes   : 36 bits physical, 48 bits virtual
> > > power management:
> > >
> > > processor       : 1
> > > vendor_id       : GenuineIntel
> > > cpu family      : 6
> > > model           : 15
> > > model name      : Intel(R) Core(TM)2 CPU          6300  @ 1.86GHz
> > > stepping        : 6
> > > cpu MHz         : 1866.667
> > > cache size      : 2048 KB
> > > physical id     : 0
> > > siblings        : 2
> > > core id         : 1
> > > cpu cores       : 2
> > > fpu             : yes
> > > fpu_exception   : yes
> > > cpuid level     : 10
> > > wp              : yes
> > > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
> pge
> > > mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
> syscall
> > > nx lm constant_tsc pni monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr
> lahf_lm
> > > bogomips        : 3733.31
> > > clflush size    : 64
> > > cache_alignment : 64
> > > address sizes   : 36 bits physical, 48 bits virtual
> > > power management:
> >
> > (switched mailing lists)
> >
> > Please raise a report against acpi at bugzilla.kernel.org for this,
> > thanks.
> >
>
>
> Hi Andrew,
>
> this is already reported in
> http://bugzilla.kernel.org/show_bug.cgi?id=8630
> and
> http://bugzilla.kernel.org/show_bug.cgi?id=8570
>
> Seems the issue was somehow related to my bios, but i don't understand
> why windows worked.
> Now it's working ok, but i still have the
>
> "AE_NOT_FOUND, Processor Device is not present [20070126]"
> warning.
>
> Seems a patch is available here for the warning fix:
> http://bugzilla.kernel.org/show_bug.cgi?id=8570
>
>

I will try the patch, but as you said is cosmetic. CPU freq is fixed for me.
I just have an issue that i didn't have before:

 LC_ALL="C" cpufreq-info
cpufrequtils 002: cpufreq-info (C) Dominik Brodowski 2004-2006
Report errors and bugs to linux@brodo.de, please.
analyzing CPU 0:
  driver: acpi-cpufreq
  CPUs which need to switch frequency at the same time: 0
  hardware limits: 1.60 GHz - 1.86 GHz
  available frequency steps: 1.86 GHz, 1.60 GHz
  available cpufreq governors: ondemand, powersave, performance
  current policy: frequency should be within 1.60 GHz and 1.86 GHz.
                  The governor "ondemand" may decide which speed to use
                  within this range.
  current CPU frequency is 1.60 GHz (asserted by call to hardware).
analyzing CPU 1:
  driver: acpi-cpufreq
  CPUs which need to switch frequency at the same time: 1
  hardware limits: 1.60 GHz - 1.86 GHz
  available frequency steps: 1.86 GHz, 1.60 GHz
  available cpufreq governors: ondemand, powersave, performance
  current policy: frequency should be within 1.60 GHz and 1.86 GHz.
                  The governor "performance" may decide which speed to use
                  within this range.
  current CPU frequency is 1.60 GHz (asserted by call to hardware).




from user:

cpufrequtils 002: cpufreq-info (C) Dominik Brodowski 2004-2006
Report errors and bugs to linux@brodo.de, please.
analyzing CPU 0:
  driver: acpi-cpufreq
  CPUs which need to switch frequency at the same time: 0
  hardware limits: 1.60 GHz - 1.86 GHz
  available frequency steps: 1.86 GHz, 1.60 GHz
  available cpufreq governors: ondemand, powersave, performance
  current policy: frequency should be within 1.60 GHz and 1.86 GHz.
                  The governor "ondemand" may decide which speed to use
                  within this range.
  current CPU frequency is 1.60 GHz.
analyzing CPU 1:
  driver: acpi-cpufreq
  CPUs which need to switch frequency at the same time: 1
  hardware limits: 1.60 GHz - 1.86 GHz
  available frequency steps: 1.86 GHz, 1.60 GHz
  available cpufreq governors: ondemand, powersave, performance
  current policy: frequency should be within 1.60 GHz and 1.86 GHz.
                  The governor "performance" may decide which speed to use
                  within this range.
  current CPU frequency is 1.86 GHz.


so seems the cpu 1 from user is always top speed.
The governor i set is ondemand. But seems set only for the first one,
while the second cpu says performance.

So, to resume: 1 issue for the governor for all users, just speed for
the last cpu for simple user and not root.

known issues?

-- 

Patrizio Bassi
www.patriziobassi.it
