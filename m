From: Ernst Herzberg <earny-euM3SP4ZHrg@public.gmane.org>
Subject: Re: Re: ACPI source patches updated (20021101)
Date: Sun, 3 Nov 2002 08:09:02 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200211030809.02748.earny@net4u.de>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A49E@orsmsx119.jf.intel.com> <m2y98ct3fm.fsf@tnuctip.rychter.com> <200211031015.52270.acpi@computerdatasafe.com.au>
Reply-To: earny-euM3SP4ZHrg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200211031015.52270.acpi-bdq14YP6qtSeVB85EesmETSf8X3wrgjD@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: John Summerfield <summer-bdq14YP6qtSeVB85EesmETSf8X3wrgjD@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
Cc: andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sonntag, 3. November 2002 03:17, John Summerfield wrote:
> This is the hardest discussion list on which to have a discussion I know!
>
> On Sat, 2 Nov 2002 23:08, Jan Rychter wrote:
> > Doesn't boot on my machine (Sharp Mebius PC-MT1-H5). The kernel starts
> > booting, then thousands of ACPI debug messages scroll by. All I can say
> > about them is that they are related to mutexes, they scroll way too fast
> > for me to read them and I don't know of any way to stop them scrolling.
> >
> >
> > This goes on for about 2 minutes and finishes with a glorious oops.
>
> Can you run with a serial console talking to (maybe) minicom?
>
> That would allow you to get a complete completley accurate log.
>

Yupp;-)

The following output is only the first part, with 38400 bps on the serial
console the kernel is still booting after 15min. No oops yet, the log
reaches 4MB...  after about 20 minutes ...

(rebooting...)
<Earny>
-----------------------------

kernel (hd0,2)/vmlinuz  root=/dev/hda1  hdc=ide-scsi  vga=791 console=tty0 cons
ole=ttyS0,38400n8
   [Linux-bzImage, setup=0x1400, size=0x10d5bd]
initrd (hd0,2)/initrd
   [Linux-initrd @ 0x1fea4000, 0x3bf71 bytes]

Linux version 2.4.20-rc1 (root@lidl) (gcc version 3.2) #7 Sun Nov 3 07:07:54 CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c0000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fef0000 (usable)
 BIOS-e820: 000000001fef0000 - 000000001feff000 (ACPI data)
 BIOS-e820: 000000001feff000 - 000000001ff00000 (ACPI NVS)
 BIOS-e820: 000000001ff00000 - 0000000020000000 (usable)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
512MB LOWMEM available.
On node 0 totalpages: 131072
zone(0): 4096 pages.
zone(1): 126976 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 PTLTD                      ) @ 0x000f6d40
ACPI: RSDT (v001 PTLTD    RSDT   01540.00000) @ 0x1fefb426
ACPI: FADT (v001 SMDVIA VT5228C  01540.00000) @ 0x1fefef8c
ACPI: DSDT (v001  VIA   PTL_ACPI 01540.00000) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Kernel command line: root=/dev/hda1  hdc=ide-scsi  vga=791 console=tty0 console=ttyS0,38400n8
ide_setup: hdc=ide-scsi
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 1199.819 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 2392.06 BogoMIPS
Memory: 515312k/524288k available (1631k kernel code, 8524k reserved, 581k data, 148k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) III CPU             1200MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1199.8165 MHz.
..... host bus clock speed is 133.3128 MHz.
cpu: 0, clocks: 1333128, slice: 666564
CPU0<T0:1333120,T1:666544,D:12,S:666564,C:1333128>
mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20021101

**** Context Switch from TID FFFFFFFF to TID 1 ****

acpi_bus-1857 [0001] [02] acpi_bus_init         : ----Entry
 utxface-0057 [0001] [03] Acpi_initialize_subsys: ----Entry
