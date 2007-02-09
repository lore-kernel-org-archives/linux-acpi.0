From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/2] ACPI: ibm-acpi: cleanup init and exit paths
Date: Fri, 9 Feb 2007 15:40:00 -0500
Message-ID: <200702091540.00980.lenb@kernel.org>
References: <11707964241851-git-send-email-hmh@hmh.eng.br> <11707964243869-git-send-email-hmh@hmh.eng.br> <11707964241860-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33153 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992835AbXBIUvR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Feb 2007 15:51:17 -0500
In-Reply-To: <11707964241860-git-send-email-hmh@hmh.eng.br>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

Applied.

thanks,
-Len

On Tuesday 06 February 2007 16:13, Henrique de Moraes Holschuh wrote:
> This patch fixes a small memory leak on module removal, and does other
> assorted minor cleanups on the module init codepath.
> 
> Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> ---
>  drivers/acpi/ibm_acpi.c |   13 ++++++++-----
>  1 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
> index 5c0f1b8..20cbde5 100644
> --- a/drivers/acpi/ibm_acpi.c
> +++ b/drivers/acpi/ibm_acpi.c
> @@ -497,6 +497,10 @@ static int ibm_acpi_driver_init(void)
>  	printk(IBM_INFO "%s v%s\n", IBM_DESC, IBM_VERSION);
>  	printk(IBM_INFO "%s\n", IBM_URL);
>  
> +	if (ibm_thinkpad_ec_found)
> +		printk(IBM_INFO "ThinkPad EC firmware %s\n",
> +		       ibm_thinkpad_ec_found);
> +
>  	return 0;
>  }
>  
> @@ -2618,7 +2622,7 @@ static void __init ibm_handle_init(char *name,
>  	ibm_handle_init(#object, &object##_handle, *object##_parent,	\
>  		object##_paths, ARRAY_SIZE(object##_paths), &object##_path)
>  
> -static int set_ibm_param(const char *val, struct kernel_param *kp)
> +static int __init set_ibm_param(const char *val, struct kernel_param *kp)
>  {
>  	unsigned int i;
>  
> @@ -2660,7 +2664,8 @@ static void acpi_ibm_exit(void)
>  	for (i = ARRAY_SIZE(ibms) - 1; i >= 0; i--)
>  		ibm_exit(&ibms[i]);
>  
> -	remove_proc_entry(IBM_DIR, acpi_root_dir);
> +	if (proc_dir)
> +		remove_proc_entry(IBM_DIR, acpi_root_dir);
>  
>  	if (ibm_thinkpad_ec_found)
>  		kfree(ibm_thinkpad_ec_found);
> @@ -2711,9 +2716,6 @@ static int __init acpi_ibm_init(void)
>  
>  	/* Models with newer firmware report the EC in DMI */
>  	ibm_thinkpad_ec_found = check_dmi_for_ec();
> -	if (ibm_thinkpad_ec_found)
> -		printk(IBM_INFO "ThinkPad EC firmware %s\n",
> -		       ibm_thinkpad_ec_found);
>  
>  	/* these handles are not required */
>  	IBM_HANDLE_INIT(vid);
> @@ -2743,6 +2745,7 @@ static int __init acpi_ibm_init(void)
>  	proc_dir = proc_mkdir(IBM_DIR, acpi_root_dir);
>  	if (!proc_dir) {
>  		printk(IBM_ERR "unable to create proc dir %s", IBM_DIR);
> +		acpi_ibm_exit();
>  		return -ENODEV;
>  	}
>  	proc_dir->owner = THIS_MODULE;
