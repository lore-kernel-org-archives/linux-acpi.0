From: "Joey Lee" <jlee@novell.com>
Subject: Re: [PATCH] Add Intel Poulsbo Stub Driver
Date: Tue, 14 Sep 2010 12:07:48 -0600
Message-ID: <4C90469402000023000205B8@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Valdis.Kletnieks@vt.edu
Cc: randy.dunlap@oracle.com, mjg@redhat.com, mjg59@srcf.ucam.org, gregkh@suse.de, trenn@suse.de, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Dennis.Jansen@web.de

Hi Valdis,=20

Thank's for your kindly review.

=E6=96=BC =E4=BA=8C=EF=BC=8C2010-09-14 =E6=96=BC 13:10 -0400=EF=BC=8CVa=
ldis.Kletnieks@vt.edu =E6=8F=90=E5=88=B0=EF=BC=9A
> On Tue, 14 Sep 2010 10:39:42 +0800, "Lee, Chun-Yi" said:
> >=20
> > +        select ACPI_VIDEO if ACPI
> > +	help
> > +	  Choose this option if you have a system that has Intel Poulsbo
> > +	  integrated graphics.
>=20
> Can we have a part number or something here?  When I buy a system fro=
m Dell or
> someplace, the spec sheet doesn't say 'Poulsbo', it says 'i945' or 'i=
987' or
> something like that.
>=20
> (If this is a not-yet-escaped-from-engineering new part, maybe a foll=
ow-up patch
> when the part is officially named/announced?)
>=20

I just google the MSI U110/U115 poulsbo netbook on my hand, it's a Inte=
l
Menlow netbook.
I am not sure _Menlow_ is a more popular name compare with _Poulsbo_,
how do you think about that?
Should I put the _Menlow_ in config help ?


Thank's a lot!
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
