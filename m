From: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH] mfd: dln2: add support for ACPI
Date: Fri, 12 Dec 2014 14:49:23 +0200
Message-ID: <CAE1zotKz-ucZbMX_hospdEBGqKSdWKiy9jwr6O4SS-ZDthyxPA@mail.gmail.com>
References: <1418315527-19492-1-git-send-email-octavian.purdila@intel.com>
	<26284472.QRDfee3QOT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <26284472.QRDfee3QOT-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Heikki Krogerus <heikki.krogerus-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Dec 11, 2014 at 11:44 PM, Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org> wrote:
>
> On Thursday, December 11, 2014 06:32:07 PM Octavian Purdila wrote:
> > This patch adds support to load a custom ACPI table that describes
> > devices connected via the DLN2 USB to I2C/SPI/GPIO bridge.
> >
> > The ACPI table is loaded at runtime as firmware with the name
> > dln2.aml, it looks for an ACPI device entry with _HID set to
> > "DLN20000" and makes it the ACPI companion for DLN2 USB sub-drivers.
>
> Why?
>

Hi Rafael,

Thanks for the review.

We are using this so that we can describe the resources for I2C
sensors we connect to the I2C bridge (i.e. the I2C address and the
GPIO number).


> > It is sort of a hack due to the "../acpi/internal.h" and
> > "../usb/core/usb.h" includes and perhaps something more generic would
> > be more appropriate. Any suggestions to the right direction are kindly
> > appreciated.
> >
> > Signed-off-by: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > ---
> >  Documentation/acpi/dln2-acpi.txt |  48 ++++++++++++++++++
> >  drivers/mfd/Kconfig              |  11 +++++
> >  drivers/mfd/Makefile             |   1 +
> >  drivers/mfd/dln2-acpi.c          | 103 +++++++++++++++++++++++++++++++++++++++
> >  drivers/mfd/dln2.c               |   6 +--
> >  drivers/mfd/dln2.h               |   9 ++++
> >  6 files changed, 173 insertions(+), 5 deletions(-)
> >  create mode 100644 Documentation/acpi/dln2-acpi.txt
> >  create mode 100644 drivers/mfd/dln2-acpi.c
> >  create mode 100644 drivers/mfd/dln2.h
> >
> > diff --git a/Documentation/acpi/dln2-acpi.txt b/Documentation/acpi/dln2-acpi.txt
> > new file mode 100644
> > index 0000000..c099241
> > --- /dev/null
> > +++ b/Documentation/acpi/dln2-acpi.txt
> > @@ -0,0 +1,48 @@
> > +Diolan DLN2 custom APCI table
> > +
> > +The Diolan DLN2 is an USB to I2C/SPI/GPIO bridge and as such it can be used to
> > +connect to various I2C or SPI devices. Because these busses lack an enumeration
> > +protocol, the driver obtains various information about the device (such as I2C
> > +address and GPIO pins) from either ACPI or device tree.
> > +
> > +To allow using such devices connect to the DLN2 bridge to their full extend
> > +(e.g. interrupt mode), if CONFIG_MFD_DLN2_ACPI option has been compiled in the
> > +kernel, the user can define a custom ACPI table that will be dynamically loaded
> > +at boot time from firmware paths. The ACPI table filename must be dln2.aml and
> > +it must contain a root device with _HID set "DLN20000".
> > +
> > +Here is a example of how the ACPI table should look like:
> > +
> > +DefinitionBlock ("ssdt.aml", "SSDT", 1, "INTEL ", "CpuDptf", 0x00000003)
> > +{
> > +     Device (DLN0)
> > +     {
> > +             Name (_ADR, Zero)
> > +             Name (_HID, "DLN2000")
> > +
> > +             Device (STAC)
> > +             {
> > +                     Name (_ADR, Zero)
> > +                     Name (_HID, "BMC150A")
> > +                     Name (_CID, "INTACCL")
> > +                     Name (_UID, One)
> > +
> > +                     Method (_CRS, 0, Serialized)
> > +                     {
> > +                             Name (RBUF, ResourceTemplate ()
> > +                             {
> > +                                     I2cSerialBus (0x0010, ControllerInitiated, 0x00061A80,
> > +                                                   AddressingMode7Bit, "\\DLN0",
> > +                                                   0x00, ResourceConsumer, ,)
> > +
> > +                                     GpioInt (Level, ActiveHigh, Exclusive, PullDown, 0x0000,
> > +                                              "\\DLN0", 0x00, ResourceConsumer, , )
> > +                                     { // Pin list
> > +                                             0
> > +                                     }
> > +                             })
> > +                             Return (RBUF)
> > +                    }
> > +             }
> > +     }
> > +}
>
> Well, can you please explain here what the resources in the _CRS mean for
> this device?  How they are supposed to be used etc.
>

