From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [PATCH 1/2] IPMI/ACPI: Locate the IPMI system interface in
	ACPI namespace
Date: Wed, 28 Oct 2009 10:50:48 +0800
Message-ID: <1256698248.12059.65.camel@localhost.localdomain>
References: <1256564026-9855-1-git-send-email-yakui.zhao@intel.com>
	 <200910260920.11124.bjorn.helgaas@hp.com>
	 <1256605375.3563.182.camel@localhost.localdomain>
	 <200910270938.42527.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:7907 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756354AbZJ1CwM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Oct 2009 22:52:12 -0400
In-Reply-To: <200910270938.42527.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "minyard@acm.org" <minyard@acm.org>, "lenb@kernel.org" <lenb@kernel.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, 2009-10-27 at 23:38 +0800, Bjorn Helgaas wrote:
> On Monday 26 October 2009 07:02:55 pm ykzhao wrote:
> > In fact you mention two issues about the two patches:
> >    1: Load a PNP driver for it to register the IPMI system interfac=
e.
> > This is about the first patch.
> >    2. coding style( for example: comments, the definition about som=
e
> > variables).
> >=20
> > For the first issue: Before I start the first patch, I consider usi=
ng
> > the PNP device driver. But I find that it is so complex because of =
the
> > following two points:
> >     1. One is that we can't register the IPMI system interface if t=
he
> > boot option of "pnpacpi=3Doff" is added. This will also depend on t=
he PNP
> > module.
>=20
> This is not a problem.  It is perfectly acceptable for the IPMI drive=
r
> to depend on PNP and PNPACPI in order to claim an ACPI device.  If th=
e
> users boots with "pnpacpi=3Doff", we just won't find an IPMI device.
> That is the way it works for TPM devices and serial devices described
> by ACPI, and IPMI should work the same way.
=EF=BB=BFYes. Several methods can be used to detect the IPMI system int=
erface.
In such case it still can be detected by using other method when the
ACPI detection mechanism is disabled. But the acpi detection mechanism
will depend on the ACPI and PNP subsystem if we detect the IMPI system
interface defined in ACPI table by using PNP device driver.=20

At the same time there exist two ACPI detection mechanisms. One is
defined in SPMI table. The other is defined in ACPI table. We expect
that the two ACPI detection mechanisms depend on the same judgement
condition.=20
So I prefer to detect the IPMI system interface when ACPI enabled
regardless of the boot option of "pnpacpi=3Doff".
>=20
> >     2. The second is that there exist so many cases about the IPMI
> > IO/memory resource definition. Maybe there exist both IO/memory res=
ource
> > definition for one IPMI device. In such case we can't know which sh=
ould
> > be selected. At the same time we have similar issues about the inte=
rrupt
> > type. So I decide to parse the IO/memory/interrupt resource
> > independently.
>=20
> This doesn't make any sense.  The fact that an IPMI device might have
> a variety of IO/memory/IRQ resources is orthogonal to the question of
> whether you should use pnp_register_driver() or acpi_walk_namespace()=
=2E
When we detect the IPMI system interface by loading PNP device driver,
the advantage is that it can re-use the parse mechanism of
IO/memory/interrupt. Right?
In fact we will have to evaluate the following ACPI object:
	>_IFT, _GPE, _SRV

If there exists the _GPE object, it is unnecessary to parse the resourc=
e
related with the interrupt.

At the same time as I mentioned in the previous email, sometimes we wil=
l
get the two different IO address definitions after evaluating the _CRS
object. Which should be selected?
If there exist both IO and memory address definition in _CRS object,
which should be selected?

> PNPACPI parses the IPMI device resources for every ACPI device,
> including the IPMI device, before we even know whether there will be
> a PNP driver for the device.  It's much easier to look at the PNP
> resources and figure out which to use than it is to use
> acpi_walk_resources() manually.
>=20
> The main point is that ipmi_si_intf.c is a device driver, and it shou=
ld
> use the normal driver registration mechanisms.  I think it would be
> simplest and clearest to make a few PNP enhancements so it could use
> pnp_register_driver(), but even using acpi_bus_register_driver() woul=
d
> be fine.  Using acpi_walk_namespace() to do everything by hand is jus=
t
> completely wrong.
The main purpose is to detect the IPMI system interface defined in ACPI
table.  If the device can be detected correctly, IMO it will be OK.

Why do think that it is wrong to use the acpi_walk_namespace to parse
the resource?

In the second patch it will register an ACPI device driver, which is
used to install the IPMI opregion space handler. After doing so, the
ACPI AML code can communicate with the IPMI system interface.

>=20
> Bjorn
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
