From: Christian Hesse <mail-8oMOrB1mGocUSW6y5lq3GQ@public.gmane.org>
Subject: Re: Success with kernel-swsusp and Nvidia-closed-source
Date: Sun, 7 Nov 2004 20:52:48 +0100
Message-ID: <200411072052.53065.mail@earthworm.de>
References: <Pine.LNX.4.60.0411031215260.1187@frog.athome> <Pine.LNX.4.60.0411041729180.4727@frog.athome> <200411041812.54813.christian.hesse@linuxob.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1636727.5EFEHKvxbe";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200411041812.54813.christian.hesse-5lmcC6f56PSELgA04lAiVw@public.gmane.org>
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
Cc: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org, Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--nextPart1636727.5EFEHKvxbe
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 04 November 2004 18:12, Christian Hesse wrote:
> On Thursday 04 November 2004 17:36, liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
> > Salut Christian,
> >
> > On Thu, 4 Nov 2004 liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
> > >>> Salut Christian,
> > >>>
> > >>> On Wed, 3 Nov 2004, Christian Hesse wrote:
> > >>>> I'm using software suspend 2.1. For me suspend works fine, but the
> > >>>> system
> > >>>> freezes as soon as it is resumed, I only see a black screen then.
> > >>>> Driver nv
> > >>>> works without any problems. Any hints what could be the cause?
> >
> > I played a bit with my X setup. When I force X to use the ali-agp inste=
ad
> > of the "NVIDIA internal" I get a nearly lockedup machine on resume. This
> > is obviously some bug in the linux-agp-driver-tree. Also if I change to=
 a
> > runlevel without X I may rmmod the nvidia module but not the agp-module=
s.
> > So they are really buggy (at least the ali-agp, which I would have to
> > use). The workaround, if I get such a lockedup machine is to login over
> > the network and
> >   killall -9 X
> > because kill alone will not be enought. So you may want to try
> >       Option      "NvAGP" "1"
> > in your /etc/X11/XF86Config.
> >
> > Let us know if this gets you any further. When I find time, I will give
> > swsusp 2.1 another try myself!
>
> I disabled AGP in my kernel config, recompiled the module and added the
> line mentioned above in my xorg.conf - nothing changed. Screen is still
> black after resume. But I can confirm that I can log in via network and
> killall -9 X.

Tried with nvidias new driver 1.0-6629 today. I managed to make it work onc=
e,=20
but I couldn't reproduce it... :(

=2D-=20
Christian

--nextPart1636727.5EFEHKvxbe
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.10 (GNU/Linux)

iD8DBQBBjn0UlZfG2c8gdSURApIXAKCCZZkoBd0cUGzTPVxSNiAkMQUJ0wCfVPuQ
ZVlp46NFMc/tjz/yYydK9rQ=
=YNCK
-----END PGP SIGNATURE-----

--nextPart1636727.5EFEHKvxbe--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
