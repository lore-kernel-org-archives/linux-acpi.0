From: Leonid Isaev <lisaev@umail.iu.edu>
Subject: Re: [arch-general] powernow-k8 fails to load with linux 3.7.2
Date: Sun, 20 Jan 2013 23:14:32 -0600
Message-ID: <20130120231432.67351ee6@bluemoon>
References: <20130116131725.4e590c34@bluemoon>
	<CAG-2HqWBVf=RWXExeFgxYdPTzPfQYZnt-3ZKzULTwdP9+-5mVQ@mail.gmail.com>
	<1448223.sdUJnNSRz4@vostro.rjw.lan>
	<20130116231728.GA10204@x1.alien8.de>
	<20130116181600.4c48ee3b@bluemoon>
	<20130117094648.GD30700@pd.tnic>
	<20130117194044.7a18a29d@bluemoon>
	<20130118113717.GA6808@pd.tnic>
	<20130118133233.4521ddb6@hydra>
	<E99CBA9F97C3D149AA6B19ED2E277C9B0193997E@BY2PRD0510MB365.namprd05.prod.outlook.com>
	<20130119120814.GA4026@pd.tnic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/aisIX7ijO3WfwEqubSEshpV"; protocol="application/pgp-signature"
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130119120814.GA4026@pd.tnic>
Sender: cpufreq-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Matthew Garrett <matthew.garrett@nebula.com>, =?UTF-8?B?QW5kcsOp?= Przywara <andre@andrep.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Tom Gundersen <teg@jklm.no>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

--Sig_/aisIX7ijO3WfwEqubSEshpV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 19 Jan 2013 13:08:14 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Fri, Jan 18, 2013 at 03:17:04PM +0000, Matthew Garrett wrote:
> > Can you try this (entirely untested) patch?
> >=20
> > diff --git a/drivers/cpufreq/acpi-cpufreq.c
> > b/drivers/cpufreq/acpi-cpufreq.c
> > index 0d048f6..7b0d49d 100644
> > --- a/drivers/cpufreq/acpi-cpufreq.c
> > +++ b/drivers/cpufreq/acpi-cpufreq.c
> > @@ -1030,4 +1030,11 @@ MODULE_PARM_DESC(acpi_pstate_strict,
> >  late_initcall(acpi_cpufreq_init);
> >  module_exit(acpi_cpufreq_exit);
> > =20
> > +static const struct x86_cpu_id acpi_cpufreq_ids[] =3D {
> > +	X86_FEATURE_MATCH(X86_FEATURE_ACPI),
> > +	X86_FEATURE_MATCH(X86_FEATURE_HW_PSTATE),
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(x86cpu, acpi_cpufreq_ids);
> > +
> >  MODULE_ALIAS("acpi");
>=20
> Leonid, can you try Matthew's patch?
>=20
> This is adding the additional cpufreatures aliases:
>=20
> alias:          x86cpu:vendor:*:family:*:model:*:feature:*00E8*
> alias:          x86cpu:vendor:*:family:*:model:*:feature:*0016*
>=20
> and since powernow-k8 used to load on 3.6-stable, it probably happened
> because the 0xe8 feature and since 3.7 moved it to acpi-cpufreq, this
> patch should actually fix it.
>=20
> Thanks.
>=20

Matthew and Borislav, thanks a lot for the patch and explanation!

I applied the above patch on top of linux 3.7.3 -- it does generate the
aliases and fixes the autoprobing issue, at least on my AMD machine. Should=
 we
expect it in 3.7.4 or 3.8? Otherwise, I'll forward it to archlinux devel ML=
 to
be possibly included in current -stable kernel. Also, Borislav, this patch =
is
not in your patch series, is it?

Thanks again,
L.

--=20
Leonid Isaev
GnuPG key: 0x164B5A6D
Fingerprint: C0DF 20D0 C075 C3F1 E1BE  775A A7AE F6CB 164B 5A6D

--Sig_/aisIX7ijO3WfwEqubSEshpV
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJQ/M7BAAoJEKeu9ssWS1pttSgH/At38hOEgYcH5XMMcVgQhBn0
wfhOPX1SXs/VpfNcKQSM+kf6JuGznOz1wK2eAytpsDX0SpAcICceWzxbFu2C+KlL
T55G72JgymZGrwSCg1l6zGgUZROz4Kr2OCtIVZKCOZl227Tcc0qQB3HgzqIB/6zn
kcQhtilEWU2AgX7GVuN6M9vDYnuG0m5d/I9rw5O0nTAdbe9zI6C/G0cOWuC+IqDz
2l5ngnp1lh50P0UzIyaI35AnBaOPowMCdlEgqk81TAnxhZrtSBw6AQ2VnFoIjASp
Az2+F1Psm/Ze0qxFdvyED2WT827dCLxNmnp4feJSZv9wnP1Ze5ZbLUNimkuDkuM=
=i3yN
-----END PGP SIGNATURE-----

--Sig_/aisIX7ijO3WfwEqubSEshpV--
