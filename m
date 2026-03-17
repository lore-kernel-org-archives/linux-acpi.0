Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BC83921CA
	for <linux-acpi@vger.kernel.org>; Tue, 17 Mar 2026 07:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773733334; cv=none; b=BCJvrGh05wjAMRX7np3vZKZ3i9mKInRA6kXY/YiMS0DNJgRgF6kOC3l0uv2FEmVJZO9L5WxLUqkmfz+53wZ3SQxl0FNamgyVxtfjogJW8Ur+BW4rnKoM/1jBTjKimw4O/ovsKIxdCmGDtYEALSlNGnTRVdwmhUveNsw5s+xjeos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773733334; c=relaxed/simple;
	bh=axppJ7vgRT+l1j200xQDrNPk6kDH5EhBlMQpMegQ1DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+/8HdKfGWqLEtHjdCM0zNLZR8Y0kTddbIaR3XUI57C0/p+xgN+rp69tLtz3LqAe6OlVdDowPO8wl28SLNDO+3YV+jxM+KQP3PQCo9nj84LFmXpq0pFnYTE+h0/91ggCvL2lONoc2Ky4dMSz83CvLRJbcKiX/t2I0VlvMjZTRxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Aa6jzP26; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Aa6jzP26"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=1fxb
	qImj03OXajBmpzO1CQUCWD5bO4dGjX1EHtbcLAY=; b=Aa6jzP26tOFbp867zHZJ
	/Wez7/ws1xj+fYCjTuWXNVyOt8TBM+Qh+9qqjoe/08lACxSnjZnuze2e/foZ8dk5
	5gst9VJR9MVZxK1up39HIYurtorLzowfdVFjGTms2Bd8nOqGP5sUHw81+ZPpqBc4
	kUmK5QGGEDgIYjxUNWGYXrynV4eLqPjfsHo+Be1UGornxMXwK7Ojtawvhpsw54Jx
	9zkzEXqQSec60WN/Ef1vkS+Kv1IySz9OyALNAU3OcWxPLI0SJrrpG4sxCalVmrfL
	MhE59O6Bns/GhGXVP0ItcgSyUpPoLjBr095rHZgRWEkvI6o1weebYFFstS9Q7bGU
	NA==
Received: (qmail 167291 invoked from network); 17 Mar 2026 08:42:08 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Mar 2026 08:42:08 +0100
X-UD-Smtp-Session: l3s3148p1@Ze/6eDNNfNVSwmvS
Date: Tue, 17 Mar 2026 08:42:08 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Douglas Anderson <dianders@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Daniel Scally <djrscally@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>,
	Mark Brown <broonie@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, devicetree@vger.kernel.org,
	driver-core@lists.linux.dev, imx@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] device property: Make modifications of fwnode "flags"
 thread safe
Message-ID: <abkF0GO01sMcOhvb@shikoro>
References: <20260316154159.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
 <abkCPU3rxHI49N4_@shikoro>
 <abkD-VLprcbbEbB1@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abkD-VLprcbbEbB1@ashevche-desk.local>


> > ... this change costs some memory on every system. Maybe it can be
> > avoided?
> 
> How much memory does it cost? On most 64-bit architectures is +4 bytes,
> rarely +0 bytes, on m68k it might be +2bytes. On 32-bit it most likely
> +0 bytes. I expect that 64-bit machines will cope with this bump.

I am not opposing that the issue should be fixed. If it is not possible
to take the lock everywhere, this is a proper solution. But if we don't
have to use more memory, then we could save it. Our new SoC easily has
'struct device' in the hundreds.

