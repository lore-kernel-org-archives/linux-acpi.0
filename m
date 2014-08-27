From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 2/3] Add support for Platform Communication Channel
Date: Wed, 27 Aug 2014 11:29:37 +0100
Message-ID: <20140827102937.GX17528@sirena.org.uk>
References: <1409081738-5602-1-git-send-email-ashwin.chaugule@linaro.org>
 <1409081738-5602-3-git-send-email-ashwin.chaugule@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iYLmq5he1S0iJCyn"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:35779 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756002AbaH0K3p (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Aug 2014 06:29:45 -0400
Content-Disposition: inline
In-Reply-To: <1409081738-5602-3-git-send-email-ashwin.chaugule@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: arnd@arndb.de, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, rjw@rjwysocki.net


--iYLmq5he1S0iJCyn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 26, 2014 at 03:35:37PM -0400, Ashwin Chaugule wrote:

> +static int pcc_chan_startup(struct mbox_chan *chan)
> +{
> +	return 0;
> +}
> +
> +static void pcc_chan_shutdown(struct mbox_chan *chan)
> +{
> +	return;
> +}

If these functions can be empty it seems better to have the mailbox
framework accept empty functions than require drivers to provide
dummies.

> +	/* Search for PCCT */
> +	status = acpi_get_table_with_size(ACPI_SIG_PCCT, 0,
> +			(struct acpi_table_header **)&pcct_tbl,
> +			&pcct_tbl_header_size);
> +
> +	if (ACPI_SUCCESS(status) && !pcct_tbl) {
> +		pr_warn("PCCT header not found.\n");
> +		status = AE_NOT_FOUND;
> +		goto out_err;
> +	}

Is PCC mandatory?  If not I'd not expect to see this as a warning.

--iYLmq5he1S0iJCyn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/bMOAAoJELSic+t+oim9KfcP/jmduXJkqhZb8YgHXt9bjWnC
B2liOFrrzmaIRIWyyLFovlbUmXjrP8DpK87Rbf3Oyp9DkQdOmh602sW/PekmSPTC
Sqdj296La9Q7TbESlVQhsbmMzk59Wrk4eSUzoeSppNAdIpKW8gam0eRBgeQZG6SU
tIwsig1xKPF+0b8nhaHB/sU61GUUm7DLk39jSFshnI0DbgiPFZ52Dqq+Cj0PYInk
yius+1yUYVG/9thclOIoFrrEjoJEhHlj644Bpks5UxBPRXcAQ8YsQgUX3T5kFAIv
gbqoWbQ1tOvz/Z3vg9w90RJ8yQ+PEtcCqU3G1Gz65PwY8VVO6Kubf/tezZZdVYdb
DUNq9JnQ1c668/LZ3auM8v4vo3wh2IRTzBIBCwabC5+mXZKygkNhhLCP3abzjmZ6
fkzUYemY90Moq4dJbJxHjmv7tenJMMk66W99mm417X/dg8xAy/9w/3lkzqF7fy7/
fcvka9mvyXx9nJNGdtIDIgQI2s8dh2CxoTcg3GGij/tmMz57G7FGWGS71i1GqTiq
f7ctojRoyUm1jngQu8hVjRstnA2KKS8GQyJRhK2q40zeL6S7zJvnCKEKKbsuIHWl
dI1nFI5n21pQpX02K79118bZv6sP7mUuu0BwbWrmhMSy7x7bkST7Xx3Gq+OoesGz
h+tYmkja5/u+evnQIlAV
=Ulf5
-----END PGP SIGNATURE-----

--iYLmq5he1S0iJCyn--
