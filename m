From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v1 06/11] platform/x86: apple-gmux: hide PCI specific code
Date: Sat, 22 Dec 2018 09:03:17 +0100
Message-ID: <20181222080317.qicyihyauia6n63w@wunner.de>
References: <20181222001452.7474-1-okaya@kernel.org>
 <20181222001452.7474-7-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181222001452.7474-7-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Dec 22, 2018 at 12:14:47AM +0000, Sinan Kaya wrote:
> Code is scanning PCI bus to find out if it is switchable or not. If
> CONFIG_PCI is not set, assume unswitchable.
> 
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/platform/x86/apple-gmux.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
> index fd2ffebc868f..b552b54bf58b 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c
> @@ -742,8 +742,12 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
>  	 * If Thunderbolt is present, the external DP port is not fully
>  	 * switchable. Force its AUX channel to the discrete GPU.
>  	 */
> +#ifdef CONFIG_PCI
>  	gmux_data->external_switchable =
>  		!bus_for_each_dev(&pci_bus_type, NULL, NULL, is_thunderbolt);
> +#else
> +	gmux_data->external_switchable = false;
> +#endif
>  	if (!gmux_data->external_switchable)
>  		gmux_write8(gmux_data, GMUX_PORT_SWITCH_EXTERNAL, 3);

This driver is only used on 2008+ MacBook Pros and the 2013+ Mac Pro,
all of which have PCI and are pretty much unusable with CONFIG_PCI=n.

So it is okay to just add "depends on PCI" for this driver, as you did
with other drivers, and I think that's preferrable to an #ifdef.

You can also drop the "platform/x86: " prefix from the subject if you
like, all previous commits to this driver just use "apple-gmux: ".

If you are okay with these changes, feel free to add my Reviewed-by
when respinning.

Thanks,

Lukas
