From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: PROBLEM: Executing /sbin/hwclock hangs 2.4.21-rc[12]
	with ACPI snapshot patches
Date: 01 Jun 2003 01:31:54 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1054427515.1428.18.camel@darkstar.portugal>
References: <Pine.LNX.4.33.0305290042060.1146-100000@frog.athome>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-3Hn2Boz2CpwyXL2jiBYA"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.33.0305290042060.1146-100000-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-3Hn2Boz2CpwyXL2jiBYA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi=20
I this is just a hint (of my imagination) ,=20
this isn't really a patch, it is the return back of=20
ACPI: Indicate whether we handled the interrupt or not.
that is been introduction in 20030424acpi.

I try in my computer and works ok, but I don't have the problem of
hwclock=20
so if you try this patch and if it works. we can solve this problem
putting  this problematic boards on blacklist etc.
So can you try this patch and tell me something.

Note: you just need apply this patch and=20
make bzImage;=20
and install it with:=20
make install.

thanks=20


On Wed, 2003-05-28 at 23:44, hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> On 28 May 2003, S=E9rgio Monteiro Basto wrote:
>=20
> > And with acpi20030522-rc3 have you the hwclock problem ?.
> Yes.
> I did not try the acpi...-rc2 patch myself, but the initiator of this
> thread did...
>=20
> regards
>   hartwig felger
>=20
> Hartwig Felger informatics
>=20
> - --=20
> 1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
> Key fingerprint =3D FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
> For the pulic keys, please visit my page.
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.2 (GNU/Linux)
>=20
> iD8DBQE+1TvD9bBoTzOf1pMRAoX2AJ0fXHrjjXcqUEoSqhBb29P9R388agCfVagt
> YTbwhCxyme2eFdWy/Y17F1k=3D
> =3DXSQQ
> -----END PGP SIGNATURE-----
>=20
--=20
S=E9rgioMB
email: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org

Who gives me one shell, give me everything.

--=-3Hn2Boz2CpwyXL2jiBYA
Content-Disposition: attachment; filename=routingstatic.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=routingstatic.diff; charset=ISO-8859-1

--- arch/i386/kernel/mpparse.c.orig	Sun Jun  1 01:11:28 2003
+++ arch/i386/kernel/mpparse.c	Sun Jun  1 01:11:39 2003
@@ -1269,24 +1269,16 @@
=20
 	/*
 	 * Parsing through the PCI Interrupt Routing Table (PRT) and program
-	 * routing for all entries.
+	 * routing for all static (IOAPIC-direct) entries.
 	 */
 	list_for_each(node, &acpi_prt.entries) {
 		entry =3D list_entry(node, struct acpi_prt_entry, node);
=20
-		/* Need to get irq for dynamic entry */
-		if (entry->link.handle) {
-			irq =3D acpi_pci_link_get_irq(entry->link.handle, entry->link.index);
-			if (!irq)
-				continue;
-		}
-		else
-			irq =3D entry->link.index;
-
-		/* Don't set up the ACPI SCI because it's already set up */
-		if (acpi_fadt.sci_int =3D=3D irq)
+		/* We're only interested in static (non-link) entries. */
+		if (entry->link.handle)
 			continue;
-=09
+
+		irq =3D entry->link.index;
 		ioapic =3D mp_find_ioapic(irq);
 		if (ioapic < 0)
 			continue;

--=-3Hn2Boz2CpwyXL2jiBYA--



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
