From: stef <stef-listes-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>
Subject: Wrong button event reported when waking up from S1
Date: Sat, 05 Apr 2003 15:40:03 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E8EF8D3.6020502@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

        Hello,

        I have a problem with 2.4.21pre6+acpi 20030328, when I do
'echo -n 1 >/proc/acpi/sleep' and wake my laptop with the sleep
button, acpi gives a power button (PWRF) event instead of a sleep
button event (SBTN).

cat /proc/acpi/event
button/power PWRF 00000080 00000007
button/power PWRF 00000080 00000008
button/power PWRF 00000080 00000009
button/power PWRF 00000080 0000000a
button/power PWRF 00000080 0000000b
button/power PWRF 00000080 0000000c
button/power PWRF 00000080 0000000d
button/power PWRF 00000080 0000000e
button/power PWRF 00000080 0000000f
button/power PWRF 00000080 00000010
button/power PWRF 00000080 00000011
button/power PWRF 00000080 00000012
button/sleep SBTN 00000080 0000001a <- last button pressed before 
entering S1
button/power PWRF 00000080 00000013 <- event reported

from dmesg:

[ACPI Debug] String: __________________________________
[ACPI Debug] String:
[ACPI Debug] String: Sleep button be pressed: -----
[ACPI Debug] String: __________________________________
 hwsleep-0257 [75] acpi_enter_sleep_state: Entering sleep state [S1]
[ACPI Debug] String: Wake up
   evgpe-0396: *** Error: acpi_ev_gpe_dispatch: No handler or method for 
GPE[D1], disabling event
   evgpe-0396: *** Error: acpi_ev_gpe_dispatch: No handler or method for 
GPE[12], disabling event
   evgpe-0396: *** Error: acpi_ev_gpe_dispatch: No handler or method for 
GPE[13], disabling event
   evgpe-0396: *** Error: acpi_ev_gpe_dispatch: No handler or method for 
GPE[30], disabling event
   evgpe-0396: *** Error: acpi_ev_gpe_dispatch: No handler or method for 
GPE[11], disabling event

Regards,
    Stef



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
