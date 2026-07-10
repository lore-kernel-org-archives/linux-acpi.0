Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF6326F293;
	Fri, 10 Jul 2026 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701475; cv=none; b=UGUgZHJfE0AWo63PA08z9fWrO89/hie5sQjE6pOHIrdDJHCblTs85OJL2ldLIG2/oh3Eu090jSISWdiRgfX0ihaafgZcmzOCBx+E2WoX7xpr1LK0+dszWIC5pVaBXnPPT10+3EGZLOJAcFSIJdk5qU3ig9seanYF4pft8oA5ilo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701475; c=relaxed/simple;
	bh=6JQ5HtR8U5ofo03taD6S5+G9y2naXme5iUR2sOnmczI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcTeLFHkXdl3nc/3zHX6RDsj6B8ejCZ7VQAgbOEK7h8k9AeuWtaa5yvvnP/N0U91D0VJavlGnUJqsj6kpdwpjN5taO6nf/usL741GYvvYiJ5lmTyN0I1zcNBHYfttYy1ReXWNet33y6nwzpronSbQw5Lk8lBNzeXIxQqoEQmNT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zCcH0Lmw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zCcH0Lmw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KXSTbKG+7aSBdSKpvH/rz9uGEzE4kqyoxlMBzZZMa60=; b=zCcH0LmwiB0IoGAMB8jGU7HRwq
	qtj8nKoeRqxY3LEy0uR3TLT46GPLDD0+BkhJV2v1DFCj4sJ5U2dNDdfjf17iB06l//+tan1I6HvqY
	VZhpoWof9iIuF6ndXTHdv51SHIf0rLafrC7aSOSMex22wuVaeweLDgjI5RI4eUTBVAcI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wiEEW-00BfYc-EI; Fri, 10 Jul 2026 18:37:48 +0200
Date: Fri, 10 Jul 2026 18:37:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, "chunzhi.lin" <linchunzhi0@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, linux-acpi@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH] docs: ACPI: DSD: motorcomm: fix docs build error
Message-ID: <532f6e46-ee9f-4170-8ec4-72374e761cb0@lunn.ch>
References: <20260710053106.730399-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710053106.730399-1-rdunlap@infradead.org>

On Thu, Jul 09, 2026 at 10:31:06PM -0700, Randy Dunlap wrote:
> Separate the title with commas (since they are all run togethe in the

nitpick: together.

Otherwise: Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
