From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [RFC][PATCH v3]: ACPI: Ignore invalid _PSS entries, but use
 valid ones
Date: Mon, 7 May 2012 13:27:11 -0400
Message-ID: <20120507172710.GA17704@phenom.dumpdata.com>
References: <CAEe-dwjEM8bHV838VwAO1riQk7tVUgdwKxnULxXzrajqjHkLaQ@mail.gmail.com>
 <CAEe-dwiR7kez7-b+gnZc5xNbnCPVtUjarqU80y7yiWuo9MsewQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:16843 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756105Ab2EGRdS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 May 2012 13:33:18 -0400
Content-Disposition: inline
In-Reply-To: <CAEe-dwiR7kez7-b+gnZc5xNbnCPVtUjarqU80y7yiWuo9MsewQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marco Aurelio da Costa <costa@gamic.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Mon, May 07, 2012 at 11:42:13AM -0300, Marco Aurelio da Costa wrote:
> Hi, Konrad.
>=20
> Should I change anything else?

It looks fine to my eyes. Len has the final word.

> I tested the changes in my notebook and it is working fine.

Cool.
>=20
> Cheers.
>=20
> On Fri, May 4, 2012 at 1:53 PM, Marco Aurelio da Costa <costa@gamic.c=
om> wrote:
> > From: Marco Aurelio da Costa <costa@gamic.com>
> > [v3: Fixes suggested by Konrad]
> > Signed-off-by: Marco Aurelio da Costa <costa@gamic.com>
> >
> > The EliteBook 8560W has non-initialized entries in its _PSS ACPI
> > table. Instead of bailing out when the first non-initialized entry =
is
> > found, ignore it and use only =A0the valid entries. Only bail out i=
f there
> > is no valid entry at all.
> >
> > ---
> > --- linux-3.3.3/drivers/acpi/processor_perflib.c.orig =A0 2012-04-2=
4
> > 22:18:23.288041268 +0200
> > +++ linux-3.3.3/drivers/acpi/processor_perflib.c =A0 =A0 =A0 =A0201=
2-05-04
> > 18:23:02.640111246 +0200
> > @@ -311,6 +311,7 @@ static int acpi_processor_get_performanc
> > =A0 =A0 =A0 =A0struct acpi_buffer state =3D { 0, NULL };
> > =A0 =A0 =A0 =A0union acpi_object *pss =3D NULL;
> > =A0 =A0 =A0 =A0int i;
> > + =A0 =A0 =A0 int last_invalid =3D -1;
> >
> >
> > =A0 =A0 =A0 =A0status =3D acpi_evaluate_object(pr->handle, "_PSS", =
NULL, &buffer);
> > @@ -372,14 +373,33 @@ static int acpi_processor_get_performanc
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((u32)(px->core_frequency * =
1000) !=3D
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (px->core_frequency * 1000)=
)) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR FW_B=
UG PREFIX
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Inval=
id BIOS _PSS frequency: 0x%llx MHz\n",
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0px->co=
re_frequency);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D -EFAULT;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(pr->performance=
->states);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto end;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Inval=
id BIOS _PSS frequency found for processor %d: 0x%llx MHz\n",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr->id=
, px->core_frequency);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (last_invalid =3D=3D=
 -1)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 last_=
invalid =3D i;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (last_invalid !=3D=
 -1) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* =
Copy this valid entry over last_invalid entry
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcp=
y(&(pr->performance->states[last_invalid]),
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0px, sizeof(struct acpi_processor_px));
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ++las=
t_invalid;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> > =A0 =A0 =A0 =A0}
> >
> > + =A0 =A0 =A0 if (last_invalid =3D=3D 0) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR FW_BUG PREFIX
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"No valid BIOS _PSS fr=
equency found for processor %d\n", pr->id);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D -EFAULT;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(pr->performance->states);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr->performance->states =3D NULL;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 if (last_invalid > 0)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr->performance->state_count =3D last=
_invalid;
> > +
> > =A0 =A0 =A0 end:
> > =A0 =A0 =A0 =A0kfree(buffer.pointer);
> >
> > --
> > Marco Costa
> > Customer Support
> > --
> > GAMIC mbH
> > Roermonder Strasse, 151
> > 52072 Aachen
> > Germany
>=20
>=20
>=20
> --=20
> Marco Costa
> Customer Support
> --
> GAMIC mbH
> Roermonder Strasse, 151
> 52072 Aachen
> Germany
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
