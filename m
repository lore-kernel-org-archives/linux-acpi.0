Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793608404;
	b=Lw9A3Nn/mSTVz5wBD3EVWmZFVtHIqg0WK0KIUpakkY3TPDqwLeBB8eOXndTn2RBy64qm
	 TwkPMWFy5ZhzGDSWPfxQ/YxnbIxzKXnjIeBnp4kauPjLycit4KvjCMfvNfUwaoLdTlRD+
	 rahcfEoFad7aPoXIDV5LWTtRzhe5S6njzG0bNOdzgTLNLWfEQxqrFktCzBIkgWF6gxwlu
	 oqXCkVahsArWwL00mBdURJE3pY4+WFeXjCluIsa1Dn80MOgGVSrDPUIf1FPmPpgiNRAPo
	 hprFEYKRKemOv5PcWUneqegoAPKSnJRKwr8dOhavza79Xij3axaR1Q15wqmc9EsoK1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793608404;
	h=Received:DKIM-Signature:Mime-Version:Content-Type:Date:Message-Id:
	 Subject:Cc:From:To:X-Mailer:References:In-Reply-To;
	bh=g+7LkYQEjLBa0pHbVfmJK2O9a1hTF9dUud4ExVAmhPo=;
	b=sYKo5c8Va9/p8tKnwS7Ra1zx+2KhIVFvQQpHzpC8ONtHD+9m7hjf0RTTXY3ExCNAxcd1
	 MhyyG5UToVIr78nJLdQ1rPHUwEaUF3QJI2qtGaeE9a5F5FxoMztQLEODOkWxx+ZuiGXy9
	 w+WS1LzBzx3gmwrmQvu3rUFQvQtxg+VZYBpGKgJu53vdnYVRZcwJSnVC8OAsYIMePH8Xq
	 TzPpxfGeShXXTG7XHAQdHizc2rx3IqOZ0N4IWwprdqIF3uxH/sICxU5XlYj4c5MKRjyH2
	 uNwtHEeq+0RLjtgL39Wj8dBjeQXmwf7R7RCpd+E5+57Cicb/0ZfmebmFXIrMoNm02CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CG+t2RrK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 7D9F5606A324;
	Mon,  2 Nov 2026 08:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CG+t2RrK
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 890B31F000C1;
	Mon,  2 Nov 2026 08:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793608404;
	bh=g+7LkYQEjLBa0pHbVfmJK2O9a1hTF9dUud4ExVAmhPo=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To;
	b=CG+t2RrKQUSI99OOxAXkRPc6OJNgeRSvIqSnFF845GXEyQ96eeGuWiskf/h+1+UQV
	 FCM+PCg6TkDy8vdHO+GCpry22Jyvdbpw7m0Sh6GWtrD91a+0J/L3lUNmVzQmE78x8J
	 jQL8TwQQ0wn11+sDsSYyRDR0LloyivSHNz4oR2fgPVhiknECqrJVxMpzjhFlk8cvza
	 fnjOJsdkOuj0PWc/TBomThVGEOIp+ioAY/tqzgFTZpVqh+Ydp4OwOTSnvjmXeouF8m
	 Hv8phPwMEqQXEVWc+mgzSVBDaZwdwYhThmDz/7Gzh6n0rzWsoRWFuALevpMLStwP6i
	 b4BN5PmB9KBCg==
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=e559a543ddd5736e0bc1ea0535865b80f9a388da70706e5bb56e98e2b163;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 02 Nov 2026 09:33:20 +0100
Message-Id: <DMKL43ZCOSQ3.3TAJL8BRQ6ZTH@kernel.org>
Subject: Re: [PATCH v13 08/13] gpio: regmap: remove gpiochip before tearing
 down irqchip
Cc: "Linus Walleij" <linusw@kernel.org>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@oss.qualcomm.com>, "Conor Dooley"
 <conor+dt@kernel.org>, "Mika Westerberg" <westeri@kernel.org>,
 <linux-acpi@vger.kernel.org>, <devicetree@vger.kernel.org>, "Long Zhao"
 <zl020895@163.com>, <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: <longzhao@ambarella.com>, "Bartosz Golaszewski" <brgl@kernel.org>,
 <linux-gpio@vger.kernel.org>
