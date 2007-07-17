From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: ACPI cpufreq broken on 2.6.22 for core2 duo
Date: Tue, 17 Jul 2007 00:10:06 -0700
Message-ID: <20070717001006.d54bd576.akpm@linux-foundation.org>
References: <4698B9AC.6060300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:39570 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758097AbXGQHKN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jul 2007 03:10:13 -0400
In-Reply-To: <4698B9AC.6060300@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: patrizio.bassi@gmail.com
Cc: linux-acpi@vger.kernel.org

On Sat, 14 Jul 2007 13:55:24 +0200 Patrizio Bassi <patrizio.bassi@gmail.com> wrote:

> With linux 2.6.21 and 22 i cannot get cpufreq working anymore while it
> worked in previous versions
> 
> ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device is
> not present [20070126]
> ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device is
> not present [20070126]
> 
> i'm in 64bit profile.
> Bios updated to latest version.
> 
> CC me as i'm not subscribed.
> 
> 
> cat /proc/cpuinfo
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 15
> model name      : Intel(R) Core(TM)2 CPU          6300  @ 1.86GHz
> stepping        : 6
> cpu MHz         : 1866.667
> cache size      : 2048 KB
> physical id     : 0
> siblings        : 2
> core id         : 0
> cpu cores       : 2
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 10
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall
> nx lm constant_tsc pni monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr lahf_lm
> bogomips        : 3735.47
> clflush size    : 64
> cache_alignment : 64
> address sizes   : 36 bits physical, 48 bits virtual
> power management:
> 
> processor       : 1
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 15
> model name      : Intel(R) Core(TM)2 CPU          6300  @ 1.86GHz
> stepping        : 6
> cpu MHz         : 1866.667
> cache size      : 2048 KB
> physical id     : 0
> siblings        : 2
> core id         : 1
> cpu cores       : 2
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 10
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall
> nx lm constant_tsc pni monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr lahf_lm
> bogomips        : 3733.31
> clflush size    : 64
> cache_alignment : 64
> address sizes   : 36 bits physical, 48 bits virtual
> power management:

(switched mailing lists)

Please raise a report against acpi at bugzilla.kernel.org for this,
thanks.