utglobal-0653 [0001] [04] Ut_init_globals       : ----Entry
utglobal-0765 [0001] [04] Ut_init_globals       : ----Exit-
PCI: PCI BIOS revision 2.10 entry at 0xfd82e, last bus=1
PCI: Using configuration type 1
  utmisc-0502 [0001] [04] Ut_mutex_initialize   : ----Entry
  utmisc-0571 [0001] [05] Ut_create_mutex       : ----Entry 00000000
     osl-0641 [0001] [06] os_create_semaphore   : ----Entry
     osl-0652 [0001] [06] os_create_semaphore   : Creating semaphore[dfea02e0|1].
     osl-0654 [0001] [06] os_create_semaphore   : ----Exit- AE_OK
  utmisc-0586 [0001] [05] Ut_create_mutex       : ----Exit- AE_OK
  utmisc-0571 [0001] [05] Ut_create_mutex       : ----Entry 00000001
     osl-0641 [0001] [06] os_create_semaphore   : ----Entry
     osl-0652 [0001] [06] os_create_semaphore   : Creating semaphore[dfea0300|1].
     osl-0654 [0001] [06] os_create_semaphore   : ----Exit- AE_OK
  utmisc-0586 [0001] [05] Ut_create_mutex       : ----Exit- AE_OK
  utmisc-0571 [0001] [05] Ut_create_mutex       : ----Entry 00000002
     osl-0641 [0001] [06] os_create_semaphore   : ----Entry
     osl-0652 [0001] [06] os_create_semaphore   : Creating semaphore[dfea0320|1].
     osl-0654 [0001] [06] os_create_semaphore   : ----Exit- AE_OK
  utmisc-0586 [0001] [05] Ut_create_mutex       : ----Exit- AE_OK
  utmisc-0571 [0001] [05] Ut_create_mutex       : ----Entry 00000003
     osl-0641 [0001] [06] os_create_semaphore   : ----Entry
     osl-0652 [0001] [06] os_create_semaphore   : Creating semaphore[dfea0340|1].
     osl-0654 [0001] [06] os_create_semaphore   : ----Exit- AE_OK
  utmisc-0586 [0001] [05] Ut_create_mutex       : ----Exit- AE_OK
  utmisc-0571 [0001] [05] Ut_create_mutex       : ----Entry 00000004
     osl-0641 [0001] [06] os_create_semaphore   : ----Entry
     osl-0652 [0001] [06] os_create_semaphore   : Creating semaphore[dfea0360|1].
     osl-0654 [0001] [06] os_create_semaphore   : ----Exit- AE_OK
  utmisc-0586 [0001] [05] Ut_create_mutex       : ----Exit- AE_OK
  utmisc-0571 [0001] [05] Ut_create_mutex       : ----Entry 00000005
     osl-0641 [0001] [06] os_create_semaphore   : ----Entry
     osl-0652 [0001] [06] os_create_semaphore   : Creating semaphore[dfea0380|1].
     osl-0654 [0001] [06] os_create_semaphore   : ----Exit- AE_OK
  utmisc-0586 [0001] [05] Ut_create_mutex       : ----Exit- AE_OK
  utmisc-0571 [0001] [05] Ut_create_mutex       : ----Entry 00000006
     osl-0641 [0001] [06] os_create_semaphore   : ----Entry
     osl-0652 [0001] [06] os_create_semaphore   : Creating semaphore[dfea03a0|1].
     osl-0654 [0001] [06] os_create_semaphore   : ----Exit- AE_OK
  utmisc-0586 [0001] [05] Ut_create_mutex       : ----Exit- AE_OK
  utmisc-0571 [0001] [05] Ut_create_mutex       : ----Entry 00000007
     osl-0641 [0001] [06] os_create_semaphore   : ----Entry
     osl-0652 [0001] [06] os_create_semaphore   : Creating semaphore[dfea03c0|1].
     osl-0654 [0001] [06] os_create_semaphore   : ----Exit- AE_OK
  utmisc-0586 [0001] [05] Ut_create_mutex       : ----Exit- AE_OK
  utmisc-0571 [0001] [05] Ut_create_mutex       : ----Entry 00000008
     osl-0641 [0001] [06] os_create_semaphore   : ----Entry
     osl-0652 [0001] [06] os_create_semaphore   : Creating semaphore[dfea03e0|1].
     osl-0654 [0001] [06] os_create_semaphore   : ----Exit- AE_OK
  utmisc-0586 [0001] [05] Ut_create_mutex       : ----Exit- AE_OK
  utmisc-0571 [0001] [05] Ut_create_mutex       : ----Entry 00000009
     osl-0641 [0001] [06] os_create_semaphore   : ----Entry
     osl-0652 [0001] [06] os_create_semaphore   : Creating semaphore[dfea0400|1].
     osl-0654 [0001] [06] os_create_semaphore   : ----Exit- AE_OK
  utmisc-0586 [0001] [05] Ut_create_mutex       : ----Exit- AE_OK
  utmisc-0571 [0001] [05] Ut_create_mutex       : ----Entry 0000000A
     osl-0641 [0001] [06] os_create_semaphore   : ----Entry
     osl-0652 [0001] [06] os_create_semaphore   : Creating semaphore[dfea0420|1].
     osl-0654 [0001] [06] os_create_semaphore   : ----Exit- AE_OK
  utmisc-0586 [0001] [05] Ut_create_mutex       : ----Exit- AE_OK
  utmisc-0571 [0001] [05] Ut_create_mutex       : ----Entry 0000000B
     osl-0641 [0001] [06] os_create_semaphore   : ----Entry
     osl-0652 [0001] [06] os_create_semaphore   : Creating semaphore[dfea0440|1].
     osl-0654 [0001] [06] os_create_semaphore   : ----Exit- AE_OK
  utmisc-0586 [0001] [05] Ut_create_mutex       : ----Exit- AE_OK
  utmisc-0571 [0001] [05] Ut_create_mutex       : ----Entry 0000000C
     osl-0641 [0001] [06] os_create_semaphore   : ----Entry
     osl-0652 [0001] [06] os_create_semaphore   : Creating semaphore[dfea0460|1].
     osl-0654 [0001] [06] os_create_semaphore   : ----Exit- AE_OK
  utmisc-0586 [0001] [05] Ut_create_mutex       : ----Exit- AE_OK
  utmisc-0515 [0001] [04] Ut_mutex_initialize   : ----Exit- AE_OK
