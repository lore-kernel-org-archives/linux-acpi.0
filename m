From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: add missing newline to printk
Date: Wed, 09 May 2018 11:54:06 +0200
Message-ID: <89768760.ar4GnIqtnF@aspire.rjw.lan>
References: <20180410171038.GA4189@laszlth>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180410171038.GA4189@laszlth>
Sender: linux-kernel-owner@vger.kernel.org
To: Laszlo Toth <laszlth@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday, April 10, 2018 7:10:38 PM CEST Laszlo Toth wrote:
> ...and restore reverse xmas tree while at it.
> 
> Signed-off-by: Laszlo Toth <laszlth@gmail.com>
> ---
>  drivers/acpi/reboot.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/reboot.c b/drivers/acpi/reboot.c
> index 71769fd..6fa9c2a 100644
> --- a/drivers/acpi/reboot.c
> +++ b/drivers/acpi/reboot.c
> @@ -8,8 +8,8 @@ void acpi_reboot(void)
>  {
>  	struct acpi_generic_address *rr;
>  	struct pci_bus *bus0;
> -	u8 reset_value;
>  	unsigned int devfn;
> +	u8 reset_value;
>  
>  	if (acpi_disabled)
>  		return;
> @@ -40,7 +40,7 @@ void acpi_reboot(void)
>  		/* Form PCI device/function pair. */
>  		devfn = PCI_DEVFN((rr->address >> 32) & 0xffff,
>  				  (rr->address >> 16) & 0xffff);
> -		printk(KERN_DEBUG "Resetting with ACPI PCI RESET_REG.");
> +		printk(KERN_DEBUG "Resetting with ACPI PCI RESET_REG.\n");
>  		/* Write the value that resets us. */
>  		pci_bus_write_config_byte(bus0, devfn,
>  				(rr->address & 0xffff), reset_value);
> 

Applied, thanks!
