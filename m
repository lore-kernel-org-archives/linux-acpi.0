From: Matthew Harrell <mharrell-bmWjYudjZeGERhycZ4x6Ig@public.gmane.org>
Subject: Fixing the DSDT
Date: Wed, 02 Apr 2003 12:39:38 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030402173934.GA6686@bittwiddlers.com>
Reply-To: "Matthew Harrell,,,"
 <mharrell-dated-1049737232.fdb58f-bmWjYudjZeGERhycZ4x6Ig@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Resent-to: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Resent-message-id: <20030402174031.GA10112-bmWjYudjZeGERhycZ4x6Ig@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


In the standard DSDT entry for my HP zt1195 laptop I get the following messages
in my kernel logs when attempting to access info about my battery

dsmthdat-0475 [39] ds_method_data_get_val: Uninitialized Local[1] at node def12d20
 dswexec-0421 [35] ds_exec_end_op        : [Multiply]: Could not resolve operands, AE_AML_UNINITIALIZED_LOCAL
 psparse-1121: *** Error: Method execution failed [\_SB_.PCI0.PIB_.BAT0._BIF] (Node deeff748), AE_AML_UNINITIALIZED_LOCAL
acpi_battery-0144 [27] acpi_battery_get_info : Error evaluating _BIF
dsmthdat-0475 [39] ds_method_data_get_val: Uninitialized Local[1] at node def12d20
 dswexec-0421 [35] ds_exec_end_op        : [Multiply]: Could not resolve operands, AE_AML_UNINITIALIZED_LOCAL
 psparse-1121: *** Error: Method execution failed [\_SB_.PCI0.PIB_.BAT0._BIF] (Node deeff748), AE_AML_UNINITIALIZED_LOCAL
acpi_battery-0144 [27] acpi_battery_get_info : Error evaluating _BIF

First of all, which is the better way to grab it with
  cp /proc/acpi/dsdt dsdt ; iasl -d dsdt

or with 

  acpidump > dsdt.asl

When I try it the first way isal (20030228) gives me 86 errors.  When I try
it the second way it gives me 3 errors.  Why the difference?

Anyway, I repaired the three errors in the second one (two were easy) but I
still get the same kernel message when attempting to read the battery so 
obviously something else is broken.  Anyone have any pointers what I should
try now?

-- 
  Matthew Harrell                          Bill Gates is only a white Persian
  Bit Twiddlers, Inc.                       cat and a monocle away from being
  mharrell-bmWjYudjZeGERhycZ4x6Ig@public.gmane.org                 the villain in a James Bond movie.


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