nsaccess-0060 [0001] [04] Ns_root_initialize    : ----Entry
  utmisc-0685 [0001] [04] Ut_acquire_mutex      : Thread 1 attempting to acquire Mutex [ACPI_MTX_Namespace]
     osl-0703 [0001] [05] os_wait_semaphore     : ----Entry
     osl-0711 [0001] [05] os_wait_semaphore     : Waiting for semaphore[dfea03a0|1|-1]
     osl-0767 [0001] [05] os_wait_semaphore     : Acquired semaphore[dfea03a0|1|-1]
     osl-0770 [0001] [05] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0691 [0001] [04] Ut_acquire_mutex      : Thread 1 acquired Mutex [ACPI_MTX_Namespace]
nsaccess-0086 [0001] [04] Ns_root_initialize    : Entering predefined entries into namespace
nsaccess-0259 [0001] [05] Ns_lookup             : ----Entry
nsaccess-0281 [0001] [05] Ns_lookup             : Null scope prefix, using root node (c036477c)
nsaccess-0353 [0001] [05] Ns_lookup             : Searching relative to prefix scope [\___] (c036477c)
nsaccess-0457 [0001] [05] Ns_lookup             : Simple Pathname (1 segment, Flags=0)
  nsdump-0063 [0001] [05] Ns_print_pathname     : [_GPE]
