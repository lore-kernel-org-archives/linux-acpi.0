Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DA73EF0AF
	for <linux-acpi@vger.kernel.org>; Tue, 19 May 2026 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182552; cv=none; b=UjTuyzpdlTndWHaco1+AIYFj0wD/R604Hkgqc8OBAtRePijOFXqculjstM7QZeCIVFLuO93kBswH7aeM5lxchtdS0t51R4SWZU0Arh6LCDFgdbyYCeiOQm+I4wT2pb/R1xegc39pO58IZJgeiGRq43cLt3/Ddwc/uNuOV5vYiZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182552; c=relaxed/simple;
	bh=EUMqPpjTIOg/UVJTA4J5F4Cm6Dd1SRM+qi6ZkJ7HX7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLz5lakNZ7ki7HBPDdVt1yjy+/N9BET3Ql0ySg9BdP4VtekY5rJnoRwc35oYaoWKjnXc9p5neo12wdpMXSILsRUdsCLli81dJY8Cw4bTYb9UPiRwL2D985Mf3oVoPJm7BWmAQVr76MXcVQWgct+P9Hai276mXsP6VsxWGi1BYVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=K16NRXKG; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="K16NRXKG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=vDiw
	cUS7KKcAuA9zQ93RHRaPkFaMupzoLqaQVImJgAo=; b=K16NRXKGWgwSp/DERPis
	kGb8sfRsH6tY2Iax1PPnAlDP7JGg1DqyIPCp1pkacciz63ayYD+1LpAiMM9PbTZC
	rNce/Vodq9K6BDhsrKjaZB9TlXWMgQygCcpMPEQv6GSp+kCm+ijVAhxTcsExRv5p
	H8LgtA3WLNPvphIMfh7yi+M+JOocr4frblYKNwr4OT4IWvxRX6OiFBUW0UxjpBiY
	PYnJ3ymCxCCIMGzACtEVqo/4uFArp/FsMkj4ztaSvAk02qjGmtAQyEwFWECM3E2A
	dsoXQOBFtLhK6XPs1rKFXggtmvK6b5TL8+aJppapbUlV/KU1H+xWZnMbNK0nXDGV
	Jg==
Received: (qmail 201991 invoked from network); 19 May 2026 11:22:25 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 May 2026 11:22:25 +0200
X-UD-Smtp-Session: l3s3148p1@TtmWNyhSU4tUszca
Date: Tue, 19 May 2026 11:22:24 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Kalle Niemi <kaleposti@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Len Brown <lenb@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Wolfram Sang <wsa@kernel.org>, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v7 1/3] Revert "treewide: Fix probing of devices in DT
 overlays"
Message-ID: <agwr0BE3EdYx70XA@shikoro>
References: <20260511155755.34428-1-herve.codina@bootlin.com>
 <20260511155755.34428-2-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511155755.34428-2-herve.codina@bootlin.com>

On Mon, May 11, 2026 at 05:57:48PM +0200, Herve Codina wrote:
> From: Saravana Kannan <saravanak@google.com>
> 
> This reverts commit 1a50d9403fb90cbe4dea0ec9fd0351d2ecbd8924.
> 
> While the commit fixed fw_devlink overlay handling for one case, it
> broke it for another case. So revert it and redo the fix in a separate
> patch.
> 
> Fixes: 1a50d9403fb9 ("treewide: Fix probing of devices in DT overlays")
> Reported-by: Herve Codina <herve.codina@bootlin.com>
> Closes: https://lore.kernel.org/lkml/CAMuHMdXEnSD4rRJ-o90x4OprUacN_rJgyo8x6=9F9rZ+-KzjOg@mail.gmail.com/
> Closes: https://lore.kernel.org/all/20240221095137.616d2aaa@bootlin.com/
> Closes: https://lore.kernel.org/lkml/20240312151835.29ef62a0@bootlin.com/
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Link: https://lore.kernel.org/lkml/20240411235623.1260061-2-saravanak@google.com/
> 
> [Herve: Fix conflicts due to f72e77c33e4b ("device property: Make
> modifications of fwnode "flags" thread safe")]
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com> # for I2C

