From: Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH v2-UPDATE 3/4] resource: Add device-managed
 insert/remove_resource()
Date: Mon, 07 Mar 2016 16:03:07 -0700
Message-ID: <1457391787.15454.399.camel@hpe.com>
References: <1457108082-4610-1-git-send-email-toshi.kani@hpe.com>
	 <CAPcyv4g8+6LBW08JZ3Ym0mAuo1bcwjGTeHrzS0p=QoJb4Mqeag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g9t5009.houston.hp.com ([15.240.92.67]:33249 "EHLO
	g9t5009.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753099AbcCGWKa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Mar 2016 17:10:30 -0500
In-Reply-To: <CAPcyv4g8+6LBW08JZ3Ym0mAuo1bcwjGTeHrzS0p=QoJb4Mqeag@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andrew Morton <akpm@linux-foundation.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>

On Mon, 2016-03-07 at 10:14 -0800, Dan Williams wrote:
=C2=A0:
> > +/**
> > + * devm_insert_resource() - insert an I/O or memory resource
> > + * @dev: device for which to produce the resource
> > + * @root: root of the resource tree
> > + * @new: descriptor of the new resource
> > + *
> > + * This is a device-managed version of insert_resource(). There is
> > usually
> > + * no need to release resources requested by this function explici=
tly
> > since
> > + * that will be taken care of when the device is unbound from its =
bus
> > driver.
> > + * If for some reason the resource needs to be released explicitly=
,
> > because
> > + * of ordering issues for example, bus drivers must call
> > devm_remove_resource()
> > + * rather than the regular remove_resource().
> > + *
> > + * devm_insert_resource() is intended for producers of resources, =
such
> > as
> > + * FW modules and bus drivers.
> > + *
> > + * Returns 0 on success or a negative error code on failure.
> > + */
> > +int devm_insert_resource(struct device *dev, struct resource *root=
,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0struct resource *new)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct resource **ptr;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ptr =3D devres_alloc(__d=
evm_remove_resource, sizeof(*ptr),
> > GFP_KERNEL);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!ptr)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return -ENOMEM;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*ptr =3D new;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D insert_resource(=
root, new);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0dev_err(dev, "unable to insert resource: %pR (%=
d)\n",
> > new, ret);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0devres_free(ptr);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return -EBUSY;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0devres_add(dev, ptr);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(devm_insert_resource);
>=20
> The only hesitation I have with this is that the kernel has gotten by
> a long time without allowing external modules to insert resources.=C2=
=A0=C2=A0If
> keeping it private all this time was purposeful then maybe we should
> make this new NVDIMM-need to call insert_resource() private to the
> nfit driver and built-in-only.

Here is some background info on this:

- External modules can already insert resources via platform_device_add=
(),
which is used for inserting resources that may not be enumerated by
standard FW interfaces. =C2=A0There are over 200 callers already.

- PCI mmcfg driver and ACPI HPET driver find their resources from ACPI,=
 and
call insert_resource() to insert them, which is similar to what this
patchset tries to do with ACPI NFIT. =C2=A0Both PCI and HPET drivers do=
 not
support unloading, however.
=C2=A0 # cat /proc/iomem
=C2=A0 =C2=A0:
=C2=A0 80000000-8fffffff : PCI MMCONFIG 0000 [bus 00-ff]
=C2=A0 =C2=A0 80000000-8fffffff : reserved
=C2=A0 =C2=A0:
=C2=A0 fed00000-fed003ff : HPET 0
=C2=A0 =C2=A0 fed00000-fed003ff : PNP0103:00

- Existing FW modules and bus drivers using insert_resource() are built=
-
into the kernel, and insert_resource() is not exported. =C2=A0I think t=
his is
because these modules did not have to (or may not) support unloading.

- Both the NFIT driver and NVDIMM bus drivers are new and support
unloading. =C2=A0This calls for an exported interface for insert_resour=
ce().

- devm impl of insert/remove_resource() is added to assure that resourc=
es
are properly released on unloading. =C2=A0Exporting devm interfaces mak=
es sense
(to me).

- However, devm_insert/remove_resource() should not be confused with
devm_request/release_resource(). =C2=A0Hence, this patchset adds commen=
ts to
clarify that they are used for producers of resources. =C2=A0The same c=
omments
are added to insert/remove_resource() as well.

Thanks,
-Toshi
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
