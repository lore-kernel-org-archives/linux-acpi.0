From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [RFC][PATCH] ACPI: Ignore invalid _PSS entries, but use valid
 ones
Date: Fri, 4 May 2012 10:39:48 -0400
Message-ID: <20120504143948.GD1049@phenom.dumpdata.com>
References: <CAEe-dwgCR55urie0c1MdBWTS6-E=3faXj68=WMcb6NvQCQX0rg@mail.gmail.com>
 <20120504135217.GB1049@phenom.dumpdata.com>
 <CAEe-dwj4JP-U0tc3wpmHvzv=aQU5zy3cG_E9FrriPw_sdfg2bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:30511 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318Ab2EDOpj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 May 2012 10:45:39 -0400
Content-Disposition: inline
In-Reply-To: <CAEe-dwj4JP-U0tc3wpmHvzv=aQU5zy3cG_E9FrriPw_sdfg2bg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marco Aurelio da Costa <costa@gamic.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, May 04, 2012 at 11:13:22AM -0300, Marco Aurelio da Costa wrote:
> Hi, Konrad.
>=20
> On Fri, May 4, 2012 at 10:52 AM, Konrad Rzeszutek Wilk
> <konrad.wilk@oracle.com> wrote:
> > On Fri, May 04, 2012 at 10:46:01AM -0300, Marco Aurelio da Costa wr=
ote:
> >> From: Marco Aurelio da Costa <costa@gamic.com>
> >> Signed-off-by: Marco Aurelio da Costa <costa@gamic.com>
> >>
> >> The EliteBook 8560W has non-initialized entries in its _PSS ACPI
> >> table. Instead of bailing out when the first non-initialized entry=
 is
> >> found, ignore it and use only =A0the valid entries. Only bail out =
if there
> >> is no valid entry at all.
> >
> > Is that safe? Meaning re-use the other CPU's _PSS states? Perhaps t=
he
> > warning at the end should say: "Trying to compensate by using the
> > other CPU's PSS state).
>=20
> This case in question was created by HP removing the overclock option=
s
> and leaving the entries in a invalid/empty situation. In this specifi=
c
> case, it is safe.
> I am not changing the table in any way, I just ignore the
> non-initialized entries. The code only use listed states. If they are
> CPU bound, the code doesn't assume anything.
>=20
> >
> >>
> >> ---
> >> --- linux-3.3.3/drivers/acpi/processor_perflib.c.orig =A0 2012-04-=
24
> >> 22:18:23.288041268 +0200
> >> +++ linux-3.3.3/drivers/acpi/processor_perflib.c =A0 =A0 =A0 =A020=
12-04-24
> >> 22:19:25.912042603 +0200
> >> @@ -311,6 +311,7 @@ static int acpi_processor_get_performanc
> >> =A0 =A0 =A0 =A0struct acpi_buffer state =3D { 0, NULL };
> >> =A0 =A0 =A0 =A0union acpi_object *pss =3D NULL;
> >> =A0 =A0 =A0 =A0int i;
> >> + =A0 =A0 =A0 int last_invalid =3D -1;
> >>
> >>
> >> =A0 =A0 =A0 =A0status =3D acpi_evaluate_object(pr->handle, "_PSS",=
 NULL, &buffer);
> >> @@ -374,12 +375,30 @@ static int acpi_processor_get_performanc
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR FW_=
BUG PREFIX
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Inval=
id BIOS _PSS frequency: 0x%llx MHz\n",
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 px->co=
re_frequency);
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D -EFAULT;
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(pr->performanc=
e->states);
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto end;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (-1 =3D=3D last_i=
nvalid)
> >
> > Swap it around or just do it this way:
>=20
> Ok.
>=20
> >
> > if (last_invalid < 0)
> >
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 last=
_invalid =3D i;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (last_invalid !=3D=
 -1) {
> >
> > if (last_invalid >=3D 0)
> >
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*=
 Copy this valid entry over last_invalid entry
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*=
/
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memc=
py(&(pr->performance->states[last_invalid]),
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0px, sizeof(struct acpi_processor_px));
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ++la=
st_invalid;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> >> =A0 =A0 =A0 =A0}
> >>
> >> + =A0 =A0 =A0 if (0 =3D=3D last_invalid) {
> >
> > So if _PSS that is missing is at CPU2, this own't print it.
>=20
> I don't get what do you mean by CPU. last_invalid is just the last
> invalid _PSS entry item. Nothing to do with the CPU.

The loop is based on CPU, oh wait. Not this loop. You are right - ignor=
e
that comment please.
>=20
> >
> > I think you want 'if (last_invalid >=3D 0)'
>=20
> No, it is correct. If the last invalid found item is the item 0, than
> it means that no valid item was found.

I somehow thought that the 'i' was for the for_each_possible(cpu), but
that is another funtion.

>=20
> >
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR FW_BUG PREFIX
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"No valid BIOS _PSS f=
requency found\n");
> >
> > And you should mention which CPU has it busted - as there are
> > some that are working.
>=20
> No CPU here, just the _PSS item.

Add pr->id - that will tell us which of the _PSS entries is defective.

>=20
> >
> >
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D -EFAULT;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(pr->performance->states);
> >> + =A0 =A0 =A0 }
> >> +
> >> + =A0 =A0 =A0 if (last_invalid > 0)
> >
> > Don't you want 'last_invalid >=3D 0' ?
>=20
> No. It is correct. If the last invalid item is greater than 0, then
> there was at least 1 valid _PSS entry. And the count of valid entries
> is the same as the last_invalid variable.
>=20
> >
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr->performance->state_count =3D las=
t_invalid;
> >> +
> >> =A0 =A0 =A0 end:
> >> =A0 =A0 =A0 =A0kfree(buffer.pointer);
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-ac=
pi" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>=20
> I will send the corrected patch next.
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
