From: "Darren Benham" <dbenham-FG1iuTdj8bisTnJN9+BGXg@public.gmane.org>
Subject: Thermal module errors
Date: Thu, 6 Feb 2003 23:29:05 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <32774.192.168.10.204.1044602945.squirrel@benham.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

I don't know if anyone's seen this but I haven't seen anything mentioned
(easily) in the list archives.  Here's the output from a kernel log when
trying to load the thermal module.  I've seen this with kernels 2.4.18,
2.4.20 , and 2.4.21pre4 (with the latest patch, which applied cleanly,
BTW).
Feb  6 23:04:37 ltdbenham kernel: dswstate-0251 [29]
ds_result_pop_from_bot: No result objects! State=c15d8828Feb  6 23:04:37 ltdbenham kernel:  dsutils-0494 [29] ds_create_operand    
: Missing or null operand, AE_AML_NO_RETURN_VALUEFeb  6 23:04:37 ltdbenham kernel:  dsutils-0587 [28] ds_create_operands   
: While creating Arg 1 - AE_AML_NO_RETURN_VALUEFeb  6 23:04:37 ltdbenham kernel:  psparse-1102: *** Error: Method
execution failed [\_TZ_.C1F1] (Node c15ede08), AE_AML_NO_RETURN_VALUEFeb  6 23:04:37 ltdbenham kernel:  psparse-1102: *** Error: Method
execution failed [\_TZ_.TZ1_._TMP] (Node c15ebce8), AE_AML_NO_RETURN_VALUE
Here's the .config ACPI section...

#
# ACPI Support
#
CONFIG_ACPI=y
# CONFIG_ACPI_HT_ONLY is not set
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_ACPI_DEBUG=y

compiled with gcc 2.95.4
and glibc 2.2.5

-- 
Darren




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
