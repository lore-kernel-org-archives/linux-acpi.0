From: Leonid Isaev <lisaev@umail.iu.edu>
Subject: Re: [arch-general] powernow-k8 fails to load with linux 3.7.2
Date: Fri, 18 Jan 2013 11:13:42 -0600
Message-ID: <20130118111342.3d17fef1@bluemoon>
References: <20130115224755.085aa6b7@bluemoon>
	<20130116131725.4e590c34@bluemoon>
	<CAG-2HqWBVf=RWXExeFgxYdPTzPfQYZnt-3ZKzULTwdP9+-5mVQ@mail.gmail.com>
	<1448223.sdUJnNSRz4@vostro.rjw.lan>
	<20130116231728.GA10204@x1.alien8.de>
	<20130116181600.4c48ee3b@bluemoon>
	<20130117094648.GD30700@pd.tnic>
	<20130117194044.7a18a29d@bluemoon>
	<20130118113717.GA6808@pd.tnic>
	<20130118133233.4521ddb6@hydra>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/l6124D++4gJgAixNOK9cCaw"; protocol="application/pgp-signature"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vc0-f172.google.com ([209.85.220.172]:40098 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507Ab3ARRNt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jan 2013 12:13:49 -0500
Received: by mail-vc0-f172.google.com with SMTP id l6so2781686vcl.17
        for <linux-acpi@vger.kernel.org>; Fri, 18 Jan 2013 09:13:48 -0800 (PST)
In-Reply-To: <20130118133233.4521ddb6@hydra>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?UTF-8?B?QW5kcsOp?= Przywara <andre@andrep.de>
Cc: Borislav Petkov <bp@alien8.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Tom Gundersen <teg@jklm.no>, Matthew Garrett <matthew.garrett@nebula.com>, cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org

--Sig_/l6124D++4gJgAixNOK9cCaw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Jan 2013 13:32:33 +0100
Andr=C3=A9 Przywara <andre@andrep.de> wrote:

> On Fri, 18 Jan 2013 12:37:17 +0100
> Borislav Petkov <bp@alien8.de> wrote:
>=20
> (updating Matthew's email as per MAINTAINERS)
>=20
> > On Thu, Jan 17, 2013 at 07:40:44PM -0600, Leonid Isaev wrote:
> > > Arrh, modprobe still does not exit cleanly with this...
> >=20
> > As I said already above:
> >=20
> > >> That's correct - we say ENODEV on your CPU which supports hardware
> > >> P-states and hand off to acpi-cpufreq which has that functionality
> > >> now.
> >=20
> > It is supposed to work that way: we return an error from the
> > powernow-k8 init function so that it doesn't load but hand off to
> > acpi-cpufreq so that it gets loaded instead.
> >=20
> > > > But, we also have the CPU autoprobing deal:
> > > >=20
> > > > http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;=
a=3Dcommit;h=3D644e9cbbe3fc032cc92d0936057e166a994dc246
> > > >=20
> > > > so, *actually*, powernow-k8 should be loaded by default. I dunno,
> > > > maybe upgrade udev on your distro?
> > >=20
> > > Udev 196 and 197 + linux <=3D 3.6.11 yield correct CPU autoprobing.
> > > However, udev 197 + linux 3.7.2 do not. I haven't tested udev 196
> > > with 3.7.2 though, but it does not look like a udev issue.
> >=20
> > Hmm, I'll bet this has something to do with the fact that HW_PSTATE is
> > in another CPUID function on AMD than on Intel and udev doesn't see
> > that bit to load acpi-cpufreq automatically.
>=20
> But the acpi-cpufreq does not export it's dependency on some CPUID
> flags, since it is an _ACPI_ module. Shouldn't the load be triggered
> while parsing the ACPI tree instead?
>=20
> $ /sbin/modinfo drivers/cpufreq/acpi-cpufreq.ko | grep alias
> alias:          acpi
>=20
> $ /sbin/modinfo drivers/cpufreq/powernow-k8.ko | grep alias
> alias:          x86cpu:vendor:0002:family:000F:model:*:feature:*
>=20
> How does ArchLinux loads acpi-cpufreq on Intel CPUs? It should now be
> the same mechanism on AMD. Or does it have acpi-cpufreq somehow
> hard-coded in the scripts for GenuineIntel?

In both cases Intel and AMD we rely on the kernel/udev autoprobing to insert
correct CPU and KVM drivers, i.e. there are no custom scripts or manual loa=
ding
of modules via systemd. However, in Intel's case acpi_cpufreq is loaded
correctly (and always has been). Indeed, on an Intel core2duo:
 $ dmesg | grep -i cpufreq
[    9.005851] ACPI: Requesting acpi_cpufreq

>=20
> Regards,
> Andre.

Sincerely,
L.

--=20
Leonid Isaev
GnuPG key: 0x164B5A6D
Fingerprint: C0DF 20D0 C075 C3F1 E1BE  775A A7AE F6CB 164B 5A6D

--Sig_/l6124D++4gJgAixNOK9cCaw
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJQ+YLGAAoJEKeu9ssWS1pt+iAH/ii35QXmvUYNyzHbzEpyw5yY
Xucdr9Ua3VCrBdhWmEVU5aOzPQDaQJ4ttjI841fNtn1VijPZ+OllJAY+ajeweQ6O
dLBlzppDAAr8FL0hDe1NkPFIacLHxkPimZEKo4cXcOeB6xXojqhgKqBO07cdypDG
CPYKzNQ1kTr6YetVbBPOPQNGwdmqlBDdVcJiPFL/0uSz2+1TtC7CPlDmj/85lMu4
AaxCg8uAY6wdvplOKyQMXu8AEnDrw5yM2wthzMss1kc977u5NyL5Ye6uNbyMPLjU
dEcl/B7fpRS98quhSYl1V3coEDs95lGINUHLLtpYQzAT2kDShSUskUMrfgRE810=
=7tg0
-----END PGP SIGNATURE-----

--Sig_/l6124D++4gJgAixNOK9cCaw--
