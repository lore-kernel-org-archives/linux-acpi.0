From: "S, Naveen B" <naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] ACPI based Memory Hotplug Driver Patch
Date: Fri, 10 Sep 2004 17:50:16 +0530
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <FEB6C4E97F6CAF41978FB2059D5454180F37EF@bgsmsx402.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Tolentino, Matthew E" <matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "S, Naveen B" <naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Thanks Dmitry,


> +static int=20
> +acpi_memory_get_device(acpi_handle handle,
> +=A0=A0=A0=A0=A0=A0=A0struct acpi_memory_device **mem_device)=20
> +{

I think the above should go straight into drivers/acpi/bus.c - there is
nothing memory-specific in that code and having the common code for hot-
plugged devices would help other drivers. Umm.. yep. I see that ACPI
CPU hotplug posted just recently does exactly the same.

<nave> Good point.  Let me re-look into CPU hot plug patch.

Also, does it compile as a module? acpi_bus_add does not seem to be
exported...

<nave> Yes, it does compile as a module. Acpi_bus_add is exported. =
Please refer to the following chunk of the patch.

--- linux-2.6.8.1-mm3-orig/drivers/acpi/acpi_ksyms.c	2004-09-09 =
13:55:36.000000000 +0530
+++ linux-2.6.8.1-mm3-hpmem/drivers/acpi/acpi_ksyms.c	2004-09-09 =
14:01:11.000000000 +0530
@@ -135,6 +135,7 @@
 EXPORT_SYMBOL(acpi_bus_receive_event);
 EXPORT_SYMBOL(acpi_bus_register_driver);
 EXPORT_SYMBOL(acpi_bus_unregister_driver);
+EXPORT_SYMBOL(acpi_bus_add);

--=20
Dmitry


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
