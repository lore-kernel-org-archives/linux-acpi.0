From: "Patrizio Bassi" <patrizio.bassi@gmail.com>
Subject: Re: ACPI cpufreq broken on 2.6.22 for core2 duo
Date: Tue, 17 Jul 2007 09:26:23 +0200
Message-ID: <742b1fb30707170026k382ea0enb033c6be62eecc33@mail.gmail.com>
References: <4698B9AC.6060300@gmail.com>
	 <20070717001006.d54bd576.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:65216 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755076AbXGQH0Y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jul 2007 03:26:24 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1871512wah
        for <linux-acpi@vger.kernel.org>; Tue, 17 Jul 2007 00:26:24 -0700 (PDT)
In-Reply-To: <20070717001006.d54bd576.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org

2007/7/17, Andrew Morton <akpm@linux-foundation.org>:
> On Sat, 14 Jul 2007 13:55:24 +0200 Patrizio Bassi <patrizio.bassi@gmail.com> wrote:
>
> > With linux 2.6.21 and 22 i cannot get cpufreq working anymore while it
> > worked in previous versions
> >
> > ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device is
> > not present [20070126]
> > ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device is
> > not present [20070126]
> >
> > i'm in 64bit profile.
> > Bios updated to latest version.
> >
> > CC me as i'm not subscribed.
> >
> >
> > cat /proc/cpuinfo
> > processor       : 0
> > vendor_id       : GenuineIntel
> > cpu family      : 6
> > model           : 15
> > model name      : Intel(R) Core(TM)2 CPU          6300  @ 1.86GHz
> > stepping        : 6
> > cpu MHz         : 1866.667
> > cache size      : 2048 KB
> > physical id     : 0
> > siblings        : 2
> > core id         : 0
> > cpu cores       : 2
> > fpu             : yes
> > fpu_exception   : yes
> > cpuid level     : 10
> > wp              : yes
> > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> > mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall
> > nx lm constant_tsc pni monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr lahf_lm
> > bogomips        : 3735.47
> > clflush size    : 64
> > cache_alignment : 64
> > address sizes   : 36 bits physical, 48 bits virtual
> > power management:
> >
> > processor       : 1
> > vendor_id       : GenuineIntel
> > cpu family      : 6
> > model           : 15
> > model name      : Intel(R) Core(TM)2 CPU          6300  @ 1.86GHz
> > stepping        : 6
> > cpu MHz         : 1866.667
> > cache size      : 2048 KB
> > physical id     : 0
> > siblings        : 2
> > core id         : 1
> > cpu cores       : 2
> > fpu             : yes
> > fpu_exception   : yes
> > cpuid level     : 10
> > wp              : yes
> > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> > mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall
> > nx lm constant_tsc pni monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr lahf_lm
> > bogomips        : 3733.31
> > clflush size    : 64
> > cache_alignment : 64
> > address sizes   : 36 bits physical, 48 bits virtual
> > power management:
>
> (switched mailing lists)
>
> Please raise a report against acpi at bugzilla.kernel.org for this,
> thanks.
>


Hi Andrew,

this is already reported in
http://bugzilla.kernel.org/show_bug.cgi?id=8630
and
http://bugzilla.kernel.org/show_bug.cgi?id=8570

Seems the issue was somehow related to my bios, but i don't understand
why windows worked.
Now it's working ok, but i still have the

"AE_NOT_FOUND, Processor Device is not present [20070126]"
warning.

Seems a patch is available here for the warning fix:
http://bugzilla.kernel.org/show_bug.cgi?id=8570


-- 

Patrizio Bassi
www.patriziobassi.it
