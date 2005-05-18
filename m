From: Tomasz Kojm <tkojm-Vl9ZkupcxcOsTnJN9+BGXg@public.gmane.org>
Subject: Re: Suspend2ram on Toshiba Tecra A3
Date: Thu, 19 May 2005 00:15:01 +0200
Message-ID: <20050519001501.342fa080@Wierszokleta.pl>
References: <20050407032029.4b0c9fea@Wierszokleta.pl>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=Signature_Thu__19_May_2005_00_15_01_+0200_BDAdkfettzapbMrb;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050407032029.4b0c9fea-c4cg+czvUqh2dnOJU1uSgA@public.gmane.org>
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
Cc: Jens Axboe <axboe-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--Signature_Thu__19_May_2005_00_15_01_+0200_BDAdkfettzapbMrb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 7 Apr 2005 03:20:29 +0200
Tomasz Kojm <tk-/1co0IagGzoYDkwjdqtpGQ@public.gmane.org> wrote:

> I'm fighting with S3 on Toshiba Tecra A3 without success for a few
> days now. I've tried all combinations of acpi_sleep on various kernels
> (including -mm ones) down to 2.6.8 and the effect is always the same:
> laptop properly(?) suspends but on resume it doesn't initialize
> graphics (LCD is off) and seem to be hanged (at least the keyboard,
> because the system doesn't react on any commands, including
> ctrl+alt+del). The computer is based on the Intel 915 GM chipset with
> integrated graphics.

The following sata suspend/resume patch (manually applied on 2.6.12-rc4)
from Jens Axboe fixes the problem with S3 on my laptop:

http://lkml.org/lkml/2005/5/2/46

Thanks,

--=20
   oo    .....         Tomasz Kojm <tkojm-Vl9ZkupcxcOsTnJN9+BGXg@public.gmane.org>
  (\/)\.........         http://www.ClamAV.net/gpg/tkojm.gpg
     \..........._         0DCA5A08407D5288279DB43454822DC8985A444B
       //\   /\              Thu May 19 00:13:47 CEST 2005

--Signature_Thu__19_May_2005_00_15_01_+0200_BDAdkfettzapbMrb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCi75lVIItyJhaREsRAiRwAJ4lLndLUd+PfA+1DZ7w9B8/TmJ7ygCfU734
YIPYFROSGb7bc1dJPGv0kZA=
=2Jho
-----END PGP SIGNATURE-----

--Signature_Thu__19_May_2005_00_15_01_+0200_BDAdkfettzapbMrb--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
