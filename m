From: Benson Leung <bleung@google.com>
Subject: Re: [PATCH] ACPI LID: increment wakeup count only when notified.
Date: Wed, 6 Jun 2018 16:11:30 -0700
Message-ID: <20180606231130.GA57957@decatoncale.mtv.corp.google.com>
References: <20180604182612.72699-1-ravisadineni@chromium.org>
 <CAJZ5v0jBTpUzqEj1CeQ0CKH7zVRkgj1qJffoSujEZWi0HXABXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jBTpUzqEj1CeQ0CKH7zVRkgj1qJffoSujEZWi0HXABXw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ravi Chandra Sadineni <ravisadineni@chromium.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Ravi Chandra Sadineni <ravisadineni@google.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Todd Broch <tbroch@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Rajat Jain <rajatja@google.com>, Furquan Shaikh <furquan@chromium.org>, bleung@chromium.org
List-Id: linux-acpi@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

On Wed, Jun 06, 2018 at 09:00:43AM +0200, Rafael J. Wysocki wrote:
> > @@ -417,6 +414,7 @@ static void acpi_button_notify(struct acpi_device *=
device, u32 event)
> >                 /* fall through */
> >         case ACPI_BUTTON_NOTIFY_STATUS:
> >                 input =3D button->input;
> > +               acpi_pm_wakeup_event(&device->dev);
>=20
> Not really.
>=20
> There already is an acpi_pm_wakeup_event() call in the else branch below.
>

Ravi removes that other call below. The intent for this is to call
acpi_pm_wakeup_event() regardless if the button->type is ACPI_BUTTON_TYPE_L=
ID,
in case that event is ACPI_BUTTON_NOTIFY_STATUS.
=20
> >                 if (button->type =3D=3D ACPI_BUTTON_TYPE_LID) {
> >                         mutex_lock(&button->input->mutex);
> >                         users =3D button->input->users;
> > @@ -426,7 +424,6 @@ static void acpi_button_notify(struct acpi_device *=
device, u32 event)
> >                 } else {
> >                         int keycode;
> >
> > -                       acpi_pm_wakeup_event(&device->dev);
> >                         if (button->suspended)
> >                                 break;
> >
> > --

Thanks!
Benson
--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlsYaiIACgkQHwn1ewov
5ljcig/9HuK5rrLVvY1YkXgYqdhyVyY1Vg59CbGF2BQwDPzeEq0fvJzbptMerGWB
oPwC4cs9e5jg2Od4qMo6jujcCPvlkZAIivWq7/YKQSmr3sUAeb875H8aSIMmgCog
v/YI3h91NSixkvk1Ip5WP4Kke4J1wTus6gESaty+gr81OeEunThJ30Vmm87le7nx
Qhcy6zDtXZtm3+CD42wO+k9lCQuQCrF2b2tVyFVdQdLOh4dMJYAsMV6N6gQFnzFx
A7bvMvj+8NDk9G8D3IPHGLHrq0Z+/efSbmQfgeSkAh5NpnLznkxYp4gv5VOxJjWP
ULGWC8Fk9PZfGBA+SN3d1axfEk4TE9kEcjxIcn9JpjGD5gRy9RLdVDm5UMH4/PT/
kSESPP/ExVVbr1NuxWz0v8ntH3le2LEbe84XM+/Ca9CKrzJ0ePDfjeoVDMnqAWSX
paNQjNo27wS/srFtQLDjTgkACt9czmCqwF7AFHCldItIHJou7KeXE/GQENFDOKq5
5KhWQhRuxCJhXp9zglAEg0ltGqL23gudqLPgTB4QJqlLpOy15yXqrSgruiqHpEbn
A8rxlrTqpUiObKUFyf2j1xkLa17AXYAuc52MC3+PAWcgYJP1QL2ZU7oA1+/QQYas
J2UnloTry0Dsp007y7/oeQnab4ctepWKA+t9H5EWTU2R5UKYvvI=
=cKk0
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
