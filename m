From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 2/2] RFC: Xen pad logic
Date: Tue, 13 Mar 2012 20:24:42 -0400
Message-ID: <20120314002442.GC20363@phenom.dumpdata.com>
References: <DE8DF0795D48FD4CA783C40EC82923350AD0A6@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:32121 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756817Ab2CNA3x (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Mar 2012 20:29:53 -0400
Content-Disposition: inline
In-Reply-To: <DE8DF0795D48FD4CA783C40EC82923350AD0A6@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Liu, Jinsong" <jinsong.liu@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "Brown, Len" <len.brown@intel.com>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Kernel development list <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "keir.xen@gmail.com" <keir.xen@gmail.com>, Jan Beulich <JBeulich@suse.com>, "Li, Shaohua" <shaohua.li@intel.com>

> +static struct acpi_driver xen_acpi_pad_driver = {
> +	.name = "processor_aggregator",
> +	.class = ACPI_PROCESSOR_AGGREGATOR_CLASS,
> +	.ids = xen_pad_device_ids,
> +	.ops = {
> +		.add = xen_acpi_pad_add,
> +		.remove = xen_acpi_pad_remove,
> +	},
> +};
> +
> +static int __init xen_acpi_pad_init(void)
> +{
> +	return acpi_bus_register_driver(&xen_acpi_pad_driver);

If the acpi_bus_register_driver function could work with multiple
acpi_drivers that define the same class (and have some priority) would
this be easier?
