From: "Alfredo Garcia Martino" <alfredogarcia-hi6Y0CQ0nG0@public.gmane.org>
Subject: Issues reading battery status
Date: Mon, 06 Sep 2004 17:50:33 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <opsdwwyjugae6s7i@mail.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

	I have been suffering a pair of problems with ACPI reading the battery  
status on my laptop. The two issues are:

	1: This error occurs every time you do acpi -V
--------------------------------------------------------------------------------------
Sep  6 15:00:28 localhost kernel: [ACPI Debug] String: Length 0x1E,  
"====BAT0 _BST UPBS() entry===="
Sep  6 15:00:28 localhost kernel: exconvrt-0664: *** Error: Bad  
destination type during conversion: 4
Sep  6 15:00:28 localhost kernel:  psparse-1133: *** Error: Method  
execution failed [\_SB_.BAT0.GBFE] (Node c11e5d68), AE_AML_INTERNAL
Sep  6 15:00:28 localhost kernel:  psparse-1133: *** Error: Method  
execution failed [\_SB_.BAT0.UPBS] (Node c11e58e8), AE_AML_INTERNAL
Sep  6 15:00:28 localhost kernel:  psparse-1133: *** Error: Method  
execution failed [\_SB_.BAT0._BST] (Node c11e4348), AE_AML_INTERNAL
Sep  6 15:00:28 localhost kernel: acpi_battery-0207 [31]  
acpi_battery_get_statu: Error evaluating _BST
Sep  6 15:00:28 localhost kernel: [ACPI Debug] String: Length 0x1B,  
"====BAT0 _BIF End Error===="
--------------------------------------------------------------------------------------

	2: This occurs from time to time let's say that if we repeat "acpi -V"  
every 2 seconds this error appears every 40 seconds
--------------------------------------------------------------------------------------
Sep  6 15:00:16 localhost kernel: [ACPI Debug] String: Length 0x1E,  
"====BAT0 _BST UPBS() entry===="
Sep  6 15:00:16 localhost kernel: [ACPI Debug] String: Length 0x1B,  
"====BAT0 _BST End Error===="
Sep  6 15:00:16 localhost kernel: evregion-0347: *** Error: Handler for  
[EmbeddedControl] returned AE_TIME
Sep  6 15:00:16 localhost kernel:  dswexec-0435 [38] ds_exec_end_op         
: [Store]: Could not resolve operands, AE_TIME
Sep  6 15:00:16 localhost kernel:  psparse-1133: *** Error: Method  
execution failed [\_SB_.PCI0.LPC0.EC0_.SBR_] (Node c11e1b28), AE_TIME
Sep  6 15:00:16 localhost kernel:  psparse-1133: *** Error: Method  
execution failed [\_SB_.BAT0.UPBI] (Node c11e59a8), AE_TIME
Sep  6 15:00:16 localhost kernel:  psparse-1133: *** Error: Method  
execution failed [\_SB_.BAT0._BIF] (Node c11e4408), AE_TIME
Sep  6 15:00:16 localhost kernel: acpi_battery-0146 [30]  
acpi_battery_get_info : Error evaluating _BIF
--------------------------------------------------------------------------------------

	I have followed problem 1 and I have resolved it applying next diff to  
file /usr/src/linux/drivers/acpi/executer/exconvrt.c :
--------------------------------------------------------------------------------------
--- exconvrt.c 2004-08-25 03:08:16.000000000 +0200
+++ exconvrt.c.patched 2004-09-06 16:29:43.000000000 +0200
@@ -631,6 +631,7 @@
    case ACPI_TYPE_BUFFER_FIELD:
    case ACPI_TYPE_LOCAL_BANK_FIELD:
    case ACPI_TYPE_LOCAL_INDEX_FIELD:
+  case ACPI_TYPE_PACKAGE:
     /*
      * These types require an Integer operand.  We can convert
      * a Buffer or a String to an Integer if necessary.
------------------------------------------------------------------------------------

	And now the first error doesn't occurs, but I still have the second one.
	Also my patch just uses the function "acpi_ex_convert_to_integer" with an  
ACPI_TYPE_PACKAGE and that works, but I wonder if this is the best  
approach to the problem.

	Any idea about how to resolve problem 2 or improve the solution to  
problem 1?

	Regards and thanks in advance.
	
	P.S.: DSDT is correct except by the typical WAK warning, but I have tried  
it with a corrected DSDT and there was no change.


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
