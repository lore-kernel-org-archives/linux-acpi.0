From: Leonid Isaev <lisaev@umail.iu.edu>
Subject: Re: [arch-general] powernow-k8 fails to load with linux 3.7.2
Date: Thu, 17 Jan 2013 19:40:44 -0600
Message-ID: <20130117194044.7a18a29d@bluemoon>
References: <20130115224755.085aa6b7@bluemoon>
	<20130116131725.4e590c34@bluemoon>
	<CAG-2HqWBVf=RWXExeFgxYdPTzPfQYZnt-3ZKzULTwdP9+-5mVQ@mail.gmail.com>
	<1448223.sdUJnNSRz4@vostro.rjw.lan>
	<20130116231728.GA10204@x1.alien8.de>
	<20130116181600.4c48ee3b@bluemoon>
	<20130117094648.GD30700@pd.tnic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/lmXoB5cmZRVyEAXxYx19aj8"; protocol="application/pgp-signature"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vc0-f182.google.com ([209.85.220.182]:59812 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754859Ab3ARBkv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jan 2013 20:40:51 -0500
Received: by mail-vc0-f182.google.com with SMTP id fy27so3214181vcb.27
        for <linux-acpi@vger.kernel.org>; Thu, 17 Jan 2013 17:40:50 -0800 (PST)
In-Reply-To: <20130117094648.GD30700@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Tom Gundersen <teg@jklm.no>, =?UTF-8?B?QW5kcsOp?= Przywara <andre@andrep.de>, Matthew Garrett <mjg@redhat.com>, cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org

--Sig_/lmXoB5cmZRVyEAXxYx19aj8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Jan 2013 10:46:48 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Wed, Jan 16, 2013 at 06:16:00PM -0600, Leonid Isaev wrote:
> > > [ fixup Andre's address. ]
> > >=20
> > > On Wed, Jan 16, 2013 at 11:33:21PM +0100, Rafael J. Wysocki wrote:
> > > > > down the frequancy, but is accompanied by an info-level kernel
> > > > > message "acpi-cpufreq: overriding BIOS provided _PSD data".
> > >=20
> > > That just says that BIOS has crappy data and we're using our own.
> >=20
> > OK. Yes, my BIOS is broken, so I thought it was the reason why autoload=
ing
> > does not work.
>=20
> Hmm, come to think of it, we're issuing this message on SMP on *all*
> AMDs with HW_PSTATE. Andre, remind me again why we're doing this? We're
> basically saying that we're overriding ACPI data but we still read it
> out from acpi_perf_data and use *that* data to prepare the frequencies
> table. What am I missing?
>=20
> > To be more precise: "modprobe powernow-k8" returns a "no such device"
> > error,
>=20
> That's correct - we say ENODEV on your CPU which supports hardware
> P-states and hand off to acpi-cpufreq which has that functionality now.
>=20
> > but in kernel logs I see that acpi-cpufreq is indeed loaded:
> > -------
> > Jan 15 22:42:19 metal-0 kernel: [  534.003995] acpi-cpufreq: overriding
> > BIOS provided _PSD data
> > Jan 15 22:42:32 metal-0 kernel: [  547.122695] powernow-k8: this CPU is=
 not
> > supported anymore, using acpi-cpufreq instead.
> > Jan 15 22:42:45 metal-0 kernel: [  559.623068] powernow-k8: this CPU is
> > not supported anymore, using acpi-cpufreq instead.
> > -------
> > (the CPU in question is phenom II x4 955). However, this is only after I
> > attempt to _manually_ load powernow-k8 (the timestamps in [...] are ~6 =
mins
> > after boot is completed). So the above-mentioned handoff seems to work,=
 but
> > please find attached my kernel config.
>=20
> Ok, this is maybe the issue. What used to load powernow-k8 on your
> distro before? Because basically it's enough if some script did
> 'modprobe powernow-k8' for the handoff to just work.

Arrh, modprobe still does not exit cleanly with this...

>=20
> But, we also have the CPU autoprobing deal:
>=20
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dco=
mmit;h=3D644e9cbbe3fc032cc92d0936057e166a994dc246
>=20
> so, *actually*, powernow-k8 should be loaded by default. I dunno, maybe
> upgrade udev on your distro?

Udev 196 and 197 + linux <=3D 3.6.11 yield correct CPU autoprobing. However,
udev 197 + linux 3.7.2 do not. I haven't tested udev 196 with 3.7.2 though,
but it does not look like a udev issue.

I don't know if it matters, but I also have AMD microcode "0x10000c8", albe=
it
it didn't cause problems with 3.6.11...

>=20
> Btw, your config looks fine:
>=20
> CONFIG_X86_POWERNOW_K8=3Dm
> CONFIG_X86_ACPI_CPUFREQ=3Dm
>=20
> Thanks.
> =20

Sincerely,
L.
--=20
Leonid Isaev
GnuPG key: 0x164B5A6D
Fingerprint: C0DF 20D0 C075 C3F1 E1BE  775A A7AE F6CB 164B 5A6D

--Sig_/lmXoB5cmZRVyEAXxYx19aj8
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJQ+KgcAAoJEKeu9ssWS1ptQlkH/iU1+5udlUCF+VQQLOJZ/6Cp
mgE4vPshWNm0Rsv2BxCYIklC3W0F+xW4MjFQ2Hm9DbocEuW3bwwb6ACLivFem3jh
mqO//taWiJ5ZMNVSy0kP5yHDr7XirUawYKLylnpmLRns8eyQmpe2amGWUwA6H3Io
yC8zyklKB9KRTkAPHOO+5EGWpUqj20lKmgP8ZC+aqv1xYEn/C0+16STZowZPefgn
uIETblj3gQ44PVj9ux/zqe8dpCcLR8r6g0jmmonoQCv79lda/zNYHzuUXGaJq27C
YRrN23tPSuimyu9ld+ZAfnxbD/I8pOw7YjumcVnTdb7Q/WlC12ePW/0R16PAxT0=
=UHI7
-----END PGP SIGNATURE-----

--Sig_/lmXoB5cmZRVyEAXxYx19aj8--
