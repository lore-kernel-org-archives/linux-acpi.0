From: "Christian Kraus" <lands@freenet.de>
Subject: No C-states on latest AMD Mobile Turion K8 cpus ?
Date: Fri, 24 Nov 2006 11:16:06 +0100
Message-ID: <008a01c70fb1$8e4c1f90$eeeea8c0@excelsio>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout2.freenet.de ([194.97.50.155]:43172 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S934543AbWKXKQp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 05:16:45 -0500
Received: from [194.97.55.148] (helo=mx5.freenet.de)
	by mout2.freenet.de with esmtpa (Exim 4.62)
	(envelope-from <lands@freenet.de>)
	id 1GnY6u-0008AU-Ar
	for linux-acpi@vger.kernel.org; Fri, 24 Nov 2006 11:16:44 +0100
Received: from p5495bcdb.dip0.t-ipconnect.de ([84.149.188.219]:1479 helo=excelsio)
	by mx5.freenet.de with esmtpa (ID lands@freenet.de) (port 25) (Exim 4.62 #12)
	id 1GnY6t-0005ZU-IH
	for linux-acpi@vger.kernel.org; Fri, 24 Nov 2006 11:16:44 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org



Hi,

I recently bought an Acer Aspire 5051 / 5050 with an AMD Mobile MK-36 cpu.

((( Turion 64 "Richmond" (90 nm)
* All models support: MMX, SSE, SSE2, SSE3, Enhanced 3DNow!, NX bit, AMD64 
(an x86-64 implementation), PowerNow!, AMD Virtualization
Model Number Frequency L2-Cache HyperTransport Multiplier Voltage TDP Socket 
Release date Order Part Number
Turion 64 MK-36 2000 MHz 512 KiB 800 MHz 10x 1.15 V 31 W Socket S1 
TMDMK36HAX4CM  )))


I tried several linux versions: Opensuse 10.1 beta2, Fedora Core 6, 
archlinux 0.7.2 all with latest kernel versions (2.6.18), also x86_64 
compiled ones, but there were no C-states for throttling available. ( Yes, I 
modprobed all acpi modules, powernow-k8, ... )


root@myhost acpi]# cat /proc/acpi/processor/CPU0/info
processor id: 0
acpi id: 0
bus mastering control: no
power management: no
throttling control: no
limit interface: no

[root@myhost acpi]# cat /proc/acpi/processor/CPU0/limit
not supported

[root@myhost acpi]# cat /proc/acpi/processor/CPU0/throttling
not supported


[root@myhost cpufreq]# cat /proc/cpuinfo
processor : 0
vendor_id : AuthenticAMD
cpu family : 15
model : 76
model name : AMD Turion(tm) 64 Mobile Technology MK-36
stepping : 2
cpu MHz : 800.000
cache size : 512 KB
fdiv_bug : no
hlt_bug : no
f00f_bug : no
coma_bug : no
fpu : yes
fpu_exception : yes
cpuid level : 1
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat 
pse36 clflush mmx fxsr sse sse2 syscall nx mmxext fxsr_opt lm 3dnowext 3dnow 
up pni cx16 lahf_lm svm cr8legacy ts fid vid ttp tm stc
bogomips : 1601.68



I googled but found no information.
I came to http:

acpi.sourceforge . net


- The test results also say that there is no throttling support ?
- That cannot be true ? Hopefully.
- So, what do you say ?
- Will there be support in future kernel releases ?
- What is the current status ?

-------------------------------------
Testresults from ABAT:
-------------------------------------

ACPI ABAT started...

[H [2J
Arch Linux 0.7.2 (Gimmick) (\n) (\l)

Linux myhost 2.6.18-ARCH #1 SMP PREEMPT Sun Nov 19 17:12:07 CET 2006 i686 
AMD TurionT 64 Mobile Technology MK-36 AuthenticAMD GNU/Linux



*******************************************************
* Test ACPI file system interfaces *
*******************************************************

-------------------------------------------------------
ACPI is supported.
-------------------------------------------------------
version: 20060707
-------------------------------------------------------
alarm 2006-11-18 09:08:47
event OK
dsdt OK
fadt OK
sleep mem(S3) disk(S4)
wakeup Not set
-------------------------------------------------------
Driver State Device Item Information
------ ----- ------ ---- -----------
ac build-in NO
battery build-in NO
button build-in lid/LID info type: Lid Switch
state state: open
power/PWRB info type: Power Button (CM)
power/PWRF info type: Power Button (FF)
sleep/SLPB info type: Sleep Button (CM)
ec build-in NO
fan build-in NO
power build-in NO
processor build-in NO
thermal build-in NO
video build-in NO
-------------------------------------------------------

-------------
Test Summary:
-------------
TOTAL: 17
PASS: 17
FAIL: 0
NOTSUPPORT: 0
UNRESOLVED: 0
UNTESTED: 0
-------------



*******************************************************
* Test ACPI drivers *
*******************************************************

-------------------------------------------------------
Driver State Action Results
ac build-in verifying PASS
battery build-in verifying PASS
button build-in verifying PASS
ec build-in verifying PASS
fan build-in verifying PASS
power build-in verifying PASS
processor build-in verifying PASS
thermal build-in verifying PASS
video build-in verifying PASS
container build-in verifying PASS
memhotplug notsupport
numa notsupport
-------------------------------------------------------


-------------
Test Summary:
-------------
TOTAL: 12
PASS: 10
FAIL: 0
NOTSUPPORT: 2
UNRESOLVED: 0
UNTESTED: 0
-------------




*******************************************************
* Test ACPI P-state *
*******************************************************


Native Geyserville III Support (P state) - Demand Based Switching
###############################################################################
GV3/DBS validation for I386 and EM64T
Geyserville III is an efficient mechanism for switching to/from low
voltage mode - Enhanced SpeedStep Technology. Dependent upon ACPI.
-------------------------------------------------------------------------------
[H [2J
Arch Linux 0.7.2 (Gimmick) (\n) (\l)
Linux myhost 2.6.18-ARCH #1 SMP PREEMPT Sun Nov 19 17:12:07 CET 2006 i686 
AMD TurionT 64 Mobile Technology MK-36 AuthenticAMD GNU/Linux
-------------------------------------------------------------------------------
Start setup
Finish setup
Execution of test_1_1
get_governors output:
conservative ondemand powersave userspace performance
num CPU = 0
READ_GOVERNOR performance
MAX_FREQ 2000000
READ_FREQ 2000000
Test p_states_test_1_1 PASSED
Execution of test_2_1
get_governors output:
conservative ondemand powersave userspace performance
num CPU = 0
READ_GOVERNOR powersave
MIN_FREQ 800000
READ_FREQ 800000
Test p_states_test_2_1 PASSED
Execution of test_3_1
get_governors output:
conservative ondemand powersave userspace performance
num CPU = 0
READ_GOVERNOR userspace
Test p_states_test_3_1 PASSED
Execution of test_3_2
get_governors output:
conservative ondemand powersave userspace performance
num CPU = 0
READ_GOVERNOR userspace
AVLBL_FREQS 2000000 1800000 1600000 800000
READ_FREQ 2000000
READ_FREQ 1800000
READ_FREQ 1600000
READ_FREQ 800000
Test p_states_test_3_2 PASSED
Execution of test_4_1
get_governors output:
conservative ondemand powersave userspace performance
num CPU = 0
READ_GOVERNOR ondemand
Test p_states_test_4_1 PASSED
Execution of test_4_2
get_governors output:
conservative ondemand powersave userspace performance
num CPU = 0
READ_GOVERNOR ondemand
MIN_FREQ 800000
READ_FREQ 800000
Test p_states_test_4_2 PASSED
Execution of test_4_3
get_governors output:
conservative ondemand powersave userspace performance
num CPU = 0
READ_GOVERNOR ondemand
MAX_FREQ 2000000
READ_FREQ 2000000
Test p_states_test_4_3 PASSED
Execution of test_4_4
get_governors output:
conservative ondemand powersave userspace performance
TMP_FILE_PID:
4229
num CPU = 0
READ_GOVERNOR ondemand
MAX_FREQ 2000000
MIN_FREQ 800000
READ_FREQ 2000000
Test _test_4_4 PASSED
Start cleanup
Cleaning up the system is not needed
Finish cleanup

Native Geyserville III Support (P state) - Demand Based Switching
###############################################################################
GV3/DBS validation for I386 and EM64T
Geyserville III is an efficient mechanism for switching to/from low
voltage mode - Enhanced SpeedStep Technology. Dependent upon ACPI.
-------------------------------------------------------------------------------
[H [2J
Arch Linux 0.7.2 (Gimmick) (\n) (\l)
Linux myhost 2.6.18-ARCH #1 SMP PREEMPT Sun Nov 19 17:12:07 CET 2006 i686 
AMD TurionT 64 Mobile Technology MK-36 AuthenticAMD GNU/Linux
-------------------------------------------------------------------------------
Details:
--------
p_states_test_1_1 PASSED
p_states_test_2_1 PASSED
p_states_test_3_1 PASSED
p_states_test_3_2 PASSED
p_states_test_4_1 PASSED
p_states_test_4_2 PASSED
p_states_test_4_3 PASSED
p_states_test_4_4 PASSED

Test Summary:
-------------
TOTAL: 8
PASS: 8
FAIL: 0
NOTSUPPORT: 0
UNRESOLVED: 0
UNTESTED: 0
###########################################################


Test report is in /root/acpi-test-0.1/ABAT/p_states/log/results/test_report, 
log file in /root/acpi-test-0.1/ABAT/p_states/log/stdout



*******************************************************
* Test ACPI C-states *
*******************************************************


Start to test ...

Test 1 ...
CONFIG_ACPI=y
CONFIG_ACPI_PROCESSOR=y

test C-state support on CPU0 ............
CPU0 supports C1
max_cstate=C8

Test2 ...

test C-state switch on CPU0 ............
Current State: C1, Usage: 00000000] duration[00000000000000000000
CPU0 supports C1
Current State: C1, Usage: 00000000] duration[00000000000000000000
FAIL: no C-state switch in C1, but usage change from 00000000] 
duration[00000000000000000000 to 00000000] duration[00000000000000000000
test CPU0: FAIL


------------
Test Summary:
-------------
TOTAL: 2
PASS: 1
FAIL: 1
NOTSUPPORT: 0
UNRESOLVED: 0
UNTESTED: 0
-------------




*******************************************************
* Test ACPI T-states *
*******************************************************

Start to test ...

Test1 ...
CONFIG_ACPI=y
CONFIG_ACPI_PROCESSOR=y
test T-state support on CPU0 ............
NOTSUPPORT: current system dosen't support throttling.
test CPU0: NOTSUPPORT

Test2 ...
test T-state function on CPU0 ............
NOTSUPPORT: current system dosen't support throttling.
test CPU0: NOTSUPPORT

Test3 ...
test T-state function on CPU0 ............
NOTSUPPORT: current system dosen't support throttling.
test CPU0: NOTSUPPORT


------------
Test Summary:
-------------
TOTAL: 3
PASS: 0
FAIL: 0
NOTSUPPORT: 3
UNRESOLVED: 0
UNTESTED: 0
-------------


ACPI ABAT finished...




 

