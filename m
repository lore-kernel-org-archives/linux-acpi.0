From: "Simon Moore" <Simon_Moore-HnN13UdsTkzz1n+OaKNE4w@public.gmane.org>
Subject: RE: Speedstep-centrino problems
Date: Thu, 10 Feb 2005 13:41:54 +0100
Message-ID: <0FEA36BB2ABDF44FAAFEB7A75367C07A0117DCE4@alaska.condis.es>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
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
To: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>, galin-Dn6zUBO643CDvotElmWtJA@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thanks for warning me about that.

I suppose I could ask Dell which variant they installed (or how to find
out which variant is installed). If I were to be certain which variant
it was, would the patch be safe if modified accordingly?

Or anyone up to patching it such that the variant can be defined at
runtime? ;) I would but I'm just a stupid java developer. :)

Reagrds,

Saimon

> -----Mensaje original-----
> De: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] En nombre de=20
> Rich Townsend
> Enviado el: jueves, 10 de febrero de 2005 13:06
> Para: galin-Dn6zUBO643CDvotElmWtJA@public.gmane.org
> CC: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Asunto: Re: [ACPI] Speedstep-centrino problems
>=20
>=20
> I was under the impression that this patch was possibly=20
> dangerous. This=20
> is because the Pentium M Dothan series (the recent-ish ones, with 2Mb=20
> cache) each come in four variants, VID#A through VID#D. Each=20
> variant has=20
> a different set of voltage characteristics, but unforutnately=20
> there is=20
> no way to tell which variant one has installed (is this=20
> actually true?=20
> How about a visual inspection?)
>=20
> The patch assumes that your Pentium M is a VID#C variant. If=20
> this is not=20
> the case, and there is too much of a mismatch between the voltage=20
> characteristics, then (possibly-serious) problems may ensue.
>=20
> This is my understanding as to why Dothan frequency tables=20
> have not yet=20
> appeared in any "official" patch, and to why this particular=20
> patch was=20
> rejected.
>=20
> cheers,
>=20
> Rich
>=20
> Galin Yordanov wrote:
> > Hello,
> >=20
> > I have Acer TM4500 with Centrino 1.6 (Dothan)and i had the same=20
> > problem .. then i found this patch (attached), cannot=20
> remember where i=20
> > found it but it works ;)
> >=20
> > Regards,
> > Galin
> > On Thursday 10 February 2005 04:38 am, Simon Moore wrote:
> >=20
> >>Hi,
> >>
> >>I'm trying to get acpi cpu throttling working for my Dell Inspiron=20
> >>510m with a Pentium M Centrino 1.6 Ghz cpu.
> >>
> >>I have tried a number of possibilites but have not got anywhere. I=20
> >>have an open case over at the gentoo forums but we have not had=20
> >>success in resolving this problem.
> >>
> >>This is my last ditch attempt to try and find a solution to this=20
> >>problem. I think I have exhausted most possible avenues so=20
> I'm trying=20
> >>to get some kernel hacker on board and help me with this.
> >>
> >>I would very much appreciate it if someone could take a=20
> look at this=20
> >>thread and possbily come up with a suggestion of what might=20
> be causing=20
> >>this. (http://forums.gentoo.org/viewtopic.php?p=3D2076710) I=20
> have a lot=20
> >>of info in that thread that you should find useful but if=20
> there's any=20
> >>other info you require I'll post it tonight.
> >>
> >>For what it's worth I hope it intrigues some of you enough=20
> to help me=20
> >>out.
> >>
> >>Thanks all the same,
> >>
> >>Regards,
> >>
> >>Saimon
> >>
> >>
> >>--------------------------
> >>Saimon Moore
> >>Departamento TI
> >>CondisLine e-Commerce S.A.
> >>
> >>telf./fax: 93 565 3400 ext. 473 / 935752325=20
> http://www.condisline.com
> >>mailto://simon_moore-HnN13UdsTkzz1n+OaKNE4w@public.gmane.org
> >=20
> >=20
>=20
>=20
>=20
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from=20
> real users. Discover which products truly live up to the=20
> hype. Start reading now.=20
> http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396> &op=3Dclick
>=20
> _______________________________________________
>=20
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
> https://lists.sourceforge.net/lists/listinfo/ac> pi-devel
>=20


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
