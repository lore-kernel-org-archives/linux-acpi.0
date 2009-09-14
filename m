From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH v4] topstar-laptop: add new driver for hotkeys support on Topstar N01
Date: Mon, 14 Sep 2009 09:01:30 -0600
Message-ID: <200909140901.31510.bjorn.helgaas@hp.com>
References: <200909092102.22152.herton@mandriva.com.br> <200909101702.54249.bjorn.helgaas@hp.com> <200909120155.45521.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:15122 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbZINPBa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Sep 2009 11:01:30 -0400
In-Reply-To: <200909120155.45521.herton@mandriva.com.br>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Cc: linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Alan Jenkins <sourcejedi.lkml@googlemail.com>, Corentin Chary <corentin.chary@gmail.com>

On Friday 11 September 2009 10:55:45 pm Herton Ronaldo Krzesinski wrote=
:
> Em Qui 10 Set 2009, =E0s 20:02:53, Bjorn Helgaas escreveu:

> > > +	ret =3D acpi_bus_register_driver(&acpi_topstar_driver);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	if (!found_tps_dev) {
> >=20
> > Why do we need this check to see if we found a device?  This box
> > nicely supplies a device with a _HID, so we should get a udev
> > event requesting a driver for TPSACPI01, and that is what should
> > cause this driver to be loaded.
>=20
> It's needed because someone can modprobe the module manually in a mac=
hine that
> doesn't have TPSACPI01, and acpi_bus_register_driver doesn't fail in =
this case,
> so the additional check (I want ENODEV to be returned).

I don't think there's any reason to have extra code in the driver to
deal with this case.  If a user manually modprobes a driver, and the
driver doesn't claim any devices, it's very typical for the driver
to remain loaded.

In my opinion, it's better to have consistency in that behavior than
to try to help the user recover from a mistaken manual modprobe.

Bjorn

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
