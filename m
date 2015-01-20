From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/4] mfd: dln2: add support for ACPI
Date: Tue, 20 Jan 2015 15:20:25 +0000
Message-ID: <20150120152025.GY13701@x1>
References: <1418746353-3481-1-git-send-email-octavian.purdila@intel.com>
 <1418746353-3481-4-git-send-email-octavian.purdila@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:42419 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518AbbATPUc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Jan 2015 10:20:32 -0500
Received: by mail-ie0-f176.google.com with SMTP id rd18so8380993iec.7
        for <linux-acpi@vger.kernel.org>; Tue, 20 Jan 2015 07:20:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1418746353-3481-4-git-send-email-octavian.purdila@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: linus.walleij@linaro.org, rjw@rjwysocki.net, johan@kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, heikki.krogerus@intel.com, mika.westerberg@linux.intel.com, linux-acpi@vger.kernel.org

I need an ACPI Ack on this.

> This patch adds support to load a custom ACPI table that describes
> devices connected via the DLN2 USB to I2C/SPI/GPIO bridge.
>=20
> The ACPI table can be loaded either externally (from QEMU or with
> CONFIG_ACPI_CUSTOM_DSDT) or it can be loaded as firmware file with th=
e
> name dln2.aml. The driver looks for an ACPI device entry with _HID se=
t
> to "DLN20000" and makes it the ACPI companion for DLN2 USB
> sub-drivers.
>=20
> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
> ---
>  Documentation/acpi/dln2-acpi.txt |  62 ++++++++++++++++++
>  drivers/mfd/dln2.c               | 134 +++++++++++++++++++++++++++++=
++++++++++
>  2 files changed, 196 insertions(+)
>  create mode 100644 Documentation/acpi/dln2-acpi.txt
>=20
> diff --git a/Documentation/acpi/dln2-acpi.txt b/Documentation/acpi/dl=
n2-acpi.txt
> new file mode 100644
> index 0000000..d76605f
> --- /dev/null
> +++ b/Documentation/acpi/dln2-acpi.txt
> @@ -0,0 +1,62 @@
> +Diolan DLN2 custom APCI table
> +
> +The Diolan DLN2 is an USB to I2C/SPI/GPIO bridge and as such it can =
be used to
> +connect to various I2C or SPI devices. Because these busses lack an =
enumeration
> +protocol, the driver obtains various information about the device (s=
uch as I2C
> +address and GPIO pins) from either ACPI or device tree.
> +
> +To allow enumerating devices and their properties via ACPI, the Diol=
an
> +driver looks for an ACPI tree with the root _HID set to "DLN20000". =
If
> +it finds such an ACPI object it will set the ACPI companion to the
> +DLN2 MFD driver and from their it will be propagated to all its
> +sub-devices (I2C, GPIO, SPI).
> +
> +The user can either load the custom DSDT table with three methods:
> +
> +1. Via QEMU (see -acpitable)
> +
> +2. Via the CONFIG_ACPI_CUSTOM_DSDT kernel config option (see
> +Documentation/acpi/dsdt-override.txt)
> +
> +3. By placing the custom DSDT in the firmware paths in a file name
> +dln2.aml.
> +
> +Here is an example ACPI table that enumerates a BMC150 accelerometer
> +and defines its I2C address and GPIO pin used as an interrupt source=
:
> +
> +DefinitionBlock ("ssdt.aml", "SSDT", 1, "INTEL ", "CpuDptf", 0x00000=
003)
> +{
> +	Device (DLN0)
> +	{
> +		Name (_ADR, Zero)
> +		Name (_HID, "DLN2000")
> +
> +		Device (STAC)
> +		{
> +			Name (_ADR, Zero)
> +			Name (_HID, "BMC150A")
> +			Name (_CID, "INTACCL")
> +			Name (_UID, One)
> +
> +			Method (_CRS, 0, Serialized)
> +			{
> +				Name (RBUF, ResourceTemplate ()
> +				{
> +					I2cSerialBus (0x0010, ControllerInitiated, 0x00061A80,
> +						      AddressingMode7Bit, "\\DLN0",
> +						      0x00, ResourceConsumer, ,)
> +
> +					GpioInt (Level, ActiveHigh, Exclusive, PullDown, 0x0000,
> +						 "\\DLN0", 0x00, ResourceConsumer, , )
> +					{ // Pin list
> +						0
> +					}
> +				})
> +				Return (RBUF)
> +		       }
> +		}
> +	}
> +}
> +
> +The resources defined in the devices under the DLN0 are those
> +supported by the I2C, GPIO and SPI sub-systems.
> diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
> index f9c4a0b..93f6d1d 100644
> --- a/drivers/mfd/dln2.c
> +++ b/drivers/mfd/dln2.c
> @@ -23,6 +23,8 @@
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/dln2.h>
>  #include <linux/rculist.h>
> +#include <linux/acpi.h>
> +#include <linux/firmware.h>
> =20
>  struct dln2_header {
>  	__le16 size;
> @@ -714,6 +716,134 @@ static void dln2_stop(struct dln2_dev *dln2)
> =20
>  	dln2_stop_rx_urbs(dln2);
>  }
> +
> +#if IS_ENABLED(CONFIG_ACPI)
> +
> +static struct dln2_acpi_info {
> +	const struct firmware *fw;
> +	acpi_owner_id table_id;
> +	struct acpi_device *dev;
> +	int users;
> +} dln2_acpi_info;
> +
> +static DEFINE_MUTEX(dln2_acpi_lock);
> +
> +static acpi_status dln2_find_acpi_handle(acpi_handle handle, u32 lev=
el,
> +					 void *ctxt, void **retv)
> +{
> +	acpi_handle *dln2_handle =3D (acpi_handle *)retv;
> +
> +	*dln2_handle =3D handle;
> +
> +	return AE_CTRL_TERMINATE;
> +}
> +
> +static void dln2_probe_acpi(struct dln2_dev *dln2)
> +{
> +	struct device *dev =3D &dln2->interface->dev;
> +	struct dln2_acpi_info *ai =3D &dln2_acpi_info;
> +	acpi_handle h =3D NULL;
> +	int ret;
> +	bool fw_loaded =3D false;
> +
> +	mutex_lock(&dln2_acpi_lock);
> +
> +	if (ai->dev)
> +		goto out_success;
> +
> +	/*
> +	 * Look for the DLN2000 HID in case the ACPI table was loaded
> +	 * externally (e.g. from qemu).
> +	 */
> +	acpi_get_devices("DLN20000", dln2_find_acpi_handle, NULL, &h);
> +	if (!h) {
> +		/* Try to load the ACPI table via a firmware file */
> +		ret =3D request_firmware(&ai->fw, "dln2.aml", NULL);
> +		if (ret)
> +			goto out_unlock;
> +
> +		ret =3D acpi_load_table((void *)ai->fw->data);
> +		if (ret) {
> +			dev_err(dev, "invalid ACPI table\n");
> +			goto out_release_fw;
> +		}
> +
> +		acpi_get_devices("DLN20000", dln2_find_acpi_handle, NULL, &h);
> +		if (!h) {
> +			dev_err(dev, "not a DLN2 ACPI table\n");
> +			goto out_leak_fw;
> +		}
> +
> +		ret =3D acpi_get_id(h, &ai->table_id);
> +		if (ret) {
> +			dev_err(dev, "acpi_get_id failed: %d\n", ret);
> +			goto out_leak_fw;
> +		}
> +
> +		ret =3D acpi_bus_scan(h);
> +		if (ret) {
> +			dev_err(dev, "acpi_bus_scan failed: %d\n", ret);
> +			goto out_leak_fw;
> +		}
> +
> +		fw_loaded =3D true;
> +	}
> +
> +	ret =3D acpi_bus_get_device(h, &ai->dev);
> +	if (ret) {
> +		dev_err(dev, "failed to get ACPI device: %d\n", ret);
> +		if (fw_loaded) {
> +			acpi_unload_table_id(ai->table_id);
> +			goto out_leak_fw;
> +		}
> +		goto out_unlock;
> +	}
> +
> +out_success:
> +	ACPI_COMPANION_SET(dev, ai->dev);
> +	ai->users++;
> +	mutex_unlock(&dln2_acpi_lock);
> +	return;
> +
> +out_release_fw:
> +	release_firmware(ai->fw);
> +out_leak_fw:
> +	/*
> +	 * Once a table is loaded we can't release the firmware anymore bec=
ause
> +	 * acpi_unload_table does not actually unload the table but keeps i=
t in
> +	 * memory to speed up subsequent loads.
> +	 */
> +	ai->fw =3D NULL;
> +out_unlock:
> +	mutex_unlock(&dln2_acpi_lock);
> +}
> +
> +static void dln2_disconnect_acpi(struct dln2_dev *dln2)
> +{
> +	struct dln2_acpi_info *ai =3D &dln2_acpi_info;
> +
> +	mutex_lock(&dln2_acpi_lock);
> +	if (--ai->users =3D=3D 0 && ai->fw) {
> +		acpi_scan_lock_acquire();
> +		acpi_bus_trim(ai->dev);
> +		acpi_scan_lock_release();
> +		acpi_unload_table_id(ai->table_id);
> +		ai->dev =3D NULL;
> +		/* we can't release firmware see comment in dln2_probe_acpi */
> +		ai->fw =3D NULL;
> +	}
> +	mutex_unlock(&dln2_acpi_lock);
> +}
> +#else
> +static void dln2_probe_acpi(struct dln2_dev *dln2)
> +{
> +}
> +
> +static void dln2_disconnect_acpi(struct dln2_dev *dln2)
> +{
> +}
> +#endif
> +
>  static void dln2_disconnect(struct usb_interface *interface)
>  {
>  	struct dln2_dev *dln2 =3D usb_get_intfdata(interface);
> @@ -722,6 +852,8 @@ static void dln2_disconnect(struct usb_interface =
*interface)
> =20
>  	mfd_remove_devices(&interface->dev);
> =20
> +	dln2_disconnect_acpi(dln2);
> +
>  	dln2_free(dln2);
>  }
> =20
> @@ -774,6 +906,8 @@ static int dln2_probe(struct usb_interface *inter=
face,
>  		goto out_stop_rx;
>  	}
> =20
> +	dln2_probe_acpi(dln2);
> +
>  	ret =3D mfd_add_hotplug_devices(dev, dln2_devs, ARRAY_SIZE(dln2_dev=
s));
>  	if (ret !=3D 0) {
>  		dev_err(dev, "failed to add mfd devices to core\n");
> --=20
> 1.9.1
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