OK.

> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 2e6b731..b810195 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -205,6 +205,17 @@ config MFD_DLN2
> >         etc. must be enabled in order to use the functionality of
> >         the device.
> >
> > +config MFD_DLN2_ACPI
> > +     bool "Diolan DLN2 ACPI support"
> > +     depends on MFD_DLN2 && ACPI
> > +     default n
> > +     help
> > +       Say yes here to add ACPI support to DLN2 which allows loading a custom
> > +       ACPI table to describe devices between the DLN2 I2C or SPI bridge as
> > +       well as GPIO support for those devices. See
> > +       Documentation/acpi/dln2-acpi.txt for more information.
> > +
> > +
> >  config MFD_MC13XXX
> >       tristate
> >       depends on (SPI_MASTER || I2C)
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index 53467e2..dbe1f3f 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -176,6 +176,7 @@ obj-$(CONFIG_MFD_IPAQ_MICRO)      += ipaq-micro.o
> >  obj-$(CONFIG_MFD_MENF21BMC)  += menf21bmc.o
> >  obj-$(CONFIG_MFD_HI6421_PMIC)        += hi6421-pmic-core.o
> >  obj-$(CONFIG_MFD_DLN2)               += dln2.o
> > +obj-$(CONFIG_MFD_DLN2_ACPI)  += dln2-acpi.o
>
> First, why is this MFD at all?
>

The DLN2 devices are MFD based, since the same hardware supports I2C,
SPI, GPIO, etc. So I thought I would keep the ACPI option in the MFD
realm as well. If that is ill suited, what is something more
appropriate?

> >
> >  intel-soc-pmic-objs          := intel_soc_pmic_core.o intel_soc_pmic_crc.o
> >  obj-$(CONFIG_INTEL_SOC_PMIC) += intel-soc-pmic.o
> > diff --git a/drivers/mfd/dln2-acpi.c b/drivers/mfd/dln2-acpi.c
> > new file mode 100644
> > index 0000000..8c99769
> > --- /dev/null
> > +++ b/drivers/mfd/dln2-acpi.c
> > @@ -0,0 +1,103 @@
> > +#define pr_fmt(fmt) "dln2-acpi: " fmt
> > +
> > +#include <linux/module.h>
> > +#include <linux/usb.h>
> > +#include <linux/device.h>
> > +#include <linux/errno.h>
> > +#include <linux/kernel.h>
> > +#include <linux/acpi.h>
> > +#include <linux/firmware.h>
> > +#include "../acpi/internal.h"
> > +#include "../usb/core/usb.h"
> > +#include "dln2.h"
> > +
> > +static acpi_handle dln2_acpi_handle = NULL;
> > +static const struct firmware *dln2_acpi;
> > +
> > +static bool dln2_acpi_bus_match(struct device *dev)
> > +{
> > +     struct usb_interface *intf;
> > +     struct usb_device *udev;
> > +     u16 idVendor, idProduct;
> > +     int i;
> > +
> > +     if (is_usb_endpoint(dev) || !dev->parent ||
> > +         !is_usb_interface(dev->parent))
> > +             return false;
> > +
> > +     intf = to_usb_interface(dev->parent);
> > +     udev = interface_to_usbdev(intf);
> > +     idVendor = le16_to_cpu(udev->descriptor.idVendor);
> > +     idProduct = le16_to_cpu(udev->descriptor.idProduct);
> > +
> > +     for (i = 0; i < ARRAY_SIZE(dln2_table); i++)
> > +             if (idVendor == dln2_table[i].idVendor &&
> > +                 idProduct == dln2_table[i].idProduct)
> > +                     return true;
> > +
> > +     return false;
> > +}
> > +
> > +static struct acpi_device *dln2_acpi_find_companion(struct device *dev)
> > +{
> > +     struct acpi_device *adev;
> > +     int ret;
> > +
> > +     ret = acpi_bus_get_device(dln2_acpi_handle, &adev);
> > +     if (ret) {
> > +             pr_err("failed to get device: %d\n", ret);
> > +             return NULL;
> > +     }
> > +
> > +     return adev;
> > +}
> > +
> > +static struct acpi_bus_type dln2_acpi_bus = {
> > +     .name = "DNL2",
>
> "DLN2" surely?

Yep.

>
> > +     .match = dln2_acpi_bus_match,
> > +     .find_companion = dln2_acpi_find_companion,
> > +};
>
> Why do you need all this stuff?  Is there anything like a dln2 bus type?
>

