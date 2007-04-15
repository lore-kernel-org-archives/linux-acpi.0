From: Mircea Bardac <dev.list@mircea.bardac.net>
Subject: CPU on-off-on: lost CPU management?
Date: Sun, 15 Apr 2007 22:15:43 +0300
Message-ID: <200704152215.49258.dev.list@mircea.bardac.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bravo.securenet-server.net ([207.210.84.244]:53527 "EHLO
	bravo.securenet-server.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753497AbXDOTiG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 15 Apr 2007 15:38:06 -0400
Received: from [86.121.180.74] (helo=mircea.home.bardac.net)
	by bravo.securenet-server.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.63)
	(envelope-from <dev.list@mircea.bardac.net>)
	id 1HdACt-00036T-5i
	for linux-acpi@vger.kernel.org; Sun, 15 Apr 2007 15:16:17 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi everyone,

After reading "CPU offline but power consumption increased?" lkml threa=
d I=20
wanted to test CPU on-off on my Turion 64 X2.

I found out something strange, related to the way CPU is turned off and=
 back=20
on. I don't know if this is a kernel bug, but looks pretty suspicious.


Comments can be found inline.

**** Using Kernel 2.6.20.5

**** The initial situation, both cores running at 1.6 GHz, full info di=
splayed
**** /proc/cpuinfo

# cat /proc/cpuinfo
processor =A0 =A0 =A0 : 0
vendor_id =A0 =A0 =A0 : AuthenticAMD
cpu family =A0 =A0 =A0: 15
model =A0 =A0 =A0 =A0 =A0 : 72
model name =A0 =A0 =A0: AMD Turion(tm) 64 X2 Mobile Technology TL-52
stepping =A0 =A0 =A0 =A0: 2
cpu MHz =A0 =A0 =A0 =A0 : 1600.000
cache size =A0 =A0 =A0: 512 KB
physical id =A0 =A0 : 0
siblings =A0 =A0 =A0 =A0: 2
core id =A0 =A0 =A0 =A0 : 0
cpu cores =A0 =A0 =A0 : 2
fdiv_bug =A0 =A0 =A0 =A0: no
hlt_bug =A0 =A0 =A0 =A0 : no
f00f_bug =A0 =A0 =A0 =A0: no
coma_bug =A0 =A0 =A0 =A0: no
fpu =A0 =A0 =A0 =A0 =A0 =A0 : yes
fpu_exception =A0 : yes
cpuid level =A0 =A0 : 1
wp =A0 =A0 =A0 =A0 =A0 =A0 =A0: yes
flags =A0 =A0 =A0 =A0 =A0 : fpu vme de pse tsc msr pae mce cx8 apic sep=
 mtrr pge mca=20
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt =
lm=20
3dnowext 3dnow pni cx16 lahf_lm cmp_legacy svm cr8legacy ts fid vid ttp=
 tm=20
stc
bogomips =A0 =A0 =A0 =A0: 3195.47
clflush size =A0 =A0: 64

processor =A0 =A0 =A0 : 1
vendor_id =A0 =A0 =A0 : AuthenticAMD
cpu family =A0 =A0 =A0: 15
model =A0 =A0 =A0 =A0 =A0 : 72
model name =A0 =A0 =A0: AMD Turion(tm) 64 X2 Mobile Technology TL-52
stepping =A0 =A0 =A0 =A0: 2
cpu MHz =A0 =A0 =A0 =A0 : 1600.000
cache size =A0 =A0 =A0: 512 KB
physical id =A0 =A0 : 0
siblings =A0 =A0 =A0 =A0: 2
core id =A0 =A0 =A0 =A0 : 1
cpu cores =A0 =A0 =A0 : 2
fdiv_bug =A0 =A0 =A0 =A0: no
hlt_bug =A0 =A0 =A0 =A0 : no
f00f_bug =A0 =A0 =A0 =A0: no
coma_bug =A0 =A0 =A0 =A0: no
fpu =A0 =A0 =A0 =A0 =A0 =A0 : yes
fpu_exception =A0 : yes
cpuid level =A0 =A0 : 1
wp =A0 =A0 =A0 =A0 =A0 =A0 =A0: yes
flags =A0 =A0 =A0 =A0 =A0 : fpu vme de pse tsc msr pae mce cx8 apic sep=
 mtrr pge mca=20
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt =
lm=20
3dnowext 3dnow pni cx16 lahf_lm cmp_legacy svm cr8legacy ts fid vid ttp=
 tm=20
