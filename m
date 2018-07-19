From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: save NVS memory for ASUS 1025C laptop
Date: Thu, 19 Jul 2018 12:54:09 +0200
Message-ID: <4593492.JrdWhbroZC@aspire.rjw.lan>
References: <1531137835-21581-1-git-send-email-w@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531137835-21581-1-git-send-email-w@1wt.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: Willy Tarreau <w@1wt.eu>
Cc: Lan Tianyu <tianyu.lan@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Monday, July 9, 2018 2:03:55 PM CEST Willy Tarreau wrote:
> Every time I tried to upgrade my laptop from 3.10.x to 4.x I faced an
> issue by which the fan would run at full speed upon resume. Bisecting
> it showed me the issue was introduced in 3.17 by commit 821d6f0359b0
> (ACPI / sleep: Do not save NVS for new machines to accelerate S3). This
> code only affects machines built starting as of 2012, but this Asus
> 1025C laptop was made in 2012 and apparently needs the NVS data to be
> saved, otherwise the CPU's thermal state is not properly reported on
> resume and the fan runs at full speed upon resume.
> 
> Here's a very simple way to check if such a machine is affected :
> 
>   # cat /sys/class/thermal/thermal_zone0/temp
>   55000
> 
>   ( now suspend, wait one second and resume )
> 
>   # cat /sys/class/thermal/thermal_zone0/temp
>   0
> 
>   (and after ~15 seconds the fan starts to spin)
> 
> Let's apply the same quirk as commit cbc00c13 (ACPI: save NVS memory
> for Lenovo G50-45) and reuse the function it provides. Note that this
> commit was already backported to 4.9.x but not 4.4.x.
> 
> Cc: <linux-acpi@vger.kernel.org>
> Cc: <stable@vger.kernel.org> # 3.17+: requires cbc00c13
> Signed-off-by: Willy Tarreau <w@1wt.eu>
> ---
>  drivers/acpi/sleep.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 974e584..af54d7b 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -338,6 +338,14 @@ static const struct dmi_system_id acpisleep_dmi_table[] __initconst = {
>  		DMI_MATCH(DMI_PRODUCT_NAME, "K54HR"),
>  		},
>  	},
> +	{
> +	.callback = init_nvs_save_s3,
> +	.ident = "Asus 1025C",
> +	.matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "1025C"),
> +		},
> +	},
>  	/*
>  	 * https://bugzilla.kernel.org/show_bug.cgi?id=189431
>  	 * Lenovo G50-45 is a platform later than 2012, but needs nvs memory
> 

Applied, thanks!
