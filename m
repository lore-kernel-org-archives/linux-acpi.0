Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240537;
	b=v6r1h2by8dbeQiH/klwJ0qrE9wU49UuHVAHlVh96XXGFgnulnsHnB9iAgSp+y7Fzu4OM
	 mJnkQOhUakV7N64QUcW5Y19Vo5YfB+XWTdq4ScDVGz5iHq9+AMhwEGvjMRkOn0lDMvAcr
	 OXd7Xv7mV2sjOoNlf16NDVOJm0XWd2kr9kVazl7//xPxZRvnykqpBbCEJ18whiOcQ+dHw
	 nd0dTR6oIeQmXhCURicAi/C9AWTx3WtIVSKKWRz4QQDetaYca2aPBDMBxHHn5r+1ylqDz
	 2cQ+if4Be/OL14zB1iSuSIMZGaueaqS0WZ5gJPnYVf6BQhbR/YgCt1UWuaFZNzahwqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240537;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Us1acSGCownt1gWounrmyheHNyrWFqrZMDVsMoIDEO8=;
	b=rj3Nthyhz8rh/qzYRh/veQZRkRMBgXyS0RX4r19PPYMilQB1xbSx005q0cPpCrf6rLTn
	 ETszKTmYFZsxGXj65FzHtAavlJYZ7qzqZYqtKKEpM7k+E8TSvF7GlDELobWjgF7Mfbfci
	 Y3caTWrkvmjcg9mW1zmdnGMSnxRr2vmK2MFSZNkvaJJci7Hbvcm8t4NdhagIA0SgON69Y
	 wlIvPnnu/aKsztawMwehdDtda+lB2lDjMJ07CZl+adOir5zUQ6MLb2w2OhYDZOrDaFQLZ
	 9TwNUlWgLlDt89iaH18aXQlGgjB1KjY6G5pyc2jWvLMZdPY9yuk1rD02h3yWkPzR/Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BfayhrsD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 0509A606A31C;
	Mon,  9 Nov 2026 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BfayhrsD
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C7F4D1F0089F;
	Mon,  9 Nov 2026 16:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794240536;
	bh=Us1acSGCownt1gWounrmyheHNyrWFqrZMDVsMoIDEO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BfayhrsDX/QcKNzceAymK2HMOGU+c5tB2/FuH6l5e1/0WCmyf0sGnK3gnIslVL14G
	 DrEXh5qUmPPET6mY8+4RZVIu2bzsa5nxMyBvpeGVemi3b5N82aBlmTP+5I3sj0r7/e
	 WBb+nvGRkXWnX6vAqRCGkNpzfOlRWcdmZ6c0xRU09wy1iOS15Ua40BjyZtrTC6Hk/S
	 MM/n2HCGdz3Bxmm23t1Tn96o9+lnXQlIPZuLLK+WvCOdXwd0cCKfsM+txpmsktTAny
	 vWuCO73/JGOuBreGI7rgCHle0jifhnYfPweNNgOn/mOZJ7DCruwfjoCG6YLGDkcx5P
	 svOmxspRhZKaw==
Date: Mon, 9 Nov 2026 17:08:50 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>
Subject: Re: [PATCH] software node: only let the owner release a managed node
Message-ID: <lhljpce4lyhuggmfyaq4c4g2mxqe5z3gwmqyrnxptlub3bahff@vdyh47ms5ua3>
References: <20261102-swnode-only-owner-release-v1-1-ee4c9022a629@oss.qualcomm.com>
 <avHMhh8ChrFE_b_e@hovoldconsulting.com>
 <DMQQO3DTZE66.1Q2XGGDGN3WUP@kernel.org>
 <avHZ5U_YR9QSqd0G@hovoldconsulting.com>
 <DMQREV9DFQST.1Z4ZFOFTS0Z7W@kernel.org>
 <avHfx80pHRPwtqRt@hovoldconsulting.com>
 <DMQS3EURP5MB.2DY989AOI0CSD@kernel.org>
 <avHs9hKOc3QVLM4x@hovoldconsulting.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avHs9hKOc3QVLM4x@hovoldconsulting.com>

On Mon, Nov 09, 2026 at 04:55:34PM +0100, Johan Hovold wrote:
> On Mon, Nov 09, 2026 at 04:17:33PM +0100, Danilo Krummrich wrote:
> > On Mon Nov 9, 2026 at 3:59 PM CET, Johan Hovold wrote:
> 
> > > So I think we can just go ahead and fix this in driver core directly.
> > 
> > Ok, then I agree it is fine as is. :)
> 
> Good. :)
> 
> I've updated the commit with the missing Reviewed-by and Fixes tag. I
> also decided to drop the reordering of releasing the swnode references
> as that is arguable an unrelated change and the current code expects
> users to hold a reference unless it's a managed node.
>

Ok, I won't be sending a v2 then.

I'm not sure what the workflow is exactly among the driver core maintainers
but the commit that ended up in tree looks quite different from what
I submitted and what Link: references.

Such in-tree modifications from maintainers have caused problems in the
past[1]. I would have preferred to apply changes myself based on reviews
and send a v2 which could then be queued as it appears on the list. Just
my 2 cents.

Thanks,
Bartosz

[1] https://lore.kernel.org/all/CACMJSesVR_3-PBt1ScricSKNMRzH5gesqtTVW3mqN=gg0-O-7w@mail.gmail.com/
