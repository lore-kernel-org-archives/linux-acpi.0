From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [Resend] [PATCH] ACPI: New driver for Lenovo SL laptops
Date: Fri, 23 Oct 2009 15:43:10 -0600
Message-ID: <200910231543.12254.bjorn.helgaas@hp.com>
References: <1253805163-12493-1-git-send-email-ike.pan@canonical.com> <1256325108-22626-1-git-send-email-ike.pan@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:11462 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbZJWVnJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Oct 2009 17:43:09 -0400
In-Reply-To: <1256325108-22626-1-git-send-email-ike.pan@canonical.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ike Panhc <ike.pan@canonical.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Alexandre Rostovtsev <tetromino@gmail.com>

On Friday 23 October 2009 01:11:48 pm Ike Panhc wrote:

> +static int __init lenovo_sl_laptop_init(void)
> +{
> +	int ret;
> +	acpi_status status;
> +
> +	if (acpi_disabled)
> +		return -ENODEV;

Don't need this.

> +	lenovo_sl_laptop_hkey_handle = lenovo_sl_laptop_ec0_handle = NULL;
> +	status = acpi_get_handle(NULL, ACPI_HKEY_PATH,
> +				 &lenovo_sl_laptop_hkey_handle);
> +	if (ACPI_FAILURE(status)) {
> +		pr_err("Failed to get ACPI handle for %s\n", ACPI_HKEY_PATH);
> +		return -ENODEV;
> +	}

Don't need this; acpi_bus_register_driver() is enough.

Bjorn
