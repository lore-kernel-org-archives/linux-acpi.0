From: Sebastian Henschel <acpi-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Subject: Re: [ACPI] Re: [ACPI-sppt] supported machines
Date: Mon, 16 Jun 2003 09:46:56 +0200
Sender: acpi-support-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030616074656.GB645@enigma.daemon.sh>
References: <20030612041209.GA3201@xtrinsic.com> <005501c330ec$6d0c17b0$3746028e@bio.dfo.ca> <20030612142429.GE567@xtrinsic.com> <00fc01c330f0$ea66dd40$3746028e@bio.dfo.ca> <20030612170817.GB1494@xtrinsic.com> <003b01c33113$43186e00$3746028e@bio.dfo.ca> <20030613095618.GC2580@enigma.daemon.sh> <20030613174054.GA3012@hell.org.pl>
Reply-To: acpi-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Return-path: <acpi-support-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030613174054.GA3012-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-support-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-support-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-support>,
	<mailto:acpi-support-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-support>,
	<mailto:acpi-support-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-support>
To: acpi-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


hi karol..

* Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org> [2003-06-16 09:06 +0200]:
> Thus wrote Sebastian Henschel:
> > well, if any manufacturer reads this, please raise your voice. :)
> > only including patches whould also have a technical benefit: the file
> > sizes would become smaller.
> > so if you found some more supporters, i would update the pages, files a=
nd
> > database as good as i can. the downside is that i cannot generate a diff
> > from the DSTDs where there is no "original" table provided.
>=20
> On the other hand, having the DSDT's in one place is very handy and helps
> in driver development. At least, we used the database frequently with
> Julien, and handling the development without it would be much less
> convenient.

you mean you looked into the DSDTs of machines you did not have at hand?
valid point, i think.

another problem i found with diffs is the following:
we have no "real" source code of the table. what we have is some binary
file where we run a tool for disassembly on. _most_ people use iasl, but
do they all do? and apart from that, perhaps different versions of the same
tool produce different ASL code. so it is quite possible that a patch
can fail, which can be a trivial... or something more sophisticated.

> Does file size (we're talking kilobytes of gzipped data) really
> matter anyway?

well, one archive of DSDTS is about 590k (40k DB) at the moment. this
surely does not matter. but due to constraints of sf.net i had to
install a little backup scheme which accumulates that amount of data for
each day. i usually download the backups once or twice a week and delete
them on sf.net afterwards. since we have 100MB available on sf.net, it
should not be a problem for now. but the backup scheme must be slowed
down when i am away from internet for a couple of weeks. so no, it does
not matter that much, just a little.

ok, i suggest to put the discussion back on acpi-support only, since no
big discussion has arisen on acpi-devel, but they know about it. :)

cheers,
 sebastian
--=20
::: sebastian henschel
::: kodeaffe
::: lynx -source http://www.kodeaffe.de/shensche.pub | gpg --import

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+7XXwreHfL3pi+bQRArjMAKCE9ithy7besktob9n/kvDnX+Rc2QCgkq6B
VAfGBw8fo57uDdtHgddLtbU=
=x8Ax
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--


-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
