From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [PATCH_v7 2/2] ACPI/IPMI: Add the IPMI opregion driver to
	enable ACPI to access BMC controller
Date: Mon, 19 Jul 2010 09:52:28 +0800
Message-ID: <1279504348.3660.140.camel@localhost.localdomain>
References: <1279112094-16749-1-git-send-email-yakui.zhao@intel.com>
	 <201007151027.30025.bjorn.helgaas@hp.com>
	 <1279247675.3660.104.camel@localhost.localdomain>
	 <201007161001.21956.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46248 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757999Ab0GSB4J (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 18 Jul 2010 21:56:09 -0400
In-Reply-To: <201007161001.21956.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "minyard@acm.org" <minyard@acm.org>

On Sat, 2010-07-17 at 00:01 +0800, Bjorn Helgaas wrote:
> On Thursday, July 15, 2010 08:34:35 pm ykzhao wrote:
> > On Fri, 2010-07-16 at 00:27 +0800, Bjorn Helgaas wrote:
> > > On Wednesday, July 14, 2010 07:31:06 pm ykzhao wrote:
> > > > On Thu, 2010-07-15 at 01:24 +0800, Bjorn Helgaas wrote:
> > > > Will you please look at this thread
> > > > http://marc.info/?l=3Dlinux-acpi&m=3D127608894610765&w=3D4?
> > > >=20
> > > > Before this patch, I followed your comment and put the ACPI IPM=
I
> > > > opregion code into the IPMI_SI module.=20
> > > >=20
> > > > But in fact the IPMI opregion code has nothing to do with the i=
pmi
> > > > system interface. It is enough to use the IPMI API interface. I=
n such
> > > > case maybe it is a better choice to put the IPMI opregion code =
into the
> > > > separate file. (In fact Corey suggests that the IPMI opregion c=
ode be
> > > > put into the separate file).=20
> > >=20
> > > The ACPI IPMI opregion code deals with an ACPI device, and the
> > > obvious place where you have that device is the driver "add"
> > > function, i.e., ipmi_pnp_probe().  That's the point where the
> > > PNP core will help you out by matching device IDs and handling
> > > hotplug for you.
> >=20
> > The "IPI0001" device defined in ACPI table serves the following two
> > purposes:
> >  	1. IPMI detection and registration: This is defined in IPMI spec.=
 Now
> > it is discovered in the drivers/char/ipmi/ipmi_si_intf
> >         2. IPMI opregion support: This is defined in ACPI4.0 spec.T=
his
> > is to enable that the ACPI AML code can communicate with the BMC
> > controller.=20
> >=20
> > Yes. If we put the opregion code with the detection code together, =
it
> > will be simple. And it is unnecessary to get the corresponding devi=
ce
> > list again. But as the IPMI opregion code only uses the API interfa=
ce of
> > IPMI subsystem, it will be better to put it into the separate file.=
 In
> > fact this is also Corey's idea.
>=20
> I don't care if you put it in a separate file.  My only point is that
> you shouldn't try to duplicate the device discovery that's already
> done in the PNP core.
>=20
> > Yes. The hotplug scenario should be considered. This will be handle=
d
> > under two places:
> >    a. the IPMI pnp detection:=20
> >    b. install opregion handle for the hotplug IPI0001 device
> >=20
> > But in fact the acpi_pnp device is enumerated only once at the boot
> > time.
>=20
> Drivers cannot rely on anything like "the acpi_pnp device is
> enumerated only once at boot-time."  Device enumeration happens
> in the ACPI core and PNP core, not in drivers, and drivers can't
> assume anything about when it happens.

=EF=BB=BFYes. But in fact the ACPI pnp device is enumerated only once a=
t the
boot time. In such case it is impossible to get the corresponding pnp
device when one "IPI0001" device is hot-plug. Is it still meaningful to
consider the "hot-plug" scenario?=20

>=20
> > In such case it is impossible to get the corresponding pnp device
> > when one "IPI0001" device is hotplug. Of course the "ipmi_si" can't=
 see
> > the hotplugged "IPI0001" device.  If we really want to handle the
> > hotplug scenario, IMO we should change the detection mechanism from=
 pnp
> > to ACPI again. Otherwise it is difficult to handle the hotplug scen=
ario.
>=20
> No, you're missing the point.  *All* drivers should be written in
> the standard style that supports hotplug, because then all devices,
> both those present at boot and any added later, are handled the same
> way. =20
>=20
> ipmi_si can indeed see any hotplugged IPI0001 device, simply because
> it uses pnp_register_driver().  The PNP core calls ipmi_pnp_probe()
> when any IPI0001 device is discovered.  This device could be present
> at boot, or it could be added later.

>=20
> > It is an idea to maintain the device list of "impi_si". But if we l=
ook
> > at the source code of "ipmi_si_intf", the corresponding device list=
 is
> > defined as *static*.=20
>=20
> This is a problem you're creating for yourself by trying to completel=
y
> separate acpi_ipmi from ipmi_pnp_probe().  I'm suggesting that you ca=
n
> make your life easier by adding some kind of hook in the ipmi_pnp_pro=
be()
> path to set up the opregion handler.

It is an idea to add some kind of hook. If so,=20
If so, we will have to export more symbols in ipmi subsystem and the
file of drivers/acpi/acpi_ipmi.c.  But the main function in the
drivers/char/ipmi/ipmi_si_intf.c is to discovery the BMC controller and
register the corresponding IPMI system interface. Is it appropriate to
export some symbols which is not related with IPMI discovery?

> > Another matter is that the "info->dev" in ipmi_pnp_probe is changed=
 from
> > acpi_dev to pnp_dev. Now in order to *correctly* create the user
> > interface between ACPI and BMC controller, it is realized by compar=
ing
> > the "device handle". And the prerequisite is that we should get the
> > corresponding pnp device list of "IPI0001".=20
> > If we don't export the symbol of "pnp_bus_type", do you have any id=
ea to
> > get the corresponding device list of "IPI0001"?=20
>=20
> If you have the pnp_dev for an IPI0001 device, you can always get the
> ACPI handle with pnp_acpi_device().
>=20
> > > > > > +static void ipmi_bmc_gone(int iface)
> > > > > > +{
> > > > > > +	struct acpi_ipmi_device *ipmi_device, *temp;
> > > > > > +
> > > > > > +	if (list_empty(&driver_data.ipmi_devices))
> > > > > > +		return;
> > > > >=20
> > > > > You don't need to test for list_empty before using
> > > > > list_for_each_entry_safe()
> > > >=20
> > > > IMO it is needed as it does the operation of list deletion.
> > >=20
> > > I don't think so:
> > >=20
> > >  * list_for_each_entry_safe - iterate over list of given type saf=
e against removal of list entry
> >=20
> > There exist a lot of examples about the removal of list_entry by us=
ing
> > list_for_each_entry_safe. For example:
> >    >drivers/char/ipmi/ipmi_msghandler.c
>=20
> That only means other drivers also contain this unnecessary code.
>=20
> There are many examples of list deletion using list_for_each_entry_sa=
fe()
> where we don't check list_empty() first.  For example:
>=20
>   pnp_free_resources()
>   pnp_clean_resource_table()
>   pnp_free_options()
>   omap_mux_late_init()
>   vpe_module_exit()/release_vpe()
>   fsl_dma_slave_free()
>   cbe_ptcal_disable()
>   pmi_of_remove()
>=20
> Maybe you could remove the check and do some testing to convince
> yourself that it's safe.
>=20
> Bjorn

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
