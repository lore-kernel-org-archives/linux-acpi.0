From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] ACPI: Fix the issue that the DSDT local copy is conflict with the customized DSDT.
Date: Mon, 21 Apr 2014 23:16:26 +0200
Message-ID: <3086547.jQZkA0Qj7E@vostro.rjw.lan>
References: <cover.1396925060.git.lv.zheng@intel.com> <ca34942a48b4d7414b9524c7df84fe110b07c4f8.1396925060.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50367 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754697AbaDUVAH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Apr 2014 17:00:07 -0400
In-Reply-To: <ca34942a48b4d7414b9524c7df84fe110b07c4f8.1396925060.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Enrico Etxe Arte <goitizena.generoa@gmail.com>

On Tuesday, April 08, 2014 10:49:12 AM Lv Zheng wrote:
> This patch fixes the following issue:
> If DSDT is customized, no local DSDT copy is needed.
> 
> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=69711
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> Signed-off-by: Enrico Etxe Arte <goitizena.generoa@gmail.com>
> ---
>  drivers/acpi/bus.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index e7e5844..c113e82 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -52,13 +52,20 @@ struct proc_dir_entry *acpi_root_dir;
>  EXPORT_SYMBOL(acpi_root_dir);
>  
>  #ifdef CONFIG_X86
> +#ifndef CONFIG_ACPI_CUSTOM_DSDT

Can you please use #ifdef instead of #ifndef?

So do

#ifdef CONFIG_ACPI_CUSTOM_DSDT
static inline int set_copy_dsdt(const struct dmi_system_id *id) { return 0; }
#else

etc.

>  static int set_copy_dsdt(const struct dmi_system_id *id)
>  {
> -	printk(KERN_NOTICE "%s detected - "
> +	pr_info("ACPI: %s detected - "

And how is this change related to the rest of the patch?

>  		"force copy of DSDT to local memory\n", id->ident);
>  	acpi_gbl_copy_dsdt_locally = 1;
>  	return 0;
>  }
> +#else
> +static inline int set_copy_dsdt(const struct dmi_system_id *id)
> +{
> +	return 0;
> +}
> +#endif
>  
>  static struct dmi_system_id dsdt_dmi_table[] __initdata = {
>  	/*
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
