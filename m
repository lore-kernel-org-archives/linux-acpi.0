From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 1/2] IPMI/ACPI: Locate the IPMI system interface in
	ACPI namespace
Date: Tue, 27 Oct 2009 23:11:20 -0600
Message-ID: <1256706680.29099.7.camel@dc7800.home>
References: <1256564026-9855-1-git-send-email-yakui.zhao@intel.com>
	 <200910260920.11124.bjorn.helgaas@hp.com>
	 <1256605375.3563.182.camel@localhost.localdomain>
	 <200910270938.42527.bjorn.helgaas@hp.com>
	 <1256698248.12059.65.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:3648 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757272AbZJ1FPF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Oct 2009 01:15:05 -0400
In-Reply-To: <1256698248.12059.65.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: "minyard@acm.org" <minyard@acm.org>, "lenb@kernel.org" <lenb@kernel.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, 2009-10-28 at 10:50 +0800, ykzhao wrote:
> On Tue, 2009-10-27 at 23:38 +0800, Bjorn Helgaas wrote:
> > On Monday 26 October 2009 07:02:55 pm ykzhao wrote:
> > > In fact you mention two issues about the two patches:
> > >    1: Load a PNP driver for it to register the IPMI system interf=
ace.
> > > This is about the first patch.
> > >    2. coding style( for example: comments, the definition about s=
ome
> > > variables).
> > >=20
> > > For the first issue: Before I start the first patch, I consider u=
sing
> > > the PNP device driver. But I find that it is so complex because o=
f the
> > > following two points:
> > >     1. One is that we can't register the IPMI system interface if=
 the
> > > boot option of "pnpacpi=3Doff" is added. This will also depend on=
 the PNP
> > > module.
> >=20
> > This is not a problem.  It is perfectly acceptable for the IPMI dri=
ver
> > to depend on PNP and PNPACPI in order to claim an ACPI device.  If =
the
> > users boots with "pnpacpi=3Doff", we just won't find an IPMI device=
=2E
> > That is the way it works for TPM devices and serial devices describ=
ed
> > by ACPI, and IPMI should work the same way.
> =EF=BB=BFYes. Several methods can be used to detect the IPMI system i=
nterface.
> In such case it still can be detected by using other method when the
> ACPI detection mechanism is disabled. But the acpi detection mechanis=
m
> will depend on the ACPI and PNP subsystem if we detect the IMPI syste=
m
> interface defined in ACPI table by using PNP device driver.=20
>=20
> At the same time there exist two ACPI detection mechanisms. One is
> defined in SPMI table. The other is defined in ACPI table. We expect
> that the two ACPI detection mechanisms depend on the same judgement
> condition.=20
> So I prefer to detect the IPMI system interface when ACPI enabled
> regardless of the boot option of "pnpacpi=3Doff".

The IPMI driver is not special.  It should behave like all other
drivers.  There is no reason it should handle the "pnpacpi=3Doff" case
differently than other drivers.

But if you change this to use acpi_bus_register_driver(), there will be
no PNP dependency, "pnpacpi=3Doff" will have no effect either way, and
I'll be happy.  I don't think it's the cleanest solution, but it at
least gives us a chance to properly bind the driver to the device.

> > >     2. The second is that there exist so many cases about the IPM=
I
> > > IO/memory resource definition. Maybe there exist both IO/memory r=
esource
> > > definition for one IPMI device. In such case we can't know which =
should
> > > be selected. At the same time we have similar issues about the in=
terrupt
> > > type. So I decide to parse the IO/memory/interrupt resource
> > > independently.
> >=20
> > This doesn't make any sense.  The fact that an IPMI device might ha=
ve
> > a variety of IO/memory/IRQ resources is orthogonal to the question =
of
> > whether you should use pnp_register_driver() or acpi_walk_namespace=
().
> When we detect the IPMI system interface by loading PNP device driver=
,
> the advantage is that it can re-use the parse mechanism of
> IO/memory/interrupt. Right?
> In fact we will have to evaluate the following ACPI object:
> 	>_IFT, _GPE, _SRV
>=20
> If there exists the _GPE object, it is unnecessary to parse the resou=
rce
> related with the interrupt.
>=20
> At the same time as I mentioned in the previous email, sometimes we w=
ill
> get the two different IO address definitions after evaluating the _CR=
S
> object. Which should be selected?
> If there exist both IO and memory address definition in _CRS object,
> which should be selected?

You have to decide which address to use whether you learn the addresses
by using acpi_walk_resources() or by looking through the resources
decoded by PNPACPI.  Using acpi_walk_resources() doesn't make that
choice any easier.

> > PNPACPI parses the IPMI device resources for every ACPI device,
> > including the IPMI device, before we even know whether there will b=
e
> > a PNP driver for the device.  It's much easier to look at the PNP
> > resources and figure out which to use than it is to use
> > acpi_walk_resources() manually.
> >=20
> > The main point is that ipmi_si_intf.c is a device driver, and it sh=
ould
> > use the normal driver registration mechanisms.  I think it would be
> > simplest and clearest to make a few PNP enhancements so it could us=
e
> > pnp_register_driver(), but even using acpi_bus_register_driver() wo=
uld
> > be fine.  Using acpi_walk_namespace() to do everything by hand is j=
ust
> > completely wrong.
> The main purpose is to detect the IPMI system interface defined in AC=
PI
> table.  If the device can be detected correctly, IMO it will be OK.

It is important to detect the device.  It is also important to have a
mechanism to prevent two drivers from thinking they own the same device=
=2E

> Why do think that it is wrong to use the acpi_walk_namespace to parse
> the resource?

You're using acpi_walk_namespace() to locate the device, not to parse
the resources.  You use acpi_walk_resources() to parse the resources.

The fact that your patch uses acpi_walk_namespace() to find the
device means that ipmi_si_intf.c can be talking to a device, but the
rest of the system doesn't know ipmi_si_intf.c "owns" it.  So another
driver B could come along and correctly use acpi_bus_register_driver()
with the IPMI IDs.  The Linux ACPI core knows nothing about the fact
that ipmi_si_intf.c thinks it "owns" the IPMI device, so it will call
the driver B "add" method.  Now we have two drivers that both think
they own the device.  This leads to chaos.

Bjorn


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
