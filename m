From: "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 5/5] processor: jiffies-based bm_check, bugfixes
Date: Thu, 23 Dec 2004 10:31:50 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB6003A46B1D@scsmsx403.amr.corp.intel.com>
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
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


We have another patch to fix this bm_activity history, by doing periodic
bm checks. I will post it here as soon as I rebase the patch with new
processor_idle.c.

Thanks,
Venki=20

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
>Dominik Brodowski
>Sent: Thursday, December 23, 2004 6:09 AM
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Brown, Len
>Subject: [ACPI] [PATCH 5/5] processor: jiffies-based bm_check, bugfixes
>
>Make the bm_activity depend on "jiffies", instead of numbers
>of the check being called. This means bus mastering activity
>is assumed if bm_check isn't called; and multiple calls during
>one jiffy will be |=3D'ed.
>
>Also, two fixups where promotion and demotion were mixed up.
>
>Signed-off-by: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
>---
>
> drivers/acpi/processor_idle.c |   19 ++++++++++++++++---
> include/acpi/processor.h      |    1 +
> 2 files changed, 17 insertions(+), 3 deletions(-)
>
>Index: linux-2.6.10-rc3+bk-acpi/drivers/acpi/processor_idle.c
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>---=20
>linux-2.6.10-rc3+bk-acpi.orig/drivers/acpi/processor_idle.c=09
>2004-12-23 14:25:32.385908579 +0100
>+++ linux-2.6.10-rc3+bk-acpi/drivers/acpi/processor_idle.c=09
>2004-12-23 14:39:58.360081349 +0100
>@@ -193,8 +193,18 @@
> 	 */
> 	if (pr->flags.bm_check) {
> 		u32		bm_status =3D 0;
>+		unsigned long	diff =3D jiffies -=20
>pr->power.bm_check_timestamp;
>=20
>-		pr->power.bm_activity <<=3D 1;
>+		if (diff > 32)
>+			diff =3D 32;
>+
>+		while (diff) {
>+			/* if we didn't get called, assume=20
>there was busmaster activity */
>+			diff--;
>+			if (diff)
>+				pr->power.bm_activity |=3D 0x1;
>+			pr->power.bm_activity <<=3D 1;
>+		}
>=20
> 		acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS,
> 			&bm_status, ACPI_MTX_DO_NOT_LOCK);
>@@ -213,6 +223,9 @@
> 				|| (inb_p(errata.piix4.bmisx +=20
>0x0A) & 0x01))
> 				pr->power.bm_activity++;
> 		}
>+
>+		pr->power.bm_check_timestamp =3D jiffies;
>+
> 		/*
> 		 * Apply bus mastering demotion policy. =20
>Automatically demote
> 		 * to avoid a faulty transition.  Note that the=20
>processor
>@@ -439,13 +452,13 @@
>=20
> 		if (higher) {
> 			cx->promotion.state  =3D higher;
>-			cx->demotion.threshold.ticks =3D=20
>cx->latency_ticks;
>+			cx->promotion.threshold.ticks =3D=20
>cx->latency_ticks;
> 			if (cx->type >=3D ACPI_STATE_C2)
> 				cx->promotion.threshold.count =3D 4;
> 			else
> 				cx->promotion.threshold.count =3D 10;
> 			if (higher->type =3D=3D ACPI_STATE_C3)
>-				cx->demotion.threshold.bm =3D 0x0F;
>+				cx->promotion.threshold.bm =3D 0x0F;
> 		}
>=20
> 		higher =3D cx;
>Index: linux-2.6.10-rc3+bk-acpi/include/acpi/processor.h
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>--- linux-2.6.10-rc3+bk-acpi.orig/include/acpi/processor.h=09
>2004-12-23 13:21:12.000000000 +0100
>+++ linux-2.6.10-rc3+bk-acpi/include/acpi/processor.h=09
>2004-12-23 14:41:47.558845116 +0100
>@@ -54,6 +54,7 @@
>=20
> struct acpi_processor_power {
> 	struct acpi_processor_cx *state;
>+	unsigned long		bm_check_timestamp;
> 	u32			default_state;
> 	u32			bm_activity;
> 	int			count;
>
>
>-------------------------------------------------------
>SF email is sponsored by - The IT Product Guide
>Read honest & candid reviews on hundreds of IT Products from=20
>real users.
>Discover which products truly live up to the hype. Start reading now.=20
>http://productguide.itmanagersjournal.com/
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
