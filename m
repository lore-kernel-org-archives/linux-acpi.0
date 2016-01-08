From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi: avoid leaking format string into kobject name
Date: Fri, 08 Jan 2016 01:44:33 +0100
Message-ID: <24226423.iyzeMndoHV@vostro.rjw.lan>
References: <20160107192429.GA5113@www.outflux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160107192429.GA5113@www.outflux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thursday, January 07, 2016 11:24:29 AM Kees Cook wrote:
> The dn->name is expected to be used as a literal, so add the missing
> "%s".
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied, thanks!

> ---
>  drivers/acpi/device_sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> index 707cf6213bc2..b9afb47db7ed 100644
> --- a/drivers/acpi/device_sysfs.c
> +++ b/drivers/acpi/device_sysfs.c
> @@ -104,7 +104,7 @@ static void acpi_expose_nondev_subnodes(struct kobject *kobj,
>  
>  		init_completion(&dn->kobj_done);
>  		ret = kobject_init_and_add(&dn->kobj, &acpi_data_node_ktype,
> -					   kobj, dn->name);
> +					   kobj, "%s", dn->name);
>  		if (ret)
>  			acpi_handle_err(dn->handle, "Failed to expose (%d)\n", ret);
>  		else
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
