From: "S, Naveen B" <naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [Lhms-devel] [PATCH] ACPI based Memory Hotplug DriverPatch
Date: Fri, 10 Sep 2004 18:19:50 +0530
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <FEB6C4E97F6CAF41978FB2059D5454180F37F2@bgsmsx402.gar.corp.intel.com>
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
To: "Tolentino, Matthew E" <matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dave Hansen <haveblue-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, keith <kmannth-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lhms <lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "S, Naveen B" <naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


>=20
> >I think I'd slightly prefer something that looks more like this (same
> >thing goes for the add function):
> >
> >acpi_memory_disable_device(struct acpi_memory_device *mem_device)
> >{
> >	int err;
> >	u64 start =3D mem_device->start_addr;
> >	u64 len =3D mem_device->end_addr - start + 1;
> >	unsigned long attr =3D mem_device->read_write_attribute;
> >
> >	ACPI_FUNCTION_TRACE("acpi_memory_disable_device");
> >
> >	/*
> >	 * Ask the VM to offline this memory range.
> >	 */
> >	err =3D remove_memory(start, len, attr);
> >
> >	if (err) {
> >		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Hot-Remove
> >failed.\n"));
> >		return_VALUE(err);
> >	}
> >...
>=20
> Yeah, that's a little easier to read...
>=20
This looks good and easier to read. Thanks for the suggestion, Dave.

--Naveen


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
