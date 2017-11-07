From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] APEI/ERST: use 64-bit timestamps
Date: Tue, 7 Nov 2017 21:17:12 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1711072117000.4871@nanos>
References: <20171102114320.1729239-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171102114320.1729239-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Kees Cook <keescook@chromium.org>, Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, Leon Romanovsky <leonro@mellanox.com>, Dan Williams <dan.j.williams@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 2 Nov 2017, Arnd Bergmann wrote:

> 32-bit timestamps are deprecated in the kernel, so we should not use
> get_seconds(). In this case, the 'struct cper_record_header' structure
> already contains a 64-bit field, so the only required change is to use
> the safe ktime_get_real_seconds() interface as a replacement.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

> ---
>  drivers/acpi/apei/erst.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
> index 2c462beee551..6742f6c68034 100644
> --- a/drivers/acpi/apei/erst.c
> +++ b/drivers/acpi/apei/erst.c
> @@ -1061,7 +1061,7 @@ static int erst_writer(struct pstore_record *record)
>  	rcd->hdr.error_severity = CPER_SEV_FATAL;
>  	/* timestamp valid. platform_id, partition_id are invalid */
>  	rcd->hdr.validation_bits = CPER_VALID_TIMESTAMP;
> -	rcd->hdr.timestamp = get_seconds();
> +	rcd->hdr.timestamp = ktime_get_real_seconds();
>  	rcd->hdr.record_length = sizeof(*rcd) + record->size;
>  	rcd->hdr.creator_id = CPER_CREATOR_PSTORE;
>  	rcd->hdr.notification_type = CPER_NOTIFY_MCE;
> -- 
> 2.9.0
> 
> 
