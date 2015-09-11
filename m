From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 01/22] driver core: Add pre_probe callback to bus_type
Date: Fri, 11 Sep 2015 13:04:08 +0100
Message-ID: <20150911120408.GO12027@sirena.org.uk>
References: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
 <1441628627-5143-2-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/GGxXfKRHScBDXG5"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:59984 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859AbbIKMEd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Sep 2015 08:04:33 -0400
Content-Disposition: inline
In-Reply-To: <1441628627-5143-2-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>


--/GGxXfKRHScBDXG5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 07, 2015 at 02:23:26PM +0200, Tomeu Vizoso wrote:

> +	if (dev->bus && dev->bus->pre_probe) {
> +		ret = dev->bus->pre_probe(dev);
> +		if (ret) {
> +			if (ret == -EPROBE_DEFER)
> +				driver_deferred_probe_add(dev);
> +			ret = 0;
> +			goto out_unlock;
> +		}
> +	}

So if we get an error other than -EPROBE_DEFER we silently ignore it?
That seems surprising and at least worth a comment.

> +	if (dev->bus && dev->bus->pre_probe) {
> +		ret = dev->bus->pre_probe(dev);
> +		if (ret) {
> +			if (ret == -EPROBE_DEFER)
> +				driver_deferred_probe_add(dev);
> +			goto out;
> +		}
> +	}

That's more what I'd expect.

--/GGxXfKRHScBDXG5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV8sM3AAoJECTWi3JdVIfQuAQH/0wfAhyhwtb7xaoL2MFUGJQO
3QX063MsDiR0Ga7Shnk3m6/lCQFngh54xIrtzNzUh0ANqfE7uhWx+FhSZDx1foqX
APfTvO1ssV8Gy6BSKj1jMGy2S3pLcifO+TRUKqssLecRsO1G9igjEX84cpbEPb2b
TEk7osYawsNh1yWn3tWd1NPe6FgZty97uG1O6ezfCxSGW3vFrgAaq3B0ztXGVxWT
H2kbUE3rP9kiO4IM4hcsWhxjSVRPrllqGBtIkEzKf0/G2jEcrLMI5uo+NcRtTlO5
tsHnf3RIjeQPFKuaLogK1epn5GNXxS3O8pwP9wN3VWqsv5uAHVbAAVGyQHYPEvw=
=xK52
-----END PGP SIGNATURE-----

--/GGxXfKRHScBDXG5--
