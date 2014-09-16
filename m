From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 1/2] Mailbox: Add support for Platform Communication
 Channel
Date: Tue, 16 Sep 2014 10:40:35 -0700
Message-ID: <20140916174035.GT7960@sirena.org.uk>
References: <1410369619-2570-1-git-send-email-ashwin.chaugule@linaro.org>
 <1410369619-2570-2-git-send-email-ashwin.chaugule@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IsIRZ4DwzP0DcleK"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:45452 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754706AbaIPRkp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Sep 2014 13:40:45 -0400
Content-Disposition: inline
In-Reply-To: <1410369619-2570-2-git-send-email-ashwin.chaugule@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: arnd@arndb.de, linux-acpi@vger.kernel.org, rjw@rjwysocki.net, lv.zheng@intel.com, linaro-acpi@lists.linaro.org, patches@linaro.org


--IsIRZ4DwzP0DcleK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 10, 2014 at 01:20:18PM -0400, Ashwin Chaugule wrote:

> ACPI 5.0+ spec defines a generic mode of communication
> between the OS and a platform such as the BMC. This medium
> (PCC) is typically used by CPPC (ACPI CPU Performance management),
> RAS (ACPI reliability protocol) and MPST (ACPI Memory power
> states).

This mostly looks good to me at a fairly high level, one small nit below
which I don't think should be a blocker to an initial merge but would be
good to fix.

Reviewed-by: Mark Brown <broonie@kernel.org>

> +static bool pcc_tx_done(struct mbox_chan *chan)
> +{
> +	struct acpi_pcct_subspace *pcct_ss = chan->con_priv;
> +	struct acpi_pcct_shared_memory *generic_comm_base =
> +		(struct acpi_pcct_shared_memory *) pcct_ss->base_address;
> +	u16 cmd_delay = pcct_ss->min_turnaround_time;
> +
> +	/* Wait for Platform to consume. */
> +	while (!(readw_relaxed(&generic_comm_base->status) & PCC_CMD_COMPLETE))
> +		udelay(cmd_delay);

This will busy wait for ever if the controller dies.  We're in big
trouble if that happens but it would be good to have some sort of
timeout and scream here.

--IsIRZ4DwzP0DcleK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUGHYTAAoJECTWi3JdVIfQZ+sH/A23XyqDdfb6H4tWtls+KtpO
qlO156lOVhq9X3AakF+GHXa5zqhT862tsOVuttMbrPi8ZdMrlUOxBGsAN3CZXP4K
4WFxaZ1l+JvWDzC0reFw6fuOFVW3rfurWkhKXENungokKT042vqGZ2FXhgIrSQC8
sn6nvfCjyB+kUuDgsd431g6lL2fjECoayVGr9u1W3vLFkOf1xDmubPsnKGz24h0W
mShxQkqX6op8x4m4/HB9TJ9MiGjIySwXiSsSKsmhnUgThzp0wSYjEg7TmsO1lSpb
0RJDkYEFKeldBqauxLtFGLjHDW7ahHqk4SAy3zMcxQFdv3v+Vmste4Wmmfmb7Z0=
=qPfC
-----END PGP SIGNATURE-----

--IsIRZ4DwzP0DcleK--
