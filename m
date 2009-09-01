From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH V6 2/2] introduce ACPI ALS device driver
Date: Tue, 01 Sep 2009 16:39:36 +0800
Message-ID: <1251794376.3483.238.camel@rzhang-dt>
References: <1251789956.3483.216.camel@rzhang-dt>
	 <20090901081342.GB9942@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:29628 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751400AbZIAIln (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Sep 2009 04:41:43 -0400
In-Reply-To: <20090901081342.GB9942@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Greg KH <greg@kroah.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Tue, 2009-09-01 at 16:13 +0800, Pavel Machek wrote:
> Hi!
>=20
> > ACPI spec defines ACPI Ambient Light Sensor device (hid ACPI0008),
> > which provides a standard interface by which the OS may query prope=
rties
> > of the ambient light environment the system is currently operating =
in,
> > as well as the ability to detect meaningful changes in these values=
 when
> > the environment changes.
>=20
> > +struct acpi_als {
> > +	struct acpi_device *device;
> > +	struct als_device *als_sys;
> > +	int illuminance;
> > +	int chromaticity;
> > +	int temperature;
> > +	int polling;
> > +	int count;
> > +	struct als_mapping *mappings;
> > +};
>=20
> chromaticity is write-only variable.

>  I believe you can drop it and
> associted code.
>=20
> temperature ditto. Drop from this version?
>=20
> polling ditto. Drop from this version?
>=20
=EF=BB=BFcolor temperature, chromaticity and polling are three optional=
 features
defined in the ACPI spec, which are not supported yet in the ACPI ALS
driver right now.

I think it's okay to add the code first and then generate some
incremental patches to enable these features once we found such kind of
platforms.

thanks,
rui


> Thanks,
> 									Pavel

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
