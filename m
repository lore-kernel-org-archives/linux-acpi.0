From: "Zhu, Yi" <yi.zhu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI on RH9 - just Hangs during Init
Date: Thu, 8 Apr 2004 21:29:24 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F842DB1A8@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ow Mun Heng <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>, "Acpi-List (E-mail)" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: "Arindam Dey (E-mail)" <adey-bmTD0NCZhtfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Ow Mun Heng wrote:
> Hi,
>=20
> 	I'm having some issues getting ACPI to work for a
> default RH9 install with kernel 2.4.20-8.
>=20
> Just unchecked apm and selected acpi nothing else. Did not
> want to mess around with anything else. KErnel compiled just
> fine but then it reaches init and before the messages start
> it just bloody sits there doing nothing nothing at all. No
> msgs no cpu light nothing. Its  very creepy.
>=20
> This is a Samsung Laptop.
>=20
> Can I buy a clue here???

Does appending "acpi=3Doff" boot your new compiled kernel?
If yes, can you please provide your DSDT by using=20
$ ./acpidmp DSDT > /tmp/DSDT
You can download acpidmp from
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/pmtools-20
031210.tar.bz2

Thanks,
-yi



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
