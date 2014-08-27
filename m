From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/3] Mailbox: Add support for PCC mailbox and channels
Date: Wed, 27 Aug 2014 11:27:08 +0100
Message-ID: <20140827102708.GW17528@sirena.org.uk>
References: <1409081738-5602-1-git-send-email-ashwin.chaugule@linaro.org>
 <1409081738-5602-2-git-send-email-ashwin.chaugule@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YK6JF6g3MGrlNqAP"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:35773 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933323AbaH0K1W (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Aug 2014 06:27:22 -0400
Content-Disposition: inline
In-Reply-To: <1409081738-5602-2-git-send-email-ashwin.chaugule@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: arnd@arndb.de, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, rjw@rjwysocki.net


--YK6JF6g3MGrlNqAP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2014 at 03:35:36PM -0400, Ashwin Chaugule wrote:

> The PCC (Platform Communication Channel) is a generic
> mailbox to be used by PCC clients such as CPPC, RAS
> and MPST as defined in the ACPI 5.0+ spec. This patch
> modifies the Mailbox framework to lookup PCC mailbox
> controllers and channels such that PCC drivers can work
> with or without ACPI support in the kernel.
>=20
> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> ---
>  drivers/mailbox/mailbox.c          | 118 +++++++++++++++++++++++++++++++=
+++---
>  include/linux/mailbox_client.h     |   6 ++
>  include/linux/mailbox_controller.h |   1 +
>  3 files changed, 118 insertions(+), 7 deletions(-)

Based on the patch description (adding support for a particular kind of
mailbox) I'd expect to see a new driver or helper library being added to
drivers/mailbox rather than changes in the mailbox core.  If changes in
the core are needed to support this I'd expect to see them broken out as
separate patches.

> +static struct mbox_controller *
> +mbox_find_pcc_controller(char *name)
> +{
> +	struct mbox_controller *mbox;
> +	list_for_each_entry(mbox, &mbox_cons, node) {
> +		if (mbox->name)
> +			if (!strcmp(mbox->name, name))
> +				return mbox;
> +	}
> +
> +	return NULL;
> +}

This doesn't look particularly PCC specific?

>  	/* Sanity check */
> -	if (!mbox || !mbox->dev || !mbox->ops || !mbox->num_chans)
> +
> +	/*
> +	 * PCC clients and controllers are currently not backed by
> +	 * platform device structures.
> +	 */
> +#ifndef CONFIG_PCC
> +	if (!mbox->dev)
> +		return -EINVAL;
> +#endif

It seems better to make this consistent - either enforce it all the time
or don't enforce it.

--YK6JF6g3MGrlNqAP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/bJ5AAoJELSic+t+oim97QgP/2Kk6bUVuiKenqZvUTegtvPi
Fwmzkx+MiMSoBxFZOOZ4N00zsSsAlAJMj5CLY8LzteVQPQeDtpOv7D+WRtjNLCb+
/cCKEedCKnznEt5ikPeAneo3Fb8RXt7plU2W9iL3O7CX53zS2nzbP3BabQDcjBBF
AHMOSgCfuVyp25Uem1b5jyCDXNbKi7jLrcREBZVarm4/lltvzk8xgn1YV8dm8/2/
P1hqZyQI67Z5BJUOj4nr7fRDm6CY/H5x0emiRBnLvF3jkZunzkVRRD55RQ86+p9z
T7vBfU5t8tyAqZQf0sqpEk37nb9RlNZXOcSFT7PRrak0kQMlF8JVYXD5FPmkonJC
THfzKRUd7JCu6lw3qcKrtJSSCPWXw77mWzOx0eGT7vZaUdob6ol8KyLLvmyV50Vs
l37pJks78A3M1Rlq5oawEzT5sp9JEtovcW1fmE7doa2h1y7NJZqf3CSsZ/TNKQjR
JzwN5PlgmeJR1CV1SmqQDacnY7n0MkC2J43HuL/ezHdFg9gFeiNkybfMd87gQip/
nAe+MEoJ37QwT+2HHyMdI1/643up5ZMaCpnuftfiiIWKlKGzfLiwOTewIhZztwd0
LG6drhmUgN5W1utp2LrAB62gj5GicCwKSFnc8gCdPC8FKhOfMF+ElOyTU7/tB2Y3
CgKC/ayBXXCUw1pjJJfI
=2oAb
-----END PGP SIGNATURE-----

--YK6JF6g3MGrlNqAP--
