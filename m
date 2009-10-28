From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 1/2] IPMI/ACPI: Locate the IPMI system interface
	in	ACPI namespace
Date: Wed, 28 Oct 2009 10:49:24 -0600
Message-ID: <1256748564.30701.7.camel@dc7800.home>
References: <1256564026-9855-1-git-send-email-yakui.zhao@intel.com>
	 <200910260920.11124.bjorn.helgaas@hp.com>
	 <1256605375.3563.182.camel@localhost.localdomain>
	 <200910270938.42527.bjorn.helgaas@hp.com>
	 <1256698248.12059.65.camel@localhost.localdomain>
	 <1256706680.29099.7.camel@dc7800.home>
	 <1256723487.12059.88.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:26396 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754658AbZJ1QxL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Oct 2009 12:53:11 -0400
In-Reply-To: <1256723487.12059.88.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: "minyard@acm.org" <minyard@acm.org>, "lenb@kernel.org" <lenb@kernel.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, 2009-10-28 at 17:51 +0800, ykzhao wrote:
> On Wed, 2009-10-28 at 13:11 +0800, Bjorn Helgaas wrote:
> > On Wed, 2009-10-28 at 10:50 +0800, ykzhao wrote:
> > > On Tue, 2009-10-27 at 23:38 +0800, Bjorn Helgaas wrote:
> > > > On Monday 26 October 2009 07:02:55 pm ykzhao wrote:
> > > > > In fact you mention two issues about the two patches:
> > > > >    1: Load a PNP driver for it to register the IPMI system in=
terface.
> > > > > This is about the first patch.
> > > > >    2. coding style( for example: comments, the definition abo=
ut some
> > > > > variables).
> > > > >=20
> > > > > For the first issue: Before I start the first patch, I consid=
er using
> > > > > the PNP device driver. But I find that it is so complex becau=
se of the
> > > > > following two points:
> > > > >     1. One is that we can't register the IPMI system interfac=
e if the
> > > > > boot option of "pnpacpi=3Doff" is added. This will also depen=
d on the PNP
> > > > > module.
> > > >=20
> > > > This is not a problem.  It is perfectly acceptable for the IPMI=
 driver
> > > > to depend on PNP and PNPACPI in order to claim an ACPI device. =
 If the
> > > > users boots with "pnpacpi=3Doff", we just won't find an IPMI de=
vice.
> > > > That is the way it works for TPM devices and serial devices des=
cribed
> > > > by ACPI, and IPMI should work the same way.
> > > =EF=BB=BFYes. Several methods can be used to detect the IPMI syst=
em interface.
> > > In such case it still can be detected by using other method when =
the
> > > ACPI detection mechanism is disabled. But the acpi detection mech=
anism
> > > will depend on the ACPI and PNP subsystem if we detect the IMPI s=
ystem
> > > interface defined in ACPI table by using PNP device driver.=20
> > >=20
> > > At the same time there exist two ACPI detection mechanisms. One i=
s
> > > defined in SPMI table. The other is defined in ACPI table. We exp=
ect
> > > that the two ACPI detection mechanisms depend on the same judgeme=
nt
> > > condition.=20
> > > So I prefer to detect the IPMI system interface when ACPI enabled
> > > regardless of the boot option of "pnpacpi=3Doff".
> >=20
> > The IPMI driver is not special.  It should behave like all other
> > drivers.  There is no reason it should handle the "pnpacpi=3Doff" c=
ase
> > differently than other drivers.
> >=20
> > But if you change this to use acpi_bus_register_driver(), there wil=
l be
> > no PNP dependency, "pnpacpi=3Doff" will have no effect either way, =
and
> > I'll be happy.  I don't think it's the cleanest solution, but it at
> > least gives us a chance to properly bind the driver to the device.
> This patch set includes two parts. One is to detect the IPMI system
> interface defined in ACPI table and register it. The other is to allo=
w
> the ACPI AML code to communicate with the IPMI system interface.=20
>=20
> As an device driver is already bound to the device in the second patc=
h,
> it is impossible that we load another device driver for the same IPMI
> device.

I know.  That's why in my original responses a month ago, I suggested
that you integrate these two parts.  From the Linux point of view, one
piece of hardware gets one driver.  If you need two parts internally,
that's an implementation concern of the driver.  From the point of view
of the Linux/ACPI and PNP code, there must be a single driver.

> > > > >     2. The second is that there exist so many cases about the=
 IPMI
