From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: drivers/acpi/scan.c: inconsequent NULL handling
Date: Fri, 6 Jan 2006 22:36:26 +0300
Message-ID: <20060106193625.GA26372@mipter.zuzino.mipt.ru>
References: <20060106162929.GK12131@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932434AbWAFTTk@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060106162929.GK12131@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jan 06, 2006 at 05:29:29PM +0100, Adrian Bunk wrote:
> static int
> acpi_bus_match (
>         struct acpi_device      *device,
>         struct acpi_driver      *driver)
> {
>         if (driver && driver->ops.match)
>                 return driver->ops.match(device, driver);
>         return acpi_match_ids(device, driver->ids);
> }

> Either driver can be NULL, in which case the driver->ids is a possible
> NULL pointer reference, or it can't, in which case the check whether
> it's NULL is superfluous.

Follow the mon^Wcall tree.

drivers/acpi/scan.c:478: * acpi_bus_match 
drivers/acpi/scan.c:484:acpi_bus_match(struct acpi_device *device, struct acpi_driver *driver)
drivers/acpi/scan.c:564:		if (!acpi_bus_match(dev, drv)) {
drivers/acpi/scan.c:682:		if (!acpi_bus_match(device, driver)) {

1. acpi_bus_match()

   Second arg is passed without changes.

	acpi_driver_attach()
		acpi_bus_register_driver()

	  ===>	if (!driver) <===
			return_VALUE(-EINVAL);

		spin_lock(&acpi_device_lock);
		list_add_tail(&driver->node, &acpi_bus_drivers);
		spin_unlock(&acpi_device_lock);
		count = acpi_driver_attach(driver);

2. acpi_bus_match()
	acpi_bus_find_driver()

		atomic_inc(&driver->references);
			    ^^^^^^^^
                spin_unlock(&acpi_device_lock);
		if (!acpi_bus_match(device, driver)) {

Looks like it can't.
