From: "S, Naveen B" <naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] ACPI based Memory Hotplug Driver Patch
Date: Mon, 13 Sep 2004 18:26:27 +0530
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <FEB6C4E97F6CAF41978FB2059D5454180F37FF@bgsmsx402.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Tolentino, Matthew E" <matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "S, Naveen B" <naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Thanks for your comments Bjorn.

> > +acpi_memory_get_device_resources(struct acpi_memory_device
*mem_device)
> > +{
> > +	acpi_status status;
> > +	struct acpi_buffer buffer =3D {ACPI_ALLOCATE_BUFFER, NULL};
> > +	struct acpi_resource *resource =3D NULL;
> > +	struct acpi_resource_address16 *address16 =3D NULL;
> > +	struct acpi_resource_address32 *address32 =3D NULL;
> > +	struct acpi_resource_address64 *address64 =3D NULL;
>=20
> You can use acpi_resource_to_address64() to keep from having to write
> the same code for address16, address32, and address64.

This should optimize the code. Thanks for your suggestion.

>=20
> > +	status =3D acpi_get_current_resources(mem_device->handle,
&buffer);
> > +	if (ACPI_FAILURE(status))
> > +		return_VALUE(-EINVAL);
> > +
> > +	resource =3D (struct acpi_resource *) buffer.pointer;
> > +
> > +	switch (resource->id) {
> > +	case ACPI_RSTYPE_ADDRESS16:
>=20
> I'm not sure you should assume the range will be the only item in _CRS
> (i.e., you may need to iterate over all items using
> acpi_walk_resources()).

As per my understanding from the spec that the memory device has only
range in _CRS. So I believe acpi_walk_resources is redundant in this
case.

>=20
> > +static int
> > +acpi_memory_check_device(struct acpi_memory_device *mem_device)
>=20
> Could you just use acpi_bus_get_status() instead of defining this?

I would still prefer acpi_memory_check_device which is simple and just
queries the given device status.=20

>=20
> (Different indent style).  Seems like this should check _CID as well
> as _HID?  Could it leverage acpi_match_ids() somehow?

No. Again from the spec I understand that for memory device _HID should
be able to provide pnp device ID. (anyway _CID is optional in many
cases)

Please let me know if you have any other concerns.

Thanks & Regards

--Naveen



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
