From: Rob Hughes <rob-d2NfoQ5nhImakBO8gow8eQ@public.gmane.org>
Subject: Re: ACPI 20030428 causing IP_TABLES problems?
Date: 07 May 2003 08:56:34 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1052315794.28825.4.camel@kahuna-ws.robhughes.com>
References: <1052269459.15665.162.camel@kahuna-ws.robhughes.com>
	 <20030507130657.GA29534@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-W58Gi055kMf+0wqBi8vE"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030507130657.GA29534-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-W58Gi055kMf+0wqBi8vE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-05-07 at 08:06, Matthew Wilcox wrote:
> On Tue, May 06, 2003 at 08:04:19PM -0500, Rob Hughes wrote:
> > Attached is the output of ld against the ip_tables.o module. I've been
> > working on this for about a week, but haven't been able to make any
> > progress. Is it known that the acpi patches cause unresolved symbol
> > errors in ip_tables?
>=20
> Looks like you didn't rebuild your modules and kernel against the same
> set of headers.  i recommend you make clean and then "make compressed
> modules".  Nothing really to do with acpi.

I'm using make dep&&make clean&&make bzImage&&make modules&&make
modules_install, all from the same source directory, patched with
2.4.21-rc1+ACPI20030428. This is all on a RH 9 box. I'll try the make
compressed modules. I if I simply omit ip_tables from the config, all my
other modules build cleanly, so I'm not sure that'll help. But it's
worth a shot I suppose.

Thanks,
Rob

--=-W58Gi055kMf+0wqBi8vE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Please use bofh key to send me personal data.

iD8DBQA+uRCR/9y+qWKu6HERAl6DAKCHg955QPwf+/nXONMTnd18o3JrMQCaAwBZ
pv0ElUFPgFZU/UO94qQjWF4=
=N8fB
-----END PGP SIGNATURE-----

--=-W58Gi055kMf+0wqBi8vE--



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
