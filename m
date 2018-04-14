From: James Hogan <jhogan@kernel.org>
Subject: [REGRESSION] [v2] ACPI / video: Default lcd_only to true on Win8
 ready and newer machines
Date: Sun, 15 Apr 2018 00:07:46 +0100
Message-ID: <20180414230746.GA29537@saruman>
References: <20171223184147.12016-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171223184147.12016-1-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Zhang Rui <rui.zhang@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, stable@vger.kernel.org, Sasha Levin <alexander.levin@microsoft.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-acpi@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2017 at 07:41:47PM +0100, Hans de Goede wrote:
> We're seeing a lot of bogus backlight interfaces on newer machines without
> a LCD such as desktops, servers and HDMI sticks. This causes userspace to
> show a non-functional brightness slider in e.g. the GNOME3 system menu,
> which is undesirable. More in general we should simply just not register
> a non functional backlight interface.
>=20
> Checking the lcd flag causes the bogus acpi_video backlight interfaces to
> go away (on the machines this was tested on).
>=20
> This commit enables the lcd_only option by default on any machines which
> are win8 ready, fixing this.
>=20
> This is not entirely without risk of regressions, but video_detect.c
> already prefers native-backlight interfaces over the acpi_video one
> on win8 ready machines, calling acpi_video_unregister_backlight() as soon
> as a native interface shows up. This is done because the acpi backlight
> interface often is broken on win8 ready machines, because win8 does not
> seem to actually use it.

This patch (in the form of commit 965736ee654d ("ACPI / video: Default
lcd_only to true on Win8-ready and newer machines") in stable v4.15.17),
breaks backlight control on my 2013 XPS13 laptop.

It normally uses the acpi backlight device, but after this patch that
device no longer shows up in sysfs.

This isn't the first time the backlight has gotton broken on this
system, though I think last time it was because the intel backlight
driver got used instead of the ACPI one and that didn't work properly
with it, so it needed a quirk to make it use ACPI instead.

Is some other quirk needed around here too?

Cheers
James

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrSibsACgkQbAtpk944
dnpMehAAq6g62xhJiZ8O8kQvGm76rK2vWBHo9BAZMCOKMv33jE+DPiCM738OxlaI
AJaihkP5wZoZMf8lwB25FUo+bGkpuNjXN2XthKhHefHAk+DNptOIyVNIiZ1Qk3pV
ycp9HOs5lfEoF9L1i/1/wfbAMJ/1ag/Svmbrm8UPf9Y5xAGMHwBg5+NbzBKrUf8b
kaJyHsI29argdEG0Th/oqZ0H+XTT2T1ZouVfrZED9m3W2zdFOny2reiqosULgPCd
l9ciyluKDeUCSGZjiVh7tb0Gdh7y+barObL+KxogRriwF/AP3SKjUNd/k7u6Hioh
DbYnTOa9pGCAC/rxAAwbXBYn6p3xhUXTlwtBvElguaCWzJF3oswSUEb7HiKh6Q7J
pKpepjqHJIgWkRXlrsRQ7AyZs0vfBjEW9Gp3BLaXTEQf8tLD5fXsA/M6mmyuRXgk
nIKdgbT0VYXeMAo3pO5nf830xbHlXJoZ2rvthW8HS+2ROIRnSPPs0An7cRefdmfM
uLdD/kVeEqI4WRHKBemOrOtVIBmUjCBwp1BRhchMRrV/MnNPvVfN1ZZLa1CBgwwY
wcPHeZ40TWvJ0ai2fTpIMx9Uux/+z7FGiKDXejrSrFvdtbuOUg405tEp9Ku11ckJ
RoC26t0lLhvy4WLmANHw9S/4v7zo0CZD1yznviOxxOv17wL0fjk=
=Q+fX
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
