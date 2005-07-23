From: Iacopo Spalletti <avvisi-m0DhsibC5ZROhR2lhbcafA@public.gmane.org>
Subject: Re: ASUS hotkeys regression in 2.6.13-rc3
Date: Sat, 23 Jul 2005 20:24:42 +0200
Message-ID: <200507232024.43790.avvisi@spalletti.it>
References: <3ACA40606221794F80A5670F0AF15F84041AC1E8@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="gb2312"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041AC1E8@pdsmsx403>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Alle 19:59, sabato 23 luglio 2005, Yu, Luming ha scritto:
> sorry , it is kernel boot option: acpi_specific_hotkey.
>
> Thanks
> Luming
The option is enabled (without it i could only load hotkey generic module=20
which seems not to enable asus hotkeys).
Anyway i think that acpi_specific_hotkey should be enabled by default for=20
consistency with previous versions

>
> >-----Original Message-----
> >From: Yu, Luming
> >Sent: 2005=C4=EA7=D4=C224=C8=D5 1:58
> >To: 'Iacopo Spalletti'; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> >Subject: RE: [ACPI] ASUS hotkeys regression in 2.6.13-rc3
> >
> >Please try kernel operation acpi_specific_hotkey.
> >I'm thinking to change the default value of
> >acpi_specific_hotkey_enabled to TRUE .
> >
> >Thanks
> >Luming
> >
> >>-----Original Message-----
> >>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> >>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of
> >>Iacopo Spalletti
> >>Sent: 2005=C4=EA7=D4=C223=C8=D5 15:26
> >>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> >>Subject: [ACPI] ASUS hotkeys regression in 2.6.13-rc3
> >>
> >>I would like to point out a regression in asus hotkey function
> >>in 2.6.13-rc3
> >>(filed in kernel bugzilla:
> >>http://bugzilla.kernel.org/show_bug.cgi?id=3D4906).
> >>Any idea for further investigations?
> >>
> >>--
> >>
> >>IS
> >>Iacopo Spalletti
> >>iacopo-m0DhsibC5ZROhR2lhbcafA@public.gmane.org
> >>PGP key block: http://www.spalletti.it/pgp
> >>
> >>
> >>-------------------------------------------------------
> >>SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> >>from IBM. Find simple to follow Roadmaps, straightforward articles,
> >>informative Webcasts and more! Get everything you need to get up to
> >>speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dcl=
ick
> >>_______________________________________________
> >>Acpi-devel mailing list
> >>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> >>https://lists.sourceforge.net/lists/listinfo/acpi-devel

=2D-=20
Ciao
IS
Iacopo Spalletti
iacopo-m0DhsibC5ZROhR2lhbcafA@public.gmane.org
PGP key block: http://www.spalletti.it/pgp


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
