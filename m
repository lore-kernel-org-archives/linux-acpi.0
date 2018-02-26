From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v1 4/4] pci: Re-use new dmi_get_bios_year() helper
Date: Mon, 26 Feb 2018 21:40:22 +0100
Message-ID: <20180226214022.7b239783@endymion>
References: <20180222125923.57385-1-andriy.shevchenko@linux.intel.com>
        <20180222125923.57385-4-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180222125923.57385-4-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 22 Feb 2018 14:59:23 +0200, Andy Shevchenko wrote:
> ...instead of open coding its functionality.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pci/pci.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index f6a4dd10d9b0..ae654e21439d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2258,8 +2258,6 @@ void pci_config_pm_runtime_put(struct pci_dev *pdev)
>   */
>  bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  {
> -	unsigned int year;
> -
>  	if (!pci_is_pcie(bridge))
>  		return false;
>  
> @@ -2287,10 +2285,8 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  		 * It should be safe to put PCIe ports from 2015 or newer
>  		 * to D3.
>  		 */
> -		if (dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL) &&
> -		    year >= 2015) {
> +		if (dmi_get_bios_year() >= 2015)
>  			return true;
> -		}
>  		break;
>  	}
>  

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
