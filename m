From: "Haas Ingo" <Ingo.Haas-woH5cNrEj6o@public.gmane.org>
Subject: WG: ACPI reboot hangs Asus p4b533
Date: Thu, 7 Jul 2005 09:12:13 +0200
Message-ID: <795E03B0F1E26C449762C0EDF5F5659101207B8E@Exchange.plg.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> 	Hi,
>=20
> 	Referring to this message ID
> http://sourceforge.net/mailarchive/message.php?msg_id=3D11441947 which
> meaning has this function?=20
> 	I mean "acpi_motherboard_init" in "motherboard.c".=20
>=20
> 	We have the same problem with P4B533 and init 6 with kernel
> 2.4.31. And if we use this workaround the problem seems to be fixed.
> 	I commented the call of the function out within "bus.c".
>=20
> 	Can this solution make problems?  And if, which?
>=20
> 	Regards=20
>=20
> 	Ingo Haas
>=20
>=20


*************************************************************************=
******
Wichtiger Hinweis: Diese Information ist fur den Gebrauch durch die =
Personen=20
oder die Firma / Organisation bestimmt, die in der Empfangeradresse =
benannt ist.=20
Wenn Sie nicht der angegebene Empfanger sind, nehmen Sie bitte zur =
Kenntnis,=20
dass Weitergabe, Kopieren, Verteilung oder Nutzung des Inhaltes dieser =
E-Mail=20
unzulassig ist. Falls Sie diese E-Mail irrtumlich erhalten haben, =
benachrichtigen=20
Sie den Absender bitte unverzuglich. Vielen Dank fur Ihre Unterstutzung.

Important Note: This e-mail may contain trade secrets or privileged, =
undisclosed or
otherwise confidential information. If you have received this e-mail in =
error, you are
hereby notified that any review, copying or distribution of its contents =
is strictly
prohibited. Please inform us immediately if you have received this =
e-mail erroneously.
Thank you for your cooperation.
*************************************************************************=
******



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
