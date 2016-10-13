From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi_os_vprintf: Use printk_get_level() to avoid unnecessary KERN_CONT
Date: Thu, 13 Oct 2016 23:59:52 +0200
Message-ID: <2154245.64ushtJ5yk@vostro.rjw.lan>
References: <CA+55aFxNKFxa0Hh39o0gnxkskpW1Pg004-UnH5YaUQVq4oeDGA@mail.gmail.com> <2344de692f658b8bb07ba53702286b43911e4753.1476298191.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2344de692f658b8bb07ba53702286b43911e4753.1476298191.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday, October 12, 2016 11:50:34 AM Joe Perches wrote:
> acpi_os_vprintf currently always uses a KERN_CONT prefix which may be
> followed immediately by a proper KERN_<LEVEL>.  Check if the buffer
> already has a KERN_<LEVEL> at the start of the buffer and avoid the
> unnecessary KERN_CONT.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/acpi/osl.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 4305ee9db4b2..416953a42510 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -162,11 +162,18 @@ void acpi_os_vprintf(const char *fmt, va_list args)
>  	if (acpi_in_debugger) {
>  		kdb_printf("%s", buffer);
>  	} else {
> -		printk(KERN_CONT "%s", buffer);
> +		if (printk_get_level(buffer))
> +			printk("%s", buffer);
> +		else
> +			printk(KERN_CONT "%s", buffer);
>  	}
>  #else
> -	if (acpi_debugger_write_log(buffer) < 0)
> -		printk(KERN_CONT "%s", buffer);
> +	if (acpi_debugger_write_log(buffer) < 0) {
> +		if (printk_get_level(buffer))
> +			printk("%s", buffer);
> +		else
> +			printk(KERN_CONT "%s", buffer);
> +	}
>  #endif
>  }

Applied.

Thanks,
Rafael
