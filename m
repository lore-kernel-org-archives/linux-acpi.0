From: Christian Hesse <mail-8oMOrB1mGocUSW6y5lq3GQ@public.gmane.org>
Subject: Re: Success with kernel-swsusp and Nvidia-closed-source
Date: Thu, 4 Nov 2004 14:03:05 +0100
Message-ID: <200411041403.05445.mail@earthworm.de>
References: <Pine.LNX.4.60.0411031215260.1187@frog.athome> <1099534267.3991.52.camel@desktop.cunninghams> <Pine.LNX.4.60.0411041242210.1565@frog.athome>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4592627.z9qNfo88RC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.60.0411041242210.1565-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
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

--nextPart4592627.z9qNfo88RC
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 04 November 2004 12:59, liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
> Salut Nigel,
>
> On Thu, 4 Nov 2004, Nigel Cunningham wrote:
> > Hi.
> >
> > On Thu, 2004-11-04 at 09:29, liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
> >> -----BEGIN PGP SIGNED MESSAGE-----
> >> Hash: SHA1
> >>
> >> Salut Christian,
> >>
> >> On Wed, 3 Nov 2004, Christian Hesse wrote:
> >>> I'm using software suspend 2.1. For me suspend works fine, but the
> >>> system freezes as soon as it is resumed, I only see a black screen
> >>> then. Driver nv works without any problems. Any hints what could be t=
he
> >>> cause?
> >>
> >> I did not patch in anything into the kernel. I used a vanilla 2.6.9
> >> (only the Makefile was patched to show 2.6.9 instead of 8 ... maybe
> >> somebody watched a bit too much tv... :-)
> >> So I did not use swsusp 2.1. And I could not manage to freeze on resume
> >> this time. So, why didn't you try the vanilla-kernel, with the
> >> Haggi' s patch for the nvidia driver?
> >> When you test - be sure to sync before suspending. It's the second bes=
t,
> >> besides having a jung backup handy.
> >
> > I guess I'm doing something driver related that Pavel isn't or vv :>.
> > Can I get a pointer to the driver source?
>
> The closed source driver from Nvidia is at
> http://download.nvidia.com/XFree86/Linux-x86/1.0-6111/NVIDIA-Linux-x86-1.=
0-
>6111-pkg1.run For me to make it work, you first needed to extract it with
> --extract-only Then apply Haggi's patch (attached). Otherwise it refused =
to
> suspend: Could not suspend device 0000:01:00.0: error -1
> But all this is not with Swsusp 2.1, but with the 2.6.9-kernel, and works
> as it should.
> I think Christian is also using 6.111??? nvidia driver with Swsusp 2.1.

Yes, I use 1.0-6111 as well.

=2D-=20
Christian

--nextPart4592627.z9qNfo88RC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.10 (GNU/Linux)

iD8DBQBBiiiJlZfG2c8gdSURAmsWAKCj/VTmrxViuwgHOw7kbHmJ7m71pgCg/cb2
XY51KVLI9nDDZGMtzJLoB00=
=wsiW
-----END PGP SIGNATURE-----

--nextPart4592627.z9qNfo88RC--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
