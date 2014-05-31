From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH resend 2/4] backlight: Add backlight device (un)registration notification
Date: Sun, 01 Jun 2014 00:46:10 +0200
Message-ID: <3320448.t5cXUpNSer@vostro.rjw.lan>
References: <1400679596-19663-1-git-send-email-hdegoede@redhat.com> <538323A3.1050209@redhat.com> <20140527092033.GF5875@lee--X1>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3527566.RvefO7rhO5"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62473 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752609AbaEaW3F (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 31 May 2014 18:29:05 -0400
In-Reply-To: <20140527092033.GF5875@lee--X1>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Jingoo Han <jg1.han@samsung.com>, 'Aaron Lu' <aaron.lu@intel.com>, 'Bryan Wu' <cooloney@gmail.com>, 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, 'Ben Skeggs' <bskeggs@redhat.com>, 'David Airlie' <airlied@linux.ie>, 'Zhang Rui' <rui.zhang@intel.com>, 'Len Brown' <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org


--nextPart3527566.RvefO7rhO5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, May 27, 2014 10:20:33 AM Lee Jones wrote:
> > On 05/26/2014 01:03 PM, Rafael J. Wysocki wrote:
> > > On Monday, May 26, 2014 12:03:43 PM Jingoo Han wrote:
> > >> On Thursday, May 22, 2014 6:02 PM, Lee Jones wrote:
> > >>> On Thursday, May 22, 2014 5:45 PM, Hans de Goede wrote:
> > >>>> On Thursday, May 22, 2014 8:31 AM, Rafael J. Wysocki wrote:
> > >>>>> On Wednesday, May 21, 2014 10:40 PM, Hans de Goede wrote:
> > >>>>>> Some firmware drivers, ie acpi-video want to get themselves =
out of the
> > >>>>>> way (in some cases) when their also is a raw backlight devic=
e available.
> > >>>>>>
> > >>>>>> Due to module loading ordering being unknown, acpi-video can=
not be certain
> > >>>>>> that the backlight_device_registered(BACKLIGHT_RAW) it does =
for this is
> > >>>>>> the final verdict wrt there being a BACKLIGHT_RAW device.
> > >>>>>>
> > >>>>>> By adding notification acpi-video can listen for backlight d=
evices showing
> > >>>>>> up after it has loaded, and unregister its backlight device =
if desired.
> > >>>>>>
> > >>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > >>>>>
> > >>>>> Backlight maintainer's ACK is requisite here.
> > >>>>
> > >>>> Agreed, which is why I send this set to all 3 the backlight ma=
intainers
> > >>>> directly on both postings.
> > >>>>
> > >>>> What may be helpful for them is to hear from you if you're ok =
with the
> > >>>> acpi-video bits which are actually going to use this, since th=
ose will
> > >>>> be the only user of the new backlight api (for now).
> > >>>
> > >>> I'm happy to apply any Backlight patches which have either Brya=
n or
> > >>> Jingoo's Ack, as they are the reviewers for the BL subsystem.
> > >>
> > >> Acked-by: Jingoo Han <jg1.han@samsung.com>
> > >>
> > >> Lee Jones,
> > >> Would you merge this patch into your backlight git tree?
> > >=20
> > > Hans, does this series depend on things that I've applied already=
?  If so,
> > > I'd very much prefer to take this series too as a whole.
> >=20
> > The 3th patch in this series:
> > " acpi-video: Unregister the backlight device if a raw one shows up=
 later"
> > depends on my "acpi-video: Add an acpi_video_unregister_backlight f=
unction"
> > patch, which you've applied to your linux-next branch already.
> >=20
> > As well as on the 2nd patch in this series:
> > "backlight: Add backlight device (un)registration notification"
> >=20
> > So I agree that it is a good idea to take the whole series through =
your tree.
>=20
> I'm fine with that.
>=20
> Rafael, could you apply the set onto an immutable branch and send me =
a
> signed pull-request please?

You can find this patch on the branch at

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-=
video

The top-most commit is 0dc6b96ac20c (ACPI / video: Add 4 new models to =
the
use_native_backlight DMI list).

Please feel free to pull from there if necessary, it is not going to be=
 rebased.

Thanks!

=2D-=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--nextPart3527566.RvefO7rhO5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABCAAGBQJTilu3AAoJEILEb/54YlRxixcP/A1ZvNNNu6AsAx20ttrMGLxV
gXfimoRcKpctMb4TiXy+lSCrhJj8kh7SvInaIPZz6Sfo7sbVc8E1elKmt1epJyBI
R+vRQTSVMiWUBHA8V0F+VhGUJECHYaJfbIHvdnI9MkOpAZLuThXkPzuZ4fYmOWqS
ZrOUdGHGmZWowDlOWe5ptVQdRoOrvgDMjZYmqrktXhsTqRjJB+Gfu78p9ELKXYsC
bc2P1FsVtemxo2eY3MUksRup9M/muzRUBJumGfu309rFjIUe2/eCiGjg2d1NHjvx
r2pOxKtVouXUtLFTAermmDp4Kkn8MGnyJYOObTAiTasopc0xPRbiKW/e07d0djOI
RH6egGV7PPm00prJ9VY2UCvwQJNnFug/IHeiv5JOZll42z5jodlRfM64u9gLTiYc
Ep06bHqIzrpo6FPBMClnIfFljHnCI/0NQV6zD5DvLi9rDhR0O4wkULUvDYBIbA91
NfwYsc3fgqdJmTGdd8LXaYaee93fqw1EfpC7VjGrA2MAq5ybYvC+gzv1bou3XkG5
qR5GgW4G6VUR5SaSLaxiwWvuGkH2ytQsHyR+pnHCZE/k++mX1viCCnfOQGmmFEM9
Qa+OFhlsaSRd61yiOdDHKGP2avjh/pjYs6MvT2g1z1Hss1iGTncW5r6eCSwHbBM+
YPE3+YkoPLGy96sCZCBz
=HmfM
-----END PGP SIGNATURE-----

--nextPart3527566.RvefO7rhO5--

