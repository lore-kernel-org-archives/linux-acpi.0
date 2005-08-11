From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] Disable slow duplicate object tracking in ACPI_DEBUG
Date: Wed, 10 Aug 2005 22:14:43 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30044D213E@hdsmsx401.amr.corp.intel.com>
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
To: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Maybe it is time to figure out why SLES has ACPI_DEBUG enabled.
If it is certain warnings and error messages, then perhaps
we should enable those but not all the other misc debug
and paranoia checks that come with ACPI_DEBUG?

thanks,
-Len

ps. ec-burst should be disabled by default in 2.6.12
and 2.6.13-rc6.  there is an option to enable it at boot-time
in -mm, and hopefully we'll get it working there (very) soon
so we can experiment again with ec-burst enabled by default.=20

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Andi Kleen
>Sent: Wednesday, August 10, 2005 7:33 AM
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI] [PATCH] Disable slow duplicate object tracking=20
>in ACPI_DEBUG
>
>
>The current SUSE 10.0 beta has CONFIG_ACPI_DEBUG enabled. That lead
>to severe slowdowns on several machines. One issue was the different
>default for ec_burst_mode. Another one was that the object tracking
>would always walk the full list of all objects, which lead to kacpid
>needing up to 25% of the total CPU time.
>
>This patch disables the slow list walking. It could be probably
>replaced with a hash or similar too, but I don't think the duplicate
>object tracking is too useful anaywys so I just disabled it.
>
>-Andi
>
>From: ak-l3A5Bk7waGM@public.gmane.org
>Subject: Disable linear search in ACPI debugging
>Suse-bugzilla: 102565
>
>Looking through all the memory objects all the time is just too slow.
>Don't do it.
>
>
>Signed-off-by: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
>
>Index: linux-2.6.13rc5/drivers/acpi/utilities/utalloc.c
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>--- linux-2.6.13rc5.orig/drivers/acpi/utilities/utalloc.c
>+++ linux-2.6.13rc5/drivers/acpi/utilities/utalloc.c
>@@ -674,6 +674,9 @@ acpi_ut_find_allocation (
> {
> 	struct acpi_debug_mem_block     *element;
>=20
>+	/* too slow to be usable */
>+	return NULL;
>+
>=20
> 	ACPI_FUNCTION_ENTRY ();
>=20
>
>
>-------------------------------------------------------
>SF.Net email is Sponsored by the Better Software Conference & EXPO
>September 19-22, 2005 * San Francisco, CA * Development=20
>Lifecycle Practices
>Agile & Plan-Driven Development * Managing Projects & Teams *=20
>Testing & QA
>Security * Process Improvement & Measurement *=20
>http://www.sqe.com/bsce5sf
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
