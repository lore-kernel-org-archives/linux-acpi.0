From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI patch 2002-01-23
Date: Fri, 24 Jan 2003 20:00:32 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030124190032.GB18109@poup.poupinou.org>
References: <200301240949.16462.m.c.p@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="WChQLJJJfbwij+9x"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200301240949.16462.m.c.p-hi6Y0CQ0nG0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Marc-Christian Petersen <m.c.p-hi6Y0CQ0nG0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--WChQLJJJfbwij+9x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 24, 2003 at 09:49:16AM +0100, Marc-Christian Petersen wrote:
> Hi all,
> 
> how should this ever compile? :)
> 
> acpi_ksyms.c:86: `acpi_enter_sleep_state_s4bios' undeclared here (not in a 
> function)
> acpi_ksyms.c:86: initializer element is not constant
> acpi_ksyms.c:86: (near initialization for 
> `__ksymtab_acpi_enter_sleep_state_s4bios.value')
> make[3]: *** [acpi_ksyms.o] Error 1
> 
> 
> root@codeman:[/usr/src/ACPI] # grep "sleep_state_s4bios" *
> acpi-20030123-2.4.21-pre3.diff:+                
> acpi_enter_sleep_state_s4bios();
> acpi-20030123-2.4.21-pre3.diff:+EXPORT_SYMBOL(acpi_enter_sleep_state_s4bios);
> 

Consider this patch, courtesy of Sergio Visinoni, and cleaned

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.

--WChQLJJJfbwij+9x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="00_s4bios-2.4.21-pre3-acpi-20030123.diff"

 drivers/acpi/hardware/hwsleep.c |   46 ++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpixf.h           |    4 +++
 2 files changed, 50 insertions(+)


--- linux-2.4.21-pre3-acpi-20030122/drivers/acpi/hardware/hwsleep.c	2003/01/24 16:46:36	1.1
+++ linux-2.4.21-pre3-acpi-20030122/drivers/acpi/hardware/hwsleep.c	2003/01/24 16:51:21
@@ -316,6 +316,52 @@
 	return_ACPI_STATUS (AE_OK);
 }
 
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_enter_sleep_state_s4bios
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Perform a s4 bios request.
+ *              THIS FUNCTION MUST BE CALLED WITH INTERRUPTS DISABLED
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_enter_sleep_state_s4bios (
+	void)
+{
+	u32                     in_value;
+	acpi_status             status;
+
+
+	ACPI_FUNCTION_TRACE ("Acpi_enter_sleep_state_s4bios");
+
+
+	acpi_set_register (ACPI_BITREG_WAKE_STATUS, 1, ACPI_MTX_LOCK);
+	acpi_hw_clear_acpi_status();
+
+	acpi_hw_disable_non_wakeup_gpes();
+
+	ACPI_FLUSH_CPU_CACHE();
+
+	status = acpi_os_write_port (acpi_gbl_FADT->smi_cmd, (acpi_integer) acpi_gbl_FADT->S4bios_req, 8);
+
+	do {
+		acpi_os_stall(1000);
+		status = acpi_get_register (ACPI_BITREG_WAKE_STATUS, &in_value, ACPI_MTX_LOCK);
+		if (ACPI_FAILURE (status)) {
+			return_ACPI_STATUS (status);
+		}
+	} while (!in_value);
+
+	return_ACPI_STATUS (AE_OK);
+}
+
+
 /******************************************************************************
  *
  * FUNCTION:    acpi_leave_sleep_state
--- linux-2.4.21-pre3-acpi-20030122/include/acpi/acpixf.h	2003/01/24 16:48:09	1.1
+++ linux-2.4.21-pre3-acpi-20030122/include/acpi/acpixf.h	2003/01/24 16:51:21
@@ -380,6 +380,10 @@
 	u8                              sleep_state);
 
 acpi_status
+acpi_enter_sleep_state_s4bios (
+	void);
+
+acpi_status
 acpi_leave_sleep_state (
 	u8                              sleep_state);
 

--WChQLJJJfbwij+9x--


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