X-Mailer: aerc 0.20.0
References: <20261102-cv75-gpio-v13-0-4f93114ea204@ambarella.com>
 <20261102-cv75-gpio-v13-8-4f93114ea204@ambarella.com>
In-Reply-To: <20261102-cv75-gpio-v13-8-4f93114ea204@ambarella.com>

--e559a543ddd5736e0bc1ea0535865b80f9a388da70706e5bb56e98e2b163
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Nov 2, 2026 at 7:46 AM CET, Long Zhao via B4 Relay wrote:
> From: Long Zhao <longzhao@ambarella.com>
>
> gpio_regmap_unregister() currently calls regmap_del_irq_chip() before
> gpiochip_remove(). That disposes the mapped virtual IRQs and frees the
> irq_domain while ACPI GPIO-signaled events may still be requested and
> while gpiod_free_irqs() still needs gc->irq.domain.

Maybe Andy have an opinion here. But that deviated from the usual
cleanup in the reverse order and at least deserves a comment in the
code.

> Remove the gpio_chip first so ACPI teardown and USED_AS_IRQ cleanup run
> against a live domain, then delete the regmap irqchip. Use the same
> order on the registration error path, which previously leaked the
> irqchip when gpiochip_irqchip_add_domain() failed after
> regmap_add_irq_chip_fwnode().

This should be split into a seperate patch with a Fixes: tag.

-michael

>
> Cc: Michael Walle <mwalle@kernel.org>
> Signed-off-by: Long Zhao <longzhao@ambarella.com>
> ---
>  drivers/gpio/gpio-regmap.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
> index 0a44deae3d01..6b520bd80834 100644
> --- a/drivers/gpio/gpio-regmap.c
> +++ b/drivers/gpio/gpio-regmap.c
> @@ -429,6 +429,11 @@ struct gpio_regmap *gpio_regmap_register(const struc=
t gpio_regmap_config *config
> =20
>  err_remove_gpiochip:
>  	gpiochip_remove(chip);
> +
> +#ifdef CONFIG_REGMAP_IRQ
> +	if (gpio->irq_chip_data)
> +		regmap_del_irq_chip(gpio->regmap_irq_line, gpio->irq_chip_data);
> +#endif
>  err_free_bitmap_output:
>  	bitmap_free(gpio->fixed_direction_output);
>  err_free_bitmap_dirmask:
> @@ -445,12 +450,13 @@ EXPORT_SYMBOL_GPL(gpio_regmap_register);
>   */
>  void gpio_regmap_unregister(struct gpio_regmap *gpio)
>  {
> +	gpiochip_remove(&gpio->gpio_chip);
> +
>  #ifdef CONFIG_REGMAP_IRQ
>  	if (gpio->irq_chip_data)
>  		regmap_del_irq_chip(gpio->regmap_irq_line, gpio->irq_chip_data);
>  #endif
> =20
> -	gpiochip_remove(&gpio->gpio_chip);
>  	bitmap_free(gpio->fixed_direction_output);
>  	bitmap_free(gpio->fixed_direction_mask);
>  	kfree(gpio);


--e559a543ddd5736e0bc1ea0535865b80f9a388da70706e5bb56e98e2b163
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCauhK0BIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/jxzwF/ZAkzKOGv9l7MDYcYh3jS3nkx5ghEgdBb
HCu8STEFMwoP4R28mXbuZ+uJ1KYSz0FFAX97LO7hwqVWxf3PyqlhJ3hKq74WfhY6
/5fERnbMYAZqjKeKQFXywMH5hmjOAMwDK2s=
=Ghuv
-----END PGP SIGNATURE-----

--e559a543ddd5736e0bc1ea0535865b80f9a388da70706e5bb56e98e2b163--
