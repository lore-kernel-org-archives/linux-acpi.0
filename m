From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode output - Toshiba Satellite A100
Date: Sat, 19 Jan 2008 02:12:34 -0500
Message-ID: <200801190212.35086.lenb@kernel.org>
References: <47050BAD.6070902@lakeheadu.ca> <200801182318.13320.lenb@kernel.org> <47918E98.9000303@lakeheadu.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48656 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276AbYASHNB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Jan 2008 02:13:01 -0500
In-Reply-To: <47918E98.9000303@lakeheadu.ca>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg Toombs <gtoombs@lakeheadu.ca>
Cc: linux-acpi@vger.kernel.org

On Saturday 19 January 2008 00:46, Greg Toombs wrote:

>     System Information
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Manufacturer: TOSHIBA
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Product Name: Satelli=
te A100
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Version: PSAA5C-TA102=
C
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Serial Number: X60560=
89Q =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0UUID: A75EABB0-539A-1=
1DB-A70E-00A0D1553957
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Wake-up Type: Power S=
witch
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SKU Number: Not Speci=
fied
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Family: Not Specified
>=20
> Handle 0x0002, DMI type 2, 8 bytes
> Base Board Information
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Manufacturer: ATI
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Product Name: SB450</=
pre>
>=20
>   Thanks for the dmidecode output.
>=20
> Do you notice any functional difference when booting with
>=20
> "acpi_osi=3DLinux"        (default for 2.6.22 and earlier)
> vs.
> "acpi_osi=3D!Linux"       (default for 2.6.23 and later)
>=20
> note that users of other Toshiba models find that
> the sound may be broken by one of the above.

> Well, I can tell you that<br>
> - My current linux version is Linux 2.6.22-14-generic #1 SMP Tue Dec =
18
> 08:02:57 UTC 2007 i686 GNU/Linux<br>
> - Sound is broken with the default alsa from Ubuntu (without
> adding any kernel options), but compiling from current alsa sources
> fixes this.<br>
> - My sound still works when I add acpi_osi=3DLinux to my kernel optio=
ns.


Okay, so OSI(Linux) sounds like a NOP from what you can see on this box=
=2E

> Should I install 2.6.23 for trial purposes? (I don't know how to do i=
t
> cleanly; it doesn't show up in synaptic.)

I don't think you need to.  Just speak up if it fails
when you do get to it.

Everything I said about the Dell Vostro 1000 is true of
the Toshiba Satellite A100 -- the ASL is very similar.

"Like others, Dell Vostro 1000 sets LINX, but never checks it.

TPOS and OSTB are also affected, but in the ASL they're referened
only with comparisons > 4, (NT or greater) so OSI(Linux) shouldn't
have any effect there either.

That leaves the return value of OSTP(), which I see invoked
in several places, but the return value is never used.

So I'll add this box to the OSI(Linux) NOP list."

The Toshiba has some additional references to these names
that the Dell doesn't have, but he conclusion is the same.
=2E

BTW. if you can disable HTML format and reply in plain text,
that would be helpful.

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
