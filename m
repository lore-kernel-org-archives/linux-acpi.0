From: Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH v2-UPDATE 3/4] resource: Add device-managed
 insert/remove_resource()
Date: Tue, 08 Mar 2016 10:41:47 -0700
Message-ID: <1457458907.15454.464.camel@hpe.com>
References: <1457108082-4610-1-git-send-email-toshi.kani@hpe.com>
	 <20160308120253.GA3599@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g9t5009.houston.hp.com ([15.240.92.67]:44894 "EHLO
	g9t5009.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932380AbcCHQtM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Mar 2016 11:49:12 -0500
In-Reply-To: <20160308120253.GA3599@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: bp@suse.de, dan.j.williams@intel.com, rjw@rjwysocki.net, akpm@linux-foundation.org, linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>

On Tue, 2016-03-08 at 13:02 +0100, Ingo Molnar wrote:
> * Toshi Kani <toshi.kani@hpe.com> wrote:
>=20
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
>=20
> s/explicitly since
> =C2=A0/explicitly, since

Will do.

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
> > +			=C2=A0=C2=A0struct resource *new)
> > +{
> > +	struct resource **ptr;
> > +	int ret;
> > +
> > +	ptr =3D devres_alloc(__devm_remove_resource, sizeof(*ptr),
> > GFP_KERNEL);
> > +	if (!ptr)
> > +		return -ENOMEM;
> > +
> > +	*ptr =3D new;
> > +
> > +	ret =3D insert_resource(root, new);
> > +	if (ret) {
> > +		dev_err(dev, "unable to insert resource: %pR (%d)\n",
> > new, ret);
> > +		devres_free(ptr);
> > +		return -EBUSY;
>=20
> Why not return 'ret' here, instead of -EBUSY?

Right, I will change it to 'return ret'.

> > +	}
> > +
> > +	devres_add(dev, ptr);
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(devm_insert_resource);
> > +
> > +/**
> > + * devm_remove_resource() - remove a previously inserted resource
> > + * @dev: device for which to remove the resource
> > + * @old: descriptor of the resource
> > + *
> > + * Remove a resource previously inserted using devm_insert_resourc=
e().
> > + *
> > + * devm_remove_resource() is intended for producers of resources, =
such
> > as
> > + * FW modules and bus drivers.
> > + */
> > +void devm_remove_resource(struct device *dev, struct resource *old=
)
> > +{
> > +	WARN_ON(devres_release(dev, __devm_remove_resource,
> > devm_resource_match,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0old));
>=20
> So generally we don't put functions with side effects into WARN_ON()s=
=2E
> Just like BUG_ON(), in the future it might be disabled on certain
> Kconfigs, etc. - and it's also bad for readability.
>=20
> Also, please use WARN_ON_ONCE().

I see. =C2=A0Will change to test with WARN_ON_ONCE(ret).

> > +}
> > +EXPORT_SYMBOL_GPL(devm_remove_resource);
> > +
> > +/*
> > =C2=A0 * Called from init/main.c to reserve IO ports.
> > =C2=A0 */
> > =C2=A0#define MAXRESERVE 4
>=20
> Looks good to me otherwise.

Great! =C2=A0I will send an updated patch as "[PATCH v2-UPDATE2 3/4]".

Thanks,
-Toshi

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
