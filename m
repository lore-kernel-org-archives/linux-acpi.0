From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: [2.6.29-rc2] First suspend after reboot resumes immediately.
Date: Tue, 20 Jan 2009 19:50:22 +0300
Message-ID: <200901201950.25347.arvidjaar@mail.ru>
References: <200901192339.03967.arvidjaar@mail.ru> <200901192146.26753.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2149237.TRNfptcxHJ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from flock1.newmail.ru ([82.204.219.207]:51334 "HELO
	flock1.newmail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757889AbZATQut (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Jan 2009 11:50:49 -0500
In-Reply-To: <200901192146.26753.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-usb@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

--nextPart2149237.TRNfptcxHJ
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 19 =D1=8F=D0=BD=D0=B2=D0=B0=D1=80=D1=8F 2009 23:46:26 Rafael J. Wysocki =
wrote:
> On Monday 19 January 2009, Andrey Borzenkov wrote:
> > Subsequent suspends seem fine. I suspect it is related to USB
> > controller; but because I see ACPI related message this is sent to
> > linux-acpi as well.
> >
> > Specifically, I am suspicious of this:
> >
> > [  132.763954] ohci_hcd 0000:00:02.0: wake-up capability enabled by
> > ACPI
> >
> > The controller immediately resumes after any attempt to suspend it,
> > so any autosuspend functionality is currently disabled. But it
> > /looks/ like ACPI somehow tries to do it anyway.
> >
> > I can also reproduce it by unloading and reloading USB drivers
> > which supports USB guess.
>
> This looks like http://bugzilla.kernel.org/show_bug.cgi?id=3D12399 .
>

Yes.

--nextPart2149237.TRNfptcxHJ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkl2ANEACgkQR6LMutpd94z1ewCeLZrI3LJUy01Rj+9RUzDrTI/0
icwAnAxPrIWqJk8D26vKoTlgAyF7gI+a
=J4cM
-----END PGP SIGNATURE-----

--nextPart2149237.TRNfptcxHJ--