nssearch-0263 [0001] [06] Ns_search_and_enter   : ----Entry
nssearch-0072 [0001] [07] Ns_search_node        : ----Entry
 nsnames-0129 [0001] [08] Ns_get_external_pathna: ----Entry c036477c
 utalloc-0395 [0001] [09] Ut_callocate          : ----Entry 00000031
 utalloc-0418 [0001] [09] Ut_callocate          : ----Exit- c158e220
 utalloc-0663 [0001] [09] Ut_track_allocation   : ----Entry c158e220
  utmisc-0685 [0001] [09] Ut_acquire_mutex      : Thread 1 attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0703 [0001] [10] os_wait_semaphore     : ----Entry
     osl-0711 [0001] [10] os_wait_semaphore     : Waiting for semaphore[dfea0420|1|-1]
     osl-0767 [0001] [10] os_wait_semaphore     : Acquired semaphore[dfea0420|1|-1]
     osl-0770 [0001] [10] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0691 [0001] [09] Ut_acquire_mutex      : Thread 1 acquired Mutex [ACPI_MTX_Memory]
  utmisc-0734 [0001] [09] Ut_release_mutex      : Thread 1 releasing Mutex [ACPI_MTX_Memory]
     osl-0784 [0001] [10] os_signal_semaphore   : ----Entry
     osl-0792 [0001] [10] os_signal_semaphore   : Signaling semaphore[dfea0420|1]
     osl-0796 [0001] [10] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0787 [0001] [09] Ut_release_mutex      : Thread 1 released Mutex [ACPI_MTX_Memory]
 utalloc-0714 [0001] [09] Ut_track_allocation   : ----Exit- AE_OK
 nsnames-0147 [0001] [08] Ns_get_external_pathna: ----Exit- c158e248
nssearch-0082 [0001] [07] Ns_search_node        : Searching \ [c036477c] For _GPE (Scope)
 utalloc-0557 [0001] [08] Ut_free               : ----Entry c158e248
 utalloc-0745 [0001] [09] Ut_remove_allocation  : ----Entry
  utmisc-0685 [0001] [09] Ut_acquire_mutex      : Thread 1 attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0703 [0001] [10] os_wait_semaphore     : ----Entry
     osl-0711 [0001] [10] os_wait_semaphore     : Waiting for semaphore[dfea0420|1|-1]
     osl-0767 [0001] [10] os_wait_semaphore     : Acquired semaphore[dfea0420|1|-1]
     osl-0770 [0001] [10] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0691 [0001] [09] Ut_acquire_mutex      : Thread 1 acquired Mutex [ACPI_MTX_Memory]
 utalloc-0784 [0001] [09] Ut_remove_allocation  : Freeing size 1
  utmisc-0734 [0001] [09] Ut_release_mutex      : Thread 1 releasing Mutex [ACPI_MTX_Memory]
     osl-0784 [0001] [10] os_signal_semaphore   : ----Entry
     osl-0792 [0001] [10] os_signal_semaphore   : Signaling semaphore[dfea0420|1]
     osl-0796 [0001] [10] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0787 [0001] [09] Ut_release_mutex      : Thread 1 released Mutex [ACPI_MTX_Memory]
 utalloc-0787 [0001] [09] Ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0582 [0001] [08] Ut_free               : c158e248 freed
 utalloc-0584 [0001] [08] Ut_free               : ----Exit-
