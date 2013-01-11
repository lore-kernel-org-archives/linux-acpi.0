From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/16] ACPI: Separate adding ACPI device objects from
 probing ACPI drivers
Date: Fri, 11 Jan 2013 22:00:46 +0200
Message-ID: <20130111200046.GB13897@intel.com>
References: <8498184.VilrUmatxI@vostro.rjw.lan>
 <4082842.31rfDviYHK@vostro.rjw.lan>
 <1855256.SyhOJGYMIh@vostro.rjw.lan>
 <23002897.6xbQGtPaGy@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:18518 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753510Ab3AKT5R (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Jan 2013 14:57:17 -0500
Content-Disposition: inline
In-Reply-To: <23002897.6xbQGtPaGy@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Toshi Kani <toshi.kani@hp.com>, Bjorn Helgaas <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, Myron Stowe <myron.stowe@redhat.com>, Yijing Wang <wangyijing0307@gmail.com>, Jiang Liu <liuj97@gmail.com>

(Sorry to jump in late but I noticed one problem with this series while
testing).

On Thu, Dec 20, 2012 at 02:47:47AM +0100, Rafael J. Wysocki wrote:
> +static acpi_status acpi_bus_probe_start(acpi_handle handle, u32 lvl,
> +					void *context, void **not_used)
> +{
> +	struct acpi_bus_ops *ops = context;
> +	acpi_status status = AE_OK;
> +	struct acpi_device *device;
> +	unsigned long long sta_not_used;
> +	int type_not_used;
> +
> +	/*
> +	 * Ignore errors ignored by acpi_bus_check_add() to avoid terminating
> +	 * namespace walks prematurely.
> +	 */
> +	if (acpi_bus_type_and_status(handle, &type_not_used, &sta_not_used))
> +		return AE_OK;
> +
> +	if (acpi_bus_get_device(handle, &device))
> +		return AE_CTRL_DEPTH;
> +
> +	if (ops->acpi_op_add) {
> +		if (!acpi_match_device_ids(device, acpi_platform_device_ids)) {
> +			/* This is a known good platform device. */
> +			acpi_create_platform_device(device);
> +		} else if (device_attach(&device->dev)) {

device_attach() returns 1 if it succeeds to attach device to a driver. In
that case we should continue and not return AE_CTRL_DEPTH, right?

> +			status = AE_CTRL_DEPTH;
> +		}
> +	} else if (ops->acpi_op_start) {
> +		if (ACPI_FAILURE(acpi_start_single_object(device)))
> +			status = AE_CTRL_DEPTH;
> +	}
> +	return status;
> +}
