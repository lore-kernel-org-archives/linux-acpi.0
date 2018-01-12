From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: Fix debugfs_create_*() usage
Date: Fri, 12 Jan 2018 14:33:19 +0100
Message-ID: <1702185.um3EttcCfv@aspire.rjw.lan>
References: <1514906791-9166-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1514906791-9166-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday, January 2, 2018 4:26:31 PM CET Geert Uytterhoeven wrote:
> acpi_ec.gpe is "unsigned long", hence treating it as "u32" would expose
> the wrong half on big-endian 64-bit systems.  Fix this by changing its
> type to "u32" and removing the cast, as all other code already uses u32
> or sometimes even only u8.
> 
> Fixes: 1195a098168fcacf ("ACPI: Provide /sys/kernel/debug/ec/...")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Compile-tested only.
> ---
>  drivers/acpi/ec.c       | 2 +-
>  drivers/acpi/ec_sys.c   | 2 +-
>  drivers/acpi/internal.h | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 0252c9b9af3d3a09..d9f38c645e4a1dc7 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -1516,7 +1516,7 @@ static int acpi_ec_setup(struct acpi_ec *ec, bool handle_events)
>  	}
>  
>  	acpi_handle_info(ec->handle,
> -			 "GPE=0x%lx, EC_CMD/EC_SC=0x%lx, EC_DATA=0x%lx\n",
> +			 "GPE=0x%x, EC_CMD/EC_SC=0x%lx, EC_DATA=0x%lx\n",
>  			 ec->gpe, ec->command_addr, ec->data_addr);
>  	return ret;
>  }
> diff --git a/drivers/acpi/ec_sys.c b/drivers/acpi/ec_sys.c
> index 6c7dd7af789e453c..dd70d6c2bca03eb2 100644
> --- a/drivers/acpi/ec_sys.c
> +++ b/drivers/acpi/ec_sys.c
> @@ -128,7 +128,7 @@ static int acpi_ec_add_debugfs(struct acpi_ec *ec, unsigned int ec_device_count)
>  		return -ENOMEM;
>  	}
>  
> -	if (!debugfs_create_x32("gpe", 0444, dev_dir, (u32 *)&first_ec->gpe))
> +	if (!debugfs_create_x32("gpe", 0444, dev_dir, &first_ec->gpe))
>  		goto error;
>  	if (!debugfs_create_bool("use_global_lock", 0444, dev_dir,
>  				 &first_ec->global_lock))
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 7f43423de43cebdd..1d0a501bc7f0cbbf 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -159,7 +159,7 @@ static inline void acpi_early_processor_osc(void) {}
>     -------------------------------------------------------------------------- */
>  struct acpi_ec {
>  	acpi_handle handle;
> -	unsigned long gpe;
> +	u32 gpe;
>  	unsigned long command_addr;
>  	unsigned long data_addr;
>  	bool global_lock;
> 

Applied, thanks!
