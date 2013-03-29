From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 5/6] ACPI / LPSS: return no error from register_device_clock in special cases
Date: Fri, 29 Mar 2013 23:26:38 +0100
Message-ID: <5510153.6xBDfboAWZ@vostro.rjw.lan>
References: <1364374682-8547-1-git-send-email-andriy.shevchenko@linux.intel.com> <1364374682-8547-6-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:47049 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757134Ab3C2WTI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 29 Mar 2013 18:19:08 -0400
In-Reply-To: <1364374682-8547-6-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, spear-devel <spear-devel@list.st.com>, Vinod Koul <vinod.koul@intel.com>, linux-acpi@vger.kernel.org

On Wednesday, March 27, 2013 10:58:01 AM Andy Shevchenko wrote:
> When device uses the fixed clock and has no private space of LTR, we have to
> create main LPSS clock and register platform device. This is normally a case
> for LPSS DMA controller.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/acpi/acpi_lpss.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index b1c9542..4015929 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -95,6 +95,10 @@ static int register_device_clock(struct acpi_device *adev,
>  	if (!lpss_clk_dev)
>  		lpt_register_clock_device();
>  
> +	if (!dev_desc->prv_offset && dev_desc->clk_required)

If clk_required is not set, register_device_clock() won't be called at all for
the device.  Moreover, prv_offset may be zero in principle.

You'd need to add support for shared clocks for that to really work.  I have code
for that, please ping me off-list.

> +		/* There is no error when device uses fixed clock */
> +		return 0;
> +
>  	if (!dev_desc->clk_parent || !pdata->mmio_base
>  	    || pdata->mmio_size < dev_desc->prv_offset + LPSS_CLK_SIZE)
>  		return -ENODATA;

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
