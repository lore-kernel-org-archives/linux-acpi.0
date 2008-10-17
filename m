From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: ACPI reboot
Date: Fri, 17 Oct 2008 09:13:56 +0800
Message-ID: <1224206036.3944.135.camel@yakui_zhao.sh.intel.com>
References: <alpine.LFD.1.10.0810161958460.3026@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:42525 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824AbYJQBIW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Oct 2008 21:08:22 -0400
In-Reply-To: <alpine.LFD.1.10.0810161958460.3026@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Thu, 2008-10-16 at 20:08 -0400, Len Brown wrote:
> Yakui,
> I think your patch below from
> http://bugzilla.kernel.org/show_bug.cgi?id=11481
> is close, but not quite right.
> 
> "reboot=a" should not be necessary, as reboot_type = BOOT_ACPI
> by default, yes?
the default reboot_type is BOOT_KBD. So it is necessary to add the boot
option of "reboot=a" to use the ACPI reboot mechanism.
> Re: DMI to ignore a missing (acpi_gbl_FADT.flags & 
> ACPI_FADT_RESET_REGISTER)....
> 
> If we need DMI,
> it should be checked at _boot_ time, not at _reboot_ 
> time, and the table should be marked _initdata.
Ok. I will refresh it. The DMI table will be put into _initdata
section. 
> 
> But the real question is if we should be checking this bit
> at all.  The fact that we are adding DMI to ignore it suggest
> that we should think about ignoring it by default, and instead
> perhaps sanity checking acpi_gbl_FADT.reset_register
> and basing our decision to use it on that?
According to the ACPI spec the bit indicates whether the ACPI reset
mechanism is supported. If it is zero, maybe OS should not use the ACPI
reset mechanism even when ACPI_RESET_REG is defined.

On some laptops the system can't be rebooted by using default
reboot_type(BOOT_KBD) after it is resumed from S3. If the ACPI reboot is
used, the system can be rebooted. But unfortunately the FADT flag bit
indicates that ACPI reboot mechanism is not supported.  This seems
contradictory.

In the patch the FADT flag bit is checked to comply with the ACPI spec.
But in order to use the ACPI reboot mechanism on some laptops, the DMI
check table is added in which the FADT flag bit is ignored. 

Of course what you said is also OK. When the system is expected to be
rebooted using the ACPI reboot mechanism, the FADT flag bit is ignored
and instead reset_register/reset_value is checked. If so, the DMI check
table is redundant.

I will refresh the patch based on your suggestion.
Thanks.
> 
> thanks,
> -Len
> -----------
> 
> Subject: ACPI: Add the DMI check table to support ACPI reboot
> From: Zhao Yakui <yakui.zhao@intel.com>
> 
> On some broken laptops the system can't be rebooted after it is resumed from
> S3. The system can be rebooted by writting RESET_VALUE to 
> RESET_REGISTER although the ACPI_FADT_RESET_REGISTER bit in the FADT flag 
> indicates that ACPI reboot mechanism is not supported.
> 
> Maybe it is appropriate that the acpi_reboot DMI checkt table is added so that
> the ACPI reboot is used forcibly on some broken laptops in case of adding
> the boot option of "reboot=a".
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=7299
> http://bugzilla.kernel.org/show_bug.cgi?id=11481
> 
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> ---
>  drivers/acpi/reboot.c |   25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/acpi/reboot.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/reboot.c
> +++ linux-2.6/drivers/acpi/reboot.c
> @@ -3,6 +3,22 @@
>  #include <linux/acpi.h>
>  #include <acpi/reboot.h>
>  
> +const static struct dmi_system_id reboot_dmi_table[] = {
> +	{
> +	NULL, "Asus M3N board", {
> +	DMI_MATCH(DMI_BIOS_VERSION, "0207"),
> +	DMI_MATCH(DMI_BIOS_DATE, "03/16/2004"),
> +	DMI_MATCH(DMI_PRODUCT_NAME, "M3N"),
> +	DMI_MATCH(DMI_BOARD_NAME, "M3N") }, NULL},
> +	{
> +	NULL, "Asus M6NE board", {
> +	DMI_MATCH(DMI_BIOS_VERSION, "0208"),
> +	DMI_MATCH(DMI_BIOS_DATE, "03/28/2005"),
> +	DMI_MATCH(DMI_PRODUCT_NAME, "M6Ne"),
> +	DMI_MATCH(DMI_BOARD_NAME, "M6Ne") }, NULL},
> +	{},
> +};
> +
>  void acpi_reboot(void)
>  {
>  	struct acpi_generic_address *rr;
> @@ -16,7 +32,14 @@ void acpi_reboot(void)
>  	rr = &acpi_gbl_FADT.reset_register;
>  
>  	/* Is the reset register supported? */
> -	if (!(acpi_gbl_FADT.flags & ACPI_FADT_RESET_REGISTER) ||
> +	if (dmi_check_system(reboot_dmi_table)) {
> +		/*
> +		 * If the laptop falls into the DMI check table, the
> +		 * ACPI reboot mechanism will be used forcibly regardless of
> +		 * the ACPI_FADT_RESET_REGISTER bit flag.
> +		 */
> +		printk(KERN_DEBUG "ACPI reboot mechanism will be used\n");
> +	} else if (!(acpi_gbl_FADT.flags & ACPI_FADT_RESET_REGISTER) ||
>  	    rr->bit_width != 8 || rr->bit_offset != 0)
>  		return;
>  

