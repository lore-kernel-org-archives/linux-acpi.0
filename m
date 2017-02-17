From: Ritesh Raj Sarraf <rrs@researchut.com>
Subject: 4.10-rc8: mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 6:
 ae0000000040110a
Date: Fri, 17 Feb 2017 13:03:40 +0530
Message-ID: <1487316820.6980.10.camel@researchut.com>
Reply-To: rrs@researchut.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:32985 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755353AbdBQHdo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Feb 2017 02:33:44 -0500
Received: by mail-pf0-f170.google.com with SMTP id c73so11975543pfb.0
        for <linux-acpi@vger.kernel.org>; Thu, 16 Feb 2017 23:33:44 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
Cc: acpi@linux.intel.com

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hello,

WIth the 4.10-rc8 kernel, I keep getting the following (non-fatal) error on
every boot.
With previous kernels, the mcelog daemon used to register errors occasionally.
But the errors messages weren't recurrent on every boot.

Filing it here, in case it is not a hardware bug.


On 4.10-rc8:

Feb 16 22:23:58 learner kernel: CPU: Physical Processor ID: 0
Feb 16 22:23:58 learner kernel: CPU: Processor Core ID: 0
Feb 16 22:23:58 learner kernel: ENERGY_PERF_BIAS: Set to 'normal', was
'performance'
Feb 16 22:23:58 learner kernel: ENERGY_PERF_BIAS: View and update with
x86_energy_perf_policy(8)
Feb 16 22:23:58 learner kernel: mce: CPU supports 7 MCE banks
Feb 16 22:23:58 learner kernel: CPU0: Thermal monitoring enabled (TM1)
Feb 16 22:23:58 learner kernel: process: using mwait in idle threads
Feb 16 22:23:58 learner kernel: Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB
1024
Feb 16 22:23:58 learner kernel: Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB
1024, 1GB 4
Feb 16 22:23:58 learner kernel: Freeing SMP alternatives memory: 24K
Feb 16 22:23:58 learner kernel: ftrace: allocating 25290 entries in 99 pages
Feb 16 22:23:58 learner kernel: smpboot: Max logical packages: 4
Feb 16 22:23:58 learner kernel: ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1
pin2=-1
Feb 16 22:23:58 learner kernel: TSC deadline timer enabled
Feb 16 22:23:58 learner kernel: smpboot: CPU0: Intel(R) Core(TM) i7-4510U CPU @
2.00GHz (family: 0x6, model: 0x45, stepping: 0x1)
Feb 16 22:23:58 learner kernel: mce: [Hardware Error]: CPU 0: Machine Check: 0
Bank 6: ae0000000040110a
Feb 16 22:23:58 learner kernel: mce: [Hardware Error]: TSC 0 ADDR fef87300 MISC
78a0000086 
Feb 16 22:23:58 learner kernel: mce: [Hardware Error]: PROCESSOR 0:40651 TIME
1487264016 SOCKET 0 APIC 0 microcode 1f
Feb 16 22:23:58 learner kernel: Performance Events: PEBS fmt2+, Haswell events,
16-deep LBR, full-width counters, Intel PMU driver.
Feb 16 22:23:58 learner kernel: ... version:                3
Feb 16 22:23:58 learner kernel: ... bit width:              48
Feb 16 22:23:58 learner kernel: ... generic registers:      4
Feb 16 22:23:58 learner kernel: ... value mask:             0000ffffffffffff
Feb 16 22:23:58 learner kernel: ... max period:             00007fffffffffff
Feb 16 22:23:58 learner kernel: ... fixed-purpose events:   3
Feb 16 22:23:58 learner kernel: ... event mask:             000000070000000f
Feb 16 22:23:58 learner kernel: NMI watchdog: enabled on all CPUs, permanently
consumes one hw-PMU counter.
Feb 16 22:23:58 learner kernel: smp: Bringing up secondary CPUs ...
Feb 16 22:23:58 learner kernel: x86: Booting SMP configuration:
Feb 16 22:23:58 learner kernel: .... node  #0, CPUs:      #1 #2 #3
Feb 16 22:23:58 learner kernel: smp: Brought up 1 node, 4 CPUs
Feb 16 22:23:58 learner kernel: smpboot: Total of 4 processors activated
(20765.31 BogoMIPS)


On kernels prior to 4.10, occasional log:

[    0.041496] mce: CPU supports 7 MCE banks
[  299.540930] mce: [Hardware Error]: Machine check events logged

and

