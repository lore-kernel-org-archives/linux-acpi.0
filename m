From: Erich Stamberger <eberger-95T/CBm+SuISFZ3009zmMyO7C/xPubJB@public.gmane.org>
Subject: acpica-unix/iasl: shift/reduce conflicts
Date: Sat, 23 Aug 2003 03:14:09 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.53.0308230311120.19598@gewi.kfunigraz.ac.at>
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

Hello

In an attempt to track ACPI problems down I'm having with an
Asus PR-DLSW mainboard (see bugzilla bug #1127) I downloaded
acpica-unix-20030714 from Intel's web site and tried to compile
iasl. Due to shift/reduce conficts in the grammar it seems to
be impossible to get a (correct) working compiler. I tried
bison-1.875a and bison-1.35.

These rules are never reduced because of conflicts:

TermArg: Type2IntegerOpcode
TermArg: Type2StringOpcode
TermArg: Type2BufferOpcode
TermArg: Type2BufferOrStringOpcode
CaseTermList: CaseTerm
DefaultTermList: CaseTerm

Somebody out there who got that working?

Thanks a lot
Erich



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
