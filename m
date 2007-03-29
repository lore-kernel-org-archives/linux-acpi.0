From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [Help] "Error attaching device data"
Date: Thu, 29 Mar 2007 17:19:01 +0800
Message-ID: <58A36151585E4047913F40517D307BAE43BE25@pdsmsx404.ccr.corp.intel.com>
References: <1175159110.2901.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:18359 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753208AbXC2JTE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Mar 2007 05:19:04 -0400
Content-class: urn:content-classes:message
In-Reply-To: <1175159110.2901.22.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: conke.hu@gmail.com, linux-acpi@vger.kernel.org

Does the problem still exists in the latest kernel? Say 2.6.21-rc5.
It will be helpful if you can attach your acpidump file.=20

Best regards,
Zhang.Rui(Ray)

=20
-----Original Message-----
=46rom: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.=
kernel.org] On Behalf Of Conke Hu
Sent: 2007=C4=EA3=D4=C229=C8=D5 17:05
To: linux-acpi@vger.kernel.org
Subject: [Help] "Error attaching device data"

Hi all,
    I am idiot on ACPI knowing nothing about it :)
    When I boot linux on AMD Athlon64x2 + A690G + SB600 platform, I get
2 lines of error message saying "Error attaching device data", pls see
the attachment. I've tested on kernels 2.6.18 ~ 2.6.20, and each of the=
m
has the same error.
    I debug the drivers/acpi/scan.c and find the error message is dumpe=
d
by the following code. and type =3D=3D ACPI_BUS_TYPE_PROCESSOR, status =
=3D=3D
AE_ALREADY_EXISTS.=20
    There are 2 error lines in dmesg because, I think, I use a dual cor=
e
CPU.
    Any suggestion is very thankful!


static int acpi_device_set_context(struct acpi_device *device, int type=
)
{
    acpi_status status =3D AE_OK;
    int result =3D 0;
    /*
     * Context
     * -------
     * Attach this 'struct acpi_device' to the ACPI object.  This makes
     * resolutions from handle->device very efficient.  Note that we
need
     * to be careful with fixed-feature devices as they all attach to
the
     * root object.
     */
    if (type !=3D ACPI_BUS_TYPE_POWER_BUTTON &&
        type !=3D ACPI_BUS_TYPE_SLEEP_BUTTON) {
        status =3D acpi_attach_data(device->handle,
                      acpi_bus_data_handler, device);

        if (ACPI_FAILURE(status)) {
            printk("Error attaching device data\n");
            result =3D -ENODEV;
        }
    }
    return result;
}
  =20
   =20
   =20
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
