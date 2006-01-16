From: "Papadomitsos Panagiotis" <priestjim-fiq0XRn7RtljbPX420N+Cw@public.gmane.org>
Subject: [PROBLEM] Semp64/PCI-E/ACPI not booting on kernels > 2.6.13
Date: Mon, 16 Jan 2006 17:54:54 +0200 (EET)
Message-ID: <46762.195.251.76.191.1137426894.squirrel@oslab.teipir.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

I have recently upgraded to a nice AMD64 budget system and I am
experiencing a weird boot failure on kernels > 2.6.13[.8] with ACPI
enabled. If this is sent to the wrong mailing list, I would be grateful if
you could forward it to the correct one. Full description of the problem
follows :

- System configuration -
- AMD Sempron64 S754 stepping E6 (x86_64, SSE3) 3100+
- /proc/cpuinfo

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 44
model name      : AMD Sempron(tm) Processor 3100+
stepping        : 2
cpu MHz         : 1809.188
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext fxsr_opt lm
3dnowext 3dnow pni lahf_lm
bogomips        : 3621.05


- ASUS K8N4-E Deluxe mobo with 1010 (latest) BIOS (nforce4 4X, PCI-E)
- 1G of Geil DDR400 RAM
- MSI NX6600 VTD VGA PCI Express Card
- SB Audigy2 sound card
- 2 x 120 GB Seagate SATA hdds
- DVD-ROM Pioneer DVD-117, DVD-RW LG 4120

- Linux distribution : Slackware 10.2 / IA32

- Kernel .config for working & running 2.6.13-ck8 (2.6.13.5) with some
patches : http://oslab.teipir.gr/priestjim/bugreport/config-2.6.13 (have
tried vanilla 2.6.13 before patching with my stuff, and worked without
problems)
- Kernel .config for first failing kernel (vanilla) :
http://oslab.teipir.gr/priestjim/bugreport/config-2.6.14 (2.6.14-rc1)
- Last failing kernel (the time this e-mail was written) : 2.6.15-git10,
2.6.15-mm4

- scripts/ver_linux :
Linux grovda 2.6.13-ck8 #1 Sat Jan 14 19:05:02 EET 2006 i686 unknown
unknown GNU/Linux

Gnu C                  3.4.5
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12p
mount                  2.12p
module-init-tools      3.1
e2fsprogs              1.38
reiserfsprogs          3.6.19
reiser4progs           line
PPP                    2.4.4b1
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Linux C++ Library      6.0.3
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   070
Modules Loaded         nvidia spca5xx

- BIOS settings : ACPI enabled (duh!), APIC enabled, PNP OS enabled NO, NO
OVERCLOCKING ANYWHERE.

- /proc/acpi/info (kernel 2.6.13.5)

version:                 20050408

- Workarounds tried : CONFIG_HPET_TIMER=n, CONFIG_PNP=n,
CONFIG_PNP_ACPI=n, CONFIG_ACPI_*=n but CONFIG_ACPI=y, CPU changed to I686
(in case it was an AMD64 problem), CONFIG_PM_LEGACY=n and whatnot
- lspci -vvv out : http://oslab.teipir.gr/priestjim/bugreport/lspci.out
- /proc/scsi out : http://oslab.teipir.gr/priestjim/bugreport/proc-scsi.out

There is no OOPS, and no way to paste all the kernel messages I get, as
dmesg cannot catch the first ones. There is no problem with the
filesystem. Actually the kernel does not recongize neither the SATA
controller, nor the on-board NIC, nor the sound card, nor any USB device.
I have tried booting with all possible acpi and relevant pci kernel params
(unless I am missing something) and it still does not boot. Only acpi={
off, ht } works as they do not enable ACPI (the system actually works
almost as fine, but I am missing all of the ACPI features). I have managed
to take some photos (forgive my unsteady hand-the cam's supposed to have
image stabilizer pfff) with my digicam, while booting initrd, spawning a
busybox shell and running dmesg | more. You can find them at
http://oslab.teipir.gr/priestjim/bugreport/photo{1-8}.jpg. The kernel
booting was a vanilla 2.6.15 with CONFIG_DEBUG_BUGVERBOSE=y,
CONFIG_DEBUG_INFO=y, CONFIG_PM_DEBUG=y and CONFIG_ACPI_DEBUG=y and the
rest .config same as 2.6.14-rc1. The system is runnig fine and stable with
2.6.13.5.

This is all the information I can think of. For anything else you may need
hunting this thing down, feel free to contact me at [priestjim at oslab
dot teipir dot gr]

Papadomitsos Panagiotis
IT Department Manager
Greek Lifeguard Academy

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
