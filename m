From: Christian Hesse <christian.hesse-5lmcC6f56PSELgA04lAiVw@public.gmane.org>
Subject: Re: Success with kernel-swsusp and Nvidia-closed-source
Date: Wed, 3 Nov 2004 19:58:43 +0100
Message-ID: <200411031958.47910.christian.hesse@linuxob.de>
References: <Pine.LNX.4.60.0411031215260.1187@frog.athome>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5246825.nPloxXU9yr";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.60.0411031215260.1187-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--nextPart5246825.nPloxXU9yr
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 03 November 2004 12:25, liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
> Salut Folks,
> just had a bit of spare time to re-iterate the test, if my Acer TM634
> (with it's Nvidia 2 Go) would now be ready for suspend-to-disk.
>
> Since some time ago, it is no problem to suspend to disk, if using the
> open-source (i.e. nv) driver for X. As it has problems with perfomance,
> e.g. DVD-playback is so slow, that the audio stops playing... I need to
> use the closed source driver.
> With plain Linux 2.6.9 it nearly worked. It reported:
> Could not suspend device 0000:01:00.0: error -1
>
> After a quick search on Nvidia's forums I steped over Haggis dirty hack
> for the NVIDIA-Linux-x86-1.0-6111-pkg1. I attached this. Now suspending to
> disk works relyably for me.
>
> Cheers
>    hartwig felger
>
> Hartwig Felger informatics
> P.S.: with mplayer I use the gl2 device with the nvidia-driver.

I'm using software suspend 2.1. For me suspend works fine, but the system=20
freezes as soon as it is resumed, I only see a black screen then. Driver nv=
=20
works without any problems. Any hints what could be the cause?

=2D-=20
Christian Hesse

geek by nature
linux by choice

--nextPart5246825.nPloxXU9yr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.10 (GNU/Linux)

iD8DBQBBiSpnlZfG2c8gdSURAh9CAJ9EjWrxm0PUFZpsSnjbPMCHIV44MwCfX2LW
GlssFziCmvg73RvQvHhqw/Q=
=uNBX
-----END PGP SIGNATURE-----

--nextPart5246825.nPloxXU9yr--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
