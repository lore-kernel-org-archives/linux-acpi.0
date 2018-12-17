From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI, APEI, EINJ: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date: Mon, 17 Dec 2018 12:40:19 +0100
Message-ID: <2171529.ACrt31yYEM@aspire.rjw.lan>
References: <20181130170106.4031-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181130170106.4031-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: lenb@kernel.org, tony.luck@intel.com, bp@alien8.de, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Friday, November 30, 2018 6:01:06 PM CET Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/acpi/apei/einj.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index b38737c83a24..fcccbfdbdd1a 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -607,17 +607,7 @@ static int available_error_type_show(struct seq_file *m, void *v)
>  	return 0;
>  }
>  
> -static int available_error_type_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, available_error_type_show, NULL);
> -}
> -
> -static const struct file_operations available_error_type_fops = {
> -	.open		= available_error_type_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(available_error_type);
>  
>  static int error_type_get(void *data, u64 *val)
>  {
> 

Applied, thanks!
