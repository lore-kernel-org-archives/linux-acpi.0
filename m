From: Leonid Isaev <lisaev@umail.iu.edu>
Subject: Re: [arch-general] powernow-k8 fails to load with linux 3.7.2
Date: Thu, 17 Jan 2013 19:27:21 -0600
Message-ID: <20130117192721.084408ad@bluemoon>
References: <20130115224755.085aa6b7@bluemoon>
	<20130116131725.4e590c34@bluemoon>
	<CAG-2HqWBVf=RWXExeFgxYdPTzPfQYZnt-3ZKzULTwdP9+-5mVQ@mail.gmail.com>
	<1448223.sdUJnNSRz4@vostro.rjw.lan>
	<20130116231728.GA10204@x1.alien8.de>
	<20130116181600.4c48ee3b@bluemoon>
	<20130117094648.GD30700@pd.tnic>
	<CAG-2HqVm+=pcd5hNtPqtbQYseDRZhi=hFaji6+xs8+26V2HW+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/cyb3_n3BJJ.OUw3np.swRUZ"; protocol="application/pgp-signature"
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAG-2HqVm+=pcd5hNtPqtbQYseDRZhi=hFaji6+xs8+26V2HW+A@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Tom Gundersen <teg@jklm.no>
Cc: Borislav Petkov <bp@alien8.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, =?UTF-8?B?QW5kcsOp?= Przywara <andre@andrep.de>, Matthew Garrett <mjg@redhat.com>, cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

--Sig_/cyb3_n3BJJ.OUw3np.swRUZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Sorry for a late reply...

On Thu, 17 Jan 2013 11:34:22 +0100
Tom Gundersen <teg@jklm.no> wrote:

> On Thu, Jan 17, 2013 at 10:46 AM, Borislav Petkov <bp@alien8.de> wrote:
> > On Wed, Jan 16, 2013 at 06:16:00PM -0600, Leonid Isaev wrote:
> >> > [ fixup Andre's address. ]
> >> >
> >> > On Wed, Jan 16, 2013 at 11:33:21PM +0100, Rafael J. Wysocki wrote:
> >> > > > down the frequancy, but is accompanied by an info-level kernel
> >> > > > message "acpi-cpufreq: overriding BIOS provided _PSD data".
> >> >
> >> > That just says that BIOS has crappy data and we're using our own.
> >>
> >> OK. Yes, my BIOS is broken, so I thought it was the reason why
> >> autoloading does not work.
> >
> > Hmm, come to think of it, we're issuing this message on SMP on *all*
> > AMDs with HW_PSTATE. Andre, remind me again why we're doing this? We're
> > basically saying that we're overriding ACPI data but we still read it
> > out from acpi_perf_data and use *that* data to prepare the frequencies
> > table. What am I missing?
> >
> >> To be more precise: "modprobe powernow-k8" returns a "no such device"
> >> error,
> >
> > That's correct - we say ENODEV on your CPU which supports hardware
> > P-states and hand off to acpi-cpufreq which has that functionality now.
> >
> >> but in kernel logs I see that acpi-cpufreq is indeed loaded:
> >> -------
> >> Jan 15 22:42:19 metal-0 kernel: [  534.003995] acpi-cpufreq: overriding
> >> BIOS provided _PSD data
> >> Jan 15 22:42:32 metal-0 kernel: [  547.122695] powernow-k8: this CPU is
> >> not supported anymore, using acpi-cpufreq instead.
> >> Jan 15 22:42:45 metal-0 kernel: [  559.623068] powernow-k8: this CPU is
> >> not supported anymore, using acpi-cpufreq instead.
> >> -------
> >> (the CPU in question is phenom II x4 955). However, this is only after=
 I
> >> attempt to _manually_ load powernow-k8 (the timestamps in [...] are ~6
> >> mins after boot is completed). So the above-mentioned handoff seems to
> >> work, but please find attached my kernel config.
> >
> > Ok, this is maybe the issue. What used to load powernow-k8 on your
> > distro before? Because basically it's enough if some script did
> > 'modprobe powernow-k8' for the handoff to just work.
> >
> > But, we also have the CPU autoprobing deal:
> >
> > http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commit;h=3D644e9cbbe3fc032cc92d0936057e166a994dc246
>=20
> Arch relies entirely on the CPU autoprobing, there are no scripts
> modprobing things at boot.

That's right, processor drivers used to be automatically loaded alongside
with kvm and kvm_amd. Now, only the KVM stuff is loaded.

>=20
> > so, *actually*, powernow-k8 should be loaded by default. I dunno, maybe
> > upgrade udev on your distro?
>=20
> Assuming Leonid's system is up-to-date, Arch ships the most recent
> udev version (197).

Yes, the system is fully updated running systemd/udev 197.

>=20
> Cheers,
>=20
> Tom

Thank you,
L.

--=20
Leonid Isaev
GnuPG key: 0x164B5A6D
Fingerprint: C0DF 20D0 C075 C3F1 E1BE  775A A7AE F6CB 164B 5A6D

--Sig_/cyb3_n3BJJ.OUw3np.swRUZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJQ+KUDAAoJEKeu9ssWS1ptvqYH/iycOJosExWEcL7UQuHaWSWq
X8owKvRW2JsFFpGdy5uD10EqSEz8WJ9ByRSwUdHT715ayZ6bG1dGMh11v5QWWhRG
00RyEcZB+DaCrHIT5+LqcaElKzDqNsdD0RumTGUC0r+20GPrEFGHR16AOIslzFLA
gRfvGLrAKTsVWqhHWqDnRK/wgapp1XJRUanEqkFw7mTfVD7uDj09bkbGbTEDuklX
ZZn83WTWsGX508WaZYhKn77zP5NlNiZDvUEs1C/c8fCTekgRHeauywpnUqRC724y
ciX5wuBf0UqOHpjzmrYXNKoqo2x6a8hXowHv22EkDkI80094KESWaEDapNa6tEw=
=ZvcL
-----END PGP SIGNATURE-----

--Sig_/cyb3_n3BJJ.OUw3np.swRUZ--
