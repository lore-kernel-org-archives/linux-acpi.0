From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Subject: Re: No events when pressing power button
Date: 05 Aug 2002 23:27:33 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1028594912.1622.4.camel@darkstar.portugal>
References: <Pine.LNX.4.44.0208020007200.7699-100000@blueberrysolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Tony Glader <Tony.Glader-cP9NhJtB8odr1ooMESYBxBZCeNDtXRbv@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2002-08-01 at 17:11, Tony Glader wrote:
>=20
> Hi!
>=20
> I patched my kernel (2.4.18) today with latest version of acpi-patch=20
> (acpi-20020726-2.4.18.diff). My power button gets detected but I dont get=
=20
> any events from it. I have a ABit BP6 with dual celeron processors.
>=20
> Acpi reports at boot:
>=20
> ACPI: Power Button (FF) [PWRF]
> ACPI: Processor [CPU] (supports C1)
> ACPI: Processor [CPU1] (supports C1)
> ACPI: Thermal Zone [THRM] (46 C)
>=20
> What could be wrong? I tried latest acpid rpm and 'cat /proc/acpi/event'=20
> without results. Acpid doesn't write nothing to /var/log/acpid when I=20
> press power button.=20
>=20
had you try kacpid patch=20
that detects lost acpi events

http://codecs.home.sapo.pt/acpi/
or=20
http://www.pps.jussieu.fr/%7Ejch/software/presario/

S=E9rgiomb



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
