From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 21/28] ACPI: update comments in motherboard.c
Date: Sat, 6 Jan 2007 21:56:34 -0700
Message-ID: <200701062156.35067.bjorn.helgaas@hp.com>
References: <11608131691346-git-send-email-len.brown@intel.com> <11608131973927-git-send-email-len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:35835 "EHLO atlrel8.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932394AbXAGE4n (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 6 Jan 2007 23:56:43 -0500
In-Reply-To: <11608131973927-git-send-email-len.brown@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

On Saturday 14 October 2006 02:06, Len Brown wrote:
> --- a/drivers/acpi/motherboard.c
> +++ b/drivers/acpi/motherboard.c
> ...
> > +/* 
> + * When CONFIG_PNP is enabled, pnp/system.c binds to PNP0C01
> + * and PNP0C02, redundant with acpi_reserve_io_ranges().
> + * But acpi_reserve_io_ranges() is necessary for !CONFIG_PNP.
> + */
>  static acpi_status acpi_reserve_io_ranges(struct acpi_resource *res, void *data)

I don't understand this comment.

IMHO, we should make CONFIG_ACPI should select CONFIG_PNP and
CONFIG_PNPACPI, move the FADT resource reservations somewhere
else in ACPI, make pnp/system.c reserve all the resources (not
just I/O ports), and remove acpi/motherboard.c.

Bjorn