mcelog: failed to prefill DIMM database from DMI data
Hardware event. This is not a software error.
MCE 0
CPU 0 BANK 5
MISC 38a0000086 ADDR fef81880
TIME 1432455005 Sun May 24 13:40:05 2015
MCG status:
MCi status:
Error overflow
Uncorrected error
MCi_MISC register valid
MCi_ADDR register valid
Processor context corrupt
MCA: corrected filtering (some unreported errors in same region)
Generic CACHE Level-2 Generic Error
STATUS ee0000000040110a MCGSTATUS 0
MCGCAP c07 APICID 0 SOCKETID 0
CPUID Vendor Intel Family 6 Model 69
Hardware event. This is not a software error.
MCE 1
CPU 0 BANK 6
MISC 78a0000086 ADDR fef81780
TIME 1432455005 Sun May 24 13:40:05 2015
MCG status:
MCi status:
Uncorrected error
MCi_MISC register valid
MCi_ADDR register valid
Processor context corrupt
MCA: corrected filtering (some unreported errors in same region)
Generic CACHE Level-2 Generic Error
STATUS ae0000000040110a MCGSTATUS 0
MCGCAP c07 APICID 0 SOCKETID 0
CPUID Vendor Intel Family 6 Model 69
Hardware event. This is not a software error.
MCE 2
CPU 0 BANK 5
MISC 38a0000086 ADDR fef81880
TIME 1432455114 Sun May 24 13:41:54 2015
MCG status:
MCi status:
Error overflow
Uncorrected error
MCi_MISC register valid
MCi_ADDR register valid
Processor context corrupt
MCA: corrected filtering (some unreported errors in same region)
Generic CACHE Level-2 Generic Error
STATUS ee0000000040110a MCGSTATUS 0
MCGCAP c07 APICID 0 SOCKETID 0
CPUID Vendor Intel Family 6 Model 69
Hardware event. This is not a software error.
MCE 3
CPU 0 BANK 6
MISC 78a0000086 ADDR fef81780
TIME 1432455114 Sun May 24 13:41:54 2015
MCG status:
MCi status:
Uncorrected error
MCi_MISC register valid
MCi_ADDR register valid
Processor context corrupt
MCA: corrected filtering (some unreported errors in same region)
Generic CACHE Level-2 Generic Error
STATUS ae0000000040110a MCGSTATUS 0
MCGCAP c07 APICID 0 SOCKETID 0
CPUID Vendor Intel Family 6 Model 69




Full kernel log is available at:
https://people.debian.org/~rrs/tmp/kernel-4.10-rc8.log

I have also compiled a list of similar bugs reported:
https://bugzilla.redhat.com/show_bug.cgi?id=1152717
https://bugzilla.redhat.com/show_bug.cgi?id=1082211
https://www.researchut.com/blog/lenovo-yoga-2-13-debian

- -- 
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAlimp1QACgkQpjpYo/Lh
dWmnJBAAgaLk89VHcTG36eu4YPgcor2YVkwLrrRxYByyQlKwVHYZN+5KiIzBMo8k
IcreCkejg5/4aZRn32PHaYiO7MdcyU6/91xdmUjwuWtwNEsBqJRjn576C7KvbPHw
MnCuF2ho6TwY2tcx1YsNyNbspgxB8FwLDsFXBnnUwrtRWdD7Ut0NNeN5IaKvruw0
RMrEGeZxWBxs/ivDzB7At0eW+64MFu0bK7BfRLpf1EBoXaMWwRQMONn0n+4Ku5f5
kRU+24lnsUnrV0b0MCUNkQeT01zEYf75fa+YN6ior9T4KFeooEbNK13RFuvTbWgv
qiFWrHy8zHHDPa2QTG3Vow+teBlZh22q6evdICIsKKnca2obELUYY5jqMydnDeh1
tBFTeoJjSLZNCC0JyzJv5d8ujk3D16V7+NfxZcOUQgWCuXlj3FICJ3uDYq8v13L3
r4CoiSSx2Zwx4oYobyQmBQoVMXlN1hqAXyRW0GxaUQzHFykqVpZZlCWsJ67gJtC3
B8s383UgDa9dKXxKeIsD4vS33LP0UW3ypRwS5AOCJOOFilDKEzxUn4Z0EG1GG6ib
hC8jz7rK0zIdcl3N4zBfnKcc3h9vsj3IMS7fjqE5Ck0CWfGdVzxxvz+INSwSUk/P
xaFvzRL/z8nP4qZazlDvq0f15C3U3KGO5fRE3QF+r4zleBQE+Kw=
=9WUT
-----END PGP SIGNATURE-----

