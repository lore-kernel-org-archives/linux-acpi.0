From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] ACPI: suppress compiler warnings
Date: Mon, 11 Mar 2013 11:20:37 +0200
Message-ID: <1362993637.28241.179.camel@smile>
References: <1362748991-17863-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <2201683.kMNYfgVRi1@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:27344 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752861Ab3CKJUz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Mar 2013 05:20:55 -0400
In-Reply-To: <2201683.kMNYfgVRi1@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org

On Mon, 2013-03-11 at 04:31 +0100, Rafael J. Wysocki wrote:=20
> On Friday, March 08, 2013 03:23:11 PM Andy Shevchenko wrote:
> > This patch fixes following compiler warnings:
> >=20
> > drivers/acpi/csrt.c:135:116: warning: no previous prototype for =E2=
=80=98acpi_csrt_init=E2=80=99 [-Wmissing-prototypes]
> >=20
> > drivers/acpi/container.c:183:116: warning: no previous prototype fo=
r =E2=80=98acpi_container_init=E2=80=99 [-Wmissing-prototypes]
> >=20
> > drivers/pci/pcie/portdrv_acpi.c:34:5: warning: no previous prototyp=
e for =E2=80=98pcie_port_acpi_setup=E2=80=99 [-Wmissing-prototypes]
> >=20
> > drivers/acpi/battery.c:149:52: warning: no previous prototype for =E2=
=80=98acpi_battery_present=E2=80=99 [-Wmissing-prototypes]
> >=20
> > drivers/acpi/button.c:220:5: warning: no previous prototype for =E2=
=80=98acpi_lid_notifier_register=E2=80=99 [-Wmissing-prototypes]
> > drivers/acpi/button.c:226:5: warning: no previous prototype for =E2=
=80=98acpi_lid_notifier_unregister=E2=80=99 [-Wmissing-prototypes]
> > drivers/acpi/button.c:232:5: warning: no previous prototype for =E2=
=80=98acpi_lid_open=E2=80=99 [-Wmissing-prototypes]
> >=20
> > drivers/acpi/processor_throttling.c: In function =E2=80=98acpi_proc=
essor_throttling_init=E2=80=99:
> > drivers/acpi/processor_throttling.c:216:40: warning: suggest braces=
 around empty body in an =E2=80=98if=E2=80=99 statement [-Wempty-body]
> >=20
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> Please split this into separate per-file patches.

Done.

> Also it would be good to know what config options are triggering the =
warnings
> in each case.

You mean 'compiler option', do you?
Anyway, please, review patch v2 series.


--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
