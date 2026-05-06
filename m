Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE15D4218B3;
	Wed,  6 May 2026 12:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778070041; cv=none; b=uxKHblMBQ9TZ1TFbc2A6rKkCzBfkIzAtQnFMIfm6jpRudz3o5Nmc8ySGd/CYhY2wq0KQeEKNEhGIdKHCGErUO5FeZXl9ZX+HIGyBrmyZR94b/BubHX+PVZaO5x9WuZIJlidbJspMovsG2bv9I038J3+KzBGE/5J+7gUmTzipz/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778070041; c=relaxed/simple;
	bh=Y1K9R2yWFNNKwNhN1mxkmLD2soiEXuCLKYgKNjk0OxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfehK8EPfUh9Jfj3ZqzAKM4acIcmIDyGA5eIT0mT8yHO6XnihxwgTd80jin0Jh9J/eIDH7OK2iNqZkzLDtVn//battTVvuCnwXkdw+krY2QGtrD+xreUKbeAa/5EXMF2+QRVtcKWYO0e/mFs9flrewtplkSkMlO+E7E6HjJU7Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nEmWZZmt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nEmWZZmt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pSniqUov44vUMNTsXdR0qPTGsobWMLAF5+gjv4sfAbw=; b=nEmWZZmtU1LbR7368IubWu6P4G
	8nKIdRMit8QMkZ00lZNxah+wXK1nxOXq57ZPtMVgdtlB75tRKGKdTONbJuZv0H1zCc5K5IR+xJCv3
	mHLd4bBk1RbSXivXTMZIfIb9EU+q42/GoyX5QJiNne1IwWlSNXoH6WXQkTbFDC+8gqUM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wKbEu-001dK6-2t; Wed, 06 May 2026 14:20:32 +0200
Date: Wed, 6 May 2026 14:20:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "chunzhi.lin" <linchunzhi0@gmail.com>
Cc: netdev@vger.kernel.org, Frank.Sae@motor-comm.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, davem@davemloft.net,
	linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org
Subject: Re: [PATCH 2/2] docs: acpi: dsd: add Motorcomm yt8xxx PHY properties
Message-ID: <d24c2a38-ec63-4973-91c8-357853d837b3@lunn.ch>
References: <20260506021813.3658669-1-linchunzhi0@gmail.com>
 <20260506021813.3658669-3-linchunzhi0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506021813.3658669-3-linchunzhi0@gmail.com>

> diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
> index b246902f523f..3cd38bb4de15 100644
> --- a/Documentation/firmware-guide/acpi/index.rst
> +++ b/Documentation/firmware-guide/acpi/index.rst
> @@ -12,6 +12,7 @@ ACPI Support
>     dsd/data-node-references
>     dsd/leds
>     dsd/phy
> +   dsd/motorcomm-yt8xxx-phy
>     enumeration
>     osi

Please keep this sorted within dsd/. Yes, graph is in the wrong place,
but lets not make it worse.

Apart from that, this looks good.

    Andrew

---
pw-bot: cr
