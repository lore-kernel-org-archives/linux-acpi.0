From: Christian Hesse <christian.hesse-5lmcC6f56PSELgA04lAiVw@public.gmane.org>
Subject: Re: Success with kernel-swsusp and Nvidia-closed-source
Date: Thu, 4 Nov 2004 09:54:45 +0100
Message-ID: <200411040954.49879.christian.hesse@linuxob.de>
References: <Pine.LNX.4.60.0411031215260.1187@frog.athome> <200411031958.47910.christian.hesse@linuxob.de> <Pine.LNX.4.60.0411032322410.4984@frog.athome>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1790292.Z7fM3SNcsY";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.60.0411032322410.4984-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--nextPart1790292.Z7fM3SNcsY
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 03 November 2004 23:29, liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
> Salut Christian,
>
> On Wed, 3 Nov 2004, Christian Hesse wrote:
> > I'm using software suspend 2.1. For me suspend works fine, but the syst=
em
> > freezes as soon as it is resumed, I only see a black screen then. Driver
> > nv works without any problems. Any hints what could be the cause?
>
> I did not patch in anything into the kernel. I used a vanilla 2.6.9 (only
> the Makefile was patched to show 2.6.9 instead of 8 ... maybe somebody
> watched a bit too much tv... :-)
> So I did not use swsusp 2.1. And I could not manage to freeze on resume
> this time. So, why didn't you try the vanilla-kernel, with the
> Haggi' s patch for the nvidia driver?
> When you test - be sure to sync before suspending. It's the second best,
> besides having a jung backup handy.

Vanilla kernel's suspend to disk is too slow for me. I needs 90 seconds to=
=20
suspend the system (vs. 10 seconds with swsusp-2.1). I think I'll continue=
=20
using nv until Nvidia releases a version of the driver that works without a=
ny=20
problems for me.

=2D-=20
Christian Hesse

geek by nature
linux by choice

--nextPart1790292.Z7fM3SNcsY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.10 (GNU/Linux)

iD8DBQBBie5ZlZfG2c8gdSURAh9dAKD92XrtABtEt8CCyxEDTHXfAU0OdACgue92
A2HTGQ2KSExtArPt3ZktkEI=
=0cS5
-----END PGP SIGNATURE-----

--nextPart1790292.Z7fM3SNcsY--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
