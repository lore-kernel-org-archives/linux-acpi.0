From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: [PM][ACPI] No ACPI interrupts after resume from S1
Date: Sun, 26 Oct 2003 22:41:11 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20031026214111.GA24485@hell.org.pl>
References: <3ACA40606221794F80A5670F0AF15F8401720B63@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720B63-4yWAQGcml64gGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, M?ns Rullg?rd <mru-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Yu, Luming:
> Would you please try patch at http://bugme.osdl.org/show_bug.cgi?id=1409

Hi,
The patch makes my kernel oops on resume:
hdc: completing PM  request, resume
  hwregs-0760 [56] hw_low_level_read     : Unsupported address space: 90
  hwregs-0760 [56] hw_low_level_read     : Unsupported address space: A0
  hwregs-0760 [56] hw_low_level_read     : Unsupported address space: 24
  hwregs-0760 [56] hw_low_level_read     : Unsupported address space: C8
  hwregs-0760 [56] hw_low_level_read     : Unsupported address space: E0
  hwregs-0760 [56] hw_low_level_read     : Unsupported address space: F0
  hwregs-0760 [56] hw_low_level_read     : Unsupported address space:  4
Unable to handle kernel paging request at virtual address 70677679
 printing eip:
c020c44c
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c020c44c>]   Not tainted
EFLAGS: 00010206
EIP is at acpi_hw_lowlevel_read+0x30/0x122
eax: c02e6344   ebx: cffd6408   ecx: cfc51e88   edx: 00000010
esi: 70677671   edi: cfc51e90   ebp: 00000008   esp: cfc51e58
ds: 007b   es: 007b   ss: 0068
Process bash (pid: 304, threadinfo=cfc50000 task=c1368a0)
Stack: 00000130 c021c9b8 00000002 c02e6499 c02e6344 c02f6720 cffd6408 cfe3b228
       000001e0 00000001 c020b6b2 00000008 cfc51e90 70677671 c0311650 00000018
       c020b9c2 cffd6408 00000010 00000000 00000000 cfc51ebc c02da521 00000001
Call Trace:
 acpi_ut_acquire_mutex+0xc0/0x16b
 acpi_hw_enable_gpe+0x1e/0x44
 acpi_hw_enable_ec_gpes+0x7f0x85
 acpi_leave_sleep_state+0x119/0x13e
 dpm_resume+0x34/0x5a
 acpi_pm_finish+0xb/0x38
 [...]

Code: 8b 56 08 8b 46 04 89 d1 09 c1 75 0a 31 c0 83 c4 18 5b 5c 5f
[hand typed, but at least the traces should be OK]

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org
