From: "Ow Mun Heng" <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Subject: RE: 2.6.3-rc3 + D600 + battery status missing sometimes..
Date: Thu, 19 Feb 2004 09:59:45 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C386328088ED7F4E9F81AFBABDDF60DA045C692D@wdmyexch02.my.asia.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Acpi-List (E-mail)" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Yu, Luming [mailto:luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]
> Sent: Tuesday, February 17, 2004 3:46 PM
> To: Ow Mun Heng; Acpi-List (E-mail)
> Subject: RE: [ACPI] 2.6.3-rc3 + D600 + battery status missing
> sometimes..
<snip>
> > > > osl-0886[80] os_wait_semaphore:Failed to acquire=20
> > > > semaphore[dffac580|1|0],
> > > > AE_TIME
<snip>
>=20
>=20
> Would you please have patch filed at
> http://bugzilla.kernel.org/show_bug.cgi?id=3D1791
> a try?

Tried it.. Does not work. (using the patch filed by you)
Tried it on a 2.6.3 kernel (final release) with acpi20040211-patch=20
and the patch of yours.

(note that either your patch is for another kernel release or..
since had to do it manually cos there was additional in original=20
kernel sources.)

exestore.c=20
<---snip--->
if (new_desc !=3D obj_desc) {
	acpi_ut_remove_reference (obj_desc);
	*(index_desc->reference.where) =3D new_desc;

	if (new_desc =3D=3D source_desc) {
		acpi_ut_add_reference (new_desc);
	}

	for (i =3D 1; i < ((union acpi_operand_object *)
index_desc->reference.object)->common.reference_count; i++) {
		acpi_ut_add_reference (new_desc);
	}
=09
	if (!obj_desc) {
		acpi_ut_add_reference (new_desc)l
	}
}
break;

<---end of manual typing in sources--->

ps : tried to compile 2.6.3-mm1=20
     (failed at smp_found_config & clustered_acpi_check)
	Just thought I let you know. (even though it should be on the kernel
	mailing list - which I am not subscribed to)


=09


>=20
> --Luming
>=20
> > >=20
> > > > Hmmm.. no reply yet.. more info..
> > > > There's also these message currently..
> > > >=20
> > > >=20
> > > > Appreciate the help..
> > >=20
> > > I have some impression, but still not clearly remember
> > > whether this is a known issue.
> > >=20
> > > Please post full boot log that will help me to recall=20
> > > something useful.
> >=20
> > Full boot log as requested..
> > This is 2.6.3-rc3, patched with acpi-20040211 only.
> >=20
> > Battery status is flaky.. (missing sometimes)
> > then there's the os_wait_semaphore thingy as well..
> >=20
> > Appreciate the help..
> >=20
> >=20
> >=20
>=20


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
