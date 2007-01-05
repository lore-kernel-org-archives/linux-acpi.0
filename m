From: Thomas Renninger <trenn@suse.de>
Subject: Re: [patch 03/13] acpi/processor: prevent loading module on
	failures
Date: Fri, 05 Jan 2007 02:48:44 +0100
Message-ID: <1167961724.17171.46.camel@d36.suse.de>
References: <200612042250.kB4Mommx007358@shell0.pdx.osdl.net>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:57664 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161083AbXAEMsN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 5 Jan 2007 07:48:13 -0500
In-Reply-To: <200612042250.kB4Mommx007358@shell0.pdx.osdl.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, akinobu.mita@gmail.com, len.brown@intel.com

On Mon, 2006-12-04 at 14:49 -0800, akpm@osdl.org wrote:
> From: Akinobu Mita <akinobu.mita@gmail.com>
> 
> Make loading processor.ko fail when an error happens.
> 
> Cc: Len Brown <len.brown@intel.com>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/acpi/processor_core.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff -puN drivers/acpi/processor_core.c~acpi-processor-prevent-loading-module-on-failures drivers/acpi/processor_core.c
> --- a/drivers/acpi/processor_core.c~acpi-processor-prevent-loading-module-on-failures
> +++ a/drivers/acpi/processor_core.c
> @@ -901,13 +901,13 @@ static int __init acpi_processor_init(vo
>  
>  	acpi_processor_dir = proc_mkdir(ACPI_PROCESSOR_CLASS, acpi_root_dir);
>  	if (!acpi_processor_dir)
> -		return 0;
> +		return -ENOMEM;
>  	acpi_processor_dir->owner = THIS_MODULE;
>  
>  	result = acpi_bus_register_driver(&acpi_processor_driver);
>  	if (result < 0) {
>  		remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
> -		return 0;
> +		return result;
The second one is wrong. I already sent a similar patch, but processor
module must also load if acpi_bus_register_driver fails (in
acpi_disabled case), because processor module provides necessary things
for cpufreq which must also be available in non-acpi mode.
Discussion on this list can be reviewed here:
http://marc.theaimsgroup.com/?t=114561626300002&r=1&w=2

Outcome was this patch, it's in SUSE kernels for quite a while, I sent
it twice, but it was never committed.
Sorry for slightly wrong indentation (I can correct this and header if
someone tells me that this one will finally be picked up), the reference
tag shall point to:
https://bugzilla.novell.com/show_bug.cgi?id=165803

     Thomas

From: Thomas Renninger <trenn@suse.de>
Subject: Exit ACPI processor module gracefully if acpi is disabled
Patch-mainline: not yet
References: 165803

 drivers/acpi/processor_core.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

Signed-off-by: Thomas Renninger <trenn@suse.de>

Index: linux-2.6.16/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.16.orig/drivers/acpi/processor_core.c
+++ linux-2.6.16/drivers/acpi/processor_core.c
@@ -906,6 +906,8 @@ void acpi_processor_uninstall_hotplug_no
  * ACPI, but needs symbols from this driver
  */
 
+static int processor_driver_registered = 0;
+
 static int __init acpi_processor_init(void)
 {
 	int result = 0;
@@ -926,6 +928,8 @@ static int __init acpi_processor_init(vo
 		return_VALUE(0);
 	}
 
+	processor_driver_registered = 1;
+
 	acpi_processor_install_hotplug_notify();
 
 	acpi_thermal_cpufreq_init();
@@ -943,12 +947,13 @@ static void __exit acpi_processor_exit(v
 
 	acpi_thermal_cpufreq_exit();
 
+	if (processor_driver_registered){
 	acpi_processor_uninstall_hotplug_notify();
 
 	acpi_bus_unregister_driver(&acpi_processor_driver);
 
 	remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
-
+	}
 	return_VOID;
 }
 


