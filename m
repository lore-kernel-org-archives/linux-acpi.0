From: Igor Popik <igor.popik-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] acpi: processor add release_region()
Date: Sat, 8 Oct 2005 14:41:28 +0200
Message-ID: <253000f70510080541w2175817w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

The processor module reservers some io mem but it does not release
that region during unload nor during processor removal (possibly with
hotplug support?).

This casues oops after unloading processor module and attempt to read
contents of /proc/ioports file (memory region name points to unloaded
module).

Best Regards,
Igor

--- a/drivers/acpi/processor_core.c=092005-10-08 13:26:23.000000000 +0200
+++ b/drivers/acpi/processor_core.c=092005-10-08 13:31:35.000000000 +0200
@@ -675,6 +675,9 @@

 =09acpi_processor_remove_fs(device);

+=09if (pr->throttling.address)
+=09=09release_region(pr->throttling.address, 6);
+
 =09processors[pr->id] =3D NULL;

 =09kfree(pr);


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
