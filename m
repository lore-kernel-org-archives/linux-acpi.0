From: Sebastian Henschel <shensche-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Subject: Re: [Patch] DSDT in initrd
Date: Tue, 6 May 2003 12:09:49 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030506100949.GC973@enigma.daemon.sh>
References: <Pine.LNX.4.53.0305052221420.8540@tweety.gaugusch.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5G06lTa6Jq83wMTw"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0305052221420.8540-qopfHk9/S+VQK2oVCIMtW7NldLUNz+W/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Markus Gaugusch <markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi markus...

Received at 2003-05-06 / 09:02 by Markus Gaugusch:

> I've implemented my patch to put the DSDT into the initial ramdisk.
> It uses the same approach as bootsplash: just use the raw initrd data.

hey, it seems to work here. my ac_adapter is back with my custom DSDT
=66rom the initrd.  :) thank you very much.

> 1.) enable CONFIG_BLK_DEV_INITRD and CONFIG_ACPI_INITRD

perhaps you should also say that the ramdisk support has to be
included statically (CONFIG_BLK_DEV_RAM=3Dy). i had it as a module and was
looking for these options to no avail. :)

> Then reboot.
> The message "Looking for DSDT in initrd... found!" should be in your dmesg
> after next boot. (for some reason <6> is before "found", but I'm sure
> that someone will be able to give me the right pointers to fix that).

i do not know much about printk, but possibly, KERN_INFO (<6>) is only
parsed when it is at the beginning of a line. so your "found" or "not
found" statements would also be printed out with KERN_INFO as subsequent
calls of printk without a newline, although the do not start with
KERN_INFO. just a wild guess. :)

cheers,
 sebastian

--=20
::: sebastian henschel
::: kodeaffe
::: lynx -source http://www.kodeaffe.de/shensche.pub | gpg --import

--5G06lTa6Jq83wMTw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+t4ntreHfL3pi+bQRAv0qAJ9+h8Xr5ahX47UNgJsH+jCorVTiRQCgi6nD
mUvsmaKNbn+6+SFrdgmhQoY=
=1872
-----END PGP SIGNATURE-----

--5G06lTa6Jq83wMTw--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
