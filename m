From: "   " <volley_ball-Mmb7MZpHnFY@public.gmane.org>
Subject: Medion MD 6200 notebook + SuSE Linux 9.0 + ACPI
Date: Mon, 29 Dec 2003 00:23:30 +0100 (MET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <23564.1072653810@www4.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

right now I am using SuSE Linux 9.0 professional (Kernel 2.4.21-144 with new
ACPI code, original SuSE (pre-compiled Kernel).
When I try to boot my notebook with activated acpi support, my PC hangs with
the following messages:

ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 5  (2x)
PCI: Using ACPI for IRQ Routing

Unable to handle kernel paging request at virtual address ffff0906
  printing eip:
c0121cfa
*pde = 00004063
Oops: 0000 2.4.21-144-default #1 Fri Nov 14 00:01:36 UTC 2003
CPU: 0
EIP: 0010:[<c0121cfa>]  Not tainted
EFLAGS: 00010282
eax: ffff0902   ebx: c02de11c  ecx: d1ffffff   edx: d10000000
esi: cdffbd3c  edi: c0005014   ebp: cdffa4e0  esp: c1609f78
ds: 0018  es: 0018  ss:0018
Process swapper (pid: 1, stackpage=c1609000)
Stack: cdffbd3c  00000008  c0121d6f  c02de11c  cdffbd3c  c032bc74  
c02de11c 
cdffbd3c  c0297580 00000000  00000000  cdffa460  c032bc4b  
cdffa46c  c0297580
00000000  c0105000  0008e000  c032beba  c02f48c0  c032c024  
c020aa76  c0297580
Call Trace: [<c0121d6f>] (56)  [<c0105000>] (20)  [<c020aa76>] (12)
[<c0105030>] (12)  [<c0105000>] (08)  [<c0107333>] (08)  
[<c0105020>] (04)
Code: 39 48 04 77 0c 8d 78 14 39 50 08 72 ed 5b 5e 5f c3 89 46 14
  <0>Kernel panic: Attempted to kill init!

The only way to boot Linux is to boot with acpi=off or acpi=oldboot, but
then I won't be able to view my battery status etc.
Does anyone know a solution to this problem?

Thanks for your help

Bastian

-- 
+++ GMX - die erste Adresse für Mail, Message, More +++
Neu: Preissenkung für MMS und FreeMMS! http://www.gmx.net




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
