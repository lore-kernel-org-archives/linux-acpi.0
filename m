From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: 2.6 won't poweroff
Date: Thu, 27 May 2004 02:40:01 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1085622000.3503.10.camel@darkstar>
References: <20040525044514.GC2217@smeagol>
	 <16563.119.414292.134855@aber.ac.uk>  <20040526043252.GF2576@smeagol>
Reply-To: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040526043252.GF2576-Kz9ENIl45+A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Emma Jane Hogbin <emmajane-MHIYrZpDPrNWk0Htik3J/w@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,
On Wed, 2004-05-26 at 05:32, Emma Jane Hogbin wrote:
> On Tue, May 25, 2004 at 09:14:47AM +0100, Fred Labrosse wrote:
> > Emma Jane Hogbin writes:
> >  > I have two big irritants for the 2.6.5/2.6.6 (patched for ACPI) kern=
els=20
> >  > with ACPI.=20
> >  >=20
> >  > 	1. My computer no longer powers off. acpi_power_off is called, but =
the
> >  > 	computer doesn't actually turn itself off. In fact when I use
> >  > 	"poweroff" directly I get a message flashing across my screen sayin=
g:
> >  > 		syntax error on 658 of stdin
> >=20
> > I did try various combinations (APIC off, on, no compiled in, went back=
 to
> > 2.4.26, 2.4.25-gentoo-r2, 2.6.4, 2.6.6-rc2(?)), to no avail.  It used t=
o
> > work fine when I was running RH8 with (I think) 2.4.24 (I now run gento=
o).
>=20
> I turned CONFIG_X86_GOOD_APIC=3Dy to =3Dn and I still can't shut down
> properly. I'm not sure why it did work in 2.4.22 but doesn't now. :(

1- Have you configure Power Management support on yes (CONFIG_PM=3Dy) ?
2- you use poweroff command or shutdown -h now ? poweroff can have
better results (I think).
3- no longer have to worry about compile w/ or w/o APIC because you
should have same results if you use "nolapic" on boot options, or not
use.

best regards,=20
--=20
S=E9rgio M. B.



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
