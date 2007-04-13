From: Mattia Dongili <malattia@linux.it>
Subject: CPU_IDLE prevents resuming from STR [was: Re: 2.6.21-rc6-mm1]
Date: Sat, 14 Apr 2007 01:45:13 +0200
Message-ID: <20070413234513.GA2940@inferi.kami.home>
References: <20070408143559.f5014629.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out20.alice.it ([85.33.2.20]:4611 "EHLO
	smtp-out01.alice.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030906AbXDNABQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Apr 2007 20:01:16 -0400
Content-Disposition: inline
In-Reply-To: <20070408143559.f5014629.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Shaohua Li <shaohua.li@intel.com>

On Sun, Apr 08, 2007 at 02:35:59PM -0700, Andrew Morton wrote:
...
>  git-acpi.patch

after bisecting I can finally say what breaks resume from STR here:

tadaaaaa: CPU_IDLE.
I first spotted the git-acpi.patch then reapplied it and disabled
CPU_IDLE, now my laptop resumes.

Any useful information I should add?

$ cat /sys/devices/system/cpu/cpuidle/*
acpi_idle 
no governors
acpi_idle
no governor

$ cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 15
model name	: Intel(R) Core(TM)2 CPU         T5600  @ 1.83GHz
stepping	: 6
cpu MHz		: 1000.000
cache size	: 2048 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_tsc pni monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr lahf_lm
bogomips	: 3671.24
clflush size	: 64

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 15
model name	: Intel(R) Core(TM)2 CPU         T5600  @ 1.83GHz
stepping	: 6
cpu MHz		: 1000.000
cache size	: 2048 KB
physical id	: 0
siblings	: 2
core id		: 1
cpu cores	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_tsc pni monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr lahf_lm
bogomips	: 15805.85
clflush size	: 64

-- 
mattia
:wq!