> > > > > IO/memory resource definition. Maybe there exist both IO/memo=
ry resource
> > > > > definition for one IPMI device. In such case we can't know wh=
ich should
> > > > > be selected. At the same time we have similar issues about th=
e interrupt
> > > > > type. So I decide to parse the IO/memory/interrupt resource
> > > > > independently.
> > > >=20
> > > > This doesn't make any sense.  The fact that an IPMI device migh=
t have
> > > > a variety of IO/memory/IRQ resources is orthogonal to the quest=
ion of
> > > > whether you should use pnp_register_driver() or acpi_walk_names=
pace().
> > > When we detect the IPMI system interface by loading PNP device dr=
iver,
> > > the advantage is that it can re-use the parse mechanism of
> > > IO/memory/interrupt. Right?
> > > In fact we will have to evaluate the following ACPI object:
> > > 	>_IFT, _GPE, _SRV
> > >=20
> > > If there exists the _GPE object, it is unnecessary to parse the r=
esource
> > > related with the interrupt.
> > >=20
> > > At the same time as I mentioned in the previous email, sometimes =
we will
> > > get the two different IO address definitions after evaluating the=
 _CRS
> > > object. Which should be selected?
> > > If there exist both IO and memory address definition in _CRS obje=
ct,
> > > which should be selected?
> >=20
> > You have to decide which address to use whether you learn the addre=
sses
> > by using acpi_walk_resources() or by looking through the resources
> > decoded by PNPACPI.  Using acpi_walk_resources() doesn't make that
> > choice any easier.
> >=20
> > > > PNPACPI parses the IPMI device resources for every ACPI device,
> > > > including the IPMI device, before we even know whether there wi=
ll be
> > > > a PNP driver for the device.  It's much easier to look at the P=
NP
> > > > resources and figure out which to use than it is to use
> > > > acpi_walk_resources() manually.
> > > >=20
> > > > The main point is that ipmi_si_intf.c is a device driver, and i=
t should
> > > > use the normal driver registration mechanisms.  I think it woul=
d be
> > > > simplest and clearest to make a few PNP enhancements so it coul=
d use
> > > > pnp_register_driver(), but even using acpi_bus_register_driver(=
) would
> > > > be fine.  Using acpi_walk_namespace() to do everything by hand =
is just
> > > > completely wrong.
> > > The main purpose is to detect the IPMI system interface defined i=
n ACPI
> > > table.  If the device can be detected correctly, IMO it will be O=
K.
> >=20
> > It is important to detect the device.  It is also important to have=
 a
> > mechanism to prevent two drivers from thinking they own the same de=
vice.
> >=20
> > > Why do think that it is wrong to use the acpi_walk_namespace to p=
arse
> > > the resource?
> >=20
> > You're using acpi_walk_namespace() to locate the device, not to par=
se
> > the resources.  You use acpi_walk_resources() to parse the resource=
s.
> Is it wrong to use acpi_walk_namespace to locate the device?

Yes, for the reason I explained below.  To repeat myself, you must use
acpi_bus_register_driver() (or pnp_register_driver()) so we can prevent
multiple drivers from claiming the same piece of hardware.

[There is an existing PNPACPI problem in that I think we currently allo=
w
a driver using acpi_bus_register_driver() and a driver using
pnp_register_driver() to both claim the same device.  But this is an
existing issue with the Linux/ACPI and PNPACPI core, not with the
drivers themselves.]

> Why we can't use the acpi_walk_resources directly to parse the
> corresponding resource?

You can.  I think it would be easier in the long run to rely on the
resource parsing done by PNPACPI, but you can use acpi_walk_resources()
if you want to.

> > The fact that your patch uses acpi_walk_namespace() to find the
> > device means that ipmi_si_intf.c can be talking to a device, but th=
e
> > rest of the system doesn't know ipmi_si_intf.c "owns" it.  So anoth=
er
> > driver B could come along and correctly use acpi_bus_register_drive=
r()
> > with the IPMI IDs.  The Linux ACPI core knows nothing about the fac=
t
> > that ipmi_si_intf.c thinks it "owns" the IPMI device, so it will ca=
ll
> > the driver B "add" method.  Now we have two drivers that both think
> > they own the device.  This leads to chaos.
> Why is it necessary that the reset of the system doesn't know
> ipmi_si_intf.c "owns" the IPMI system interface?

Using acpi_bus_register_driver() lets the Linux/ACPI core make sure tha=
t
only a single driver is bound to the device.  If two drivers bind to it=
,
they will interfere with each other.

Bjorn


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
