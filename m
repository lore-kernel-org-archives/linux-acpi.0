From: Greg Oliver <oliver.greg2@gmail.com>
Subject: Core i7 & C-States
Date: Wed, 17 Nov 2010 14:34:43 -0600
Message-ID: <AANLkTik+zt0FC7chXJojaqtAMC5DsfLHKcU1FVAJEXAn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00032557521274132f0495459a16
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60789 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754601Ab0KQUep (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Nov 2010 15:34:45 -0500
Received: by ywg8 with SMTP id 8so1413720ywg.19
        for <linux-acpi@vger.kernel.org>; Wed, 17 Nov 2010 12:34:44 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--00032557521274132f0495459a16
Content-Type: text/plain; charset=UTF-8

Hi,

This is my first motherboard with ACPI issues, so I am in uncharted
water. It is an intel board, so no overclocking, etc.  Reading through
as much as I can this morning, I have hit the wall.  I have
disassembled all of my [DS]SDTs, and will attach them with a dmesg as
this seems to be the normal request from the archives.

About the issue though -

If I enable either/or C-STATES/C2-STATES, the system will freeze on
boot.  Disabling them both the system runs fine, but I would obviously
like the power savings if possible.  Now I know this BIOS has some
issues as some PCI devices (when disabled in the BIOS) still get
partially enumerated and assigned IRQs on the bus as well, but that
does not concern me as much as the power.  The latest update to the
BIOS from intel is installed.

This is the only ACPI error I get from dmesg currently though:

ACPI Warning: Incorrect checksum in table [SSDT] - 3F, should be 91
(20090903/tbutils-314)

I have also booted with "acpi.debug_layer=0xFFFFFFFF
acpi.debug_level=0x80000000" appended to my kernel cmdline and I am
unsure why, but even though the system showed all debugs enabled in
/sys, I did not receive any extra debug messages in dmesg!?!?

Thanks for any insight!

-Greg

Info follows:
pmtools-20071116/acpixtract/acpixtract -l acpidump.acpi

Signature Length  OemId     OemTableId   OemRevision CompilerId CompilerRevision

    DSDT   27404  "INTEL "  "DH55TC  "    00000000    "INTL"     20051117
    FACS      64
    FACP     244  "INTEL "  "DH55TC  "    01072009    "MSFT"     00010013
    APIC     204  "INTEL "  "DH55TC  "    01072009    "MSFT"     00010013
    SSDT     470  "INTEL "  "DH55TC  "    00000001    "MSFT"     03000001
    MCFG      60  "INTEL "  "DH55TC  "    01072009    "MSFT"     00000097
    HPET      56  "INTEL "  "DH55TC  "    01072009    "AMI."     00000003
    ASF!     160  "INTEL "  "DH55TC  "    00000001    "TFSM"     000F4240
    DMAR     104  "INTEL "  "DH55TC  "    00000001    "INTL"     00000001
    XSDT      92  "INTEL "  "DH55TC  "    01072009    "MSFT"     00010013
    FACS      64
    FACP     132  "INTEL "  "DH55TC  "    01072009    "MSFT"     00010013
    RSDT      64  "INTEL "  "DH55TC  "    01072009    "MSFT"     00010013
    RSDP          "INTEL "

Found 14 ACPI tables [20060324]

dmidecode (cpu portion):

SMBIOS 2.6 present.
79 structures occupying 3163 bytes.
Table at 0x000EAF70.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Intel Corp.
	Version: TCIBX10H.86A.0040.2010.1018.1100
	Release Date: 10/18/2010
	Address: 0xF0000
	Runtime Size: 64 kB
	ROM Size: 1024 kB
	Characteristics:
		PCI is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		Boot from CD is supported
		Selectable boot is supported
		BIOS ROM is socketed
		EDD is supported
		5.25"/1.2 MB floppy services are supported (int 13h)
		3.5"/720 kB floppy services are supported (int 13h)
		3.5"/2.88 MB floppy services are supported (int 13h)
		Print screen service is supported (int 5h)
		8042 keyboard services are supported (int 9h)
		Serial services are supported (int 14h)
		Printer services are supported (int 17h)
		ACPI is supported
		USB legacy is supported
		BIOS boot specification is supported
		Targeted content distribution is supported

Handle 0x0004, DMI type 4, 42 bytes
Processor Information
	Socket Designation: XU1
	Type: Central Processor
	Family: Core i7
	Manufacturer: Intel
	ID: E5 06 01 00 FF FB EB BF
	Version: Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz
	Voltage: 0.0 V
	External Clock: 533 MHz
	Max Speed: 2926 MHz
	Current Speed: 2793 MHz
	Status: Populated, Enabled
	Upgrade: Other
	L1 Cache Handle: 0x0005
	L2 Cache Handle: 0x0006
	L3 Cache Handle: 0x0007
	Serial Number: To Be Filled By O.E.M.
	Asset Tag: To Be Filled By O.E.M.
	Part Number: To Be Filled By O.E.M.
	Core Count: 4
	Core Enabled: 1
	Thread Count: 2
	Characteristics:
		64-bit capable

Handle 0x0005, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1-Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 128 kB
	Maximum Size: 128 kB
	Supported SRAM Types:
		Other
	Installed SRAM Type: Other
	Speed: Unknown
	Error Correction Type: None
	System Type: Unified
	Associativity: 4-way Set-associative

Handle 0x0006, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L2-Cache
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Varies With Memory Address
	Location: Internal
	Installed Size: 1024 kB
	Maximum Size: 1024 kB
	Supported SRAM Types:
		Other
	Installed SRAM Type: Other
	Speed: Unknown
	Error Correction Type: None
	System Type: Instruction
	Associativity: 8-way Set-associative

Handle 0x0007, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L3-Cache
	Configuration: Enabled, Not Socketed, Level 3
	Operational Mode: Unknown
	Location: Internal
	Installed Size: 8192 kB
	Maximum Size: 8192 kB
	Supported SRAM Types:
		Other
	Installed SRAM Type: Other
	Speed: Unknown
	Error Correction Type: None
	System Type: Instruction
	Associativity: 16-way Set-associative

cpuinfo:
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 30
model name	: Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz
stepping	: 5
cpu MHz		: 2793.450
cache size	: 8192 KB
physical id	: 0
siblings	: 8
core id		: 0
cpu cores	: 4
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good xtopology
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3
cx16 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida tpr_shadow vnmi
flexpriority ept vpid
bogomips	: 5586.90
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 30
model name	: Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz
stepping	: 5
cpu MHz		: 2793.450
cache size	: 8192 KB
physical id	: 0
siblings	: 8
core id		: 0
cpu cores	: 4
apicid		: 1
initial apicid	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good xtopology
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3
cx16 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida tpr_shadow vnmi
flexpriority ept vpid
bogomips	: 5585.01
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 6
model		: 30
model name	: Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz
stepping	: 5
cpu MHz		: 2793.450
cache size	: 8192 KB
physical id	: 0
siblings	: 8
core id		: 1
cpu cores	: 4
apicid		: 2
initial apicid	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good xtopology
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3
cx16 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida tpr_shadow vnmi
flexpriority ept vpid
bogomips	: 5585.03
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 6
model		: 30
model name	: Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz
stepping	: 5
cpu MHz		: 2793.450
cache size	: 8192 KB
physical id	: 0
siblings	: 8
core id		: 1
cpu cores	: 4
apicid		: 3
initial apicid	: 3
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good xtopology
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3
cx16 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida tpr_shadow vnmi
flexpriority ept vpid
bogomips	: 5585.02
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 4
vendor_id	: GenuineIntel
cpu family	: 6
model		: 30
model name	: Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz
stepping	: 5
cpu MHz		: 2793.450
cache size	: 8192 KB
physical id	: 0
siblings	: 8
core id		: 2
cpu cores	: 4
apicid		: 4
initial apicid	: 4
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good xtopology
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3
cx16 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida tpr_shadow vnmi
flexpriority ept vpid
bogomips	: 5585.03
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 5
vendor_id	: GenuineIntel
cpu family	: 6
model		: 30
model name	: Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz
stepping	: 5
cpu MHz		: 2793.450
cache size	: 8192 KB
physical id	: 0
siblings	: 8
core id		: 2
cpu cores	: 4
apicid		: 5
initial apicid	: 5
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good xtopology
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3
cx16 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida tpr_shadow vnmi
flexpriority ept vpid
bogomips	: 5585.02
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 6
vendor_id	: GenuineIntel
cpu family	: 6
model		: 30
model name	: Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz
stepping	: 5
cpu MHz		: 2793.450
cache size	: 8192 KB
physical id	: 0
siblings	: 8
core id		: 3
cpu cores	: 4
apicid		: 6
initial apicid	: 6
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good xtopology
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3
cx16 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida tpr_shadow vnmi
flexpriority ept vpid
bogomips	: 5585.03
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 7
vendor_id	: GenuineIntel
cpu family	: 6
model		: 30
model name	: Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz
stepping	: 5
cpu MHz		: 2793.450
cache size	: 8192 KB
physical id	: 0
siblings	: 8
core id		: 3
cpu cores	: 4
apicid		: 7
initial apicid	: 7
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good xtopology
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3
cx16 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida tpr_shadow vnmi
flexpriority ept vpid
bogomips	: 5585.02
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

--00032557521274132f0495459a16
Content-Type: application/x-bzip-compressed-tar;
	name="20101117-acpi_dasm_dumps.tbz2"
Content-Disposition: attachment; filename="20101117-acpi_dasm_dumps.tbz2"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ggmo7gxs0

QlpoOTFBWSZTWWpiWtEA9HL/9f////V8///3//////////qQBABxR0AAAIQCFAlgrj8fOx8ulWAD
XxjBTrRSQCRRSIL4D6gfFnp4PiBVF7fBrW33iLYIQoHS1br53t7TwSF7bl66N7N6JJM33223g9fb
JO282vb1ut1p1sw6AAAAGr0Y6qqWrG9qE0Sb3WddQG3tu8vtqHua7eG3u3buGl0NKtm77b3t2y7s
u+7fPuGvOO+e30Xe733z3nvj0O2PXvO9l4b3h6BJ223u2zsNSu7LvXjxu7kr222gAbl7euu7ivLd
3LXjhd9nH3vtzj3u93329e3Pqefe932yOk233O6a+vXt7t833mel2ye3uNsbs773vO8yHq7e97vc
9Zq17m1t99973OuZot89NyZHXNzg5vS9e9Tr3jbvnve98dctLnXXt7ne1fL7t5aXI+83vbnd1ltm
1bLu7tnZW51u7a6Ke27Z1q5t4dxOTOu7219vfae97nt9U+Sj1ubbaeaC6042vt3r3bmbfTtK7spu
z0Xbp3VU3To0bhRrgz2vbT6eu8ONfez2mvTNK17bRw87i9utKybrXd00ee3vdvT2x1cS2Tt23Sts
p2N2vWtq543rXHuztVw+9q5iteW9de9O3d2V1c+shXWF7u5R2BJIJoAJkAEaBMEyAAIGiYmlPSPV
P9VMnoGUyegADIAAgAkhAEEJppMKYTamEaJiYjTJTxJ6TCPU09TyQek00DTIAABpoAAaaNCakjCJ
J6ntKeJPKPSD0gD1Daj1ABoDQAAAAAADQAAJNJIQIQ0NTCmGhGmSbSn6o9PSm0yj0gaNDU0wjEaG
hoB6gaZBpgRgESghACEzQRhGgBDIaE2mhMRMBJH6bRI1NmjVPUHohvKg8pp6IaaAVFEICABACCYR
owJTyaanghT8J6ppP1T1Nqek00ek0aYmhoNNA9QNNGT+ZgP9If7H+eCzpY/yGKj6vr+qDSbLtBif
sz/frNLBeb/XUiarzWJI7aGFgj0j9QxIkfhm8c59NDA/8RNSMwjefJ8/BPwWtPn4sJC17+yfwZ+R
z0hFDRUFWgSBIqfihIvwiVO8D7kCCkNAt7qixNJDPvG1CWzwSnMKskhtROJAGqhask7vLLEhahjE
YWJosFaZg0qQfEDUj+gftHwDA98eAyNA1Qn9Y/rHqbmjn6KPvijp6seXWxGEsjEpaEnFku0sIN2F
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
--00032557521274132f0495459a16--
