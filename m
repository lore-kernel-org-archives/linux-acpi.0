From: Robert Vollmert <rvollmert-lists-hi6Y0CQ0nG0@public.gmane.org>
Subject: bug report: multi-byte access in indexfields broken
Date: Sun, 21 Sep 2003 22:05:25 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030921200525.GB2968@krikkit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hello,

it appears the problems I mailed about earlier are due to a bug in the
ACPI code. Reading from multi-byte fields in a ByteAccess-IndexField
seems to be broken.

When I replace

IndexField (EIND, EDAT, ByteAcc, NoLock, Preserve)
{
    Offset (0x10), 
    IKFG,   8, 
    FRPN,   16, 
    RAMB,   32,
    AVOL,   8, 
...
}

Method (CRMB, 0, NotSerialized)
{
    Return (RAMB)
}

with

IndexField (EIND, EDAT, ByteAcc, NoLock, Preserve)
{
    Offset (0x10), 
    IKFG,   8, 
    FRPN,   16, 
    RAM0,   8,
    RAM1,   8,
    RAM2,   8,
    RAM3,   8,
    AVOL,   8, 
...
}

Method (CRMB, 0, NotSerialized)
{
    Store (RAM3, Local0)
    ShiftLeft (Local0, 0x8, Local0)
    Add (RAM2, Local0, Local0)
    ShiftLeft (Local0, 0x8, Local0)
    Add (RAM1, Local0, Local0)
    ShiftLeft (Local0, 0x8, Local0)
    Add (RAM0, Local0, Local0)
    Return (Local0)
}

the first version of CRMB computes 0x64646464, while the second
version computes the correct 0x0F750064. The least byte seems to just
be copied to the other positions.

Cheers
Robert


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
