From: Eric <spam-4Eq55P20sD9Wk0Htik3J/w@public.gmane.org>
Subject: ACPI on my compaq presario 2100
Date: 22 Jun 2003 18:05:19 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1056330318.464.42.camel@narcopia>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

OK, i've been trying for the past week to get ACPI to work on my compaq
presario 2100 notebook (i've looked all over the latop and can't find
any more exact model numbers).   Anyways, no matter what kernel/acpi
patch that i use, it always causes the kernel to hang on boot after it
loads configuration type 1, I've tried the 2.4.20 pre6 and rc3 patch
with the acpi 2.4.20/pre6 thru the 2.4.20rc3 patch.  I've also tried
kernel 2.4.21 with the default acpi modules, the acpi 2.4.21 patch, and
most the acpi 2.4.20 patches, and i've also tried the 2.4.22pre1 patch. 
None of it works.  I saw the recent post about disabling enhanced rtc,
but i've never had it enabled.  The only acpi drivers i try to enable
are the ACPI Support drivers and it errors out just the same as if i try
to compile every ACPI module.  The only time I've got it to boot with
the ACPI support driver is when i included the CPU Enumeration Only
driver, which i'm not too sure what that is, but it doesnt sound like it
works (didnt enable my Fn keys).  

One other thing is now that the acpi 2.4.21 patch came out the error is
a little different but it still hangs.  Instead of hanging on the PCI:
Using configuration type 1 line, or whatever it says, the screen just
jumps to the top of dmesg and hangs (something i've never seen happen
before on a kernel error).

Here are the last few lines that are output on boot before it hangs. 
(this is from the boots without the 2.4.21 acpi patch):
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20030619
PCI: PCI BIOS revision 2.10 entry at 0xfd87b, last bus=2
PCI: Using configuration type 1

then it hangs there.



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
