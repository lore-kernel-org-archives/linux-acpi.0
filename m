From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2] acpi_system_write_wakeup_device(): fix error check for unsigned variable.
Date: Thu, 22 Nov 2012 23:40:26 +0100
Message-ID: <27097726.Soe6qubrSj@vostro.rjw.lan>
References: <1645783.2WuR77RKxS@vostro.rjw.lan> <1353544495-25277-1-git-send-email-tipecaml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1353544495-25277-1-git-send-email-tipecaml@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cyril Roelandt <tipecaml@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thursday, November 22, 2012 01:34:55 AM Cyril Roelandt wrote:
> The LEN variable is unsigned, therefore checking whether it is less than 0 is
> useless. Also drop the LEN variable, since the COUNT parameter can be used
> instead.

Applied (under a different subject).

Thanks,
Rafael


> Signed-off-by: Cyril Roelandt <tipecaml@gmail.com>
> ---
>  drivers/acpi/proc.c |   11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/proc.c b/drivers/acpi/proc.c
> index 27adb09..ef98796 100644
> --- a/drivers/acpi/proc.c
> +++ b/drivers/acpi/proc.c
> @@ -362,16 +362,13 @@ acpi_system_write_wakeup_device(struct file *file,
>  	struct list_head *node, *next;
>  	char strbuf[5];
>  	char str[5] = "";
> -	unsigned int len = count;
>  
> -	if (len > 4)
> -		len = 4;
> -	if (len < 0)
> -		return -EFAULT;
> +	if (count > 4)
> +		count = 4;
>  
> -	if (copy_from_user(strbuf, buffer, len))
> +	if (copy_from_user(strbuf, buffer, count))
>  		return -EFAULT;
> -	strbuf[len] = '\0';
> +	strbuf[count] = '\0';
>  	sscanf(strbuf, "%s", str);
>  
>  	mutex_lock(&acpi_device_lock);
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
