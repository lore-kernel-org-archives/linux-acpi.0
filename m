From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 15/16] platform/x86: wmi-mof: New driver to expose embedded WMI MOF metadata
Date: Wed, 7 Jun 2017 19:39:25 +0200
Message-ID: <201706071939.25681@pali>
References: <cover.1495862272.git.dvhart@infradead.org> <8aa135f430b441eb82614b22d662d1ff@ausx13mpc120.AMER.DELL.COM> <20170606135621.GC4690@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1625338.1nyMpfXXsq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33792 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751433AbdFGRja (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Jun 2017 13:39:30 -0400
In-Reply-To: <20170606135621.GC4690@pali>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario.Limonciello@dell.com
Cc: luto@amacapital.net, dvhart@infradead.org, platform-driver-x86@vger.kernel.org, andriy.shevchenko@linux.intel.com, luto@kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

--nextPart1625338.1nyMpfXXsq
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 06 June 2017 15:56:21 Pali Roh=C3=A1r wrote:
> On Tuesday 06 June 2017 13:46:16 Mario.Limonciello@dell.com wrote:
> > 2) On my system when you expand the arguments for "void DoBFn" the
> > source doesn't describe individual arguments like you do. Again
> > this might not matter to MOF parsing tools but wanted to let you
> > know in case it does.
>=20
> I know, this part is missing. Order of arguments are only in ID
> qualifier and not sorted + in/out de-duplicated.

Implemented! Now arguments are correctly placed based on ID qualifier.

> > source:
> > 	void DoBFn([in, out, Description("Fn buf")] BDat Data);
> >=20
> > bmf2mof:
> > 	void doBFn([in, Description("Fn buf"), ID(0)] BDat Data, [out,
> > 	Description("Fn buf"), ID(0)] BDat Data);

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1625338.1nyMpfXXsq
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlk4Ok0ACgkQi/DJPQPkQ1JjzwCdFg4CIAQUKKt6pRxU748j3kHx
iakAoMytEZ7DNq4mMduutdSfxpr4BaHp
=Sap/
-----END PGP SIGNATURE-----

--nextPart1625338.1nyMpfXXsq--
