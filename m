Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793094118;
	b=pK4+7nPMvGwmbulU8eii6cMVE/Kz9D4990TB6zMsy/dMk26cLas4xQCeecwknFL7RaG4
	 k+447FdWCCt1+cuLnx5Yc/tQIqPus0WgJLaaptR+g3JGbwExbfz1LO6XnTFwR/SziIZzQ
	 6KEjNLsXD7sq5s99PH4OhEGpF9yJMPD8xseDtHLScRA7FriMCqz7iTjdmbS07CCJVX/8k
	 LeqSZKjjo5C4MzpA4nP/mUcVy6v9D80x6vOBphrNw3RWaiIEKpDRhfuokGTVyzUh0cI+j
	 Ehv3hcDuY2za8bTDzDqnboSFxa6j8i3fsA1d65Soumstz/XDFnaGaTcK0PdlupIcQyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793094118;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=0G5Gh9P2KO0+5GGiKNPkOdO6AKt1oHHc652uqXaZcqY=;
	b=lH0tgxaCAlDJiwRViaaHm12sHmDA0TK5IzMlIZjaTYpeBT7p8wRvpCBeKGqDAwaPYCt3
	 dWw/h1ZlqRrRZwB6rnaIeDpD0yyZWHzJPUmiVNiWladfg6OzAjwaupnUP8al2LamBarlw
	 ot6/dEP9WukDAs5RK1h7SZAH4WDEqPaPd2YtnWZRlgRRH2RhHg6yPtcwZ1yIvRWMQVy5s
	 Tnp0LKojKdxOwtJNvLmW/UGcVbdWsjXEipUAR5If69t95+bcUkkSfqhZDOINp1xQRRkhr
	 osN3DTZxUwQyGOvsmgsZGPJf362zIRD+EMwZgyHWJ9Z7M3QU/nUiTidwWIYmEpNa3Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Lrgqg8Sw;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728B2606A31F
	for <linux-acpi@vger.kernel.org>; Tue, 27 Oct 2026 09:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 728B2606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Lrgqg8Sw
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso21057335e9.2
        for <linux-acpi@vger.kernel.org>; Tue, 27 Oct 2026 02:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793094115; x=1793698915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0G5Gh9P2KO0+5GGiKNPkOdO6AKt1oHHc652uqXaZcqY=;
        b=Lrgqg8Sw8B0MTFHOgBFBsZea8yJ5PGupCUU44KFrLSJFOaY7P+6n7vJiqmkm/ccK36
         mnRTBEXSzJjw7xIZDs+5PWEyIB3Wnj60O8VDRG9CRFrmAAqy0R3jrwSfYzp2RC+iR/da
         CX+EOdAr1Jmfgg5HdNz0YL53TuoXKnFmWUVNvqvRiGwB3nJhgXmXudPcUEBUs2LGCCW0
         LQyNCaOKCXuojR58IHPS9Xzm4UhEno4FBNeMmanacYHfeaoNrvJdsY835na+t3EpbJf7
         NUxkcOBM73+LfGKKxWz0wEGr7pjwv7WTp6KLUY4Dk+hm7tkmDbCofa1WaCwsvjoa4tVW
         RVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793094115; x=1793698915;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0G5Gh9P2KO0+5GGiKNPkOdO6AKt1oHHc652uqXaZcqY=;
        b=JDeRQHT4K5DyBXoWaOS8XU1Fm4wwhKP6nVmxTQI+qdMGMUWYXAWf9WE1JzL1pd9ciT
         arFl/AmD6t6cyYmW4OZqOctD6vyW5KZcAvd7/jO6HKYxepnKPZtiZpz3HXJuqB8yLsYO
         tkU0fc4TOZupWrSzQJswJPKwDXI5tEIBEE+3T+1s1b7ZwtmEAk3RVvpzPgp+sSW8ufP6
         gLjFla8OsGW9skwsEAePUzOQXHNuZMUzqXmo2ogsOG+bGCbO0MOjvHDe5VGvx4VE95PW
         xgM+JH0AaxWFQGh86PzAD+kH479++MX+1t29jX3aFvWBNyB7JeL9GTzI8S4iPIA7/LdC
         ER4w==
X-Forwarded-Encrypted: i=1; AKwUvByk3WjpOc6LC5ucRIBjtwascr3/Dqb+RlNzWC1MKwcvKARrODmOnhBODdhEKlLjjRwjN7h10MTCsgby@vger.kernel.org
X-Gm-Message-State: AFq9FYL78FVowu3u8msk4xUmTtatfazZf2V9IlcVe37EAIpxkNPiGuJd
	8nJCV/cPD2vkrhbGc/5dIUqndIPmaK6Csu4zLnW0Zqzr31XhZVlBgFwSNk+ulX9OLt0=
