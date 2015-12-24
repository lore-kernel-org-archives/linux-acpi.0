From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 2/5] dell-wmi: Use acpi_video_handles_brightness_key_presses()
Date: Thu, 24 Dec 2015 11:04:05 +0100
Message-ID: <201512241104.06427@pali>
References: <1450807792-4980-1-git-send-email-hdegoede@redhat.com> <1450807792-4980-3-git-send-email-hdegoede@redhat.com> <20151222195319.GN7244@malice.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart725487516.WvkxoVGbNW";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20151222195319.GN7244@malice.jf.intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Corentin Chary <corentin.chary@gmail.com>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, =?utf-8?q?Micha=C5=82_K=C4=99pie=C5=84?= <kernel@kempniu.pl>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, ibm-acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

--nextPart725487516.WvkxoVGbNW
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 22 December 2015 20:53:19 Darren Hart wrote:
> On Tue, Dec 22, 2015 at 07:09:49PM +0100, Hans de Goede wrote:
>=20
> + Pali
>=20
> > Use the new acpi_video_handles_brightness_key_presses function to
> > check if we should report brightness key-presses.
> >=20
> > This makes the code both easier to read and makes it properly
> > report key-presses when acpi-video is not reporting them for
> > reasons other then the backlight type being vendor.
> >=20
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>

After discussion I'm fine with this patch. Add my
Acked-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart725487516.WvkxoVGbNW
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlZ7wxYACgkQi/DJPQPkQ1ID6ACgjNMUfUCgBP6RHLzCEKp09YID
sn0An0IS7qCDQk3cO2PxXhIEXZsofEl4
=CixW
-----END PGP SIGNATURE-----

--nextPart725487516.WvkxoVGbNW--
