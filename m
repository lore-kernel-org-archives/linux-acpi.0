From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 2/2] ACPI: Fix the issue that the DSDT local copy is conflict with the customized DSDT.
Date: Mon, 12 May 2014 02:29:08 +0200
Message-ID: <2008560.oS81rPtGJG@vostro.rjw.lan>
References: <cover.1396925060.git.lv.zheng@intel.com> <93e6bbbfb41fd514dc207b10b422fbc8afdfa432.1399624932.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59207 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751506AbaELAMX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 11 May 2014 20:12:23 -0400
In-Reply-To: <93e6bbbfb41fd514dc207b10b422fbc8afdfa432.1399624932.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Enrico Etxe Arte <goitizena.generoa@gmail.com>

On Friday, May 09, 2014 04:44:19 PM Lv Zheng wrote:
> This patch fixes the following issue:
> If DSDT is customized, no local DSDT copy is needed.
> 
> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=69711
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> Signed-off-by: Enrico Etxe Arte <goitizena.generoa@gmail.com>

This can go in without [1/2], right?

If so, do we need it in -stable?

> ---
>  drivers/acpi/bus.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 610261a..cfd2318 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -52,6 +52,12 @@ struct proc_dir_entry *acpi_root_dir;
>  EXPORT_SYMBOL(acpi_root_dir);
>  
>  #ifdef CONFIG_X86
> +#ifdef CONFIG_ACPI_CUSTOM_DSDT
> +static inline int set_copy_dsdt(const struct dmi_system_id *id)
> +{
> +	return 0;
> +}
> +#else
>  static int set_copy_dsdt(const struct dmi_system_id *id)
>  {
>  	printk(KERN_NOTICE "%s detected - "
> @@ -59,6 +65,7 @@ static int set_copy_dsdt(const struct dmi_system_id *id)
>  	acpi_gbl_copy_dsdt_locally = 1;
>  	return 0;
>  }
> +#endif
>  
>  static struct dmi_system_id dsdt_dmi_table[] __initdata = {
>  	/*
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
