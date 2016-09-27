From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 2/4] mfd: lpc_ich: Do not create iTCO watchdog when
 WDAT table exists
Date: Tue, 27 Sep 2016 20:41:14 +0100
Message-ID: <20160927194114.GL21388@dell>
References: <20160920123054.195021-1-mika.westerberg@linux.intel.com>
 <20160920123054.195021-3-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:32842 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934952AbcI0TjF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Sep 2016 15:39:05 -0400
Received: by mail-pa0-f41.google.com with SMTP id cd13so5263420pac.0
        for <linux-acpi@vger.kernel.org>; Tue, 27 Sep 2016 12:39:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160920123054.195021-3-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, Len Brown <lenb@kernel.org>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Peter Tyser <ptyser@xes-inc.com>, Zha Qipeng <qipeng.zha@intel.com>, Darren Hart <dvhart@infradead.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 20 Sep 2016, Mika Westerberg wrote:

> ACPI WDAT table is the preferred way to use hardware watchdog over the
> native iTCO_wdt. Windows only uses this table for its hardware watchdog
> implementation so we should be relatively safe to trust it has been
> validated by OEMs
> 
> Prevent iTCO watchdog creation if we detect that there is ACPI WDAT table.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/mfd/lpc_ich.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.

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

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
