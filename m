From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: PCI Root Bridge
Date: Wed, 7 May 2003 17:11:45 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F842722E4@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
To: Szabolcs Barsony <Szabolcs.Barsony-pFqtzsCLIqPQT0dZR+AlfA@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Szabolcs,
According to ACPI spec 2.0a, Control Method Battery has Plug and Play ID =
 PNP0C0A.
I searched your ASL file for PNP0C0A, and found device C11D and C11E has =
such _HID.
So, I searched your Dmesg for C11D and C11E, and I found below message:

ACPI: Battery Slot [C11E] (battery absent).

Maybe Battery Slot C11E can work on your platform. Would you please have =
it a try.
Regarding battery slot C11D, there are no clue to do further =
investigation to me.
Would you please try to find out whether device C11E has successfully =
loaded into ACPI namespace?
I have noticed that there are two AE_NOT_EXIST and two AE_ALREADY_EXISTS =
messages, but it's for devices C03B.
I can't guess what happened during period between reporting AE_NOT_EXIST =
and initializing device C11D.

Thanks,
Luming

-----Original Message-----
From: Szabolcs Barsony [mailto:Szabolcs.Barsony-pFqtzsCLIqPQT0dZR+AlfA@public.gmane.org]
Sent: 2003?4?14? 20:34
To: Yu, Luming
Subject: RE: [ACPI] PCI Root Bridge


Hi,

I did only basic corrections.=20
1. After disassembling the BIOS DSDT table there were many symbols =
starting
with asterisk (*). I removed them from the name of the symbols.
2. During compilation I got many undefined symbols. I defined them as
extern.
3. I got few messages that not all methods return a value. I added =
Return
(0x00) to those methods.

That's all. I attach the original DSDT table and my fixed one in a zip =
file.

Thanks and regards,
Szabolcs


-----Original Message-----
From: Yu, Luming [mailto:luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]
Sent: Monday, 2003 April 14 12:14
To: Szabolcs Barsony
Cc: Grover, Andrew; Brown, Len
Subject: RE: [ACPI] PCI Root Bridge


I looked into your dmesg.  I noticed that:

First error is that pci_config for C03B has already installed.=20

Second error is that method execution was failed =
[\_SB_C03B.C04E.C0CF.COD3]
due to AE_NOT_EXIST.

Obviously, something is missing from this DSDT table.

I don't know if this dmesg is kernel having your fixed DSDT table. If =
yes,
are you missing something?

Would you please describe how did you fix the buggy DSDT table, and give =
me
dmesg of kernel with original DSDT table.

It will help me better understand your problem.

Thanks,
Luming



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
