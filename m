From: Len Brown <len.brown@intel.com>
Subject: Re: [PATCH][Trivial] ACPI: Get rid of 'unused variable' warning in  acpi_ev_global_lock_handler()
Date: Mon, 6 Nov 2006 15:16:17 -0500
Message-ID: <200611061516.17988.len.brown@intel.com>
References: <200611021313.22709.jesper.juhl@gmail.com>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753375AbWKFUUT@vger.kernel.org>
In-Reply-To: <200611021313.22709.jesper.juhl@gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, trivial@kernel.org
List-Id: linux-acpi@vger.kernel.org

Applied.

thanks,
-Len

On Thursday 02 November 2006 07:13, Jesper Juhl wrote:
> Fix this warning : 
>   drivers/acpi/events/evmisc.c: In function `acpi_ev_global_lock_handler':
>   drivers/acpi/events/evmisc.c:334: warning: unused variable `status'
> 
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
> 
>  drivers/acpi/events/evmisc.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/events/evmisc.c b/drivers/acpi/events/evmisc.c
> index ee2a10b..bf63edc 100644
> --- a/drivers/acpi/events/evmisc.c
> +++ b/drivers/acpi/events/evmisc.c
> @@ -331,7 +331,6 @@ static void ACPI_SYSTEM_XFACE acpi_ev_gl
>  static u32 acpi_ev_global_lock_handler(void *context)
>  {
>  	u8 acquired = FALSE;
> -	acpi_status status;
>  
>  	/*
>  	 * Attempt to get the lock
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
