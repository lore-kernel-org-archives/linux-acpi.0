From: Len Brown <lenb@kernel.org>
Subject: Re: [patch] Hook acpi D-state method to pnp suspend/resume
Date: Wed, 6 Jun 2007 21:55:41 -0400
Message-ID: <200706062155.41912.lenb@kernel.org>
References: <1180665425.27219.5.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59459 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935420AbXFGB4H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jun 2007 21:56:07 -0400
In-Reply-To: <1180665425.27219.5.camel@sli10-conroe.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Adam Belay <abelay@novell.com>

On Thursday 31 May 2007 22:37, Shaohua Li wrote:

I like this patch, it may save power while in S3...
I gather that it should also automatically expose the D-state controls
for these PNP devices in sysfs, which may come in very handy...

> +static int pnpacpi_suspend(struct pnp_dev *dev, pm_message_t state)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return acpi_bus_set_power(=
(acpi_handle)dev->data, 3);
> +}
> +

This should usually work, but...
If the device is enabled as a wakeup device, this could
disable its wakeup capability.

So in that case, we need to check _S3W to make sure that
we are not putting the device in a D-state deeper than
it can still wake the system.

-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
