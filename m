From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] take2: enable acpi_os_allocate() to allocate larger memory
Date: Tue, 24 May 2005 05:48:08 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B300381628C@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

My personal preference is to delete /proc/acpi/dsdt
rather than complicate other code to support a feature
that shouldn't exist.

We've got an updated user-space utility that can read dsdt,
multiple ssdt, etc -- should be available in an acpica release soon;
replacing the current pmtools acpidmp.

-Len

>-----Original Message-----
>From: Kenji Kaneshige [mailto:kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org]=20
>Sent: Tuesday, May 24, 2005 4:28 AM
>To: Brown, Len; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Cc: Alan Cox
>Subject: [PATCH] take2: enable acpi_os_allocate() to allocate=20
>larger memory
>
>Hi,
>
>Here is an updated patch to enable acpi_os_allocate() to allocate
>larger memory. This patch is based on the feedback from Alan Cox
>(Thank you!).
>
>Len, could you consider applying this patch?
>
>Thanks,
>Kenji Kaneshige
>
>---
>
>I encountered the problem that I could not read /proc/acpi/dsdt on my
>machine. It turned out that acpi_os_allocate() was failed to allocate
>buffer. The DSDT on my machine was too large for acpi_os_allocate() to
>allocate the buffer.
>
>Current acpi_os_allocate() interface is implemented by using kmalloc()
>whose maximum allocation size is limited. So acpi_os_allocate() would
>fail if larger size than maximum allocation size of kmalloc was
>specified. I think this restriction should be removed.
>
>The following patch enables acpi_os_allocate() to allocate larger
>memory.
>
>Signed-off-by: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
>
>---
>
> linux-2.6.12-rc4-kanesige/drivers/acpi/osl.c |   12 ++++++++++--
> 1 files changed, 10 insertions(+), 2 deletions(-)
>
>diff -puN drivers/acpi/osl.c~fix_acpi_os_allocate drivers/acpi/osl.c
>--- linux-2.6.12-rc4/drivers/acpi/osl.c~fix_acpi_os_allocate=09
>2005-05-24 16:32:51.000000000 +0900
>+++ linux-2.6.12-rc4-kanesige/drivers/acpi/osl.c=09
>2005-05-24 16:34:25.000000000 +0900
>@@ -37,6 +37,7 @@
> #include <linux/delay.h>
> #include <linux/workqueue.h>
> #include <linux/nmi.h>
>+#include <linux/vmalloc.h>
> #include <acpi/acpi.h>
> #include <asm/io.h>
> #include <acpi/acpi_bus.h>
>@@ -145,13 +146,20 @@ acpi_os_vprintf(const char *fmt, va_list
> void *
> acpi_os_allocate(acpi_size size)
> {
>-	return kmalloc(size, GFP_KERNEL);
>+	void *ptr =3D kmalloc(size,=20
>GFP_KERNEL|__GFP_NORETRY|__GFP_NOWARN);
>+	if (!ptr)
>+		ptr =3D vmalloc(size);
>+	return ptr;
> }
>=20
> void
> acpi_os_free(void *ptr)
> {
>-	kfree(ptr);
>+	if (VMALLOC_START <=3D (unsigned long)ptr &&
>+	    (unsigned long)ptr < VMALLOC_END)
>+		vfree(ptr);
>+	else
>+		kfree(ptr);
> }
> EXPORT_SYMBOL(acpi_os_free);
>=20
>
>_
>


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
