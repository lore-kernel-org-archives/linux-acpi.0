From: Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Battery status reading problems
Date: Thu, 25 Sep 2003 22:38:57 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m24qz0f6ry.fsf@tnuctip.rychter.com>
References: <m2vfrpthxt.fsf@tnuctip.rychter.com>
	<Pine.LNX.4.58.0309192257480.1613@phoenix.kerstin.at>
	<3F6EAADC.4020509@basmevissen.nl>
	<Pine.LNX.4.53.0309220954120.9385@dynast.gaugusch.at>
	<1064230622.8592.14.camel@dhcp23.swansea.linux.org.uk>
	<3F703933.50604@basmevissen.nl>
	<1064334307.14784.92.camel@idoru.kc.de>
	<Pine.LNX.4.58.0309232001000.1228@frog.athome>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0309232001000.1228-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org> (liste@hgfelger.de's
 message of "Tue, 23 Sep 2003 20:11:38 +0200 (CEST)")
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

Hartwig Felger:
> Salut Nils,
> On Tue, 23 Sep 2003, Nils Faerber wrote:
> > Am Di, 2003-09-23 um 14.14 schrieb Bas Mevissen:
> > > Alan Cox wrote:
> > > > Several vendors implement the actual battery reading logic as an SMI
> > > > trap and disable interrupts during their slow chat with the battery.
> > > > There isnt much anyone can do about that bit alas (except read it a=
 lot
> > > > less often)
> > > (or does the AC/battery power work with an event? The my assumption
> > > won't hold then)
> I commented on that before!
>=20
> > I could very well accept CPU load.
> > I would even accept delays, given they are small.
> > But I experienced kernel hangs, i.e. short periods of no I/O activity at
> > all when querying the battery status. And even that could be acceptable.
> > What was not acceptable were very bizarre happenings that lokked like
> > lost interrupts!? Events that did not cause the reaction they should
> > have. Less severe were lost mouse events but more severe was packet loss
> > on network.
> That are the things that follow from, what Alan is saying - interrupts are
> disabled over some time.
>=20
> > So for me it looks more like a bug in the ACPI code than just a
> > performnce issue or hardware misdesign.
> > The other thing that leads to this assumption is that so many of us see
> > this happening, with various notebooks by various manufacturers. It is
> > not bound to certain or limited number of "bad" machines.
> Sorry to tell you, that I have no problems with my Acer TM630. I did try a
> bash-loop with a uspleep 10, always querrying the battery-state, that did
> not consume any interrupts on my maschine. May you collect, what various
> notebooks you claim are affected?

[...]

For the reference, I have always had performance problems with reading
the battery status on my Sharp Mebius. I can't use any "battery applets"
nor cpufreqd because of that -- they eat too much CPU power and cause
the whole machine to slow down.

I got bored with reporting this all over again, and since this issue has
been largely ignored by developers, I decided I can do without battery
information after all.

=2D-J.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/c9DzLth4/7/QhDoRAl96AKDy/kjfQjebX39Wx0lKmXnQfKk1WwCghIkz
6M/8Bvt80/NGqW9yUc/tRTE=
=ITsK
-----END PGP SIGNATURE-----
--=-=-=--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
