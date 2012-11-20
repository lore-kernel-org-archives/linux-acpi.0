From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [Update][PATCH 2/3] ACPI / driver core: Introduce struct
 acpi_dev_node and related macros
Date: Tue, 20 Nov 2012 11:10:07 +0200
Message-ID: <20121120091007.GN17774@intel.com>
References: <1352977397-2280-1-git-send-email-mika.westerberg@linux.intel.com>
 <1758879.PKgPhTGcB7@vostro.rjw.lan>
 <4036218.zBRlg5OZsZ@vostro.rjw.lan>
 <6570191.KCDMiILtRE@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6570191.KCDMiILtRE@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, Jean Delvare <khali@linux-fr.org>, ben-linux@fluff.org, w.sang@pengutronix.de, linux-kernel@vger.kernel.org, lenb@kernel.org, rafael.j.wysocki@intel.com, broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, mathias.nyman@linux.intel.com, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 20, 2012 at 01:59:23AM +0100, Rafael J. Wysocki wrote:
> Index: linux/include/linux/device.h
> ===================================================================
> --- linux.orig/include/linux/device.h
> +++ linux/include/linux/device.h
> @@ -578,6 +578,12 @@ struct device_dma_parameters {
>  	unsigned long segment_boundary_mask;
>  };
>  
> +struct acpi_dev_node {
> +#ifdef CONFIG_ACPI
> +	void	*handle;
> +#endif
> +};
> +
>  /**
>   * struct device - The basic device structure
>   * @parent:	The device's "parent" device, the device to which it is attached.
> @@ -683,7 +689,7 @@ struct device {
>  	struct dev_archdata	archdata;
>  
>  	struct device_node	*of_node; /* associated device tree node */
> -	void			*acpi_handle; /* associated ACPI device node */
> +	struct acpi_dev_node	acpi_node; /* associated ACPI device node */

Please update the kerneldoc comment as well.
