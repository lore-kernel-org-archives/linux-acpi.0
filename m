From: "Rus V. Brushkoff" <rus-YPKzlcOx6JWP+XVi2HspGA@public.gmane.org>
Subject: False thermall shutdown (seems like 2.6 ACPI bug)
Date: Tue, 27 Apr 2004 16:28:32 +0300 (EEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.53.0404271615250.5536@Soyuz-KT.TeNet.Odessa.UA>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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


	Hi.

 I'm trying to boot 2.6.5 at ASUS L3H laptop but got shutdown just after
starting init, this is part of the dmesg :

..........

exoparg2-0432 [50] ex_opcode_2A_1T_1R    : Index value (FFFFFFFF) beyond
package end (7)
 psparse-1133: *** Error: Method execution failed [\_TZ_.RSCM] (Node
c17ad1a8),
AE_AML_PACKAGE_LIMIT
 psparse-1133: *** Error: Method execution failed [\_TZ_.TZ__._SCP] (Node
c17af128), AE_AML_PACKAGE_LIMIT
acpi_thermal-0464 [42] acpi_thermal_critical : Critical trip point
Critical temperature reached (255 C), shutting down.
ACPI: Thermal Zone [TZ] (255 C)
Asus Laptop ACPI Extras version 0.27
  L3H model detected, supported
..........


 The 2.4.X working ok on this machine. If somebody interested I can send
any debug info or test new patches/ideas.

TIA

		Rus


-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