stc
bogomips =A0 =A0 =A0 =A0: 3195.47
clflush size =A0 =A0: 64



**** The initial situation, both cores running at 1.6 GHz, full info di=
splayed
**** cpufreq-info

# cpufreq-info
cpufrequtils 002: cpufreq-info (C) Dominik Brodowski 2004-2006
Report errors and bugs to linux@brodo.de, please.
analyzing CPU 0:
=A0 driver: powernow-k8
=A0 CPUs which need to switch frequency at the same time: 0 1
=A0 hardware limits: 800 MHz - 1.60 GHz
=A0 available frequency steps: 1.60 GHz, 800 MHz
=A0 available cpufreq governors: powersave, performance
=A0 current policy: frequency should be within 800 MHz and 1.60 GHz.
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 The governor "performance" may deci=
de which speed to use
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 within this range.
=A0 current CPU frequency is 1.60 GHz (asserted by call to hardware).
analyzing CPU 1:
=A0 driver: powernow-k8
=A0 CPUs which need to switch frequency at the same time: 0 1
=A0 hardware limits: 800 MHz - 1.60 GHz
=A0 available frequency steps: 1.60 GHz, 800 MHz
=A0 available cpufreq governors: powersave, performance
=A0 current policy: frequency should be within 800 MHz and 1.60 GHz.
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 The governor "performance" may deci=
de which speed to use
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 within this range.
=A0 current CPU frequency is 1.60 GHz (asserted by call to hardware).



**** 2nd core is shut down

# echo 0 > /sys/devices/system/cpu/cpu1/online



**** Only 2nd core is now running, at 800 MHz, half bogomips
**** /proc/cpuinfo

# cat /proc/cpuinfo
processor =A0 =A0 =A0 : 0
vendor_id =A0 =A0 =A0 : AuthenticAMD
cpu family =A0 =A0 =A0: 15
model =A0 =A0 =A0 =A0 =A0 : 72
model name =A0 =A0 =A0: AMD Turion(tm) 64 X2 Mobile Technology TL-52
stepping =A0 =A0 =A0 =A0: 2
cpu MHz =A0 =A0 =A0 =A0 : 800.000
cache size =A0 =A0 =A0: 512 KB
physical id =A0 =A0 : 0
siblings =A0 =A0 =A0 =A0: 1
core id =A0 =A0 =A0 =A0 : 0
cpu cores =A0 =A0 =A0 : 1
fdiv_bug =A0 =A0 =A0 =A0: no
hlt_bug =A0 =A0 =A0 =A0 : no
f00f_bug =A0 =A0 =A0 =A0: no
coma_bug =A0 =A0 =A0 =A0: no
fpu =A0 =A0 =A0 =A0 =A0 =A0 : yes
fpu_exception =A0 : yes
cpuid level =A0 =A0 : 1
wp =A0 =A0 =A0 =A0 =A0 =A0 =A0: yes
flags =A0 =A0 =A0 =A0 =A0 : fpu vme de pse tsc msr pae mce cx8 apic sep=
 mtrr pge mca=20
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt =
lm=20
3dnowext 3dnow up pni cx16 lahf_lm cmp_legacy svm cr8legacy ts fid vid =
ttp tm=20
stc
bogomips =A0 =A0 =A0 =A0: 1597.73
clflush size =A0 =A0: 64



**** Only 2nd core is now running, at 800 MHz, half bogomips
**** cpufreq-info

# cpufreq-info
cpufrequtils 002: cpufreq-info (C) Dominik Brodowski 2004-2006
Report errors and bugs to linux@brodo.de, please.
analyzing CPU 0:
=A0 driver: powernow-k8
=A0 CPUs which need to switch frequency at the same time: 0
=A0 hardware limits: 800 MHz - 1.60 GHz
=A0 available frequency steps: 1.60 GHz, 800 MHz
=A0 available cpufreq governors: powersave, performance
=A0 current policy: frequency should be within 800 MHz and 1.60 GHz.
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 The governor "performance" may deci=
de which speed to use
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 within this range.
=A0 current CPU frequency is 800 MHz (asserted by call to hardware).



**** Turning 2nd core back on

# echo 1 > /sys/devices/system/cpu/cpu1/online



**** /proc/cpuinfo shows again info about 2nd core
**** but some details are missing about 2nd core, such as "cache size"
**** (others might also be missing) - this makes me think something mig=
ht not
**** be working right (cache not used maybe?)
**** Bogomips is still half (I'm not sure if this is directly proportio=
nal
**** with CPU frequency or with number of cores)

