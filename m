From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] drivers: acpi: Used resource_size function
Date: Tue, 26 Mar 2013 14:28:45 +0100
Message-ID: <1984421.YzSJxzshgC@vostro.rjw.lan>
References: <1363078382-30229-1-git-send-email-gheorghiuandru@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363078382-30229-1-git-send-email-gheorghiuandru@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday, March 12, 2013 10:53:02 AM Alexandru Gheorghiu wrote:
> Used resource_size function instead of explicit computation.
> 
> Signed-off-by: Alexandru Gheorghiu <gheorghiuandru@gmail.com>

Applied to linux-pm.git/linux-next.

Thanks,
Rafael


> ---
>  drivers/acpi/osl.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 586e7e9..4d31748 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -1555,7 +1555,7 @@ int acpi_check_resource_conflict(const struct resource *res)
>  	else
>  		space_id = ACPI_ADR_SPACE_SYSTEM_MEMORY;
>  
> -	length = res->end - res->start + 1;
> +	length = resource_size(res);
>  	if (acpi_enforce_resources != ENFORCE_RESOURCES_NO)
>  		warn = 1;
>  	clash = acpi_check_address_range(space_id, res->start, length, warn);
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