No, but I will explain below.

> > +
> > +static acpi_status dln2_find_acpi_handle(acpi_handle handle, u32 level,
> > +                                      void *ctxt, void **retv)
> > +{
> > +     acpi_handle *dln2_handle = (acpi_handle *)retv;
> > +
> > +     *dln2_handle = handle;
> > +
> > +     return AE_CTRL_TERMINATE;
> > +}
> > +
> > +static int dln2_acpi_init(void)
> > +{
> > +     int ret;
> > +
> > +     request_firmware_direct(&dln2_acpi, "dln2.aml", NULL);
> > +     if (dln2_acpi) {
> > +             struct acpi_table_header *acpi_table = (void *)dln2_acpi->data;
> > +
> > +             ret = acpi_load_table(acpi_table);
> > +             if (ret) {
> > +                     pr_err("invalid ACPI table\n");
> > +                     release_firmware(dln2_acpi);
> > +             }
> > +     }
>
> You can return here already if dln2_acpi is NULL, can't you?
>

We can also load the ACPI table externally (via qemu for now).

> > +
> > +     acpi_get_devices("DLN20000", dln2_find_acpi_handle, NULL, &dln2_acpi_handle);
> > +     if (!dln2_acpi_handle)
> > +             return -ENODEV;
> > +
> > +     if (dln2_acpi)
> > +             acpi_bus_scan(dln2_acpi_handle);
> > +
> > +     return register_acpi_bus_type(&dln2_acpi_bus);
>
> It looks like you'd need a scan handler.
>

Sorry, you lost me here.


> > +}
> > +
> > +static void dln2_acpi_exit(void)
> > +{
>
> acpi_bus_trim(), anyone?  And no, it doesn't cause the device object to
> go away, so you can't really do the release_firmware() below.
>
> Conclusion: This can't be a module.
>

Hmm, ok. It can't be a module for other reasons too, is_usb_endpoint,
etc. are not exported symbols.

> > +     release_firmware(dln2_acpi);
> > +     unregister_acpi_bus_type(&dln2_acpi_bus);
> > +}
> > +
> > +module_init(dln2_acpi_init);
> > +module_exit(dln2_acpi_exit);
> > diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
> > index 08c403c..62120e7 100644
> > --- a/drivers/mfd/dln2.c
> > +++ b/drivers/mfd/dln2.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/mfd/core.h>
> >  #include <linux/mfd/dln2.h>
> >  #include <linux/rculist.h>
> > +#include "dln2.h"
> >
> >  struct dln2_header {
> >       __le16 size;
> > @@ -768,11 +769,6 @@ out_cleanup:
> >       return ret;
> >  }
> >
> > -static const struct usb_device_id dln2_table[] = {
> > -     { USB_DEVICE(0xa257, 0x2013) },
> > -     { }
> > -};
> > -
> >  MODULE_DEVICE_TABLE(usb, dln2_table);
> >
> >  static int dln2_suspend(struct usb_interface *iface, pm_message_t message)
> > diff --git a/drivers/mfd/dln2.h b/drivers/mfd/dln2.h
> > new file mode 100644
> > index 0000000..1ed4272
> > --- /dev/null
> > +++ b/drivers/mfd/dln2.h
> > @@ -0,0 +1,9 @@
> > +#ifndef _MFD_DLN2_H
> > +#define _MFD_DLN2_H
> > +
> > +static const struct usb_device_id dln2_table[] = {
> > +     { USB_DEVICE(0xa257, 0x2013) },
> > +     { }
> > +};
> > +
> > +#endif /* _MFD_DLN2_H */
>
> Can you explain to me in plain English what you actually want to achieve?
>
> I'm not really sure if my understanding of the above is correct, but it seems
> to me that it would be much more straightforward to check for the existence
> of the "DLN20000" device when you are about to register DLN2 USB sub-devices
> and set it directly as an ACPI companion for them if present.
>

Unfortunately we don't have access to the "struct device *"
sub-devices until it is too late. But I just noticed that ACPI support
for MFD was added in 3.18 and I think that is just what I need.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
