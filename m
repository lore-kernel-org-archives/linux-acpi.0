From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V5 02/12] PNPACPI: use whilte list for pnpacpi device enumeration
Date: Mon, 28 Apr 2014 00:01:26 +0200
Message-ID: <34978551.c1lKBcQLqc@vostro.rjw.lan>
References: <1396886819-2637-1-git-send-email-rui.zhang@intel.com> <1396886819-2637-3-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49153 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751994AbaD0Vo7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Apr 2014 17:44:59 -0400
In-Reply-To: <1396886819-2637-3-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, matthew.garrett@nebula.com, rafael.j.wysocki@intel.com, dmitry.torokhov@gmail.com

On Tuesday, April 08, 2014 12:06:49 AM Zhang Rui wrote:

[...]

> +
> +static int acpi_pnp_scan_handler_attach(struct acpi_device *adev,
> +					const struct acpi_device_id *id)
> +{
> +	return 1;
> +}
> +
> +static int acpi_pnp_scan_handler_match(char *devid, char *handlerid)
> +{
> +	int i;
> +
> +	if (memcmp(devid, handlerid, 3))
> +		return 0;
> +
> +	for (i = 3; i < 7; i++) {
> +		/* Not a HEX value */
> +		if (!((devid[i] >= '0' && devid[i] <= '9') ||
> +		      (devid[i] > 'A' && devid[i] <= 'F')))
> +			return 0;
> +
> +		if ((handlerid[i] != 'X') &&

Hmm.  What exactly is the above check for?

> +		    toupper(devid[i]) != toupper(handlerid[i]))
> +			return 0;
> +	}
> +	return 1;
> +}
> +
> +static struct acpi_scan_handler acpi_pnp_handler = {
> +	.ids = acpi_pnp_device_ids,
> +	.match = acpi_pnp_scan_handler_match,
> +	.attach = acpi_pnp_scan_handler_attach,
> +};
> +
> +bool acpi_is_pnp_device(struct acpi_device *device)
> +{
> +	return device->handler == &acpi_pnp_handler;
> +}
> +EXPORT_SYMBOL_GPL(acpi_is_pnp_device);
> +
> +void __init acpi_pnp_init(void)
> +{
> +	acpi_scan_add_handler(&acpi_pnp_handler);
> +}
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
