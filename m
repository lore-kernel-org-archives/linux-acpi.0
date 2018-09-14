From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi: remove a meaningless null check before debugfs_remove
Date: Fri, 14 Sep 2018 10:37:19 +0200
Message-ID: <23292371.I5A41k64Vn@aspire.rjw.lan>
References: <1534589360-64938-1-git-send-email-zhongjiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534589360-64938-1-git-send-email-zhongjiang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: zhong jiang <zhongjiang@huawei.com>
Cc: lenb@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Saturday, August 18, 2018 12:49:20 PM CEST zhong jiang wrote:
> debugfs_remove has taken null pointer into account. So it is safe
> to remove the check before debugfs_remove.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/acpi/custom_method.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
> index e967c11..4451877 100644
> --- a/drivers/acpi/custom_method.c
> +++ b/drivers/acpi/custom_method.c
> @@ -92,8 +92,7 @@ static int __init acpi_custom_method_init(void)
>  
>  static void __exit acpi_custom_method_exit(void)
>  {
> -	if (cm_dentry)
> -		debugfs_remove(cm_dentry);
> +	debugfs_remove(cm_dentry);
>  }
>  
>  module_init(acpi_custom_method_init);
> 

Applied, thanks!
