From: Stefan Behnel <behnel_ml-8NdywcgfOMlWMvVl7B+zuCEWGD4kr0XT@public.gmane.org>
Subject: ACPI-Errors with battery, ac_adapter, thermal
Date: Tue, 21 Jan 2003 19:16:52 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E2D8E94.2050301@gkec.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Hi!

*I only subscribed to the list yesterday, so I don't know if this mail
(that I sent before subscribing) actually got there. Sorry if it did.*


I have a problem with my laptop (Samsung P10, P4, i845). I use the
lates ACPI-Patches and kernel 2.4.20/2.4.21-pre3.

In /proc/acpi, the directories ac_adapter, battery and thermal_zone
are empty (so I can't find out about the battery state, etc.) and
dmesg shows related errors:

----------------------------------------------------

evregion-0235 [22] ev_address_space_dispa: no handler for
region(c12f4c28) [embedded_control]

     exfldio-0216 [21] ex_access_region      : Region embedded_control(3)
has no handler

     dswexec-0402 [14] ds_exec_end_op        : [LEqual]: Could not
resolve operands, AE_NOT_EXIST

dswstate-0251 [16] ds_result_pop_from_bot: No result objects!
State=cff67828

     dsutils-0494 [16] ds_create_operand     : Missing or null operand,
AE_AML_NO_RETURN_VALUE

     psparse-1102: *** Error: Method execution failed [\_SB_.ADP1._STA]
(Node c12f8228), AE_AML_NO_RETURN_VALUE


evregion-0235 [22] ev_address_space_dispa: no handler for
region(c12f4c28) [embedded_control]

     exfldio-0216 [21] ex_access_region      : Region embedded_control(3)
has no handler

     dswexec-0402 [14] ds_exec_end_op        : [LEqual]: Could not
resolve operands, AE_NOT_EXIST

dswstate-0251 [16] ds_result_pop_from_bot: No result objects!
State=cff67828

     dsutils-0494 [16] ds_create_operand     : Missing or null operand,
AE_AML_NO_RETURN_VALUE

     psparse-1102: *** Error: Method execution failed [\_SB_.BAT1._STA]
(Node c12f8c28), AE_AML_NO_RETURN_VALUE


evregion-0322: *** Error: Handler for [embedded_control] returned
AE_BAD_PARAMETER

     dswexec-0402 [20] ds_exec_end_op        : [Store]: Could not resolve
operands, AE_BAD_PARAMETER

     psparse-1102: *** Error: Method execution failed [\_TZ_.THRM._TMP]
(Node c12fa128), AE_BAD_PARAMETER

----------------------------------------------------


I do actually get the ACPI interrupts, /proc/interrupts increments
when I pull out the AC plug or while the battery discharges. While on
battery, the syslog fills up with

-----------------------
kernel:     ACPI-0322: *** Error: Handler for [embedded_control]
returned AE_BAD_PARAMETER
kernel:     ACPI-1102: *** Error: Method execution failed
[\_SB_.BAT1.BAST] (Node c12fb680), AE_BAD_PARAMETER
kernel:     ACPI-1102: *** Error: Method execution failed
[\_SB_.PCI0.LPCB.H_EC._Q66] (Node c12f49c0), AE_BAD_PARAMETER
-----------------------


Any hints how I could get that stuff running ?


Oh, and, BTW: Running the kernel (tried with 2.4.21-pre3) with
ACPI-debug compiled in tends to throw Oopses that kill the keyboard
(nothing else) when an event occurs...


Thanks in advance for any help,
Stefan Behnel






-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
