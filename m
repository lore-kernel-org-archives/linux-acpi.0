From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/4] mfd: lpc_ich: Do not create iTCO watchdog when WDAT
 table exists
Date: Wed, 14 Sep 2016 13:03:41 -0700
Message-ID: <20160914200341.GA14003@roeck-us.net>
References: <20160913152336.75405-1-mika.westerberg@linux.intel.com>
 <20160913152336.75405-3-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:50479 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933195AbcINUD5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Sep 2016 16:03:57 -0400
Content-Disposition: inline
In-Reply-To: <20160913152336.75405-3-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Peter Tyser <ptyser@xes-inc.com>, Lee Jones <lee.jones@linaro.org>, Zha Qipeng <qipeng.zha@intel.com>, Darren Hart <dvhart@infradead.org>, Wim Van Sebroeck <wim@iguana.be>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Sep 13, 2016 at 06:23:34PM +0300, Mika Westerberg wrote:
> ACPI WDAT table is the preferred way to use hardware watchdog over the
> native iTCO_wdt. Windows only uses this table for its hardware watchdog
> implementation so we should be relatively safe to trust it has been
> validated by OEMs
> 
> Prevent iTCO watchdog creation if we detect that there is ACPI WDAT table.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/mfd/lpc_ich.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mfd/lpc_ich.c b/drivers/mfd/lpc_ich.c
> index bd3aa4578346..c8dee47b45d9 100644
> --- a/drivers/mfd/lpc_ich.c
> +++ b/drivers/mfd/lpc_ich.c
> @@ -984,6 +984,10 @@ static int lpc_ich_init_wdt(struct pci_dev *dev)
>  	int ret;
>  	struct resource *res;
>  
> +	/* If we have ACPI based watchdog use that instead */
> +	if (acpi_has_watchdog())
> +		return -ENODEV;
> +
>  	/* Setup power management base register */
>  	pci_read_config_dword(dev, priv->abase, &base_addr_cfg);
>  	base_addr = base_addr_cfg & 0x0000ff80;
> -- 
> 2.9.3
> 
