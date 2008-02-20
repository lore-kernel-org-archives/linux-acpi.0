From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: 2.6.25-rc2-mm1 (x64 thermal build failure)
Date: Wed, 20 Feb 2008 08:21:33 +0100
Message-ID: <20080220082133.56f93d27@crazy>
References: <20080216002522.9c4bd0fb.akpm@linux-foundation.org>
	<20080216211603.bb4f3582.randy.dunlap@oracle.com>
	<20080216214410.b9699910.akpm@linux-foundation.org>
	<20080218111536.511c4fbc@crazy>
	<20080218041340.f1e46ec9.akpm@linux-foundation.org>
	<20080219165502.2c202759@crazy>
	<20080219152129.6e8b7956.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/v9SkIC1I3rgH11jU9F1sxey";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754303AbYBTHV5@vger.kernel.org>
In-Reply-To: <20080219152129.6e8b7956.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, linux-kernel@vger.kernel.org, len.brown@intel.com, linux-acpi@vger.kernel.org, michael@free-electrons.com
List-Id: linux-acpi@vger.kernel.org

--Sig_/v9SkIC1I3rgH11jU9F1sxey
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Le Tue, 19 Feb 2008 15:21:29 -0800,
Andrew Morton <akpm@linux-foundation.org> a =C3=A9crit :

> ug, sorry, if I'd realised it was like this I'd have said "don't
> bother". Apart from the obvious problem, this means that people will
> keep breaking CONFIG_DMI=3Dn all the time, because they will forget the
> ifdefs, and the number of people who test with CONFIG_DMI=3Dn will be
> small.

Yes, #ifdef CONFIG_DMI is not very comfortable. That why I proposed
things such as DECLARE_DMI_FIXUP_TABLE(), because it would force people
to use these macros, which would then be working correctly depending on
DMI=3Dy/n. However, there's still the issue of driver_data that I
mentionned in my earlier post.

What should I do ? Option 1 ? Option 2 ? Give up with the patch ?

Thanks for your comments,

Thomas
--=20
Thomas Petazzoni, Free Electrons
Free Embedded Linux Training Materials
on http://free-electrons.com/training
(More than 1500 pages!)

--Sig_/v9SkIC1I3rgH11jU9F1sxey
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD4DBQFHu9UB9lPLMJjT96cRAmjHAJd6dSQi8ZRI2tqu2nNT9dmSBFMfAJ0YXzwX
IoCwUCmPv6ZeYPhAg/0PTQ==
=M1LJ
-----END PGP SIGNATURE-----

--Sig_/v9SkIC1I3rgH11jU9F1sxey--
