From: Andres Freund <andres@anarazel.de>
Subject: Re: 20000+ wake-ups/second in 2.6.24.   Bug?
Date: Sun, 2 Dec 2007 02:10:50 +0100
Message-ID: <200712020210.59041.andres@anarazel.de>
References: <200711302153.lAULrZ7n026255@imap1.linux-foundation.org> <4751F484.6040204@rtr.ca> <20071201161302.731b80d3@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1682725.tduZQciSPq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755363AbXLBBL0@vger.kernel.org>
In-Reply-To: <20071201161302.731b80d3@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Mark Lord <lkml@rtr.ca>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Andrew Morton <akpm@linux-foundation.org>, abelay@novell.com, lenb@kernel.org, rjw@sisk.pl, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

--nextPart1682725.tduZQciSPq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sunday 02 December 2007, Arjan van de Ven wrote in "Re: 20000+=20
wake-ups/second in 2.6.24.   Bug?":
> > > Mark Lord <lkml@rtr.ca> wrote:
> > >> 2.6.23 did not have this problem.
> > > actually we have reports of 2.6.23 having the exact same problem.
> > > The thing is, "something" is causing the system to go into a state
> > > where the cpu throws us right out of the C-state the kernel asks
> > > for.
Just as an Information - I see the same problem here, with an ubuntu 2.6.22=
=20
kernel. I did not report it so far, as I couldnt reliably reproduce it with=
=20
an upstream kernel.
Just as an additional datapoint (Lenovo T60 here).

=46or me it happens only when using battery. Thats another reason I havent=
=20
reported it so far - it only happened while on the road with work to do.=20

If there is any testing needed - just say it.

Greetings,=20

Andres

--nextPart1682725.tduZQciSPq
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHUgYiporPraT14igRAhXRAJ9KcmAV6+O1mbhl9xrJZ7b4U9hu/wCgkElB
gz5FXuPb4qRqNXD//az/3Qc=
=2Yu5
-----END PGP SIGNATURE-----

--nextPart1682725.tduZQciSPq--
