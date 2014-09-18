From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 1/2] Mailbox: Add support for Platform Communication
 Channel
Date: Thu, 18 Sep 2014 10:35:45 -0700
Message-ID: <20140918173545.GZ7960@sirena.org.uk>
References: <1410369619-2570-1-git-send-email-ashwin.chaugule@linaro.org>
 <1410369619-2570-2-git-send-email-ashwin.chaugule@linaro.org>
 <20140916174035.GT7960@sirena.org.uk>
 <CAJ5Y-eak5iMak6vqTBNYdWz1tKFRjGUfD7cZor+uHKknwYNhoQ@mail.gmail.com>
 <CAJ5Y-ebOd1wN+FFH4BSB7JgvEqLi_5fq_FFmVD_i50cpoWjKXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QTkViXUG6g/Oux56"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:58045 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755533AbaIWAzF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Sep 2014 20:55:05 -0400
Received: from [166.170.38.79] (helo=finisterre)
	by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <broonie@sirena.org.uk>)
	id 1XWENj-0006UT-3Q
	for linux-acpi@vger.kernel.org; Tue, 23 Sep 2014 00:55:04 +0000
Content-Disposition: inline
In-Reply-To: <CAJ5Y-ebOd1wN+FFH4BSB7JgvEqLi_5fq_FFmVD_i50cpoWjKXQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Zheng, Lv" <lv.zheng@intel.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>


--QTkViXUG6g/Oux56
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 17, 2014 at 06:17:03PM -0400, Ashwin Chaugule wrote:

> +       while (!(readw_relaxed(&generic_comm_base->status) &
> PCC_CMD_COMPLETE)) {
> +               if (retries++ < 5)
> +                       udelay(cmd_delay);
> +               else {
> +                       pr_err("PCC platform did not respond.\n");
> +                       return false;
> +               }
> +       }

You should have { } on both branches of the if but otherwise that looks
fine to me (assuming that there are enough retries).

--QTkViXUG6g/Oux56
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUGxfxAAoJECTWi3JdVIfQCl4H/02RGp1CosvM7VOitOy8bowH
O1GmjlbfdLfAEb474bi/SRI+TVY1zK5fKh/ETv0p83Szu5lgL9HTVuV3mripbyVd
qw5HMrBX78YsG+0zQpPbLrD3ILso1HzGt14LgMsugG8V3m32rVtS4LlNfjCI0Lix
FpFiW4VqbkHmwmObTPkndxMVv3rdUY6jj+yxs+rYCaTtpp0+eEXf8jQyeCehygU4
jkbFiQJa/ujfjZmJcz/Bd9w0HnKTxPzwRMUbB1qlSzn/EbGC91BOynwICDNh/56D
txSYRVs0kzni4/cOJriujReP3XU+uUCJAMnxi4o4GkGGCgU8LlnJ1es3/QJEtMc=
=kyNt
-----END PGP SIGNATURE-----

--QTkViXUG6g/Oux56--
