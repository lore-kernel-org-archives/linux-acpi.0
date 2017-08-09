From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / dock: constify attribute_group structure
Date: Thu, 10 Aug 2017 00:44:43 +0200
Message-ID: <751192022.91ZtdmPBFf@aspire.rjw.lan>
References: <20170802002846.GA14666@amitoj-Inspiron-3542>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170802002846.GA14666@amitoj-Inspiron-3542>
Sender: linux-kernel-owner@vger.kernel.org
To: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday, August 2, 2017 2:28:46 AM CEST Amitoj Kaur Chawla wrote:
> Functions working with attribute_groups provided by <linux/sysfs.h>
> work with const attribute_group. These attribute_group structures do not
> change at runtime so mark them as const.
> 
> File size before:
>  text      data     bss     dec     hex filename
>  7902      3528      64   11494    2ce6 drivers/acpi/dock.o
> 
> File size after:
>  text      data     bss     dec     hex filename
>  7998      3432      64   11494    2ce6 drivers/acpi/dock.o
> 
> This change was made with the help of Coccinelle.
> 
> Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
> ---
>  drivers/acpi/dock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
> index 0c00208..2305e1a 100644
> --- a/drivers/acpi/dock.c
> +++ b/drivers/acpi/dock.c
> @@ -585,7 +585,7 @@ static struct attribute *dock_attributes[] = {
>  	NULL
>  };
>  
> -static struct attribute_group dock_attribute_group = {
> +static const struct attribute_group dock_attribute_group = {
>  	.attrs = dock_attributes
>  };
>  
> 

Applied, thanks!
