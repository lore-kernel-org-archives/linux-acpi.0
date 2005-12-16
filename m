From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 1/2] make acpi_path_name() global
Date: Thu, 15 Dec 2005 23:56:47 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30056F8757@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: Randy Dunlap <randy_d_dunlap-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, pcihpd-discuss-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Accardi, Kristen C" <kristen.c.accardi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, gregkh-l3A5Bk7waGM@public.gmane.org, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I think that some of our code partitioning is screwed up
and this continues and extends that tradition:-)

acpiosxf.h is supposed to declare ACPICA core things that
the OS needs to see.  osl.c is supposed to glue and
wrap the appropriate core and Linux functions together.

The big problem we have here is that every acpi sub-system
header is sucked into a consolidated header and so every
internal function is available to the entire kernel.

an example of this is acpi_get_name(), which as declared
isn't supposed to be available outside the core.
All the uses of it to print ACPI namespace tokens in /proc
are totally bogus and should be deleted.  The other use
of it is to print out debug strings -- stuff the OS
doesn't really need to "know" and maybe something the
core should do for it.  That leaves the hotplug use,
which I don't understand.  What does SATA need
with the actual path names?

thanks,
-Len

>-----Original Message-----
>From: Randy Dunlap [mailto:randy_d_dunlap-VuQAYsv1563Yd54FQh9/CA@public.gmane.org]=20
>Sent: Thursday, December 15, 2005 8:20 PM
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org;=20
>pcihpd-discuss-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Cc: Accardi, Kristen C; Brown, Len; gregkh-l3A5Bk7waGM@public.gmane.org
>Subject: [PATCH 1/2] make acpi_path_name() global
>
>From: Randy Dunlap <randy_d_dunlap-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>
>Make acpi_path_name() usable by everyone.
>I need this for adding SATA suspend/resume ACPI support.
>
>Note:
>This function is now a memory allocator and callers should kfree()
>the memory when done with it.  It doesn't seem safe to me to leave
>it as returning a pointer to a static buffer (as it was in multiple
>cloned copies) as we add callers to it.
>
>
>Signed-off-by: Randy Dunlap <randy_d_dunlap-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>---
> drivers/acpi/osl.c      |   29 +++++++++++++++++++++++++++++
> include/acpi/acpiosxf.h |    2 ++
> 2 files changed, 31 insertions(+)
>
>--- linux-2615-rc5g5.orig/drivers/acpi/osl.c
>+++ linux-2615-rc5g5/drivers/acpi/osl.c
>@@ -1078,6 +1078,35 @@ void acpi_os_release_lock(acpi_handle ha
> 	spin_unlock_irqrestore((spinlock_t *) handle, flags);
> }
>=20
>+/**
>+ * acpi_path_name - get ACPI path_name for the given handle
>+ * @handle: ACPI object handle to look up name of
>+ *
>+ * Allocates memory if successul.  Caller must free the memory.
>+ *
>+ * Returns: pointer to path_name if successful, NULL if not.
>+ */
>+u8 *acpi_path_name(acpi_handle handle)
>+{
>+	acpi_status		status;
>+	static u8		*path_name;
>+	struct acpi_buffer	ret_buf =3D {ACPI_PATHNAME_MAX,=20
>path_name};
>+
>+	path_name =3D kzalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
>+	if (!path_name)
>+		return NULL;
>+
>+	status =3D acpi_get_name(handle, ACPI_FULL_PATHNAME, &ret_buf);
>+
>+	if (ACPI_FAILURE(status)) {
>+		acpi_os_free(path_name);
>+		return NULL;
>+	}
>+
>+	return path_name;
>+}
>+EXPORT_SYMBOL(acpi_path_name);
>+
> #ifndef ACPI_USE_LOCAL_CACHE
>=20
>=20
>/**************************************************************
>*****************
>--- linux-2615-rc5g5.orig/include/acpi/acpiosxf.h
>+++ linux-2615-rc5g5/include/acpi/acpiosxf.h
>@@ -112,6 +112,8 @@ unsigned long acpi_os_acquire_lock(acpi_
>=20
> void acpi_os_release_lock(acpi_handle handle, unsigned long flags);
>=20
>+u8 *acpi_path_name(acpi_handle handle);
>+
> /*
>  * Memory allocation and mapping
>  */
>
>
>---
>


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
