From: Jaroslaw Gorny <jaroslav@aster.pl>
Subject: Re: dock problem - Dell Latitude+2.6.18-rc2
Date: Wed, 19 Jul 2006 21:41:01 +0200
Message-ID: <200607192141.10429.jaroslav@aster.pl>
References: <200607181957.21224.jaroslav@aster.pl> <20060718110917.1f35ca8c.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart9379276.fVV0b3B0rv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail2.aster.pl ([212.76.33.47]:39546 "EHLO mail2.astercity.net")
	by vger.kernel.org with ESMTP id S1030235AbWGSTkL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Jul 2006 15:40:11 -0400
In-Reply-To: <20060718110917.1f35ca8c.kristen.c.accardi@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: linux-acpi@vger.kernel.org

--nextPart9379276.fVV0b3B0rv
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Kristen,

Dnia wtorek, 18 lipca 2006 20:09, napisa=C5=82e=C5=9B:
> On Tue, 18 Jul 2006 19:57:12 +0200
>
> Jaroslaw Gorny <jaroslav@aster.pl> wrote:
> > Hi,
> > I've got one Dell Latitude D505 with a dock-station, like this:
> > http://laptoptravel.com/product.aspx?pc=3DDELLDPORT&V=3DDT
>
> Hi!  Can you please run an experiment in which you boot your laptop
> undocked, and then dock and then try undocking again and let me know
> if you still encounter the problem.

I've tried this, with no success. The result was the same as previously wit=
h=20
small exception: something appeared in /var/log/acpid (see link below)


> Also, can you send me your=20
> acpi dsdt table, as well as the output of lspci -vv with your laptop
> booted in the dock station, and also with it booted outside of the
> dock station.  I'd also like a copy of your dmesg output from your
> laptop when you boot docked, as well as when you boot undocked.

All done.
Requested logs and dumps are here:
http://rmrmg.com/jaroslav/acpi-dock/2.6.18-rc2-20060719/

(with some explanations of how they were collected, hope I did it correctly=
).

>
> I am travelling this week and will probably not be available to
> work on this problem till next week, but if in the meantime you can
> collect this information that would be helpful.

Of course. If there's something more I can do, I'll do my best.

Regards,

=2D-=20
Jaroslaw Gorny
jaroslav@aster.pl


=2D----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GMU/E/CS d+/-- s+: a- c++ UL++/US P+>++ L+++>++++
E>++ W N++ o? K w--- !O M V- PS+++ PE++ Y PGP>++ t 5
X- R- tv--/!tv b++ DI-- D G- e++>+++ h-- r+++ z+++
=2D----END GEEK CODE BLOCK-----

--nextPart9379276.fVV0b3B0rv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)

iD8DBQBEvorW6haYWsLTFVgRAsnOAJ0bTNPA8Yp1iZ6k5ihUzU0K2/9+aQCgsWvt
tjzAg2X0A/jqFw1Zv6AC+48=
=wTux
-----END PGP SIGNATURE-----

--nextPart9379276.fVV0b3B0rv--
