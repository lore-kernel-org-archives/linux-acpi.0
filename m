From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI / SPI: Use parent's ACPI_HANDLE() in
 acpi_register_spi_devices()
Date: Mon, 1 Apr 2013 11:27:17 +0300
Message-ID: <20130401082717.GK21804@intel.com>
References: <2747891.0orCNBJG8v@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:61577 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757787Ab3DAIXG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 1 Apr 2013 04:23:06 -0400
Content-Disposition: inline
In-Reply-To: <2747891.0orCNBJG8v@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, grant.likely@secretlab.ca, broonie@opensource.wolfsonmicro.com

On Mon, Apr 01, 2013 at 02:21:08AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The ACPI handle of struct spi_master's dev member should not be
> set, because this causes that struct spi_master to be associated
> with the ACPI device node corresponding to its parent as the
> second "physical_device", which is incorrect (this happens during
> the registration of struct spi_master).  Consequently,
> acpi_register_spi_devices() should use the ACPI handle of the
> parent of the struct spi_master it is called for rather than that
> struct spi_master's ACPI handle (which should be NULL).
> 
> Make that happen and modify the spi-pxa2xx driver, which currently is
> the only driver for ACPI-enumerated SPI controller chips, not to set
> the ACPI handle for the struct spi_master it creates.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