X-Gm-Gg: AYBFou3r97Mh2wCg3x8KijoPjhC7W1Mm5fpi4PZQ8b+nm7hFGEuO3W12OPFy5ceSxug
	Rw23erJ89V086AcbxBLar8c/+ysXkbb9iF+BrnQgEyn6Vc6APOFk7XITMNJH8irIZOzsaicNMLf
	LunHANdgtdVzjolM87D1o+UlHoISOGaqsAGAP+FmKL9OslGvBfFr+dJbJR898td+gla6P9u+OTU
	Q8KhuV2PkgdVf2ohy55+aX1N3kTKh73jaTpBdPU4kcgds6UScvSL/fGovwEQ0C9SDgZqoaossut
	mP8+fQ+8lwn5ldux/RXgLHD8DlbzDsC9sEEa+PfZa1Tx70nI+BEIfaBSOMACvj57LPZ5JxV1MSg
	0IOzY88f1d/XSRMN7MzVaYPGB+z47FnkOlPJfH+np4KefLsBQB/F6vQ0Hy9ZakT3vrjh4fG/nqZ
	0aNYoCaSD6Ly63zeIrUaORSB0ItcQenoDZxjO2LR4+02Y1GqzIepqBe5L/KxxAloE5MPPUOFVWN
	tLgC+mzLrS2gSeah03LBulwaaG5ogQ2ubMt/cSXiKvCxfwV+U4qQFfrlnKnVV/LsQqjYcFR7guj
	PGKmyXgSLnmrupHryfnjfUJGiLbK3ojaJRTKY94Go+0=
X-Received: by 2002:a05:600c:8a08:b0:4a4:7a8d:c736 with SMTP id 5b1f17b1804b1-4a47a8dc93bmr110335135e9.9.1793094114509;
        Tue, 27 Oct 2026 02:41:54 -0700 (PDT)
Received: from localhost (p200300f65f19a904240e81f1f32a429c.dip0.t-ipconnect.de. [2003:f6:5f19:a904:240e:81f1:f32a:429c])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a35a59d998sm263939065e9.15.2026.10.27.02.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 02:41:53 -0700 (PDT)
Date: Tue, 27 Oct 2026 10:41:52 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lixu Zhang <lixu.zhang@intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Imre Kaloz <kaloz@kernel.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez <valentina.fernandezalanis@microchip.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, Daniel Palmer <daniel@thingy.jp>, 
	Romain Perier <romain.perier@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	Hoan Tran <hoan@os.amperecomputing.com>, Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>, 
	Mika Westerberg <westeri@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, "Enrico Weigelt, metux IT consult" <info@metux.net>, 
	Viresh Kumar <vireshk@kernel.org>, virtualization@lists.linux.dev, Yinbo Zhu <zhuyinbo@loongson.cn>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-tegra@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Srinivas Neeli <srinivas.neeli@amd.com>, 
	Michal Simek <michal.simek@amd.com>, linux-aspeed@lists.ozlabs.org, asahi@lists.linux.dev, 
	linux-mediatek@lists.infradead.org, openbmc@lists.ozlabs.org, linux-omap@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-unisoc@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	Michael Buesch <m@bues.ch>, William Breathitt Gray <wbg@kernel.org>, 
	Robert Richter <rric@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 00/22] gpio: Improvements around device-id arrays
Message-ID: <auBxfVzkveb7KlEk@monoceros>
References: <cover.1793030820.git.u.kleine-koenig@baylibre.com>
 <at-CGVq5jVsMQief@SMW015318>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qlk6jmpzfns64bdk"
Content-Disposition: inline
In-Reply-To: <at-CGVq5jVsMQief@SMW015318>


--qlk6jmpzfns64bdk
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 00/22] gpio: Improvements around device-id arrays
MIME-Version: 1.0

Hello,

On Mon, Oct 26, 2026 at 11:38:49AM -0500, Frank Li wrote:
> On Mon, Oct 26, 2026 at 05:28:11PM +0100, Uwe Kleine-K=F6nig (The Capable=
 Hub) wrote:
> > [...]
> >  drivers/gpio/gpio-imx-scu.c         |  1 +
> > [...]
> >  drivers/gpio/gpio-mxc.c             |  2 +-
> >  drivers/gpio/gpio-mxs.c             |  4 ++--
>=20
> For all imx part:
>=20
> Acked-by: Frank Li <Frank.Li@nxp.com>

I'll apply this to all patches touching the three files left in my
quote.

Best regards
Uwe

--qlk6jmpzfns64bdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrgcd0ACgkQj4D7WH0S
/k4RSwf+IK0Zg4d+0uYc5szRXc18DV2GOQKuWytvc6Mb7rb8wBUlhLcCzHXfHJw5
GKyFFUIrW1GHu/p4aSlsaOLm8RjGYbgR1RTnxQySdf79td9IxG/EXqQcp6FcxSH5
30Ema9IFNIy1Z1fLQlqcQWR4FaujBuohFx12psbgjzkhMn3OY0x3w6FsZddRxBu6
hjb1B8M89jP2R7VcM2CC+KYKqlxNoQYiS/XOiE7oyKj9CqBRDIrGPNwKtLxUelaD
kKhTCJUSL4uTa26RZDC42xIr79ip8u0RW/+hzEwjtlicpsH0uFemsO1TO74xS/ol
PbKbBRoQJlRhoDMBJ7sTb6K4gJHPEA==
=KSfn
-----END PGP SIGNATURE-----

--qlk6jmpzfns64bdk--
