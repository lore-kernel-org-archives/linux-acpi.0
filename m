From: Sandro Weiser <sandro.weiser-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: acpi on r40e
Date: Wed, 11 Feb 2004 22:48:11 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200402112248.15925.sandro.weiser@gmx.de>
References: <Pine.LNX.4.44.0402101040090.27892-100000@aero.iisc.ernet.in>
Reply-To: sandro.weiser-Mmb7MZpHnFY@public.gmane.org
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44.0402101040090.27892-100000-8a50ANe9Mx0/NI2e8YfAcJ/QNRX+jHPU@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Dienstag, 10. Februar 2004 06:18 schrieb Praveen C:
> >Interesting.
> >If you boot, say with "acpi=3Doff", your volume and brightness buttons
> >work, but if you boot with ACPI enabled they have no effect?
>
> Thats right. I know that many others with R40e are facing the same
> problems as me with acpi (hangup with processor/thermal modules and the
> special button problems). When I am booting an acpi kernel I have to
> adjust the brightness before the kernel starts. With acpi=3Doff the
> buttons work without me doing anything extra.
>
> There are other buttons which dont work either with or without acpi.
> For example Fn+F3 switches off the backlight in the display in Windows
> but does nothing in Linux. In Linux I can switch off the backlight only
> by closing the lid.
>
> Regarding the hangup with processor/thermal modules I am not
> able to locate any messages in kernel log.
>
> Is there any other information I can provide which help to identify the
> problem?
Here the same with Fn+F3 which doesn't works anymore with acpi
I'm using now apm in 2.4.24 and haven't tested 2.5.XX and 2.6.XX heavily=20
anymore, but

When I experimented with early acpi-support in 2.4 before switching to apm=
=20
(was in March 2003) Fn+F3 *definitely* worked with acpi.

=2D --=20
Sandro Weiser <Sandro.Weiser-Mmb7MZpHnFY@public.gmane.org>
=46ingerprint: 77E0 7C87 4DB2 6BBB 5419  343C 7995 1C67 25B9 CBF1

=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAKqMfeZUcZyW5y/ERAnzHAJ40pSOOCUKerA4pF6HHfAlD2zGKVACgu6zd
N57WKlL25Zg3vYMKpf0H0ns=3D
=3Dfeaw
=2D----END PGP SIGNATURE-----


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
