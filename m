From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: add a dummy ACPI RTC driver to handle BIOS's accesses to registers delcared in OperationRegion.
Date: Thu, 17 Jan 2013 14:34:06 +0100
Message-ID: <2246908.8S37bCFqXe@vostro.rjw.lan>
References: <1358306125-8104-1-git-send-email-alex.hung@canonical.com> <50F773B3.1030205@canonical.com> <94F2FBAB4432B54E8AACC7DFDE6C92E357E52057@ORSMSX101.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:43336 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751183Ab3AQN2N (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Jan 2013 08:28:13 -0500
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E357E52057@ORSMSX101.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Alex Hung <alex.hung@canonical.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thursday, January 17, 2013 05:12:24 AM Moore, Robert wrote:
> It is correct that ACPICA does not install a default handler for the SystemCMOS address space.
> 
> However, it is conceivable that we could add one.  It is a simple thing to do.

I think that would be better than adding it the way this patch does. :-)

Alternatively, we can just add an empty handler during the Linux-specific
initialization.

Thanks,
Rafael


> > -----Original Message-----
> > From: Alex Hung [mailto:alex.hung@canonical.com]
> > Sent: Wednesday, January 16, 2013 7:45 PM
> > To: Rafael J. Wysocki
> > Cc: Moore, Robert; lenb@kernel.org; linux-acpi@vger.kernel.org
> > Subject: Re: [PATCH] ACPI: add a dummy ACPI RTC driver to handle BIOS's
> > accesses to registers delcared in OperationRegion.
> > 
> > On 01/17/2013 07:02 AM, Rafael J. Wysocki wrote:
> > > On Wednesday, January 16, 2013 11:15:25 AM Alex Hung wrote:
> > >> This is to fix acpica returns an error and terminate AML execution as
> > >> soon as BIOS tries to access ACPI's RTC registers.
> > >>
> > >> BugLink: http://launchpad.net/bugs/1065066
> > >
> > > Can you please describe the problem in more detail in the changelog
> > itself?
> > > Providing a link to the bug report doesn't explain why you think this
> > > fix is the best possible one.  Which quite frankly I'm not sure of.
> > >
> > 
> > Hi,
> > 
> > Sure.
> > 
> > It is found that BIOS declared a RTC device with an OperationRegion as
> > below (1). When the BIOS executes accesses to the registers such as in
> > Method _Q33 in an EC (2), the kernel outputs messages (3) because there is
> > no handler for this OperationRegion. The patch is to create a handler to
> > avoid the errors in AML's execution.
> > 
> > (1)
> > Device (RTC)
> > {
> > 	Name (_HID, EisaId ("PNP0B00"))
> > 	...
> > 	OperationRegion (CMS0, SystemCMOS, Zero, 0x40)
> > 	Field (CMS0, ByteAcc, NoLock, Preserve)
> > 	{
> > 		RTSE,   8,
> > 			Offset (0x02),
> > 		RTMN,   8,
> > 			Offset (0x04),
> > 		RTHR,   8,
> > 			Offset (0x06),
> > 		RTDY,   8,
> > 		RTDE,   8
> > 	}
> > }
> > 
> > (2)
> > Method (_Q33, 0, NotSerialized)
> > {
> > 	Store (^^RTC.RTMN, Local0)
> > 	FromBCD (Local0, Local0)
> > 	Store (^^RTC.RTHR, Local1)
> > 	FromBCD (Local1, Local1)
> > 	Store (^^RTC.RTDY, Local2)
> > 	Store (^^RTC.RTSE, Local3)
> > 	...
> > }
> > 
> > (3)
> > [ 5553.247507] ACPI Error: No handler for Region [CMS0]
> > (ffff88023503b2d0) [SystemCMOS] (20121018/evregion-376)
> > [ 5553.247526] ACPI Error: Region SystemCMOS (ID=5) has no handler
> > (20121018/exfldio-305)
> > [ 5553.247545] ACPI Error: Method parse/execution failed
> > [\_SB_.PCI0.LPCB.EC0_._Q33] (Node ffff8802350609d8), AE_NOT_EXIST
> > (20121018/psparse-537)
> > [ 5553.247603] Failed to execute _Q33
> > 
> > 
> > >> Signed-off-by: Alex Hung <alex.hung@canonical.com>
> > >> ---
> > >>   drivers/acpi/Kconfig    |    9 +++
> > >>   drivers/acpi/Makefile   |    1 +
> > >>   drivers/acpi/acpi_rtc.c |  140
> > +++++++++++++++++++++++++++++++++++++++++++++++
> > >>   3 files changed, 150 insertions(+)
> > >>   create mode 100644 drivers/acpi/acpi_rtc.c
> > >>
> > >> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> > >> index 38c5078..fb90397 100644
> > >> --- a/drivers/acpi/Kconfig
> > >> +++ b/drivers/acpi/Kconfig
> > >> @@ -181,6 +181,15 @@ config ACPI_DOCK
> > >>   	  This driver supports ACPI-controlled docking stations and
> > removable
> > >>   	  drive bays such as the IBM Ultrabay and the Dell Module Bay.
> > >>
> > >> +config ACPI_RTC
> > >> +	tristate "RTC"
> > >> +	default m
> > >> +	help
> > >> +	  This driver supports an ACPI RTC device. It enables BIOS to read
> > and
> > >> +	  to write ACPI RTC registers declared in an OperationRegion with
> > >> +	  RegionSpace as SYSTEMCMOS. This is required if BIOS needs to
> > access
> > >> +	  RTC registers during run-time such as a number of HP laptops.
> > >> +
> > >>   config ACPI_I2C
> > >>   	def_tristate I2C
> > >>   	depends on I2C
> > >> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> > >> index 2a4502b..383c62b 100644
> > >> --- a/drivers/acpi/Makefile
> > >> +++ b/drivers/acpi/Makefile
> > >> @@ -71,6 +71,7 @@ obj-$(CONFIG_ACPI_EC_DEBUGFS)	+= ec_sys.o
> > >>   obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
> > >>   obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
> > >>   obj-$(CONFIG_ACPI_I2C)		+= acpi_i2c.o
> > >> +obj-$(CONFIG_ACPI_RTC)          += acpi_rtc.o
> > >>
> > >>   # processor has its own "processor." module_param namespace
> > >>   processor-y			:= processor_driver.o processor_throttling.o
> > >> diff --git a/drivers/acpi/acpi_rtc.c b/drivers/acpi/acpi_rtc.c
> > >> new file mode 100644
> > >> index 0000000..0ddcfc8
> > >> --- /dev/null
> > >> +++ b/drivers/acpi/acpi_rtc.c
> > >> @@ -0,0 +1,140 @@
> > >> +/*
> > >> + *  acpi_rtc - ACPI RTC Driver
> > >> + *
> > >> + *  Copyright (C) 2013 Alex Hung <alex.hung@canonical.com>
> > >> + *
> > >> + *
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >> + *
> > >> + *  This program is free software; you can redistribute it and/or
> > modify
> > >> + *  it under the terms of the GNU General Public License as published
> > by
> > >> + *  the Free Software Foundation; either version 2 of the License, or
> > (at
> > >> + *  your option) any later version.
> > >> + *
> > >> + *  This program is distributed in the hope that it will be useful,
> > but
> > >> + *  WITHOUT ANY WARRANTY; without even the implied warranty of
> > >> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > >> + *  General Public License for more details.
> > >> + *
> > >> + *  You should have received a copy of the GNU General Public License
> > along
> > >> + *  with this program; if not, write to the Free Software Foundation,
> > Inc.,
> > >> + *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
> > >> + *
> > >> + *
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >> + */
> > >> +
> > >> +#include <linux/kernel.h>
> > >> +#include <linux/module.h>
> > >> +#include <linux/init.h>
> > >> +#include <linux/pci.h>
> > >> +#include <linux/acpi.h>
> > >> +#include <acpi/acpi_bus.h>
> > >> +#include <acpi/acpi_drivers.h>
> > >> +#include <linux/miscdevice.h>
> > >> +
> > >> +#define pr_fmt(fmt) "acpi_rtc: " fmt
> > >> +
> > >> +MODULE_LICENSE("GPL");
> > >> +MODULE_ALIAS("acpi*:PNP0B00:*");
> > >> +
> > >> +static const struct acpi_device_id rtc_device_ids[] = {
> > >> +	{"PNP0B00", 0},
> > >> +	{"", 0},
> > >> +};
> > >> +
> > >> +static acpi_status acpi_acpi_handle_locate_callback(acpi_handle
> > handle,
> > >> +			u32 level, void *context, void **return_value)
> > >> +{
> > >> +	struct acpi_device *dev = context;
> > >> +	dev->handle = handle;
> > >> +
> > >> +	return AE_CTRL_TERMINATE;
> > >> +}
> > >> +
> > >> +static acpi_status
> > >> +acpi_rtc_space_handler(u32 function, acpi_physical_address address,
> > >> +		      u32 bits, u64 *value64,
> > >> +		      void *handler_context, void *region_context)
> > >> +{
> > >> +	return AE_OK;
> > >> +}
> > >> +
> > >> +static int rtc_install_handlers(struct acpi_device *rtc_dev)
> > >> +{
> > >> +	acpi_status status;
> > >> +	status = acpi_install_address_space_handler(rtc_dev->handle,
> > >> +						    ACPI_ADR_SPACE_CMOS,
> > >> +						    &acpi_rtc_space_handler,
> > >> +						    NULL, rtc_dev);
> > >> +	if (ACPI_FAILURE(status)) {
> > >> +		pr_info("Fail to install ACPI RTC handler\n");
> > >> +		return AE_ERROR;
> > >> +	}
> > >> +
> > >> +	return 0;
> > >> +}
> > >> +
> > >> +static int acpi_rtc_add(struct acpi_device *device)
> > >> +{
> > >> +	int ret;
> > >> +	acpi_status status;
> > >> +	acpi_handle rtc_dev;
> > >> +
> > >> +	status = acpi_get_devices(rtc_device_ids[0].id,
> > >> +				  acpi_acpi_handle_locate_callback,
> > >> +				  &rtc_dev, &rtc_dev);
> > >> +	if (!ACPI_SUCCESS(status))
> > >> +		return AE_NOT_FOUND;
> > >> +
> > >> +	ret = rtc_install_handlers((struct acpi_device *) &rtc_dev);
> > >> +
> > >> +	return ret;
> > >> +}
> > >> +
> > >> +static int acpi_rtc_remove(struct acpi_device *device, int type)
> > >> +{
> > >> +	acpi_status status;
> > >> +	status = acpi_remove_address_space_handler(device->handle,
> > >> +						   ACPI_ADR_SPACE_CMOS,
> > >> +						   &acpi_rtc_space_handler);
> > >> +	if (!ACPI_SUCCESS(status))
> > >> +		return AE_ERROR;
> > >> +
> > >> +	return AE_OK;
> > >> +}
> > >> +
> > >> +static struct acpi_driver acpi_rtc_driver = {
> > >> +	.name = "rtc",
> > >> +	.class = "ACPI_RTC_CLASS",
> > >> +	.ids = rtc_device_ids,
> > >> +	.ops = {
> > >> +		.add = acpi_rtc_add,
> > >> +		.remove = acpi_rtc_remove,
> > >> +		},
> > >> +};
> > >> +
> > >> +static int __init rtc_init(void)
> > >> +{
> > >> +	int err;
> > >> +
> > >> +	pr_info("Initializing ACPI RTC module\n");
> > >> +	err = acpi_bus_register_driver(&acpi_rtc_driver);
> > >> +	if (err) {
> > >> +		pr_err("Unable to register acpi driver.\n");
> > >> +		goto error_acpi_register;
> > >> +	}
> > >> +
> > >> +	return 0;
> > >> +
> > >> +error_acpi_register:
> > >> +
> > >> +	return err;
> > >> +}
> > >> +
> > >> +static void __exit rtc_exit(void)
> > >> +{
> > >> +	pr_info("Exiting ACPI RTC module\n");
> > >> +	acpi_bus_unregister_driver(&acpi_rtc_driver);
> > >> +}
> > >> +
> > >> +module_init(rtc_init);
> > >> +module_exit(rtc_exit);
> > >
> > > So all it does is to install an empty address space handler for the CMOS
> > > address space, right?
> > >
> > > Bob, I wonder what you think about that?
> > >
> > > Rafael
> > >
> > >
> 
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
