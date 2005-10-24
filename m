From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: sony vaio pcg-k45 hell
Date: Mon, 24 Oct 2005 09:39:48 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8409DDEB5D@pdsmsx403>
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
To: Thom Cherryhomes <thom.cherryhomes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


what's your kernel version?=20
I suggest you file bugs on bugzilla.kernel.org.

>well, to start:
>
>(1) battery meter most of the time shows zero
>(2) I get maybe 1 hour battery time.
>(3) S3 suspend does NOT work at all (using hibernate-ram script)
>(4) i get unusual time readings that seem to keep incrementing when
>the battery is charging (when I DO see the battery meter)
>(5) no fan control
>(6) display does not dim when disconnected.
>(7) hotkeys for changing brightness etc do not work.
>
>arrggghhhhh
>
>I tried to find a PSS table in the DSDT, and couldn't.. it seems the
>acpi on this laptop is insanely broken. :-(

Please try 2.6.14-rc5 with ec_burst=3D0 and ec_burst=3D1 and latest =
patch=20
at  http://bugzilla.kernel.org/show_bug.cgi?id=3D4980
, http://bugzilla.kernel.org/show_bug.cgi?id=3D4588
for battery issue.=20

For others, please file bugs on bugzilla.kernel.org in ACPI category.

Thanks,
Luming


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
