From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / tables: Add an ifdef around amlcode and dsdt_amlcode
Date: Fri, 21 Dec 2018 12:16:46 +0100
Message-ID: <1712098.V69yOz7Vcp@aspire.rjw.lan>
References: <20181220193856.7833-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181220193856.7833-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thursday, December 20, 2018 8:38:56 PM CET Nathan Chancellor wrote:
> Clang warns:
> 
> drivers/acpi/tables.c:715:14: warning: unused variable 'amlcode'
> [-Wunused-variable]
> static void *amlcode __attribute__ ((weakref("AmlCode")));
>              ^
> drivers/acpi/tables.c:716:14: warning: unused variable 'dsdt_amlcode'
> [-Wunused-variable]
> static void *dsdt_amlcode __attribute__ ((weakref("dsdt_aml_code")));
>              ^
> 2 warnings generated.
> 
> The only uses of these variables are hiddem behind CONFIG_ACPI_CUSTOM_DSDT
> so do the same thing here.
> 
> Fixes: 82e4eb4e9653 ("ACPI / tables: add DSDT AmlCode new declaration name support")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/acpi/tables.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index ccb90eff00e5..48eabb6c2d4f 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -712,8 +712,10 @@ acpi_os_physical_table_override(struct acpi_table_header *existing_table,
>  					  table_length);
>  }
>  
> +#ifdef CONFIG_ACPI_CUSTOM_DSDT
>  static void *amlcode __attribute__ ((weakref("AmlCode")));
>  static void *dsdt_amlcode __attribute__ ((weakref("dsdt_aml_code")));
> +#endif
>  
>  acpi_status
>  acpi_os_table_override(struct acpi_table_header *existing_table,
> 

Applied, thanks!
