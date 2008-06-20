From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH4/4] ACPI :  Add DMI check to disable mwait for CPU C-states
Date: Fri, 20 Jun 2008 02:37:44 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806200237070.22284@localhost.localdomain>
References: <1213685083.19901.17.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:39829 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192AbYFTGiV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 02:38:21 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2R007QT0RUDMO3@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 01:31:06 -0500 (CDT)
In-reply-to: <1213685083.19901.17.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org


Applied.
thanks,
-Len

On Tue, 17 Jun 2008, Zhao Yakui wrote:

> Subject:[ACPI]:Add DMI check to disable mwait for CPU C-states
> From: Zhao Yakui <yakui.zhao@intel.com>
> 
> Add the DMI check to disable mwait for CPU C-states.
> If the board is matched with DMI table, OSPM should not use mwait for CPU 
> C-states even when mwait is supported. In such case the C2C3_FFH access mode 
> will be disabled.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=10807
> 
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> Signed-off-by: Li Shaohua <shaohua.li@intel.com>
> 
> ---
>  drivers/acpi/processor_core.c |   22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> Index: linux-2.6/drivers/acpi/processor_core.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/processor_core.c
> +++ linux-2.6/drivers/acpi/processor_core.c
> @@ -121,6 +121,23 @@ static const struct file_operations acpi
>  
>  struct acpi_processor *processors[NR_CPUS];
>  struct acpi_processor_errata errata __read_mostly;
> +static int set_no_mwait(const struct dmi_system_id *id)
> +{
> +	printk(KERN_NOTICE PREFIX "%s detected - "
> +		"disable mwait for CPU C-stetes\n", id->ident);
> +	idle_nomwait = 1;
> +	return 0;
> +}
> +
> +static struct dmi_system_id __cpuinitdata processor_idle_dmi_table[] = {
> +	{
> +	set_no_mwait, "IFL91 board", {
> +	DMI_MATCH(DMI_BIOS_VENDOR, "COMPAL"),
> +	DMI_MATCH(DMI_SYS_VENDOR, "ZEPTO"),
> +	DMI_MATCH(DMI_PRODUCT_VERSION, "3215W"),
> +	DMI_MATCH(DMI_BOARD_NAME, "IFL91") }, NULL},
> +	{},
> +};
>  
>  /* --------------------------------------------------------------------------
>                                  Errata Handling
> @@ -1102,6 +1119,11 @@ static int __init acpi_processor_init(vo
>  		return -ENOMEM;
>  	acpi_processor_dir->owner = THIS_MODULE;
>  
> +	/*
> +	 * Check whether the system is DMI table. If yes, OSPM
> +	 * should not use mwait for CPU-states.
> +	 */
> +	dmi_check_system(processor_idle_dmi_table);
>  	result = cpuidle_register_driver(&acpi_idle_driver);
>  	if (result < 0)
>  		goto out_proc;
> 
> 
