From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: AML parser modifications - 2.6.10 - 2.6.10-bk7 - AE_AML_BUFFER_LIMIT
Date: Mon, 7 Feb 2005 14:15:52 -0800
Message-ID: <971FCB6690CD0E4898387DBF7552B90E828898@orsmsx403.amr.corp.intel.com>
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
To: Jan Kasprzak <kas-0hYGf3jDe+XrBKCeMvbIDA@public.gmane.org>, Thomas Renninger <mail-smMupaH/RwJM7kwft8N7nw@public.gmane.org>
Cc: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This was fixed recently:

14 January 2005.  Summary of changes for version 20050114:

1) ACPI CA Core Subsystem:

Fixed an issue with the String-to-Buffer conversion code where the
string null terminator was not included in the buffer after conversion,
but there is existing ASL that assumes the string null terminator is
included. This is the root of the ACPI_AML_BUFFER_LIMIT regression. This
problem was introduced in the previous version when the code was updated
to correctly set the converted buffer size as per the ACPI
specification. The ACPI spec is ambiguous and will be updated to specify
that the null terminator must be included in the converted buffer. This
also affects the ToBuffer() ASL operator.


> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
> Jan Kasprzak
> Sent: Monday, February 07, 2005 3:18 AM
> To: Thomas Renninger
> Cc: ML ACPI-devel
> Subject: Re: [ACPI] AML parser modifications - 2.6.10 -=20
> 2.6.10-bk7 - AE_AML_BUFFER_LIMIT
>=20
>=20
> Thomas Renninger wrote:
> :=20
> : I have a machine booting with 2.6.10 not booting any more=20
> with 2.6.10-bk7 .
>=20
> 	I want to add a "me too" (I have posted this few days=20
> ago). Asus M6R, the similar "kind-of-strcmp" method, which=20
> fails on newer kernels with AE_AML_BUFFER_LIMIT (2.6.9 is OK).
>=20
> [...]
> : Seems as if accessing BUF0[20] (C style) the kernel thinks=20
> the index is=20
> : out of bounds, but it shouldn't ?!?
> : Is this a regression in the kernel, or was the dsdt=20
> code/syntax always=20
> : wrong, but accepted by previous kernels?
>=20
> 	I don't know either. But 2.6.9 seems to be OK WRT this.
>=20
> -Y.
>=20
> --=20
> | Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work |=20
> yenya.net - private}> |
> | GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7=20
> 8B35FCDE05B18A5E |
> | http://www.fi.muni.cz/~kas/   Czech Linux Homepage:=20
> http://www.linux.cz/ |
> > Whatever the Java applications and desktop dances may lead=20
> to, Unix will <
> > still be pushing the packets around for a quite a while.   =20
>   --Rob Pike <
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: IntelliVIEW -- Interactive=20
> Reporting Tool for open source databases. Create drag-&-drop=20
> reports. Save time by over 75%! Publish reports on the web.=20
> Export to DOC, XLS, RTF, etc. Download a FREE copy at=20
> http://www.intelliview.com/go/osdn_nl
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
