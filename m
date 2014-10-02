From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v8 1/2] Mailbox: Add support for Platform Communication
 Channel
Date: Thu, 2 Oct 2014 18:25:30 +0100
Message-ID: <20141002172530.GW4273@sirena.org.uk>
References: <1412196373-7794-1-git-send-email-ashwin.chaugule@linaro.org>
 <1412196373-7794-2-git-send-email-ashwin.chaugule@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dU989noCA+aq9KP4"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:58938 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832AbaJBRZm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Oct 2014 13:25:42 -0400
Content-Disposition: inline
In-Reply-To: <1412196373-7794-2-git-send-email-ashwin.chaugule@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: lv.zheng@intel.com, linaro-acpi@lists.linaro.org, patches@linaro.org, linux-acpi@vger.kernel.org, rjw@rjwysocki.net, arnd@arndb.de


--dU989noCA+aq9KP4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 01, 2014 at 04:46:12PM -0400, Ashwin Chaugule wrote:
> ACPI 5.0+ spec defines a generic mode of communication
> between the OS and a platform such as the BMC. This medium
> (PCC) is typically used by CPPC (ACPI CPU Performance management),
> RAS (ACPI reliability protocol) and MPST (ACPI Memory power
> states).

Reviewed-by: Mark Brown <broonie@kernel.org>

--dU989noCA+aq9KP4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJULYqJAAoJECTWi3JdVIfQl2gH/iirHBlcntiqmdoHeAiZuRN+
EehNCrmh/cdiJqetaXJBQKjpTkX3ILSkLVjFH31lijJ8OMnaNWUWiXmkuW/XtFbu
qAkfZkglQVHkA0dlDrVcZGsY8RmzBIMPicM81rSAcnS/YcecfcQnIlHWqsN2yNDd
ctl3SpZMSL4yj7EUumL93m4xDDk31kC4Y425NwuKrYrxRQj6iayAHOpN5LGuDQ2n
j2gns5Min6BH+EjJnRT/DeHSMLpqQcdWhPzTtmLRxbl7KEH6AeUgymc4T/Bg226W
5UcBTo8JUX1ERuBng5HoTuNTfPtcyes6QEMqeIhQxO6TFTXgO/AWtYopTFZsx28=
=YOPn
-----END PGP SIGNATURE-----

--dU989noCA+aq9KP4--
