From: James Hogan <jhogan@kernel.org>
Subject: Re: [REGRESSION] [v2] ACPI / video: Default lcd_only to true on Win8
 ready and newer machines
Date: Mon, 16 Apr 2018 14:02:12 +0100
Message-ID: <20180416130211.GA484@jamesdev>
References: <20171223184147.12016-1-hdegoede@redhat.com>
 <20180414230746.GA29537@saruman>
 <d5ff7ff3-4fa1-0f8c-e0a9-6779b9185e14@redhat.com>
 <20180415225403.GA6373@jamesdev>
 <18c72a70-577f-358e-fb82-095b75157a29@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <18c72a70-577f-358e-fb82-095b75157a29@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Zhang Rui <rui.zhang@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, stable@vger.kernel.org, Sasha Levin <alexander.levin@microsoft.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-acpi@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 16, 2018 at 01:07:50PM +0200, Hans de Goede wrote:
> On 16-04-18 00:54, James Hogan wrote:
> > On Sun, Apr 15, 2018 at 02:04:26PM +0200, Hans de Goede wrote:
> > > When you say quirk do you mean you add something to
> > > the kernel commandline to work around this?
> >=20
> > No, it was automatic, in the source. I don't know this code well enough
> > to know how they got it working.
>=20
> Weird, if my only_lcd changes impact you then acpi_osi_is_win8()
> returns true for you

It rings a bell that this laptop claims win8 support.

> you should get the intel backlight interface
> by default, but maybe the i915 driver somehow detects that that
> is not appropriate on your device ... ?
>=20
> Before I can start working on a quirk to fix this I've some
> questions:
>=20
> 1) With recent kernels without the 965736ee654d commit, what is
>    the output of "ls /sys/class/backlight" ?

$ ls -l /sys/class/backlight
total 0
lrwxrwxrwx 1 root root 0 Apr 16 13:57 acpi_video0 -> ../../devices/pci0000:=
00/0000:00:02.0/backlight/acpi_video0

> 2) What is the output of "ls /sys/class/backlight" after
>    commit 965736ee654d ?

no devices show up there.

> 3) Can you start a kernel with commit 965736ee654d in there and
>    "video.only_lcd=3D0" on the kernel commandline and verify that
>    this fixes backlight control for you ?

Confirmed, acpi_video0 shows up and backlight control works as expected.

Cheers
James

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrUnsYACgkQbAtpk944
dnpGlxAAkoxr01uGlwNh64cbZGZLrPZmQJykYa2sBkHQhxfBw9S6o77mGW7WTWfp
PJfAEpUkm4QHdUvDgXhfs9pQfvD9xeivghqJeVCD+oz+UPAtGpNcYXU5uSge6+Zh
ewF94K8I/R9Y6w5m2denQANmZVyZcDhWOaZii+bhyVqBBtwqju4nJEhN3pnMg1/F
avTcCAWk62OLB10HoAByl7y6Sd0xRvP8LpTARFCcdcLq+bDqkJvSNfn05gyEzJeQ
Xi/pzBpCjf0itTmvefjazkhi0JweaDgBQdPQWaEopeYZiaTdX+A+vSOSdhGI3ECy
H1NNJGHW5y7MuAhZ8xKOq4ZJh4oJsMKXMl7fcFOUEpcJFTvMhekOkEXRFEzzhRIz
i8K9Zffg5nU5p+2gN9mwQGqg1PJCsbEiSIM2g9MMxrqH23he4Pm8FXN7nsWR3bRL
77pyAhDUn0rLftebV3rWuwk30q1gh0WWW1r7GyKPk/BML4WSkqbZJ6OhrI9PEZpm
5tu/ct81L+gH/2OJ9iQZw26Cn/kQBm7GfVO7T6yO1DXAEMMAqYptRMqoT4hRQQCV
v0MFV/kj4LPB4OHY2lAEDKyhWSraUm3eEme+iRZ5v6ULYbjof9I8tHLM/Ib9KYIS
AUlxetKWZJmnX7fB6gugexGlAmxN1HfBoUjR/9EJVbILpdzzA74=
=l+Mf
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
