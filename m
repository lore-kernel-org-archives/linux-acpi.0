From: Christian Hesse <christian.hesse-5lmcC6f56PSELgA04lAiVw@public.gmane.org>
Subject: Re: Success with kernel-swsusp and Nvidia-closed-source
Date: Thu, 4 Nov 2004 18:12:51 +0100
Message-ID: <200411041812.54813.christian.hesse@linuxob.de>
References: <Pine.LNX.4.60.0411031215260.1187@frog.athome> <Pine.LNX.4.60.0411041242210.1565@frog.athome> <Pine.LNX.4.60.0411041729180.4727@frog.athome>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1725185.Hj2T3Li9qG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.60.0411041729180.4727-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
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
Cc: Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--nextPart1725185.Hj2T3Li9qG
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 04 November 2004 17:36, liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
> Salut Christian,
>
> On Thu, 4 Nov 2004 liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
> >>> Salut Christian,
> >>>
> >>> On Wed, 3 Nov 2004, Christian Hesse wrote:
> >>>> I'm using software suspend 2.1. For me suspend works fine, but the
> >>>> system
> >>>> freezes as soon as it is resumed, I only see a black screen then.
> >>>> Driver nv
> >>>> works without any problems. Any hints what could be the cause?
>
> I played a bit with my X setup. When I force X to use the ali-agp instead
> of the "NVIDIA internal" I get a nearly lockedup machine on resume. This
> is obviously some bug in the linux-agp-driver-tree. Also if I change to a
> runlevel without X I may rmmod the nvidia module but not the agp-modules.
> So they are really buggy (at least the ali-agp, which I would have to
> use). The workaround, if I get such a lockedup machine is to login over
> the network and
>   killall -9 X
> because kill alone will not be enought. So you may want to try
>       Option      "NvAGP" "1"
> in your /etc/X11/XF86Config.
>
> Let us know if this gets you any further. When I find time, I will give
> swsusp 2.1 another try myself!

I disabled AGP in my kernel config, recompiled the module and added the lin=
e=20
mentioned above in my xorg.conf - nothing changed. Screen is still black=20
after resume. But I can confirm that I can log in via network and killall -=
9=20
X.

=2D-=20
Christian Hesse

geek by nature
linux by choice

--nextPart1725185.Hj2T3Li9qG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.10 (GNU/Linux)

iD8DBQBBimMWlZfG2c8gdSURAvksAKDck3pv1o+hUw8V4+0kaLEeG1rcFwCgyZGL
BJvWEuq32Xnh3O39tSMwWmE=
=tCiT
-----END PGP SIGNATURE-----

--nextPart1725185.Hj2T3Li9qG--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
