From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [patch 2/2] ACPI / debugger: copy_to_user doesn't return
 errors
Date: Thu, 24 Dec 2015 08:39:06 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1512240838170.2053@localhost6.localdomain6>
References: <20151224072437.GB29642@mwanda>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20151224072437.GB29642@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lv Zheng <lv.zheng@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 24 Dec 2015, Dan Carpenter wrote:

> The copy_to/from_user() functions don't return error codes, they return
> the number of bytes remaining.  We had intended to return -EFUALT here.
> We actually have already checked access_ok() in an earlier function so
> I don't think these functions will fail but let's fix it anyway.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/acpi/acpi_dbg.c b/drivers/acpi/acpi_dbg.c
> index f2c92ab..2a1777b 100644
> --- a/drivers/acpi/acpi_dbg.c
> +++ b/drivers/acpi/acpi_dbg.c
> @@ -592,9 +592,10 @@ static int acpi_aml_read_user(char __user *buf, int len)
>  	smp_rmb();
>  	p = &crc->buf[crc->tail];
>  	n = min(len, circ_count_to_end(crc));
> -	ret = copy_to_user(buf, p, n);
> -	if (IS_ERR_VALUE(ret))

I'm not familiar with IS_ERR_VALUE.  Is it to allow functions that return 
unsigned values to also return negative error codes?

thanks,
julia

> +	if (copy_to_user(buf, p, n)) {
> +		ret = -EFAULT;
>  		goto out;
> +	}
>  	/* sync tail after removing logs */
>  	smp_mb();
>  	crc->tail = (crc->tail + n) & (ACPI_AML_BUF_SIZE - 1);
> @@ -661,9 +662,10 @@ static int acpi_aml_write_user(const char __user *buf, int len)
>  	smp_mb();
>  	p = &crc->buf[crc->head];
>  	n = min(len, circ_space_to_end(crc));
> -	ret = copy_from_user(p, buf, n);
> -	if (IS_ERR_VALUE(ret))
> +	if (copy_from_user(p, buf, n)) {
> +		ret = -EFAULT;
>  		goto out;
> +	}
>  	/* sync head after inserting cmds */
>  	smp_wmb();
>  	crc->head = (crc->head + n) & (ACPI_AML_BUF_SIZE - 1);
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
