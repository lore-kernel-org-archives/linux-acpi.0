From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Linaro-acpi] [RFC PATCH for Juno 1/2] net: smsc911x add support for probing from ACPI
Date: Mon, 01 Sep 2014 17:17:51 +0200
Message-ID: <2861461.8zNpLC3I2n@wuerfel>
References: <1409583961-7466-1-git-send-email-hanjun.guo@linaro.org> <1409583961-7466-2-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:53551 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbaIAPTN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Sep 2014 11:19:13 -0400
In-Reply-To: <1409583961-7466-2-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linaro-acpi@lists.linaro.org
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Robert Moore <robert.moore@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Lv Zheng <lv.zheng@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org

On Monday 01 September 2014 23:06:00 Hanjun Guo wrote:
> +#ifdef CONFIG_ACPI
> +/* Configure some sensible defaults for ACPI mode */
> +static int smsc911x_probe_config_acpi(struct smsc911x_platform_config *config,
> +                                   acpi_handle *ahandle)
> +{
> +       if (!ahandle)
> +               return -ENOSYS;
> +
> +       config->phy_interface = PHY_INTERFACE_MODE_MII;
> 

Please remove the #ifdef and use 

	if (!IS_ENABLED(CONFIG_ACPI) || !ahandle)

to check for ACPI support. This should result in the same object code
in all cases, but give better compile-time coverage when ACPI is
disabled.

Also, -ENOSYS is probably the wrong return value. I think you mean
-ENXIO.

	Arnd
