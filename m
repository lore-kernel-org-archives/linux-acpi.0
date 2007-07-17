From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: ACPI cpufreq broken on 2.6.22 for core2 duo
Date: Tue, 17 Jul 2007 15:41:31 +0800
Message-ID: <823A93EED437D048963A3697DB0E35DE781EA7@pdsmsx414.ccr.corp.intel.com>
References: <742b1fb30707170026k382ea0enb033c6be62eecc33@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:60105 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752134AbXGQHlt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jul 2007 03:41:49 -0400
Content-class: urn:content-classes:message
In-Reply-To: <742b1fb30707170026k382ea0enb033c6be62eecc33@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Patrizio Bassi <patrizio.bassi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org

Hi, Patrizio,

> > ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device
is
> > not present [20070126]
> > ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device
is
> > not present [20070126]
This is just a debug message output and should have no impact on the
cpufreq driver.
Please try the patch at
http://bugzilla.kernel.org/show_bug.cgi?id=8570#c21

>Seems the issue was somehow related to my bios, but i don't understand
>why windows worked. Now it's working ok,
So the cpufreq problem is already fixed, right?

Thanks,
Rui

-----Original Message-----
From: linux-acpi-owner@vger.kernel.org
[mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Patrizio Bassi
Sent: Tuesday, July 17, 2007 3:26 PM
To: Andrew Morton
Cc: linux-acpi@vger.kernel.org
Subject: Re: ACPI cpufreq broken on 2.6.22 for core2 duo

2007/7/17, Andrew Morton <akpm@linux-foundation.org>:
> On Sat, 14 Jul 2007 13:55:24 +0200 Patrizio Bassi
<patrizio.bassi@gmail.com> wrote:
>
> > With linux 2.6.21 and 22 i cannot get cpufreq working anymore while
it
> > worked in previous versions
> >
> > ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device
is
> > not present [20070126]
> > ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device
is
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
> > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
pge
> > mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
syscall
> > nx lm constant_tsc pni monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr
lahf_lm
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
> > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
pge
> > mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
syscall
> > nx lm constant_tsc pni monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr
lahf_lm
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
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
