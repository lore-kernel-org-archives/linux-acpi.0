From: Bernhard Rosenkraenzer <bero-9zdaV+82baBg9hUCZPvPmw@public.gmane.org>
Subject: crash on bootup w/ MSI mainboard
Date: Tue, 3 Dec 2002 01:57:01 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.50.0212030154590.20080-100000@dot.kde.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

Hi,
the current (20021126) ACPI implementation (running on top of Linux 
2.4.20-ac1) crashes on bootup if io-apic is enabled on MSI p4 mainboards.

Disabling APIC mode in BIOS is a workaround; after doing that, even ACPI 
suspends etc. work.

Oops:
ksymoops 2.4.5 on i686 2.4.20-3ark.  Options used
     -V (default)
     -k /proc/ksyms (specified)
     -l /proc/modules (specified)
     -o /lib/modules/2.4.20-3ark (specified)
     -m /boot/System.map-2.4.20-3ark (specified)

402f3470
*pde = 00000000
Oops: 0000 2.4.20-3ark #1 Sun Dec 1 23:37:09 UTC 2002
CPU: 0
EFLAGS: 00010287
eax: 00000000 ebx: 00001000 ecx: 00000000 edx: 00000000
esi: 00000010 edi: 00000000 ebp: 4035a500 esp: 402e9f7c
ds: 0018 es: 0018 ss: 0018
Process swapper (pid: 0, stackpage=402e9000)
Stack: 00001000 00098700 402e8000 402e9fb8 402f37cf 00000000 00000000 00000000
       00000001 00001000 402e8000 00000400 00000001 00000000 00000000 00000900
       01000000 00000000 00098700 40105000 0008e000 402f4561 40275387 00010809
Call Trace: [<40105000>] (0x402e9fc8)
            [<40105000>] (0x402e9fe0)
Code: 0f b6 44 d1 01 39 f8 74 17 42 39 f2 7c f2 bb ff ff ff ff 89
Using defaults from ksymoops -t elf32-i386 -a i386


>>ebx; 00001000 Before first symbol
>>ebp; 4035a500 <mp_ioapics+0/40>
>>esp; 402e9f7c <init_task_union+1f7c/2000>

Trace; 40105000 <_stext+0/0>
Trace; 40105000 <_stext+0/0>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f b6 44 d1 01            movzbl 0x1(%ecx,%edx,8),%eax
Code;  00000005 Before first symbol
   5:   39 f8                     cmp    %edi,%eax
Code;  00000007 Before first symbol
   7:   74 17                     je     20 <_EIP+0x20>
Code;  00000009 Before first symbol
   9:   42                        inc    %edx
Code;  0000000a Before first symbol
   a:   39 f2                     cmp    %esi,%edx
Code;  0000000c Before first symbol
   c:   7c f2                     jl     0 <_EIP>
Code;  0000000e Before first symbol
   e:   bb ff ff ff ff            mov    $0xffffffff,%ebx
Code;  00000013 Before first symbol
  13:   89 00                     mov    %eax,(%eax)


dsdt and fadt tables at
http://www.arklinux.org/stuff/acpi/msi/dsdt
http://www.arklinux.org/stuff/acpi/msi/fadt

LLaP
bero



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
