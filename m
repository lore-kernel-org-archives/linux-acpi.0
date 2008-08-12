From: =?UTF-8?B?RGlldGVyIFNjaMO2bg==?= <tshinbum@gmail.com>
Subject: Re: expicitly use XT_PIC interrupt for an old device?
Date: Tue, 12 Aug 2008 09:04:04 +0200
Message-ID: <48A135E4.1090707@gmail.com>
References: <48A053E7.3090305@googlemail.com> <1218503362.6671.143.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:43632 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576AbYHLHES (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Aug 2008 03:04:18 -0400
Received: by nf-out-0910.google.com with SMTP id d3so824184nfc.21
        for <linux-acpi@vger.kernel.org>; Tue, 12 Aug 2008 00:04:16 -0700 (PDT)
In-Reply-To: <1218503362.6671.143.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org

hi,

thanks for the answer,

Zhao Yakui schrieb:
> On Mon, 2008-08-11 at 16:59 +0200, Dieter Sch=C3=B6n wrote:
>> hi group,
>>
>> i have to migrate a character device driver for an old synchronus
>> serial PCI board (Moxa C502/PCI)
>> from 2.2.something to 2.6.5-smp x86_64.
>> the problem is, that no interrupts are routed to the driver.
>> i was able to get interrupts when i used a non-SMP kernel and the
>> "noapic" boot option.
>>
>> is there a way to explicitly force the use of the 8259 when i reques=
t
>> an interrupt to get the interrupts for this card not routed via the
>> APIC?
>> any pointers are appreciated.
> doubt whether the I8259 and I/O APIC can be used at the same time.
> When the non-smp kernel is used and boot option of "noapic" is added,
> there exists the interrupt for PCI UART card.=20
> Do you try it with the boot option of "noapic" on smp kernel?
> Can you try it on the latest kernel?

i have tried it with 2.6.25 on suse11, and also on another hardware=20
platform (i have heard that some motherboards/BIOSes have problems with=
=20
the APIC) to rule that out.

and it seems that it is possible to operate both ways at the same time:
the cascade driver seems to use the 8259.
my driver is one line below, the Moxa. another idea: would it be=20
possible to force a IO-APIC-level interrupt instead of an edge-triggere=
d?

user@host $ cat /proc/interrupts
            CPU0       CPU1
   0:     145319     102178    IO-APIC-edge  timer
   1:        368        485    IO-APIC-edge  i8042
   2:          0          0          XT-PIC  cascade
   6:          0          0    IO-APIC-edge  Moxa
   8:          0          0    IO-APIC-edge  rtc
   9:          0          0   IO-APIC-level  acpi
  12:        668       1190    IO-APIC-edge  i8042
  14:        494        624    IO-APIC-edge  ide0
  16:          0          0   IO-APIC-level  eth0, ehci_hcd, uhci_hcd
  17:          0          0   IO-APIC-level  eth1, uhci_hcd
  18:       6783       3973   IO-APIC-level  libata
NMI:     247349     247309
LOC:     246859     247246
ERR:          0
MIS:          0

user@host $ uname -a
Linux host 2.6.5-7.244-smp #1 SMP Mon Dec 12 18:32:25 UTC 2005 x86_64=20
x86_64 x86_64 GNU/Linux

user@host $ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 6
model name      :               Intel(R) Pentium(R) D CPU 3.40GHz
stepping        : 4
cpu MHz         : 3400.280
cache size      : 2048 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 6
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge=20
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall=20
lm pni monitor ds_cpl tm2 cid cmpxchg16b lahf_lm
bogomips        : 6717.44
clflush size    : 64
cache_alignment : 128
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 6
model name      :               Intel(R) Pentium(R) D CPU 3.40GHz
stepping        : 4
cpu MHz         : 3400.280
cache size      : 2048 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 6
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge=20
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall=20
lm pni monitor ds_cpl tm2 cid cmpxchg16b lahf_lm
bogomips        : 6782.97
clflush size    : 64
cache_alignment : 128
address sizes   : 36 bits physical, 48 bits virtual
power management:


kind regards,
dieter
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
