From: Bernhard Rosenkraenzer <bero-9zdaV+82baBg9hUCZPvPmw@public.gmane.org>
Subject: Some failures
Date: Mon, 2 Dec 2002 15:49:01 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.50.0212021428260.1091-100000@dot.kde.org>
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
I've just tried kernel 2.4.20-ac1 + the current (20021126) ACPI patch on 4 
different boxes - one caused a fatal crash and 3 were somewhat working, 
but missing suspend etc.:

On an ASUS A7S333 mainboard using the 1005.003 BIOS, the kernel produces 
an oops at startup, when enabling IO-APIC IRQs:

Unable to handle kernel NULL pointer dereference at virtual address
00000001 printing eip:
402ef3a0
*pde = 00000000
Oops: 0000 2.4.20-3ark #1 Sun Dec 1 23:37:09 UTC 2002
CPU: 0
EIP: 0010:[<402ef3a0>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010293
eax: 00000000  ebx: 00001000  ecx: 00000000  edx: 00000000
esi: 00000011  edi: 00000000  ebp: 40358200  esp: 402e5f78
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=402e5000)
Stack: 00001000 00000001 402e4000 402e5fb4 402ef6e5 00000000 00000000 00000000
       00000001 00001000 402e4000 00000400 00000001 00000000 00000000 00000900
       01000000 00000000 00000001 40105000 0008e000 402f0446 40271867 00000000
Call Trace: [<40105000>] (0x402e5fc4) [<40105000>] (0x402e5fe0)
Code: 0f b6 44 d1 01 39 f8 74 17 42 39 f2 7c f2 bb ff ff ff ff 89

>>EIP; 402ef3a0 <find_irq_entry+20/70>   <=====
Trace; 40105000 <_stext+0/0>
Code;  402ef3a0 <find_irq_entry+20/70>
00000000 <_EIP>:
Code;  402ef3a0 <find_irq_entry+20/70>   <=====
   0:   0f b6 44 d1 01            movzbl 0x1(%ecx,%edx,8),%eax   <=====
Code;  402ef3a5 <find_irq_entry+25/70>
   5:   39 f8                     cmp    %edi,%eax
Code;  402ef3a7 <find_irq_entry+27/70>
   7:   74 17                     je     20 <_EIP+0x20>
Code;  402ef3a9 <find_irq_entry+29/70>
   9:   42                        inc    %edx
Code;  402ef3aa <find_irq_entry+2a/70>
   a:   39 f2                     cmp    %esi,%edx
Code;  402ef3ac <find_irq_entry+2c/70>
   c:   7c f2                     jl     0 <_EIP>
Code;  402ef3ae <find_irq_entry+2e/70>
   e:   bb ff ff ff ff            mov    $0xffffffff,%ebx
Code;  402ef3b3 <find_irq_entry+33/70>
  13:   89 00                     mov    %eax,(%eax)

<0>Kernel panic: Attempted to kill the idle task!
(The kernel boots only with acpi=off, so I can't get to the dsdt and fadt 
tables :/)


On a QDI i810 based mainboard (don't have the full name - the board is 
taken from a set top box ;) ), results are better, but not perfect - 
bootup works, ACPI IRQ routing works, but sleep modes don't work -
echo 1>/proc/acpi/sleep returns immediately without changing anything, 
thouch /proc/acpi/sleep claims modes 0, 1, 4 and 5 are supported (5 
actually works).
I've put up the ACPI tables for this board at
http://www.arklinux.org/stuff/acpi/qdi/dsdt and
http://www.arklinux.org/stuff/acpi/qdi/fadt

The same effect happens on a Chaintech 7AJA2 mainboard
(http://www.arklinux.org/stuff/acpi/chaintech/dsdt, 
http://www.arklinux.org/stuff/acpi/chaintech/fadt)

and a Dell SmartPC 250N notebook 
(http://www.arklinux.org/stuff/acpi/dell/dsdt, 
http://www.arklinux.org/stuff/acpi/dell/fadt).

Any ideas?

LLaP
bero



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
