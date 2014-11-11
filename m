From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 0/3] Support PMIC operation region for CrystalCove and
 XPower
Date: Tue, 11 Nov 2014 11:11:52 +0000
Message-ID: <20141111111152.GX24004@x1>
References: <1414735705-18366-1-git-send-email-aaron.lu@intel.com>
 <54616E55.80204@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54616E55.80204@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, 11 Nov 2014, Aaron Lu wrote:

> On 10/31/2014 02:08 PM, Aaron Lu wrote:
> > On Intel Baytrail-T and Baytrail-T-CR platforms, there are two cust=
omized
> > ACPI operation regions defined for the Power Management Integrated =
Circuit
> > device, one is for power resource handling and one is for thermal: =
sensor
> > temperature reporting, trip point setting, etc. There are different=
 PMIC
> > chips used on those platforms and though each has the same two oper=
ation
> > regions and functionality, their implementation is different so eve=
ry PMIC
> > will need a driver. But since their functionality is similar, some =
common
> > code is abstracted into the intel_soc_pmic_opregion.c.
> >=20
> > The last version is posted here:
> > https://lkml.org/lkml/2014/9/8/801
> >=20
> > Changes since then:
> > 1 Move to drivers/acpi as discussed on the above thread;
> > 2 Added support for XPower AXP288 PMIC operation region support;
> > 3 Since operation region handler can not be removed(at the moment a=
t least),
> >   use bool for the two operation region driver configs instead of t=
ristate;
> >   Another reason to do this is that, with Mika's MFD ACPI support p=
atch, all
> >   those MFD cell devices created will have the same modalias as the=
ir parent's
> >   so it doesn't make much sense to compile these drivers into modul=
es.
> >=20
> > Patch 1 applies on top of Rafael's pm-next branch, and then patch 2=
 and
> > patch 3 needs merge of Lee's mfd/ib-mfd-iio-3.19 branch where the P=
MIC
> > driver XPower AXP288 and iio driver axp288_adc is located.
>=20
> Since patch 2-3 are based on top of the mfd/ib-mfd-iio-3.19 branch, i=
t
> would be easy to go through the mfd/ib-mfd-iio-3.19 branch.
>=20
> Rafael,
> Can I get your ACK for the three patches?
>=20
> Lee,
> Can you please take the series if Rafael gives it ack?

Yes, no problem.

> > Aaron Lu (3):
> >   ACPI / pmic_opregion: support PMIC operation region for CrystalCo=
ve
> >   ACPI / pmic_opregion: support PMIC operation region for XPower AX=
P288
> >   ACPI / pmic_opregion: AXP288: support virtual GPIO in ACPI table
> >=20
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