# cat /proc/cpuinfo
processor =A0 =A0 =A0 : 0
vendor_id =A0 =A0 =A0 : AuthenticAMD
cpu family =A0 =A0 =A0: 15
model =A0 =A0 =A0 =A0 =A0 : 72
model name =A0 =A0 =A0: AMD Turion(tm) 64 X2 Mobile Technology TL-52
stepping =A0 =A0 =A0 =A0: 2
cpu MHz =A0 =A0 =A0 =A0 : 800.000
cache size =A0 =A0 =A0: 512 KB
physical id =A0 =A0 : 0
siblings =A0 =A0 =A0 =A0: 1
core id =A0 =A0 =A0 =A0 : 0
cpu cores =A0 =A0 =A0 : 1
fdiv_bug =A0 =A0 =A0 =A0: no
hlt_bug =A0 =A0 =A0 =A0 : no
f00f_bug =A0 =A0 =A0 =A0: no
coma_bug =A0 =A0 =A0 =A0: no
fpu =A0 =A0 =A0 =A0 =A0 =A0 : yes
fpu_exception =A0 : yes
cpuid level =A0 =A0 : 1
wp =A0 =A0 =A0 =A0 =A0 =A0 =A0: yes
flags =A0 =A0 =A0 =A0 =A0 : fpu vme de pse tsc msr pae mce cx8 apic sep=
 mtrr pge mca=20
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt =
lm=20
3dnowext 3dnow pni cx16 lahf_lm cmp_legacy svm cr8legacy ts fid vid ttp=
 tm=20
stc
bogomips =A0 =A0 =A0 =A0: 1597.73
clflush size =A0 =A0: 64

processor =A0 =A0 =A0 : 1
vendor_id =A0 =A0 =A0 : AuthenticAMD
cpu family =A0 =A0 =A0: 15
model =A0 =A0 =A0 =A0 =A0 : 72
model name =A0 =A0 =A0: AMD Turion(tm) 64 X2 Mobile Technology TL-52
stepping =A0 =A0 =A0 =A0: 2
cpu MHz =A0 =A0 =A0 =A0 : 1596.093
fdiv_bug =A0 =A0 =A0 =A0: no
hlt_bug =A0 =A0 =A0 =A0 : no
f00f_bug =A0 =A0 =A0 =A0: no
coma_bug =A0 =A0 =A0 =A0: no
fpu =A0 =A0 =A0 =A0 =A0 =A0 : yes
fpu_exception =A0 : yes
cpuid level =A0 =A0 : 1
wp =A0 =A0 =A0 =A0 =A0 =A0 =A0: yes
flags =A0 =A0 =A0 =A0 =A0 : fpu vme de pse tsc msr pae mce cx8 apic sep=
 mtrr pge mca=20
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt =
lm=20
3dnowext 3dnow pni cx16 lahf_lm cmp_legacy svm cr8legacy ts fid vid ttp=
 tm=20
stc
bogomips =A0 =A0 =A0 =A0: 1596.01
clflush size =A0 =A0: 64


**** cpufreq-info shows info only about 1st core

# cpufreq-info
cpufrequtils 002: cpufreq-info (C) Dominik Brodowski 2004-2006
Report errors and bugs to linux@brodo.de, please.
analyzing CPU 0:
=A0 driver: powernow-k8
=A0 CPUs which need to switch frequency at the same time: 0
=A0 hardware limits: 800 MHz - 1.60 GHz
=A0 available frequency steps: 1.60 GHz, 800 MHz
=A0 available cpufreq governors: powersave, performance
=A0 current policy: frequency should be within 800 MHz and 1.60 GHz.
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 The governor "performance" may deci=
de which speed to use
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 within this range.
=A0 current CPU frequency is 800 MHz (asserted by call to hardware).
analyzing CPU 1:
=A0 no or unknown cpufreq driver is active on this CPU



**** reloading powernow-k8 driver, to check if cpufreq-info gets back w=
orking

# rmmod powernow-k8

# modprobe powernow-k8
=46ATAL: Error inserting powernow_k8=20
(/lib/modules/2.6.20-ARCH/kernel/arch/i386/kernel/cpu/cpufreq/powernow-=
k8.ko):=20
No such device


Many thanks,
Mircea

--=20
http://mircea.bardac.net
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
