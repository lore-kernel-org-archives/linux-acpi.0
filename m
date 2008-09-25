From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: Re: [PATCH 7/7] x86: print out irq nr for msi/ht -v2
Date: Thu, 25 Sep 2008 13:30:40 +0200
Message-ID: <200809251330.43471.eike-kernel@sf-tec.de>
References: <1222323223-23529-1-git-send-email-yhlu.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4305458.UIFvjaWf2G";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1222323223-23529-1-git-send-email-yhlu.kernel@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

--nextPart4305458.UIFvjaWf2G
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Yinghai Lu wrote:
> v2: fix hpet compiling

Are you sure you sent the right patch? It only adds some printk()'s and=20
unrelated newlines.

Eike

--nextPart4305458.UIFvjaWf2G
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkjbdmMACgkQXKSJPmm5/E62cgCfdrUzsWQYYllJ2H5bKBO4soiY
FOMAmgONRLVUmuiIV8k4QZqg1rFm5K+x
=0Ndx
-----END PGP SIGNATURE-----

--nextPart4305458.UIFvjaWf2G--
