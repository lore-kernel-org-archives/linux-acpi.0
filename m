From: Leonid Isaev <lisaev@umail.iu.edu>
Subject: Re: [arch-general] powernow-k8 fails to load with linux 3.7.2
Date: Fri, 18 Jan 2013 10:59:39 -0600
Message-ID: <20130118105939.5a8788d6@bluemoon>
References: <20130115224755.085aa6b7@bluemoon>
	<20130116131725.4e590c34@bluemoon>
	<CAG-2HqWBVf=RWXExeFgxYdPTzPfQYZnt-3ZKzULTwdP9+-5mVQ@mail.gmail.com>
	<1448223.sdUJnNSRz4@vostro.rjw.lan>
	<20130116231728.GA10204@x1.alien8.de>
	<20130116181600.4c48ee3b@bluemoon>
	<20130117094648.GD30700@pd.tnic>
	<20130117194044.7a18a29d@bluemoon>
	<20130118113717.GA6808@pd.tnic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/c7s4YR5i42AO2c+sUEWGiq."; protocol="application/pgp-signature"
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130118113717.GA6808@pd.tnic>
Sender: cpufreq-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Tom Gundersen <teg@jklm.no>, =?UTF-8?B?QW5kcsOp?= Przywara <andre@andrep.de>, Matthew Garrett <mjg@redhat.com>, cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

--Sig_/c7s4YR5i42AO2c+sUEWGiq.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Jan 2013 12:37:17 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Thu, Jan 17, 2013 at 07:40:44PM -0600, Leonid Isaev wrote:
> > Arrh, modprobe still does not exit cleanly with this...
>=20
> As I said already above:
>=20
> >> That's correct - we say ENODEV on your CPU which supports hardware
> >> P-states and hand off to acpi-cpufreq which has that functionality
> >> now.
>=20
> It is supposed to work that way: we return an error from the powernow-k8
> init function so that it doesn't load but hand off to acpi-cpufreq so
> that it gets loaded instead.
>=20
> > > But, we also have the CPU autoprobing deal:
> > >=20
> > > http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dcommit;h=3D644e9cbbe3fc032cc92d0936057e166a994dc246
> > >=20
> > > so, *actually*, powernow-k8 should be loaded by default. I dunno, may=
be
> > > upgrade udev on your distro?
> >=20
> > Udev 196 and 197 + linux <=3D 3.6.11 yield correct CPU autoprobing. How=
ever,
> > udev 197 + linux 3.7.2 do not. I haven't tested udev 196 with 3.7.2 tho=
ugh,
> > but it does not look like a udev issue.
>=20
> Hmm, I'll bet this has something to do with the fact that HW_PSTATE is
> in another CPUID function on AMD than on Intel and udev doesn't see that
> bit to load acpi-cpufreq automatically.
>=20
> Before I go and install archlinux here, where can I get the udev sources
> which are in your archlinux installation to stare at them a little? :)
> Especially the cpu autoprobing part which supposedly uses the cpuid
> kernel driver.

They are vanilla systemd-197
(http://www.freedesktop.org/software/systemd/systemd-197.tar.xz) with only 1
dbus-related patch
(https://projects.archlinux.org/svntogit/packages.git/tree/trunk?h=3Dpackag=
es/systemd).

>=20
> > I don't know if it matters, but I also have AMD microcode "0x10000c8",
> > albeit it didn't cause problems with 3.6.11...
>=20
> Nah, microcode doesn't have anything to do with it.
>=20
> Thanks.
>=20

Thanks,
L.

--=20
Leonid Isaev
GnuPG key: 0x164B5A6D
Fingerprint: C0DF 20D0 C075 C3F1 E1BE  775A A7AE F6CB 164B 5A6D

--Sig_/c7s4YR5i42AO2c+sUEWGiq.
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJQ+X+BAAoJEKeu9ssWS1ptBpQH+wfP8mjy+3HOaZd01ffz0iaQ
iG4hdUpPVHiBdPJykEe8mQr2yomOpExRVrI6UMmCdU+1z68z5uYHf/qc5GNkQjwM
vpby65yM7JEQDFpYVvM/tIMhjoz9hHw6JYvNFzE8iXPNX7v7PRKk0Cd/tKRQfBMX
rBETionID8SaVSEuqPe3MT5QF4f7hN3imWajmvzCHPtHg1Ixwm9mXCCdD2zmbGkU
vL6SkquSSBklGpV4Co64RDjWo5P7EHgoFVMEcdoaL8FCIPK9qDQZ2bp3Nbhr6mxQ
4piKOZAwIrWOWGq4Nx1iHXKBNPgsqIDo/Gk6r6FyUuAHKeFtBbpoV108rCpuBPA=
=Sxs8
-----END PGP SIGNATURE-----

--Sig_/c7s4YR5i42AO2c+sUEWGiq.--
