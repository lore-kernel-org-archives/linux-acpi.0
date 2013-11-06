From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [patch 2/2] ACPI, extlog: remove unneeded NULL check
Date: Wed, 06 Nov 2013 23:06:26 +0100
Message-ID: <4572462.cKQzNDzG5Z@vostro.rjw.lan>
References: <20131105202007.GB3949@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20131105202007.GB3949@elgon.mountain>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Len Brown <lenb@kernel.org>, Chen@elgon.mountain, Gong <gong.chen@linux.intel.com>, linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday, November 05, 2013 11:20:07 PM Dan Carpenter wrote:
> We dereference extlog_l1_addr so the check is too late.  The
> "extlog_l1_addr" pointer can never be NULL when this function is called
> so I have removed the check.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

I'm wondering what kernel you have checked, because drivers/acpi/acpi_extlog.c
is not present in the mainline or even in linux-next?

Rafael


> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index c4d5e59..d59e4bb 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -308,8 +308,7 @@ static void __exit extlog_exit(void)
>  {
>  	mce_unregister_decode_chain(&extlog_mce_dec);
>  	((struct extlog_l1_head *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
> -	if (extlog_l1_addr)
> -		acpi_os_unmap_memory(extlog_l1_addr, l1_size);
> +	acpi_os_unmap_memory(extlog_l1_addr, l1_size);
>  	if (elog_addr)
>  		acpi_os_unmap_memory(elog_addr, elog_size);
>  	release_mem_region(elog_base, elog_size);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
