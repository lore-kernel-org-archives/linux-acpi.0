From: "Bencsath Boldizsar" <boldi-VDXXwik4frg@public.gmane.org>
Subject: fujitsu-siemens e-6624 kernel oops 2.6.0testing1 acpi
Date: Thu, 17 Jul 2003 16:23:54 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <001201c34c6f$0e0ab750$5001690a@fbi>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000F_01C34C7F.D0C22D90"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_000F_01C34C7F.D0C22D90
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,
 I have only bad experience with both acpi and apm on my Fujitsu Siemens =
E-6624
notebook(933Mhz PIII-M,512M SD133 ram, some nasty stuff like "security" =
keys on the front of
the notebook). ACPI did not work with the 2.4 series and nowtime I tried =
it again on the 2.5
series. It is still not working with the latest 2.6.0testing1 too. (In =
2.4 series, with ACPI
enabled the kernel hanged if I pressed any special keys (fn+brightness =
etc.), now it drops
OOPS at kernel start.=20
=20
 I would be pretty happy to solve the issue.
 Details:
 Kernel: Simple 2.6.0testing1. Debian unstable - kernel from source.
=20
 Dump of the serial console:
 Linux version 2.6.0-test1 (root@fbi) (gcc version 3.3.1 20030626 =
(Debian prerelease)) #2
SMP Tue Jul 15 16:00:47 CEST 2003
 Video mode to be used for restore is ffff
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
  BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e6400 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000001fee0000 (usable)
  BIOS-e820: 000000001fee0000 - 000000001feefc00 (ACPI data)
  BIOS-e820: 000000001feefc00 - 000000001fef0000 (ACPI NVS)
  BIOS-e820: 000000001fef0000 - 000000001ff00000 (reserved)
  BIOS-e820: 000000001ff00000 - 000000001ff80000 (usable)
  BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
 511MB LOWMEM available.
 On node 0 totalpages: 130944
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 126848 pages, LIFO batch:16
   HighMem zone: 0 pages, LIFO batch:1
 ACPI: RSDP (v000 FUJ                        ) @ 0x000f62c0
 ACPI: RSDT (v001 FUJ    RICKWOOD 00265.00000) @ 0x1feeba1f
 ACPI: FADT (v001 FUJ    RICKWOOD 00265.00000) @ 0x1feefb8c
 ACPI: DSDT (v001 FUJ    RICKWOOD 00265.00000) @ 0x00000000
 ACPI: BIOS passes blacklist
 ACPI: MADT not present
 Building zonelist for node : 0
 Kernel command line: BOOT_IMAGE=3Dl260p1 ro root=3D305 =
console=3DttyS0,38400n8 console=3Dtty0
 Local APIC disabled by BIOS -- reenabling.
 Found and enabled local APIC!
 Initializing CPU#0
 PID hash table entries: 2048 (order 11: 16384 bytes)
 Detected 930.413 MHz processor.
 Console: colour VGA+ 80x25
 Calibrating delay loop... 1839.10 BogoMIPS
 Memory: 510088k/523776k available (4302k kernel code, 12808k reserved, =
1594k data, 244k
init, 0k highmem)
 Security Scaffold v1.0.0 initialized
 Capability LSM initialized
 Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
 Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
 Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
 -> /dev
 -> /dev/console
 -> /root
 CPU: L1 I cache: 16K, L1 D cache: 16K
 CPU: L2 cache: 512K
 Intel machine check architecture supported.
 Intel machine check reporting enabled on CPU#0.
 Enabling fast FPU save and restore... done.
 Enabling unmasked SIMD FPU exception support... done.
 Checking 'hlt' instruction... OK.
 POSIX conformance testing by UNIFIX
 CPU0: Intel(R) Pentium(R) III Mobile CPU       933MHz stepping 01
 per-CPU timeslice cutoff: 1462.52 usecs.
 task migration cache decay timeout: 2 msecs.
 SMP motherboard not detected.
 enabled ExtINT on CPU#0
 ESR value before enabling vector: 00000000
 ESR value after enabling vector: 00000000
 Using local APIC timer interrupts.
 calibrating APIC timer ...
 ..... CPU clock speed is 235.0889 MHz.
 ..... host bus clock speed is 132.0844 MHz.
 Starting migration thread for cpu 0
 CPUS done 32
 Initializing RT netlink socket
 PCI: PCI BIOS revision 2.10 entry at 0xfd97e, last bus=3D4
 PCI: Using configuration type 1
 mtrr: v2.0 (20020519)
 BIO: pool of 256 setup, 15Kb (60 bytes/bio)
 biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
 biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
 biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
 biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
 biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
 biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
 ACPI: Subsystem revision 20030619
 ACPI: Interpreter enabled
 ACPI: Using PIC for interrupt routing
 ACPI: PCI Root Bridge [PCI0] (00:00)
 PCI: Probing PCI hardware (bus 00)
 Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bri
 Unable to handle kernel NULL pointer dereference at virtual address =
00000007
  printing eip:
 c02a622c
 *pde =3D 00000000
 Oops: 0000 [#1]
 CPU:    0
 EIP:    0060:[<c02a622c>]    Not tainted
 EFLAGS: 00010246
 EIP is at acpi_ns_map_handle_to_node+0x1a/0x22
 eax: 00000000   ebx: c167ef40   ecx: dfeddde4   edx: 00000007
 esi: 00000000   edi: dfeddde4   ebp: dfedddb8   esp: dfedddb8
 ds: 007b   es: 007b   ss: 0068
 Process swapper (pid: 1, threadinfo=3Ddfedc000 task=3Ddfedf8c0)
 Stack: dfedddd0 c02a5c3f 00000007 c167ef40 00000000 c167ef50 dfeddef8 =
c02b0ac0=20
        00000007 dfeddde4 dfeddde4 00000100 dfedddec 00000000 00000000 =
00000000=20
        00000000 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000=20
 Call Trace:
  [<c02a5c3f>] acpi_ns_handle_to_pathname+0x11/0x4a
  [<c02b0ac0>] acpi_pci_bind_root+0xa5/0xd5
  [<c02afd0d>] acpi_pci_root_add+0x177/0x1c9
  [<c02b190e>] acpi_bus_driver_init+0x2d/0x8f
  [<c02b1c5d>] acpi_bus_find_driver+0x86/0xe6
  [<c02b212c>] acpi_bus_add+0x127/0x155
  [<c02b2254>] acpi_bus_scan+0xfa/0x145
  [<c06dbc38>] acpi_scan_init+0x51/0x79
  [<c06c6a1b>] do_initcalls+0x2b/0xa0
  [<c0137732>] init_workqueues+0x12/0x29
  [<c01050da>] init+0x5a/0x1f0
  [<c0105080>] init+0x0/0x1f0
  [<c01091e9>] kernel_thread_helper+0x5/0xc
=20
 Code: 80 3a aa 0f 44 c2 5d c3 55 89 e5 8b 45 08 5d c3 55 89 e5 ff=20
  <0>Kernel panic: Attempted to kill init!
 =20
 =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D-------------
 ksymoops, If it succeeded:
 ksymoops 2.4.8 on i686 2.6.0-test1.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.6.0-test1/ (default)
      -m /boot/System.map (specified)
=20
 Error (regular_file): read_ksyms stat /proc/ksyms failed
 No modules in ksyms, skipping objects
 No ksyms, skipping lsmod
 Reading Oops report from the terminal
 Unable to handle kernel NULL pointer dereference at virtual address =
00000007
 c02a622c
 *pde =3D 00000000
 Oops: 0000 [#1]
 CPU:    0
 EIP:    0060:[<c02a622c>]    Not tainted
 Using defaults from ksymoops -t elf32-i386 -a i386
 EFLAGS: 00010246
 eax: 00000000   ebx: c167ef40   ecx: dfeddde4   edx: 00000007
 esi: 00000000   edi: dfeddde4   ebp: dfedddb8   esp: dfedddb8
 ds: 007b   es: 007b   ss: 0068
 Stack: dfedddd0 c02a5c3f 00000007 c167ef40 00000000 c167ef50 dfeddef8 =
c02b0ac0
        00000007 dfeddde4 dfeddde4 00000100 dfedddec 00000000 00000000 =
00000000
        00000000 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000
 Call Trace:
  [<c02a5c3f>] acpi_ns_handle_to_pathname+0x11/0x4a
  [<c02b0ac0>] acpi_pci_bind_root+0xa5/0xd5
  [<c02afd0d>] acpi_pci_root_add+0x177/0x1c9
  [<c02b190e>] acpi_bus_driver_init+0x2d/0x8f
  [<c02b1c5d>] acpi_bus_find_driver+0x86/0xe6
  [<c02b212c>] acpi_bus_add+0x127/0x155
  [<c02b2254>] acpi_bus_scan+0xfa/0x145
  [<c06dbc38>] acpi_scan_init+0x51/0x79
  [<c06c6a1b>] do_initcalls+0x2b/0xa0
  [<c0137732>] init_workqueues+0x12/0x29
  [<c01050da>] init+0x5a/0x1f0
  [<c0105080>] init+0x0/0x1f0
  [<c01091e9>] kernel_thread_helper+0x5/0xc
 Code: 80 3a aa 0f 44 c2 5d c3 55 89 e5 8b 45 08 5d c3 55 89 e5 ff
=20
=20
 >>EIP; c02a622c <acpi_ns_map_handle_to_node+1a/22>   <=3D=3D=3D=3D=3D
=20
 >>ebx; c167ef40 <_end+f1a1f8/3f8992b8>
 >>ecx; dfeddde4 <_end+1f77909c/3f8992b8>
 >>edi; dfeddde4 <_end+1f77909c/3f8992b8>
 >>ebp; dfedddb8 <_end+1f779070/3f8992b8>
 >>esp; dfedddb8 <_end+1f779070/3f8992b8>
=20
 Trace; c02a5c3f <acpi_ns_handle_to_pathname+11/4a>
 Trace; c02b0ac0 <acpi_pci_bind_root+a5/d5>
 Trace; c02afd0d <acpi_pci_root_add+177/1c9>
 Trace; c02b190e <acpi_bus_driver_init+2d/8f>
 Trace; c02b1c5d <acpi_bus_find_driver+86/e6>
 Trace; c02b212c <acpi_bus_add+127/155>
 Trace; c02b2254 <acpi_bus_scan+fa/145>
 Trace; c06dbc38 <pte_chain_init+58/60>
 Trace; c06c6a1b <_edata+71b/1d00>
 Trace; c0137732 <init_workqueues+12/29>
 Trace; c01050da <init+5a/1f0>
 Trace; c0105080 <init+0/1f0>
 Trace; c01091e9 <kernel_thread_helper+5/c>
=20
 Code;  c02a622c <acpi_ns_map_handle_to_node+1a/22>
 00000000 <_EIP>:
 Code;  c02a622c <acpi_ns_map_handle_to_node+1a/22>   <=3D=3D=3D=3D=3D
    0:   80 3a aa                  cmpb   $0xaa,(%edx)   =
<=3D=3D=3D=3D=3D
 Code;  c02a622f <acpi_ns_map_handle_to_node+1d/22>
    3:   0f 44 c2                  cmove  %edx,%eax
 Code;  c02a6232 <acpi_ns_map_handle_to_node+20/22>
    6:   5d                        pop    %ebp
 Code;  c02a6233 <acpi_ns_map_handle_to_node+21/22>
    7:   c3                        ret   =20
 Code;  c02a6234 <acpi_ns_convert_entry_to_handle+0/8>
    8:   55                        push   %ebp
 Code;  c02a6235 <acpi_ns_convert_entry_to_handle+1/8>
    9:   89 e5                     mov    %esp,%ebp
 Code;  c02a6237 <acpi_ns_convert_entry_to_handle+3/8>
    b:   8b 45 08                  mov    0x8(%ebp),%eax
 Code;  c02a623a <acpi_ns_convert_entry_to_handle+6/8>
    e:   5d                        pop    %ebp
 Code;  c02a623b <acpi_ns_convert_entry_to_handle+7/8>
    f:   c3                        ret   =20
 Code;  c02a623c <acpi_ns_terminate+0/31>
   10:   55                        push   %ebp
 Code;  c02a623d <acpi_ns_terminate+1/31>
   11:   89 e5                     mov    %esp,%ebp
 Code;  c02a623f <acpi_ns_terminate+3/31>
   13:   ff 00                     incl   (%eax)
=20
  <0>Kernel panic: Attempted to kill init!
=20
 1 error issued.  Results may not be reliable.
=20
=20
 (FYI: apm -s or -S 1. does nothing 2. does not suspend 3. does suspend =
but it cannot
resume)
 (FYI2: with acpi=3Doff kernel says everything is on the same IRQ =
(shared), and recommends
pci=3Dumasqpirq)
=20
=20
 any answers are welcome, I can send more detail or check anything as =
you wish. CC: to me
please,
 boldizsar

------=_NextPart_000_000F_01C34C7F.D0C22D90
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1170" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV>Hi,<BR> I have only bad experience with both acpi and apm on my =
Fujitsu=20
Siemens E-6624<BR>notebook(933Mhz PIII-M,512M SD133 ram, some nasty =
stuff like=20
"security" keys on the front of<BR>the notebook). ACPI did not work with =
the 2.4=20
series and nowtime I tried it again on the 2.5<BR>series. It is still =
not=20
working with the latest 2.6.0testing1 too. (In 2.4 series, with =
ACPI<BR>enabled=20
the kernel hanged if I pressed any special keys (fn+brightness etc.), =
now it=20
drops<BR>OOPS at kernel start. <BR> <BR> I would be pretty happy to =
solve the=20
issue.<BR> Details:<BR> Kernel: Simple 2.6.0testing1. Debian unstable - =
kernel=20
from source.<BR> <BR> Dump of the serial console:<BR> Linux version =
2.6.0-test1=20
(root@fbi) (gcc version 3.3.1 20030626 (Debian prerelease)) #2<BR>SMP =
Tue Jul 15=20
16:00:47 CEST 2003<BR> Video mode to be used for restore is ffff<BR>=20
BIOS-provided physical RAM map:<BR>&nbsp; BIOS-e820: 0000000000000000 -=20
000000000009f400 (usable)<BR>&nbsp; BIOS-e820: 000000000009f400 -=20
00000000000a0000 (reserved)<BR>&nbsp; BIOS-e820: 00000000000e6400 -=20
0000000000100000 (reserved)<BR>&nbsp; BIOS-e820: 0000000000100000 -=20
000000001fee0000 (usable)<BR>&nbsp; BIOS-e820: 000000001fee0000 -=20
000000001feefc00 (ACPI data)<BR>&nbsp; BIOS-e820: 000000001feefc00 -=20
000000001fef0000 (ACPI NVS)<BR>&nbsp; BIOS-e820: 000000001fef0000 -=20
000000001ff00000 (reserved)<BR>&nbsp; BIOS-e820: 000000001ff00000 -=20
000000001ff80000 (usable)<BR>&nbsp; BIOS-e820: 000000001ff80000 -=20
0000000020000000 (reserved)<BR>&nbsp; BIOS-e820: 00000000fff00000 -=20
0000000100000000 (reserved)<BR> 511MB LOWMEM available.<BR> On node 0=20
totalpages: 130944<BR>&nbsp;&nbsp; DMA zone: 4096 pages, LIFO=20
batch:1<BR>&nbsp;&nbsp; Normal zone: 126848 pages, LIFO =
batch:16<BR>&nbsp;&nbsp;=20
HighMem zone: 0 pages, LIFO batch:1<BR> ACPI: RSDP (v000=20
FUJ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
) @ 0x000f62c0<BR> ACPI: RSDT (v001 FUJ&nbsp;&nbsp;&nbsp; RICKWOOD =
00265.00000)=20
@ 0x1feeba1f<BR> ACPI: FADT (v001 FUJ&nbsp;&nbsp;&nbsp; RICKWOOD =
00265.00000) @=20
0x1feefb8c<BR> ACPI: DSDT (v001 FUJ&nbsp;&nbsp;&nbsp; RICKWOOD =
00265.00000) @=20
0x00000000<BR> ACPI: BIOS passes blacklist<BR> ACPI: MADT not =
present<BR>=20
Building zonelist for node : 0<BR> Kernel command line: =
BOOT_IMAGE=3Dl260p1 ro=20
root=3D305 console=3DttyS0,38400n8 console=3Dtty0<BR> Local APIC =
disabled by BIOS --=20
reenabling.<BR> Found and enabled local APIC!<BR> Initializing CPU#0<BR> =
PID=20
hash table entries: 2048 (order 11: 16384 bytes)<BR> Detected 930.413 =
MHz=20
processor.<BR> Console: colour VGA+ 80x25<BR> Calibrating delay loop... =
1839.10=20
BogoMIPS<BR> Memory: 510088k/523776k available (4302k kernel code, =
12808k=20
reserved, 1594k data, 244k<BR>init, 0k highmem)<BR> Security Scaffold =
v1.0.0=20
initialized<BR> Capability LSM initialized<BR> Dentry cache hash table =
entries:=20
65536 (order: 6, 262144 bytes)<BR> Inode-cache hash table entries: 32768 =
(order:=20
5, 131072 bytes)<BR> Mount-cache hash table entries: 512 (order: 0, 4096 =

bytes)<BR> -&gt; /dev<BR> -&gt; /dev/console<BR> -&gt; /root<BR> CPU: L1 =
I=20
cache: 16K, L1 D cache: 16K<BR> CPU: L2 cache: 512K<BR> Intel machine =
check=20
architecture supported.<BR> Intel machine check reporting enabled on =
CPU#0.<BR>=20
Enabling fast FPU save and restore... done.<BR> Enabling unmasked SIMD =
FPU=20
exception support... done.<BR> Checking 'hlt' instruction... OK.<BR> =
POSIX=20
conformance testing by UNIFIX<BR> CPU0: Intel(R) Pentium(R) III Mobile=20
CPU&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 933MHz stepping 01<BR> per-CPU =
timeslice=20
cutoff: 1462.52 usecs.<BR> task migration cache decay timeout: 2 =
msecs.<BR> SMP=20
motherboard not detected.<BR> enabled ExtINT on CPU#0<BR> ESR value =
before=20
enabling vector: 00000000<BR> ESR value after enabling vector: =
00000000<BR>=20
Using local APIC timer interrupts.<BR> calibrating APIC timer ...<BR> =
..... CPU=20
clock speed is 235.0889 MHz.<BR> ..... host bus clock speed is 132.0844 =
MHz.<BR>=20
Starting migration thread for cpu 0<BR> CPUS done 32<BR> Initializing RT =
netlink=20
socket<BR> PCI: PCI BIOS revision 2.10 entry at 0xfd97e, last =
bus=3D4<BR> PCI:=20
Using configuration type 1<BR> mtrr: v2.0 (20020519)<BR> BIO: pool of =
256 setup,=20
15Kb (60 bytes/bio)<BR> biovec pool[0]:&nbsp;&nbsp; 1 bvecs: 256 entries =
(12=20
bytes)<BR> biovec pool[1]:&nbsp;&nbsp; 4 bvecs: 256 entries (48 =
bytes)<BR>=20
biovec pool[2]:&nbsp; 16 bvecs: 256 entries (192 bytes)<BR> biovec=20
pool[3]:&nbsp; 64 bvecs: 256 entries (768 bytes)<BR> biovec pool[4]: 128 =
bvecs:=20
256 entries (1536 bytes)<BR> biovec pool[5]: 256 bvecs: 256 entries =
(3072=20
bytes)<BR> ACPI: Subsystem revision 20030619<BR> ACPI: Interpreter =
enabled<BR>=20
ACPI: Using PIC for interrupt routing<BR> ACPI: PCI Root Bridge [PCI0]=20
(00:00)<BR> PCI: Probing PCI hardware (bus 00)<BR> Transparent bridge - =
Intel=20
Corp. 82801BAM/CAM PCI Bri<BR> Unable to handle kernel NULL pointer =
dereference=20
at virtual address 00000007<BR>&nbsp; printing eip:<BR> c02a622c<BR> =
*pde =3D=20
00000000<BR> Oops: 0000 [#1]<BR> CPU:&nbsp;&nbsp;&nbsp; 0<BR>=20
EIP:&nbsp;&nbsp;&nbsp; 0060:[&lt;c02a622c&gt;]&nbsp;&nbsp;&nbsp; Not =
tainted<BR>=20
EFLAGS: 00010246<BR> EIP is at acpi_ns_map_handle_to_node+0x1a/0x22<BR> =
eax:=20
00000000&nbsp;&nbsp; ebx: c167ef40&nbsp;&nbsp; ecx: dfeddde4&nbsp;&nbsp; =
edx:=20
00000007<BR> esi: 00000000&nbsp;&nbsp; edi: dfeddde4&nbsp;&nbsp; ebp:=20
dfedddb8&nbsp;&nbsp; esp: dfedddb8<BR> ds: 007b&nbsp;&nbsp; es: =
007b&nbsp;&nbsp;=20
ss: 0068<BR> Process swapper (pid: 1, threadinfo=3Ddfedc000 =
task=3Ddfedf8c0)<BR>=20
Stack: dfedddd0 c02a5c3f 00000007 c167ef40 00000000 c167ef50 dfeddef8 =
c02b0ac0=20
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00000007 dfeddde4 =
dfeddde4=20
00000100 dfedddec 00000000 00000000 00000000=20
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00000000 00000000 =
00000000=20
00000000 00000000 00000000 00000000 00000000 <BR> Call Trace:<BR>&nbsp;=20
[&lt;c02a5c3f&gt;] acpi_ns_handle_to_pathname+0x11/0x4a<BR>&nbsp;=20
[&lt;c02b0ac0&gt;] acpi_pci_bind_root+0xa5/0xd5<BR>&nbsp; =
[&lt;c02afd0d&gt;]=20
acpi_pci_root_add+0x177/0x1c9<BR>&nbsp; [&lt;c02b190e&gt;]=20
acpi_bus_driver_init+0x2d/0x8f<BR>&nbsp; [&lt;c02b1c5d&gt;]=20
acpi_bus_find_driver+0x86/0xe6<BR>&nbsp; [&lt;c02b212c&gt;]=20
acpi_bus_add+0x127/0x155<BR>&nbsp; [&lt;c02b2254&gt;]=20
acpi_bus_scan+0xfa/0x145<BR>&nbsp; [&lt;c06dbc38&gt;]=20
acpi_scan_init+0x51/0x79<BR>&nbsp; [&lt;c06c6a1b&gt;]=20
do_initcalls+0x2b/0xa0<BR>&nbsp; [&lt;c0137732&gt;]=20
init_workqueues+0x12/0x29<BR>&nbsp; [&lt;c01050da&gt;] =
init+0x5a/0x1f0<BR>&nbsp;=20
[&lt;c0105080&gt;] init+0x0/0x1f0<BR>&nbsp; [&lt;c01091e9&gt;]=20
kernel_thread_helper+0x5/0xc<BR> <BR> Code: 80 3a aa 0f 44 c2 5d c3 55 =
89 e5 8b=20
45 08 5d c3 55 89 e5 ff <BR>&nbsp; &lt;0&gt;Kernel panic: Attempted to =
kill=20
init!<BR>&nbsp; <BR> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D-------------<BR> ksymoops,=20
If it succeeded:<BR> ksymoops 2.4.8 on i686 2.6.0-test1.&nbsp; Options=20
used<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -V=20
(default)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -k /proc/ksyms=20
(default)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -l /proc/modules=20
(default)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -o /lib/modules/2.6.0-test1/ =

(default)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -m /boot/System.map =
(specified)<BR>=20
<BR> Error (regular_file): read_ksyms stat /proc/ksyms failed<BR> No =
modules in=20
ksyms, skipping objects<BR> No ksyms, skipping lsmod<BR> Reading Oops =
report=20
from the terminal<BR> Unable to handle kernel NULL pointer dereference =
at=20
virtual address 00000007<BR> c02a622c<BR> *pde =3D 00000000<BR> Oops: =
0000=20
[#1]<BR> CPU:&nbsp;&nbsp;&nbsp; 0<BR> EIP:&nbsp;&nbsp;&nbsp;=20
0060:[&lt;c02a622c&gt;]&nbsp;&nbsp;&nbsp; Not tainted<BR> Using defaults =
from=20
ksymoops -t elf32-i386 -a i386<BR> EFLAGS: 00010246<BR> eax:=20
00000000&nbsp;&nbsp; ebx: c167ef40&nbsp;&nbsp; ecx: dfeddde4&nbsp;&nbsp; =
edx:=20
00000007<BR> esi: 00000000&nbsp;&nbsp; edi: dfeddde4&nbsp;&nbsp; ebp:=20
dfedddb8&nbsp;&nbsp; esp: dfedddb8<BR> ds: 007b&nbsp;&nbsp; es: =
007b&nbsp;&nbsp;=20
ss: 0068<BR> Stack: dfedddd0 c02a5c3f 00000007 c167ef40 00000000 =
c167ef50=20
dfeddef8 c02b0ac0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00000007 =

dfeddde4 dfeddde4 00000100 dfedddec 00000000 00000000=20
00000000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00000000 00000000 =

00000000 00000000 00000000 00000000 00000000 00000000<BR> Call =
Trace:<BR>&nbsp;=20
[&lt;c02a5c3f&gt;] acpi_ns_handle_to_pathname+0x11/0x4a<BR>&nbsp;=20
[&lt;c02b0ac0&gt;] acpi_pci_bind_root+0xa5/0xd5<BR>&nbsp; =
[&lt;c02afd0d&gt;]=20
acpi_pci_root_add+0x177/0x1c9<BR>&nbsp; [&lt;c02b190e&gt;]=20
acpi_bus_driver_init+0x2d/0x8f<BR>&nbsp; [&lt;c02b1c5d&gt;]=20
acpi_bus_find_driver+0x86/0xe6<BR>&nbsp; [&lt;c02b212c&gt;]=20
acpi_bus_add+0x127/0x155<BR>&nbsp; [&lt;c02b2254&gt;]=20
acpi_bus_scan+0xfa/0x145<BR>&nbsp; [&lt;c06dbc38&gt;]=20
acpi_scan_init+0x51/0x79<BR>&nbsp; [&lt;c06c6a1b&gt;]=20
do_initcalls+0x2b/0xa0<BR>&nbsp; [&lt;c0137732&gt;]=20
init_workqueues+0x12/0x29<BR>&nbsp; [&lt;c01050da&gt;] =
init+0x5a/0x1f0<BR>&nbsp;=20
[&lt;c0105080&gt;] init+0x0/0x1f0<BR>&nbsp; [&lt;c01091e9&gt;]=20
kernel_thread_helper+0x5/0xc<BR> Code: 80 3a aa 0f 44 c2 5d c3 55 89 e5 =
8b 45 08=20
5d c3 55 89 e5 ff<BR> <BR> <BR> &gt;&gt;EIP; c02a622c=20
&lt;acpi_ns_map_handle_to_node+1a/22&gt;&nbsp;&nbsp; =
&lt;=3D=3D=3D=3D=3D<BR> <BR>=20
&gt;&gt;ebx; c167ef40 &lt;_end+f1a1f8/3f8992b8&gt;<BR> &gt;&gt;ecx; =
dfeddde4=20
&lt;_end+1f77909c/3f8992b8&gt;<BR> &gt;&gt;edi; dfeddde4=20
&lt;_end+1f77909c/3f8992b8&gt;<BR> &gt;&gt;ebp; dfedddb8=20
&lt;_end+1f779070/3f8992b8&gt;<BR> &gt;&gt;esp; dfedddb8=20
&lt;_end+1f779070/3f8992b8&gt;<BR> <BR> Trace; c02a5c3f=20
&lt;acpi_ns_handle_to_pathname+11/4a&gt;<BR> Trace; c02b0ac0=20
&lt;acpi_pci_bind_root+a5/d5&gt;<BR> Trace; c02afd0d=20
&lt;acpi_pci_root_add+177/1c9&gt;<BR> Trace; c02b190e=20
&lt;acpi_bus_driver_init+2d/8f&gt;<BR> Trace; c02b1c5d=20
&lt;acpi_bus_find_driver+86/e6&gt;<BR> Trace; c02b212c=20
&lt;acpi_bus_add+127/155&gt;<BR> Trace; c02b2254=20
&lt;acpi_bus_scan+fa/145&gt;<BR> Trace; c06dbc38=20
&lt;pte_chain_init+58/60&gt;<BR> Trace; c06c6a1b =
&lt;_edata+71b/1d00&gt;<BR>=20
Trace; c0137732 &lt;init_workqueues+12/29&gt;<BR> Trace; c01050da=20
&lt;init+5a/1f0&gt;<BR> Trace; c0105080 &lt;init+0/1f0&gt;<BR> Trace; =
c01091e9=20
&lt;kernel_thread_helper+5/c&gt;<BR> <BR> Code;&nbsp; c02a622c=20
&lt;acpi_ns_map_handle_to_node+1a/22&gt;<BR> 00000000 &lt;_EIP&gt;:<BR>=20
Code;&nbsp; c02a622c =
&lt;acpi_ns_map_handle_to_node+1a/22&gt;&nbsp;&nbsp;=20
&lt;=3D=3D=3D=3D=3D<BR>&nbsp;&nbsp;&nbsp; 0:&nbsp;&nbsp; 80 3a=20
aa&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
cmpb&nbsp;&nbsp; $0xaa,(%edx)&nbsp;&nbsp; &lt;=3D=3D=3D=3D=3D<BR> =
Code;&nbsp; c02a622f=20
&lt;acpi_ns_map_handle_to_node+1d/22&gt;<BR>&nbsp;&nbsp;&nbsp; =
3:&nbsp;&nbsp; 0f=20
44=20
c2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
cmove&nbsp; %edx,%eax<BR> Code;&nbsp; c02a6232=20
&lt;acpi_ns_map_handle_to_node+20/22&gt;<BR>&nbsp;&nbsp;&nbsp; =
6:&nbsp;&nbsp;=20
5d&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
pop&nbsp;&nbsp;&nbsp; %ebp<BR> Code;&nbsp; c02a6233=20
&lt;acpi_ns_map_handle_to_node+21/22&gt;<BR>&nbsp;&nbsp;&nbsp; =
7:&nbsp;&nbsp;=20
c3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
ret&nbsp;&nbsp;&nbsp; <BR> Code;&nbsp; c02a6234=20
&lt;acpi_ns_convert_entry_to_handle+0/8&gt;<BR>&nbsp;&nbsp;&nbsp; =
8:&nbsp;&nbsp;=20
55&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
push&nbsp;&nbsp; %ebp<BR> Code;&nbsp; c02a6235=20
&lt;acpi_ns_convert_entry_to_handle+1/8&gt;<BR>&nbsp;&nbsp;&nbsp; =
9:&nbsp;&nbsp;=20
89=20
e5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
mov&nbsp;&nbsp;&nbsp; %esp,%ebp<BR> Code;&nbsp; c02a6237=20
&lt;acpi_ns_convert_entry_to_handle+3/8&gt;<BR>&nbsp;&nbsp;&nbsp; =
b:&nbsp;&nbsp;=20
8b 45=20
08&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
mov&nbsp;&nbsp;&nbsp; 0x8(%ebp),%eax<BR> Code;&nbsp; c02a623a=20
&lt;acpi_ns_convert_entry_to_handle+6/8&gt;<BR>&nbsp;&nbsp;&nbsp; =
e:&nbsp;&nbsp;=20
5d&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
pop&nbsp;&nbsp;&nbsp; %ebp<BR> Code;&nbsp; c02a623b=20
&lt;acpi_ns_convert_entry_to_handle+7/8&gt;<BR>&nbsp;&nbsp;&nbsp; =
f:&nbsp;&nbsp;=20
c3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
ret&nbsp;&nbsp;&nbsp; <BR> Code;&nbsp; c02a623c=20
&lt;acpi_ns_terminate+0/31&gt;<BR>&nbsp;&nbsp; 10:&nbsp;&nbsp;=20
55&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
push&nbsp;&nbsp; %ebp<BR> Code;&nbsp; c02a623d=20
&lt;acpi_ns_terminate+1/31&gt;<BR>&nbsp;&nbsp; 11:&nbsp;&nbsp; 89=20
e5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
mov&nbsp;&nbsp;&nbsp; %esp,%ebp<BR> Code;&nbsp; c02a623f=20
&lt;acpi_ns_terminate+3/31&gt;<BR>&nbsp;&nbsp; 13:&nbsp;&nbsp; ff=20
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
incl&nbsp;&nbsp; (%eax)<BR> <BR>&nbsp; &lt;0&gt;Kernel panic: Attempted =
to kill=20
init!<BR> <BR> 1 error issued.&nbsp; Results may not be reliable.<BR> =
<BR> <BR>=20
(FYI: apm -s or -S 1. does nothing 2. does not suspend 3. does suspend =
but it=20
cannot<BR>resume)<BR> (FYI2: with acpi=3Doff kernel says everything is =
on the same=20
IRQ (shared), and recommends<BR>pci=3Dumasqpirq)<BR> <BR> <BR> any =
answers are=20
welcome, I can send more detail or check anything as you wish. CC: to=20
me<BR>please,<BR> boldizsar<BR></DIV></BODY></HTML>

------=_NextPart_000_000F_01C34C7F.D0C22D90--



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
