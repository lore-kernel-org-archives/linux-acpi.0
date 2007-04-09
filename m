From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [Help] "Error attaching device data"
Date: Mon, 9 Apr 2007 10:44:18 +0800
Message-ID: <823A93EED437D048963A3697DB0E35DE16B671@pdsmsx414.ccr.corp.intel.com>
References: <1175169645.2908.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:35059 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752345AbXDICod convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 8 Apr 2007 22:44:33 -0400
Content-class: urn:content-classes:message
In-Reply-To: <1175169645.2908.1.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: conke.hu@gmail.com
Cc: linux-acpi@vger.kernel.org

Hi, Conke,
Please file a bug report at bugzilla.kernel.org, and attach the acpidum=
p file there.

Thanks,
Zhang.Rui(Ray)

=20
-----Original Message-----
=46rom: Conke Hu [mailto:conke.hu@gmail.com]=20
Sent: 2007=C4=EA3=D4=C229=C8=D5 20:01
To: Zhang, Rui
Cc: linux-acpi@vger.kernel.org
Subject: RE: [Help] "Error attaching device data"

On Thu, 2007-03-29 at 17:19 +0800, Zhang, Rui wrote:
> Does the problem still exists in the latest kernel? Say 2.6.21-rc5.
> It will be helpful if you can attach your acpidump file.=20
>=20
> Best regards,
> Zhang.Rui(Ray)
>=20
> =20
> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.=
kernel.org] On Behalf Of Conke Hu
> Sent: 2007=C4=EA3=D4=C229=C8=D5 17:05
> To: linux-acpi@vger.kernel.org
> Subject: [Help] "Error attaching device data"
>=20
> Hi all,
>     I am idiot on ACPI knowing nothing about it :)
>     When I boot linux on AMD Athlon64x2 + A690G + SB600 platform, I g=
et
> 2 lines of error message saying "Error attaching device data", pls se=
e
> the attachment. I've tested on kernels 2.6.18 ~ 2.6.20, and each of t=
hem
> has the same error.
>     I debug the drivers/acpi/scan.c and find the error message is dum=
ped
> by the following code. and type =3D=3D ACPI_BUS_TYPE_PROCESSOR, statu=
s =3D=3D
> AE_ALREADY_EXISTS.=20
>     There are 2 error lines in dmesg because, I think, I use a dual c=
ore
> CPU.
>     Any suggestion is very thankful!
>=20
>=20
> static int acpi_device_set_context(struct acpi_device *device, int ty=
pe)
> {
>     acpi_status status =3D AE_OK;
>     int result =3D 0;
>     /*
>      * Context
>      * -------
>      * Attach this 'struct acpi_device' to the ACPI object.  This mak=
es
>      * resolutions from handle->device very efficient.  Note that we
> need
>      * to be careful with fixed-feature devices as they all attach to
> the
>      * root object.
>      */
>     if (type !=3D ACPI_BUS_TYPE_POWER_BUTTON &&
>         type !=3D ACPI_BUS_TYPE_SLEEP_BUTTON) {
>         status =3D acpi_attach_data(device->handle,
>                       acpi_bus_data_handler, device);
>=20
>         if (ACPI_FAILURE(status)) {
>             printk("Error attaching device data\n");
>             result =3D -ENODEV;
>         }
>     }
>     return result;
> }
>   =20
>    =20
>    =20

the attachment is acpidump file, thanks!
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
