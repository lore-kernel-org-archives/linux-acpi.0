From: Franklin Marmon <marmon-a4VQZhDi8cxBDgjK7y7TUQ@public.gmane.org>
Subject: panic at acpi_ns_one_complete_parse
Date: Tue, 11 May 2004 14:19:17 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1084306757.5031.8.camel@laptop.hydeco.com>
Reply-To: marmon-a4VQZhDi8cxBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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


I've compiled a new DSDT table into my kernel (attached).  It compiles
fine using iasl at this point, no warnings or errors.  When I reboot
using this kernel I get a panic.  The top level of the call trace is 

	acpi_ns_one_complete_parse-xd0/0xee

I'm wondering how I go about debugging this?  Presumably there is
something wrong with my asm code, though the compiler isn't complaining
about it any longer.  It was at great length when I dumped and
disassembled /proc/acpi/dsdt.

Thank you,

frm

-- 
Franklin Marmon <marmon-a4VQZhDi8cxBDgjK7y7TUQ@public.gmane.org>
"To error is human, machines do as they are told.  Unless they don't
feel like it."



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
