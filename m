From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: acpi 20020918 problems
Date: Fri, 18 Oct 2002 08:52:26 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19B865@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'Jan Rychter' <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

It would be interesting to look at the ASL code for the \_GPE._E18 method.

Please send your binary DSDT so we can disassemble it and take a look.

Thanks,
Bob Moore


-----Original Message-----
From: Jan Rychter [mailto:jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org] 
Sent: Friday, October 18, 2002 4:26 AM
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI] acpi 20020918 problems

Along with the problems with thermal management (which I have already
reported) I get the following:

 psparse-1155: *** Error: Method execution failed, AE_AML_MUTEX_NOT_ACQUIRED
Method pathname:  \_GPE._E18 (Node cfe7dce8)
 evevent-0797: *** Error: AE_AML_MUTEX_NOT_ACQUIRED while evaluated GPE18
method
acpi_power-0361 [20] acpi_power_transition : Error transitioning device
[FAN1] to D0
acpi_bus-0495 [19] acpi_bus_set_power    : Error transitioning device [FAN1]
to D0
acpi_thermal-0548 [18] acpi_thermal_active   : Unable to turn cooling device
[cfe7e648] 'on'
 psparse-1155: *** Error: Method execution failed, AE_AML_NOT_OWNER
Method pathname:  \_GPE._E18 (Node cfe7dce8)
 evevent-0797: *** Error: AE_AML_NOT_OWNER while evaluated GPE18 method
 psparse-1155: *** Error: Method execution failed, AE_AML_NOT_OWNER
Method pathname:  \_GPE._E18 (Node cfe7dce8)
 evevent-0797: *** Error: AE_AML_NOT_OWNER while evaluated GPE18 method
 psparse-1155: *** Error: Method execution failed, AE_AML_NOT_OWNER
Method pathname:  \_GPE._E18 (Node cfe7dce8)
 evevent-0797: *** Error: AE_AML_NOT_OWNER while evaluated GPE18 method
 psparse-1155: *** Error: Method execution failed, AE_AML_NOT_OWNER
Method pathname:  \_GPE._E18 (Node cfe7dce8)
 evevent-0797: *** Error: AE_AML_NOT_OWNER while evaluated GPE18 method
 psparse-1155: *** Error: Method execution failed, AE_AML_NOT_OWNER
Method pathname:  \_GPE._E18 (Node cfe7dce8)
 evevent-0797: *** Error: AE_AML_NOT_OWNER while evaluated GPE18 method
 psparse-1155: *** Error: Method execution failed, AE_AML_NOT_OWNER
Method pathname:  \_GPE._E18 (Node cfe7dce8)
 evevent-0797: *** Error: AE_AML_NOT_OWNER while evaluated GPE18 method
 psparse-1155: *** Error: Method execution failed, AE_AML_NOT_OWNER
Method pathname:  \_GPE._E18 (Node cfe7dce8)
 evevent-0797: *** Error: AE_AML_NOT_OWNER while evaluated GPE18 method
 psparse-1155: *** Error: Method execution failed, AE_AML_NOT_OWNER
Method pathname:  \_GPE._E18 (Node cfe7dce8)
 evevent-0797: *** Error: AE_AML_NOT_OWNER while evaluated GPE18 method
 psparse-1155: *** Error: Method execution failed, AE_AML_NOT_OWNER
Method pathname:  \_GPE._E18 (Node cfe7dce8)
 evevent-0797: *** Error: AE_AML_NOT_OWNER while evaluated GPE18 method
 psparse-1155: *** Error: Method execution failed, AE_AML_NOT_OWNER
Method pathname:  \_GPE._E18 (Node cfe7dce8)
 evevent-0797: *** Error: AE_AML_NOT_OWNER while evaluated GPE18 method
 psparse-1155: *** Error: Method execution failed, AE_AML_NOT_OWNER
Method pathname:  \_GPE._E18 (Node cfe7dce8)
 evevent-0797: *** Error: AE_AML_NOT_OWNER while evaluated GPE18 method
 psparse-1155: *** Error: Method execution failed, AE_AML_NOT_OWNER
Method pathname:  \_GPE._E18 (Node cfe7dce8)
 evevent-0797: *** Error: AE_AML_NOT_OWNER while evaluated GPE18 method

Perhaps this can point someone to the right direction.

DSDT as usually at http://jan.rychter.com/acpi/sharp.pc-mt1-h5.dsdt

--J.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
