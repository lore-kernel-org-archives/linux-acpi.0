From: Ian Pilcher <i.pilcher-Wuw85uim5zDR7s880joybQ@public.gmane.org>
Subject: Re: Plea for help
Date: Thu, 01 Jan 2004 10:54:21 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FF450BD.1010101@comcast.net>
References: <3ACA40606221794F80A5670F0AF15F8401720C66@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020903060905080900040003"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720C66-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------020903060905080900040003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Yu, Luming wrote:
> I'm not sure, but the most possibility is at acpi_ev_create_gpe_block.
> Normally, the next expected message  would be like:
> 
> evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode
> successful
> evgpeblk-0747 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at
> 0000009
> 
> I did find the desultory words showing that in ACPI-DEBUG dmesg.  Is it
> possible to dig into ?

The attached file is what appears on the local console (modulo possible
typos).  You can see that these messages do appear, mixed in with the
panic information.

> BTW, I want to know whether that panic could be found in UP kernel.

The panic does not occur with a uniprocessor kernel, nor does it happen
when I boot with 'maxcpus=1'.

And just for grins and giggles, I tried booting with 'idle=poll'.  Sure
enough, no panic.

Happy New Year!

-- 
========================================================================
Ian Pilcher                                        i.pilcher-Wuw85uim5zDR7s880joybQ@public.gmane.org
========================================================================

--------------020903060905080900040003
Content-Type: text/plain;
 name="acpi_debug-console.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi_debug-console.txt"

PCI: PCI BIOS revision 2.10 entry at 0xfb370, last bus=1
PCI: Using configuration type 1
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:.....................................................................
..................
Table [DSDT](id F004) - 295 Objects with 29 Devices 70 Methods 19 Regions
ACPI Namespace successfully loaded at root c039949c
IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9 Mode:1 Active:1)
Invalid operand: 0000
<4>evxfevnt-0093 [04] acpi_enable           : CPU:    1
EIP:    0010:[<dffe9fc2>]    Not tainted
<4>Transition to ACPI mode successful
EFLAGS: 00010202
evgpeblk-0747 eax: c0107290   ebx: 5d90f4fb   ecx: 00000000   edx: dffe8000
<4>[06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 0000000000004020 on int 9
esi: dffe8000   edi: dffe8000   ebp: dffe9fac   esp: dffe9fb0
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=dffe9000)
Stack: c0107352 00000002 00000000 00000000 dffe93f8 ffffffff 00000286 00000292
       fffff11d 00000001 00000286 00000000 c0389a2a 00000246 0000002a c0339f8c
       c011f8c3 0000000a 00000000 c02aefa7
Call Trace:    [<c0107352>] [<c011f8c3>]

Code: fe df ff ff ff ff 86 02 00 00 92 02 00 00 1d f1 ff ff 01 00
 <0>Kernel panic: Attempted to kill the idel task!
<4>Completing Region/Field/Buffer/Package initialization:In idle task - not syncing
--------------020903060905080900040003--



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
