From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: speedstep-centrino: ENODEV
Date: Thu, 19 Oct 2006 08:57:32 -0700
Message-ID: <EB12A50964762B4D8111D55B764A8454C1A2D8@scsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1946144AbWJSP6x@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>, =?iso-8859-1?Q?Sune_M=F8lgaard?= <sune@molgaard.org>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


No. As in 2.6.18, speedstep-centrino and acpi-cpufreq are  two different drivers/modules that support Enhanced Speedstep in slightly different ways. It depends on your platform/BIOS on which one will work for your system. So you should try loading both those drivers in that order. If you have both compiled in the kernel, these drivers will be loaded (or tried to) in proper order. Please try this with the latest stable 2.6.18 kernel.

Also, can both of you send the complete acpidump output from your system. You can find acpidump in latest version of pmtools package here: http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

Also, it will help if you can open a bug in http://bugme.osdl.org and attach this acpidump to the bug. The issue can be tracked better that way..

Thanks,
Venki 

>-----Original Message-----
>From: Jiri Slaby [mailto:jirislaby@gmail.com] 
>Sent: Thursday, October 19, 2006 7:21 AM
>To: Pallipadi, Venkatesh
>Cc: Linux kernel mailing list; linux-acpi@vger.kernel.org
>Subject: Re: speedstep-centrino: ENODEV
>
>Pallipadi, Venkatesh wrote:
>> How about acpi-cpufreq? Does it work?
>
>How did you mean this, speedstep-centrino (which can also 
>control voltage) is 
>one of acpi-cpufreq drivers, isn't it?
>
>> 
>> Thanks,
>> Venki 
>> 
>>> -----Original Message-----
>>> From: linux-kernel-owner@vger.kernel.org 
>>> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Jiri Slaby
>>> Sent: Wednesday, October 18, 2006 12:01 PM
>>> To: Linux kernel mailing list
>>> Cc: linux-acpi@vger.kernel.org
>>> Subject: speedstep-centrino: ENODEV
>>>
>>> Hi!
>>>
>>> How is it possible to find out whether or not 
>>> speedstep-centrino is supported. I 
>>> have
>>> processor       : 0
>>> vendor_id       : GenuineIntel
>>> cpu family      : 6
>>> model           : 13
>>> model name      : Intel(R) Pentium(R) M processor 1.60GHz
>>> stepping        : 6
>>> cpu MHz         : 1600.149
>>> cache size      : 2048 KB
>>> fdiv_bug        : no
>>> hlt_bug         : no
>>> f00f_bug        : no
>>> coma_bug        : no
>>> fpu             : yes
>>> fpu_exception   : yes
>>> cpuid level     : 2
>>> wp              : yes
>>> flags           : fpu vme de pse tsc msr mce cx8 apic sep mtrr 
>>> pge mca cmov pat 
>>> clflush dts acpi mmx fxsr sse sse2 ss tm pbe est tm2
>>> bogomips        : 3201.52
>>>
>>> processor, but speedstep-centrino returns ENODEV because of 
>>> lack of _PCT et al 
>>> entries in DSDT (http://www.fi.muni.cz/~xslaby/sklad/adump). 
>>> It is possible to 
>>> hard-code that values to speedstep-centrino as for banias cpus 
>>> or use corrected 
>>> DSDT that will contain _PCT, _PSS and _PPC, but where may I 
>>> obtain these values?
>>>
>>> This is Asus M6R notebook, some DSDT parts of this piece of HW 
>>> are really ugly 
>>> (problems with acpi some time ago).
>>>
>>> I may use p4-clockmod (and it points me to speedstep-centrino 
>>> module), but if I 
>>> am correct, it doesn't save battery life?
>
>regards,
>-- 
>http://www.fi.muni.cz/~xslaby/            Jiri Slaby
>faculty of informatics, masaryk university, brno, cz
>e-mail: jirislaby gmail com, gpg pubkey fingerprint:
>B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
>
