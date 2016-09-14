From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 4/4] platform/x86: intel_pmc_ipc: Do not create iTCO
 watchdog when WDAT table exists
Date: Wed, 14 Sep 2016 13:04:29 -0700
Message-ID: <20160914200429.GC14003@roeck-us.net>
References: <20160913152336.75405-1-mika.westerberg@linux.intel.com>
 <20160913152336.75405-5-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160913152336.75405-5-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Peter Tyser <ptyser@xes-inc.com>, Lee Jones <lee.jones@linaro.org>, Zha Qipeng <qipeng.zha@intel.com>, Darren Hart <dvhart@infradead.org>, Wim Van Sebroeck <wim@iguana.be>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Sep 13, 2016 at 06:23:36PM +0300, Mika Westerberg wrote:
> ACPI WDAT table is the preferred way to use hardware watchdog over the
> native iTCO_wdt. Windows only uses this table for its hardware watchdog
> implementation so we should be relatively safe to trust it has been
> validated by OEMs.
> 
> Prevent iTCO watchdog creation if we detect that there is an ACPI WDAT
> table.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/platform/x86/intel_pmc_ipc.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
> index b86e1bcaa055..a511d518206b 100644
> --- a/drivers/platform/x86/intel_pmc_ipc.c
> +++ b/drivers/platform/x86/intel_pmc_ipc.c
> @@ -651,11 +651,15 @@ static int ipc_create_pmc_devices(void)
>  {
>  	int ret;
>  
> -	ret = ipc_create_tco_device();
> -	if (ret) {
> -		dev_err(ipcdev.dev, "Failed to add tco platform device\n");
> -		return ret;
> +	/* If we have ACPI based watchdog use that instead */
> +	if (!acpi_has_watchdog()) {
> +		ret = ipc_create_tco_device();
> +		if (ret) {
> +			dev_err(ipcdev.dev, "Failed to add tco platform device\n");
> +			return ret;
> +		}
>  	}
> +
>  	ret = ipc_create_punit_device();
>  	if (ret) {
>  		dev_err(ipcdev.dev, "Failed to add punit platform device\n");
> -- 
> 2.9.3
> 
