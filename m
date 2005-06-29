From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: oops with asus_acpi on P30/P35
Date: Wed, 29 Jun 2005 09:09:19 -0700
Message-ID: <971FCB6690CD0E4898387DBF7552B90E01F61BCB@orsmsx403.amr.corp.intel.com>
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
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Christian Aichinger <Greek0-hi6Y0CQ0nG0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Yes, the implicit return code works for EvaluateObject.

In general, code should check for the correct object type before
accessing the object.

There are utility procedures available to execute a method and specify
the expected return type; error otherwise.
Bob


> -----Original Message-----
> From: Karol Kozimor [mailto:sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org]
> Sent: Wednesday, June 29, 2005 4:11 AM
> To: Moore, Robert
> Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Christian Aichinger
> Subject: Re: [ACPI] oops with asus_acpi on P30/P35
>=20
> Thus wrote Christian Aichinger:
> > The oops occurs in asus_acpi.c, line 1016:
> >     hotk->model =3D END_MODEL;
> > 	if (strncmp(model->string.pointer, "L3D", 3) =3D=3D 0) // <-- OOPS
> > 		hotk->model =3D L3D;
> >
> > Some added debug printk's later it turned out that:
> > model->type =3D=3D ACPI_TYPE_INTEGER
> > model->integer.value =3D=3D 56
>=20
> Thanks, I suspected that but I'm really swamped both with Real Work
and
> my exams so I'm slow even with catching up with the lists...
>=20
> > This is why the problem wasn't fixed by your patch, since that
> > resided in the if (model->type =3D=3D ACPI_TYPE_STRING) code-path.
> > I've attatched a patch that works for me, but IMHO it's ugly and
> > only fixes the sympthoms. Why do we get an integer here in the first
> > place?
>=20
> Bob, is the implicit return code supposed to trigger also when using
> acpi_evaluate_object()? FYI, this is what we currently do:
>=20
> write_acpi_int(hotk->handle, "INIT", 0, &buffer)
> (drivers/acpi/asus_acpi.c)
>=20
> which is fine if the INIT method returns a string (the usual), but
> apparently not if there is no return statement in the method (the P30
> case). The old code assumed the buffer will be null in this case.
>=20
> Is that a bug in the ACPICA or should the asus_acpi code cover for
other
> cases of buffer.type?
>=20
> Best regards,
>=20
> --
> Karol 'sziwan' Kozimor
> sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
