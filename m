From: Robert Vollmert <rvollmert-lists-hi6Y0CQ0nG0@public.gmane.org>
Subject: [ACPI-sppt] summary of ASUS M2N strangeness
Date: Sun, 21 Sep 2003 19:51:01 +0200
Sender: acpi-support-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030921175101.GA2968@krikkit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-support-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-support-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-support-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-support>,
	<mailto:acpi-support-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-support>,
	<mailto:acpi-support-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-support>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: acpi-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

here's a summary of what's been found out about the ASUS M2N and
related models. I'm posting here hoping that the experts have some
advice. Sorry for posting to both lists, but I thought there might be
people only on -support that are interested.

There's two somewhat different cases: (1) when the computer has been
off for a while (>5min) after having used Windows, and (2) when not.

Some relevant excerpts from the original DSDT are:

OperationRegion (BIOS, SystemMemory, 0x1F750064, 0xFF)
Field (BIOS, ByteAcc, NoLock, Preserve)
{
    SS1,    1,
    SS2,    1,
...
}

OperationRegion (\ECMS, SystemIO, 0x72, 0x02)
Field (\ECMS, ByteAcc, Lock, Preserve)
{
    EIND,   8,
    EDAT,   8
}

IndexField (EIND, EDAT, ByteAcc, NoLock, Preserve)
{
    Offset (0x10),
    IKFG,   8,
    FRPN,   16,
    RAMB,   32,
...
}

OperationRegion (\RAMW, SystemMemory, RAMB, 0xFF)
Field (\RAMW, ByteAcc, NoLock, Preserve)
{
    Offset (0xB0),
...
    TSAD,   8,
...
} 
 
In cases (1) and (2), the DSDTs are identical, except for the above
first line, where in case (2), 0x1F750064 is replaced by 0x0F750064.

In case (1), the computer boots successfully, but ACPI only works
partially due to RAMB having been evaluated to 0x64646464, while the
correct value (as read via 0x72 after booting and verified by a
correct value for TSAD) is 0x0F750064.

In case (2), the computer hangs during ACPI initialization (executing
all _STA and _INI).

I haven't verified what RAMB evaluates to in case (2). However,
hardcoding the correct value doesn't make a difference, so I assume
it's correct.

I don't need help debugging the hanging in case two yet. What I was
wondering is whether it's common for the BIOS to provide different
DSDTs in different circumstances, i.e. that the 0x1F750064 is there on
purpose, or is this likely to be a bug? 

Secondly, in case it is indeed a bug, is it likely that the fact that
RAMB evaluates to 0x64646464 is caused by this, or is this a separate
issue?

Thanks for any input.

Cheers
Robert


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
