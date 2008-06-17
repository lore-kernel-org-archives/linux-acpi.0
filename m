From: Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [linux-pm] [RFC][PATCH 2/3] PCI PM: Introduce
	platform_pci_power_manageable
Date: Mon, 16 Jun 2008 18:26:20 -0700
Message-ID: <1213665980.11712.120.camel@localhost.localdomain>
References: <200806170206.26616.rjw@sisk.pl>
	 <200806170214.51160.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143]:55030 "EHLO e3.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751619AbYFQB0d (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Jun 2008 21:26:33 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5H1QXw3006986
	for <linux-acpi@vger.kernel.org>; Mon, 16 Jun 2008 21:26:33 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m5H1QNEq216822
	for <linux-acpi@vger.kernel.org>; Mon, 16 Jun 2008 21:26:23 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m5H1QMX9007439
	for <linux-acpi@vger.kernel.org>; Mon, 16 Jun 2008 21:26:22 -0400
In-Reply-To: <200806170214.51160.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>


On Tue, 2008-06-17 at 02:14 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Introduce function pointer platform_pci_power_manageable to be used
> by the platform-related code to point to a function allowing us to
> check if given device is power manageable by the platform.
> 
> Introduce acpi_pci_power_manageable() playing that role for ACPI.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/pci/pci-acpi.c |   11 +++++++++++
>  drivers/pci/pci.c      |    1 +
>  drivers/pci/pci.h      |    1 +
>  3 files changed, 13 insertions(+)
> 
> Index: linux-2.6/drivers/pci/pci-acpi.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/pci-acpi.c
> +++ linux-2.6/drivers/pci/pci-acpi.c
> @@ -315,6 +315,16 @@ static pci_power_t acpi_pci_choose_state
>  }
>  #endif
> 
> +static bool acpi_pci_power_manageable(struct pci_dev *dev)
> +{
> +	acpi_handle handle = DEVICE_ACPI_HANDLE(&dev->dev);
> +
> +	if (!handle)
> +		return -ENODEV;

Seems like a bad idea to pass non-true/false values using a bool.
Wouldn't an int return type be more appropriate here?

<snip>

Cheers,
	-Matt Helsley

