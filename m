From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] fix building module (was [PATCH] disable SMM access to SpeedStep using ACPI-FADT pstate_cnt)
Date: Thu, 11 Mar 2004 14:36:20 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040311133620.GK28592@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Sorry to break threads, but I want to be sure that you get it.

On Sun, 2004-02-15 at 05:57, Dominik Brodowski wrote:
> Disable SMM access to SpeedStep
> 
> Often, the BIOS changes the CPU frequency if a notebook is (dis)connected
> from its AC adapter. This interferes with a) an user setting the CPU frequency
> and b) kernel timing code which needs to know loops_per_jiffy, cpu_khz etc.
> 

...

>  drivers/acpi/processor.c       |   61 +++++++++++++++++++++++++++++++++++++++++
>  drivers/acpi/tables/tbconvrt.c |    5 ++-
>  2 files changed, 64 insertions(+), 2 deletions(-)
> 
> diff -ruN linux-original/drivers/acpi/processor.c linux/drivers/acpi/processor.c
> --- linux-original/drivers/acpi/processor.c	2004-02-13 17:09:59.000000000 +0100
> +
> +	status = acpi_os_write_port (acpi_fadt.smi_cmd,
> +					(u32) acpi_fadt.pstate_cnt, 8);
> +	if (ACPI_FAILURE (status))

acpi_os_write_port is not EXPORTed.  So this patch break module compile
for the acpi processor.


 linux-2.6.4-bk-acpi/drivers/acpi/acpi_ksyms.c |    2 ++
 1 files changed, 2 insertions(+)

--- linux-2.6.4-bk-acpi/drivers/acpi/acpi_ksyms.c	2004/03/11 12:28:24	1.1
+++ linux-2.6.4-bk-acpi/drivers/acpi/acpi_ksyms.c	2004/03/11 12:30:37
@@ -100,6 +100,8 @@
 EXPORT_SYMBOL(acpi_os_printf);
 EXPORT_SYMBOL(acpi_os_sleep);
 EXPORT_SYMBOL(acpi_os_stall);
+EXPORT_SYMBOL(acpi_os_read_port);
+EXPORT_SYMBOL(acpi_os_write_port);
 EXPORT_SYMBOL(acpi_os_signal);
 EXPORT_SYMBOL(acpi_os_queue_for_execution);
 EXPORT_SYMBOL(acpi_os_signal_semaphore);


-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
