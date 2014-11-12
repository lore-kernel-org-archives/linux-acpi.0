From: Mark Brown <broonie@kernel.org>
Subject: Re: [Linaro-acpi] [PATCH v10 1/1] Mailbox: Add support for Platform
 Communication Channel
Date: Wed, 12 Nov 2014 18:26:48 +0000
Message-ID: <20141112182648.GQ3815@sirena.org.uk>
References: <1415371964-4451-1-git-send-email-ashwin.chaugule@linaro.org>
 <CAJ5Y-eZ+q2dHuuWwVjMCcVtXqSwg0o9Zj-kqQS95K40VakwReQ@mail.gmail.com>
 <546224C8.7050502@arm.com>
 <1620095.ORCbaZ8QlJ@wuerfel>
 <CAJ5Y-eafz7PuZKQwX7bGYnYGvfWc5DmDdRWYd0PpGb_g7Ni1CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O3KjmIjxKtuMlabb"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:35271 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753056AbaKLS2Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Nov 2014 13:28:25 -0500
Content-Disposition: inline
In-Reply-To: <CAJ5Y-eafz7PuZKQwX7bGYnYGvfWc5DmDdRWYd0PpGb_g7Ni1CA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <sudeep.holla@arm.com>, "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>, "patches@linaro.org" <patches@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lv.zheng@intel.com" <lv.zheng@intel.com>


--O3KjmIjxKtuMlabb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 12, 2014 at 01:25:31PM -0500, Ashwin Chaugule wrote:
> On 11 November 2014 15:25, Arnd Bergmann <arnd@arndb.de> wrote:

> struct pcc_channel {
>   struct list_head node;
>   struct mbox_chan chan;
> };

> Then use list_for_each_entry() to get the subspace id from a struct
> mbox_chan* , and list_for_each() + list_entry() to get the channel
> from a subspace index. These lists are not expected to get long in
> practice so traversing them for lookups is not really expensive and
> its only done at init.

> Does this make sense?

That's how we do it for regulators - even if the list does get a bit
long it seems like it's unlikely to get so long that it's going to be a
problem in init paths.

--O3KjmIjxKtuMlabb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUY6ZnAAoJECTWi3JdVIfQIIIH/iLr0xpGNavINDDWMT7R9TZp
8sPdXMOwTFoJ7/+05O0m4kg0nc2E+A1TG9d7XOtl3B9BCgxe1LRXdfvA8/gFql0S
/vYe2MjRINMqhwylRDvXAkXwAhsuaR4JVUd/TnXX1NLUqZEOjlVuAWeghMWvPJNg
mzmFJ3fqFGnwv3pDkf/w3Cmvq5TcAWp79jLTMfuAivLmbrIvDUGMyGka7hML7rDm
tlhVfkrGSXpt6sNmAcWGGvNLVrBdWpNozpTZOew/a43mFPOnxkDbjQCUwbwEG7jU
Iueq2UNMuL/Bv1g8c3vFHqpohx/tp8zj/5NNSwKnPZ2J6ZRd4VlDRBf0pPooO6M=
=/E4a
-----END PGP SIGNATURE-----

--O3KjmIjxKtuMlabb--
