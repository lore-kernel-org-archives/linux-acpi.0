From: "Polevoy, IgorX" <igorx.polevoy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: enabling ACPI on RH 8
Date: Wed, 9 Apr 2003 17:54:19 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <DFDDBBFBAF6C634BAE34B5F175A29F021F0B52@hasmsx403.iil.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Mattia Dongili <dongili-vcC760zL2fQ1GQ1Ptb7lUw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Installed vanilla kernel 2.4.20 with patch acpi-20021212-2.4.20.diff.gz. 
Still no /proc/acpi... ?

Thanks,
Igor.

dmesg: 

Linux version 2.4.20 (root-MhUJylentZ8jHRH29WNCow@public.gmane.org) (gcc version 3.2 20020903 (Red Hat
Linux 8.0 3.2-7)) #6 SMP Wed Apr 9 20:14:52 IDT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ffd000 (usable)
 BIOS-e820: 0000000007ffd000 - 0000000007fff000 (ACPI data)
 BIOS-e820: 0000000007fff000 - 0000000008000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB LOWMEM available.
On node 0 totalpages: 32765
zone(0): 4096 pages.
zone(1): 28669 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 ASUS                       ) @ 0x000f8010
ACPI: RSDT (v001 ASUS   P2B-N    22616.11825) @ 0x07ffd000
ACPI: FADT (v001 ASUS   P2B-N    22616.11825) @ 0x07ffd080
ACPI: BOOT (v001 ASUS   P2B-N    22616.11825) @ 0x07ffd040
ACPI: DSDT (v001   ASUS P2B-N    00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Kernel command line: auto BOOT_IMAGE=linux-2.4.20 ro root=302
BOOT_FILE=/boot/vmlinuz-2.4.20 apm=off acpi=on

> -----Original Message-----
> this is an ancient acpi subsystem, you should try with a 
> recent vanilla
> kernel and a recent acpi patch from www.sf.net/projects/acpi 
> 
> --
> mattia
>   
> 


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
