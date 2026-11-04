Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801560;
	b=l0M3dfOOBNnjXlkQppd7vkBVa/PFtn4eYUmF3lM5m9ZnwA4txe8ks/I8yUCmN3gV5gy5
	 Sx1zFORBusZF0Rk5Jy9CYx71+0G23xMq7P9ULJqaNk4W8qBKIyLi4/7Hdmw1CcRqBkwda
	 IekO24YQ/+xbJ/6pupLx9ckcSHlOW6YAZpnm5P8TBay1kpptnFclx+v4Nq2pZUXVJr2Q7
	 THTxY7dSPvHuz77f3p5bkg2euDE4SZb7drMSa7D2Yd5odgwnphbaK+ZJsUJ0ppRLMPTrq
	 LdOm88Mt3TuNxXUYfrSx1hQksQg36KWKiaPb/K/AqgpPBgm4RHVXAIkBRg2TkOA0+6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801560;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HTROKWbLtBdwvAccLPzBB3mIAmFWbuKi2E0W50i4Av8=;
	b=hFaf62WDLiQbBmKu2//+SX+MoHsozUsdK3gIOBBqQjkAFj6VkxIS9h2waCCS1ivDwqFd
	 4+4sRMSQcGI7SVvHeSuAhYc1KXiIhUBY1WiHePLP+Ne3HKwRVN8le14sHr0AHf19g32sw
	 iS2VnjUiWO7Oo8SEfWYaoHCg5q+kDhGZVzKox4iRDGratG3wOodmcxRs8v5Mg5bH3V+EY
	 dHP9hTF7enhxy1YJ3QPhT6Mwqkk1cenqaU9W1SLPu7lUSmr5NaCjWLGMxLlz+vrxmYpEI
	 iULBdSG4ps/xwds/wbQG6ijeYOPbXI3Cm91/ritldKjkNkBZHRI3uVp4nzGh1gU5eNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c04mG+z7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 3118D606EE8C;
	Wed,  4 Nov 2026 14:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c04mG+z7
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 20AB11F00A18;
	Wed,  4 Nov 2026 14:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793801560;
	bh=HTROKWbLtBdwvAccLPzBB3mIAmFWbuKi2E0W50i4Av8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c04mG+z7Tvxwuog+3MwAz7NyM157MLbgxK6l3hP4aNOxO37ZtJxONtEa5g4WLW/D8
	 mkJKc3mx8IdLcYlJQsZlkZhGwarMF/UVKt0ZHLiSQD/uycFGvvZczhfO/hKWTaw2q+
	 U9pz9EB9xt9jIQyKMclc5cJcekeNiSakjKTMS4o0X5qhUYZvmlxFAnx7yPd48kTxZF
	 1bX8ZDk6vw6oL120IIrQzcS//P6jxvS+N9Bz99YF83pivDsdgRO+4L3ZDdyyYYjwtr
	 feXSXw4LCqX9WplGWCzrr9y0nupqiVg+v3zhsU/KShHt0kV68ye0ArYWcADFWwpvnS
	 NOLaJNZbgkUkA==
Date: Wed, 4 Nov 2026 15:12:35 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Michael Walle <mwalle@kernel.org>, longzhao@ambarella.com, 
	linux-gpio@vger.kernel.org, Linus Walleij <linusw@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Conor Dooley <conor+dt@kernel.org>, 
	Mika Westerberg <westeri@kernel.org>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, 
	Long Zhao <zl020895@163.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 08/13] gpio: regmap: remove gpiochip before tearing
 down irqchip
Message-ID: <awdvsfanqmvivihwhaik4atseyty3rwk2dytf4yihwvnbcj47l@ejipwyffq25k>
References: <20261102-cv75-gpio-v13-0-4f93114ea204@ambarella.com>
 <20261102-cv75-gpio-v13-8-4f93114ea204@ambarella.com>
 <DMKL43ZCOSQ3.3TAJL8BRQ6ZTH@kernel.org>
 <auoeysEHqGemmuhO@ashevche-desk.local>
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
In-Reply-To: <auoeysEHqGemmuhO@ashevche-desk.local>

On Tue, Nov 03, 2026 at 07:50:02PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 02, 2026 at 09:33:20AM +0100, Michael Walle wrote:
> > On Mon Nov 2, 2026 at 7:46 AM CET, Long Zhao via B4 Relay wrote:
> > >
> > > gpio_regmap_unregister() currently calls regmap_del_irq_chip() before
> > > gpiochip_remove(). That disposes the mapped virtual IRQs and frees the
> > > irq_domain while ACPI GPIO-signaled events may still be requested and
> > > while gpiod_free_irqs() still needs gc->irq.domain.
> > 
> > Maybe Andy have an opinion here. But that deviated from the usual
> > cleanup in the reverse order and at least deserves a comment in the
> > code.
> 
> Yeah, this is unfortunate. I think to make it work as proposed the IRQ domain
> handling in GPIOLIB should be revisited. So, at least a good comment is a must,
> indeed.
> 
> > > Remove the gpio_chip first so ACPI teardown and USED_AS_IRQ cleanup run
> > > against a live domain, then delete the regmap irqchip. Use the same
> > > order on the registration error path, which previously leaked the
> > > irqchip when gpiochip_irqchip_add_domain() failed after
> > > regmap_add_irq_chip_fwnode().
> > 
> > This should be split into a seperate patch with a Fixes: tag.
> 
> Not sure if we need a separate change here as two are coupled.
> I leave it to Bart to decide.
>

Rule of thumb: can we have a smaller fix that can go in first and be
backported? If so: Split. Otherwise let's leave it as is.

Bart
