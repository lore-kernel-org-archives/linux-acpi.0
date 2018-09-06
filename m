From: zhong jiang <zhongjiang@huawei.com>
Subject: Re: [PATCH] acpi: remove a meaningless null check before debugfs_remove
Date: Thu, 6 Sep 2018 22:28:27 +0800
Message-ID: <5B91398B.8060702@huawei.com>
References: <1534589360-64938-1-git-send-email-zhongjiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534589360-64938-1-git-send-email-zhongjiang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, jkosina@suse.cz, rafael.j.wysocki@intel.com, rusty@rustcorp.com.au
List-Id: linux-acpi@vger.kernel.org

+to maintainers

On 2018/8/18 18:49, zhong jiang wrote:
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
