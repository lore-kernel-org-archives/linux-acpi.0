From: "Tolentino, Matthew E" <matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [Lhms-devel] [PATCH] ACPI based Memory Hotplug DriverPatch
Date: Thu, 9 Sep 2004 11:28:06 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <D36CE1FCEFD3524B81CA12C6FE5BCAB007A6C485@fmsmsx406.amr.corp.intel.com>
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
To: Dave Hansen <haveblue-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, "S, Naveen B" <naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, keith <kmannth-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lhms <lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

>What does this end up naming the module?  If it ends up being memory.o,
>you might want to think about making it something a bit more
>descriptive.  Does it even need to be allowed to be a module,=20
>or is that
>standard ACPI practice?

Currently, it names it memory.ko.  Len has also suggested that it be
something more like memory_hotplug.ko or memory_hp.ko or something
like that, because the ACPI spec does include verbage about the
system memory map...  As this driver does handle "memory"
devices, it kinda makes sense, but we're not wed to any particular=20
name...  ;-) =20

I would prefer to maintain the option to build this driver as a module=20
at least until there is more testing.  It's certainly easier to work=20
with right now as a module.

>I think I'd slightly prefer something that looks more like this (same
>thing goes for the add function):=20
>
>acpi_memory_disable_device(struct acpi_memory_device *mem_device)=20
>{
>	int err;
>	u64 start =3D mem_device->start_addr;
>	u64 len =3D mem_device->end_addr - start + 1;
>	unsigned long attr =3D mem_device->read_write_attribute;
>
>	ACPI_FUNCTION_TRACE("acpi_memory_disable_device");
>
>	/*=20
>	 * Ask the VM to offline this memory range.
>	 */
>	err =3D remove_memory(start, len, attr);
>
>	if (err) {
>		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Hot-Remove=20
>failed.\n"));
>		return_VALUE(err);=09
>	}
>...

Yeah, that's a little easier to read... =20

>Other than the add/remove_memory() calls does this have any real
>interaction with any non-ACPI code that I overlooked?

Nope, the only real interaction with the VM is isolated to those=20
calls.  This driver is really only for handling the interaction=20
with real hardware via ACPI, so it shouldn't need to muck around=20
with other code... =20

Btw, Keith please give this a once over as I know we talked about
this before...

matt


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
