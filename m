From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [12/12] acpi: set fake hid
Date: Mon, 25 Sep 2006 17:31:22 +0800
Message-ID: <1159176682.5351.11.camel@localhost.localdomain>
References: <1158918880.11985.88.camel@localhost.localdomain>
	 <4513D02A.8020106@kolumbus.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22618 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1750817AbWIYJ3z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Sep 2006 05:29:55 -0400
In-Reply-To: <4513D02A.8020106@kolumbus.fi>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika =?ISO-8859-1?Q?Penttil=E4?= <mika.penttila@kolumbus.fi>
Cc: linux-acpi@vger.kernel.org, len.brown@intel.com, shaohua.li@intel.com

On Fri, 2006-09-22 at 14:59 +0300, Mika Penttil=C3=A4 wrote:=20
> +static int acpi_pci_bridge_match(struct acpi_device *device)
> +{
> +       acpi_status status;
> +       acpi_handle handle;
> +
> +       /* pci bridge has _PRT but isn't PNP0A03 */
> +       status =3D acpi_get_handle(device->handle, METHOD_NAME__PRT, =
&handle);
> +       if (ACPI_FAILURE(status))
> +               return -ENODEV;
> +       if (!acpi_match_ids(device, "PNP0A03"))
> +               return -ENODEV;
> +       return 0;
> +}
> +
>=20
>=20
> You seem to handle pci-pci bridge here incorrectly (returns -ENODEV f=
rom match to PNP0A03)
>
Is there any pci-pci bridge that has a _HID of "PNP0A03"?

thanks,
--Rui
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