nssearch-0127 [0001] [07] Ns_search_node        : Name _GPE Type [Scope] not found at 00000000
nssearch-0129 [0001] [07] Ns_search_node        : ----Exit- ****Exception****: AE_NOT_FOUND
 nsalloc-0054 [0001] [07] Ns_create_node        : ----Entry
 utalloc-0395 [0001] [08] Ut_callocate          : ----Entry 00000048
 utalloc-0418 [0001] [08] Ut_callocate          : ----Exit- c159ae20
 utalloc-0663 [0001] [08] Ut_track_allocation   : ----Entry c159ae20
  utmisc-0685 [0001] [08] Ut_acquire_mutex      : Thread 1 attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0703 [0001] [09] os_wait_semaphore     : ----Entry
     osl-0711 [0001] [09] os_wait_semaphore     : Waiting for semaphore[dfea0420|1|-1]
     osl-0767 [0001] [09] os_wait_semaphore     : Acquired semaphore[dfea0420|1|-1]
     osl-0770 [0001] [09] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0691 [0001] [08] Ut_acquire_mutex      : Thread 1 acquired Mutex [ACPI_MTX_Memory]
  utmisc-0734 [0001] [08] Ut_release_mutex      : Thread 1 releasing Mutex [ACPI_MTX_Memory]
     osl-0784 [0001] [09] os_signal_semaphore   : ----Entry
     osl-0792 [0001] [09] os_signal_semaphore   : Signaling semaphore[dfea0420|1]
     osl-0796 [0001] [09] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0787 [0001] [08] Ut_release_mutex      : Thread 1 released Mutex [ACPI_MTX_Memory]
 utalloc-0714 [0001] [08] Ut_track_allocation   : ----Exit- AE_OK
 nsalloc-0068 [0001] [07] Ns_create_node        : ----Exit- c159ae48
 nsalloc-0215 [0001] [07] Ns_install_node       : ----Entry

[......]
  utmisc-0685 [0001] [06] Ut_acquire_mutex      : Thread 1 attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0703 [0001] [07] os_wait_semaphore     : ----Entry
     osl-0711 [0001] [07] os_wait_semaphore     : Waiting for semaphore[dfea0420|1|-1]
     osl-0767 [0001] [07] os_wait_semaphore     : Acquired semaphore[dfea0420|1|-1]
     osl-0770 [0001] [07] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0691 [0001] [06] Ut_acquire_mutex      : Thread 1 acquired Mutex [ACPI_MTX_Memory]
  utmisc-0734 [0001] [06] Ut_release_mutex      : Thread 1 releasing Mutex [ACPI_MTX_Memory]
     osl-0784 [0001] [07] os_signal_semaphore   : ----Entry
     osl-0792 [0001] [07] os_signal_semaphore   : Signaling semaphore[dfea0420|1]
     osl-0796 [0001] [07] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0787 [0001] [06] Ut_release_mutex      : Thread 1 released Mutex [ACPI_MTX_Memory]
 utalloc-0714 [0001] [06] Ut_track_allocation   : ----Exit- AE_OK
tbgetall-0287 [0001] [04] Tb_get_required_tables: Hex dump of entire DSDT, size 15166 (0x3B3E), Integer width = 32

Offset Value
00000  44 53 44 54 3E 3B 00 00 01 0D 56 49 41 20 20 00 DSDT>;....VIA  .
00010  50 54 4C 5F 41 43 50 49 00 00 04 06 4D 53 46 54 PTL_ACPI....MSFT
00020  0D 00 00 01 10 13 5C 5F 50 52 5F 5B 83 0B 43 50 ......\_PR_[..CP
00030  55 30 01 10 40 00 00 06 08 5C 5F 53 30 5F 12 06 U0..-9D9NNryygCw@public.gmane.org\_S0_..
00040  02 0A 00 0A 00 08 5C 5F 53 31 5F 12 06 02 0A 04 ......\_S1_.....
00050  0A 04 08 5C 5F 53 34 5F 12 06 02 0A 02 0A 02 08 ...\_S4_........
00060  5C 5F 53 35 5F 12 06 02 0A 02 0A 02 08 55 42 48 \_S5_........UBH
00070  31 11 08 0A 05 00 00 00 00 00 8C 55 42 48 31 0A 1..........UBH1.
00080  00 48 41 30 34 8C 55 42 48 31 0A 01 48 41 32 30 .HA04.UBH1..HA20
00090  8C 55 42 48 31 0A 02 48 41 32 31 8C 55 42 48 31 .UBH1..HA21.UBH1

[..................]


[....................................................]


-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
