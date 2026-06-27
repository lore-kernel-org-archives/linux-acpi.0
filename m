Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F4EBE63;
	Sat, 27 Jun 2026 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782569557; cv=none; b=ZdKHlf7CyW7jLfWpMSllJfJtth23qLBrECux6Gm7q37BZjNT/V+3X6N4kKMykbHSx8o/7xIPKJx1wulYr5O73ZFCfoV8Zx7e0X3Fho0naxm1Lag4Vp6d/KxnSBpzlEeCcukwnaIbd5w6wYq2ix/mgtZEn54n2/8yh0N4mD0YS6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782569557; c=relaxed/simple;
	bh=rSpZw36NyPOB7EqC/lJN9eRgCijS4xzRO0Ko+O2De3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfGH+Y5dN4S+6VK34nxI1h1nKW7b2y/v/VbIsDAUyfG8SIcU9SFl6h4N55wTY3U/vc2nRsby67f8JtqPFw6rQ4RTS38To/w5WU2pQNMHC1CnYAAqJ10YD0D41cpflCyWZgRshqr9cuM9kG+yThz3J8zOHoISxt39neenzSgpobs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaduymzg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaduymzg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1691F000E9;
	Sat, 27 Jun 2026 14:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782569556;
	bh=RsEsmEqrIzycIaSTj/W3zmpo1iGvzRxGr9mlEHGW4OA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kaduymzgikZ+SNaoe6/KHrrwdsMD8lYj7r0SxxOKOEXRgNvbGXvn5OJ6owe3+GdUn
	 X4Fn6Rd02xkH0jExllIDza2dWCwhRxxNn9fckx0Kjbp+Ac0WnMNMKPOgLAHASE/xXl
	 v4XJuqLdRQwPPypE2YwlyMO6MSj8d707vXpM/AQHzd0Sj9Rd0dVvRZSUWvz3WgdBR5
	 tzV1aBvtb/ga5leUEl/9BY5Mf8pk1EZo7Wgbpo1zvghpQOlU73jRI/YqehB2k0+buV
	 O1uZVxJPe7+8G07pFY2UM1RMK7ZJ6AnGGoifPFQLklNF0mR1P3vcW1dZnty4MswrrV
	 VIIqqFVQ7naMg==
Date: Sat, 27 Jun 2026 15:12:31 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [RFC 00/12] RFC: Devicetree-ACPI hybrid mode
Message-ID: <20260627-miniature-skink-of-superiority-234091@sudeepholla>
References: <20260623145225.143218-1-johannes.goede@oss.qualcomm.com>
 <20260626-friendly-ammonite-of-holiness-aabefb@sudeepholla>
 <obvpvyx3kmzcdc5nxmx4inlpiqugjxdgzfzmdxzfqqy4qqwt7l@y2zyrtso6yk4>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <obvpvyx3kmzcdc5nxmx4inlpiqugjxdgzfzmdxzfqqy4qqwt7l@y2zyrtso6yk4>

On Fri, Jun 26, 2026 at 11:57:47PM +0300, Dmitry Baryshkov wrote:
> On Fri, Jun 26, 2026 at 04:52:41PM +0100, Sudeep Holla wrote:
> > On Tue, Jun 23, 2026 at 04:52:13PM +0200, Hans de Goede wrote:
> > > Hi All,
> > > 
> > > Currently as soon as the kernel boots with a populated DT provided then
> > > the arch/arm64 code sets acpi_disabled=1 and the complete ACPI subsystem
> > > gets disabled. On WoA Snapdragon laptops where the factory Windows OS
> > > actually boots using these tables this is not necessarily desirable.
> > > 
> > 
> > I am bit lost reading the very first statement here.
> > 
> > Who is populating DT and why ? It seems that is the source of the problem.
> > 
> > If windows can boot with ACPI tables, why is it causing issues for the
> > Linux kernel, any specifics?
> 
> Windows uses a separate beast called PEP, which nobody wanted to
> implement for these platforms up to now. You can find a lot of ACPI
> dumps for these devices at [1].
> 

Agreed and I assume that is the reason why we want DT.

> > IOW why is DT populated which creates the problem you are trying to address
> > here.
> 
> Most of the laptops resemble other Qualcomm platforms, which use DT for
> hardware description. In some cases, it is the same platform being used
> for both mobile, IoT and laptops. It was more or less natural to reuse
> existing support.
> 

Sure, just use DT then, why are we even talking about mixed/hybrid mode.
It gives no incentive to OEMs using PEP to get away from it and use
standard ACPI or improve if anything is missing.

So I don't like this idea of mixing at all. Use ACPI or DT, make up you
mind. You can't expect to get the best of both worlds if you are not improving
the missing parts in either of those. This is just a shortcut.

-- 
Regards,
Sudeep
