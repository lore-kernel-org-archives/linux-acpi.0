From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: RE: Re: ACPI for 2.4
Date: Fri, 26 Mar 2004 15:30:38 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1080315038.2479.21.camel@darkstar>
References: <BF1FE1855350A0479097B3A0D2A80EE002D31BC7@hdsmsx402.hd.intel.com>
Reply-To: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE002D31BC7-N2PTB0HCzHJF3Yvz3xaN/VDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Sergey Vlasov <vsu-u2l5PoMzF/Uox3rIn2DAYQ@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Brown, Len also wrote:
> So I'd like to delete 2.4.22 and 2.4.24 support.  When 2.4.26
> closes,I'll delete 2.4.25 too.

well 2.4.24 and 2.4.25 just have been released because one security
issue, so doesn't have much differences in concerning of acpi and (I
think) that can be delete it.


On Thu, 2004-03-25 at 23:28, Brown, Len wrote:
> >ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/
> >release/2.4.26/acpi-20040311-2.4.26.diff.gz
> Yes, on each release I update the ACPI patch for every release that I
> support.

In fact, you overwrite the patch and can't be applied against 2.26.pre6
isn't it ? I think one=20
acpi-20040311-2.4.26-pre6.diff.gz could be useful for testing, before
been released into kernel tree.

>=20
> >Patch for 2.4.25 seems to be updated too; however, it gives several
> >rejects when applied to a fresh 2.4.25 tree:

> I just tested it on a clean 2.4.25 tree and got no rejects.
> (I tested the .gz edition)
>=20
> Either there was a patch in your tree already, or the
> patch got corrupted.  Note that kernel.org signs their files
> and you can verify their valididity per instructions in here:
>=20
> http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/README.=
ACPI
>=20
> Cheers,
> -Len
>=20

--=20
S=E9rgio M. B.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
