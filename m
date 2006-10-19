From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: speedstep-centrino: ENODEV
Date: Thu, 19 Oct 2006 16:20:34 +0200
Message-ID: <453789B2.5040809@gmail.com>
References: <EB12A50964762B4D8111D55B764A8454C1A223@scsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tirith.ics.muni.cz ([147.251.4.36]:27068 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1945964AbWJSOUq
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Oct 2006 10:20:46 -0400
In-Reply-To: <EB12A50964762B4D8111D55B764A8454C1A223@scsmsx413.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

Pallipadi, Venkatesh wrote:
> How about acpi-cpufreq? Does it work?

How did you mean this, speedstep-centrino (which can also control voltage) is 
one of acpi-cpufreq drivers, isn't it?

> 
> Thanks,
> Venki 
> 
>> -----Original Message-----
>> From: linux-kernel-owner@vger.kernel.org 
>> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Jiri Slaby
>> Sent: Wednesday, October 18, 2006 12:01 PM
>> To: Linux kernel mailing list
>> Cc: linux-acpi@vger.kernel.org
>> Subject: speedstep-centrino: ENODEV
>>
>> Hi!
>>
>> How is it possible to find out whether or not 
>> speedstep-centrino is supported. I 
>> have
>> processor       : 0
>> vendor_id       : GenuineIntel
>> cpu family      : 6
>> model           : 13
>> model name      : Intel(R) Pentium(R) M processor 1.60GHz
>> stepping        : 6
>> cpu MHz         : 1600.149
>> cache size      : 2048 KB
>> fdiv_bug        : no
>> hlt_bug         : no
>> f00f_bug        : no
>> coma_bug        : no
>> fpu             : yes
>> fpu_exception   : yes
>> cpuid level     : 2
>> wp              : yes
>> flags           : fpu vme de pse tsc msr mce cx8 apic sep mtrr 
>> pge mca cmov pat 
>> clflush dts acpi mmx fxsr sse sse2 ss tm pbe est tm2
>> bogomips        : 3201.52
>>
>> processor, but speedstep-centrino returns ENODEV because of 
>> lack of _PCT et al 
>> entries in DSDT (http://www.fi.muni.cz/~xslaby/sklad/adump). 
>> It is possible to 
>> hard-code that values to speedstep-centrino as for banias cpus 
>> or use corrected 
>> DSDT that will contain _PCT, _PSS and _PPC, but where may I 
>> obtain these values?
>>
>> This is Asus M6R notebook, some DSDT parts of this piece of HW 
>> are really ugly 
>> (problems with acpi some time ago).
>>
>> I may use p4-clockmod (and it points me to speedstep-centrino 
>> module), but if I 
>> am correct, it doesn't save battery life?

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
