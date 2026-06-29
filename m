Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618273C343C;
	Mon, 29 Jun 2026 08:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782721329; cv=none; b=rW5NPo0pslBXJYc1dDBEfHYtlT4K5IJ5NOUEV3ZUZJQyu4gWD6FE/c/1w1xmOzS4yMQJAy1ttxNv+k9lZL2HwZV+nekessn7IelUb5KjaY3vB9/yofOjI7bbE5ghNOTMir97wYcBKemUFuMJIVzCb0/2iUII1fxHKPa80ZefQfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782721329; c=relaxed/simple;
	bh=yKusn79KwbrEg3D9I4t24OWk4gQ1Qu/IOk6Ez3ri9Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oELQUu9b5hj4yuKCvDeO/73oeLELq8x5pMwJe02Kk9NROLYZ+FL6sCMTebk84ZU8iGwAKTLrp52s6LULGhacML+chyl37I2DZxl9H0UoquO3aZFfnmPicfM13UXs/+7lYiCqUEyt5RUglwUlvggkUGa1TxdCIOGchB2J5lrTuLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MM/swq+/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MM/swq+/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBABE1F00A3F;
	Mon, 29 Jun 2026 08:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782721327;
	bh=iAxmFHuidiONJITAk4OsD6egnPPOI7pNLRnDMvxzO4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MM/swq+/Q3P9Fov5m3VAhpuj3kXFVIVyWrSteq+Tir1K1zOA/zOWHBEwgHnpStX4E
	 W+kQvbTXjbp/31NabZgkk8HhSpv1ZnlP8aQtaei+/vBpmcwpPwGQ5+HXdjbUS41DvC
	 HqhSmhSnsfsZHcjY32H4oLxt8gIQYr7Bv1B6d4wCi0D6sShp1c1l6GNrbisvk8MkYa
	 DMqfK1l2aqPoTXPtxoOu+sYMgRVGZV+B5iLhwpFJyRJCv1lvgMU4tJcpirrAr8Hs3F
	 g5loHCEMSU6Ut0NgC23qnph9mifKMLmWFdHLXlESnhEE6igi5R+Vfafoq8j8l+MS0s
	 5FeFNpWysQdAQ==
Date: Mon, 29 Jun 2026 09:22:02 +0100
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
Message-ID: <20260629-optimal-vermilion-salamander-0190fc@sudeepholla>
References: <20260623145225.143218-1-johannes.goede@oss.qualcomm.com>
 <20260626-friendly-ammonite-of-holiness-aabefb@sudeepholla>
 <obvpvyx3kmzcdc5nxmx4inlpiqugjxdgzfzmdxzfqqy4qqwt7l@y2zyrtso6yk4>
 <20260627-miniature-skink-of-superiority-234091@sudeepholla>
 <2dbfkh3djdrvklsin7zcy53g3wpc76dd4iosxgahbd26zssmx5@zpkplzscllx3>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2dbfkh3djdrvklsin7zcy53g3wpc76dd4iosxgahbd26zssmx5@zpkplzscllx3>

On Sun, Jun 28, 2026 at 10:23:15PM +0300, Dmitry Baryshkov wrote:
> On Sat, Jun 27, 2026 at 03:12:31PM +0100, Sudeep Holla wrote:
> > On Fri, Jun 26, 2026 at 11:57:47PM +0300, Dmitry Baryshkov wrote:
> > > On Fri, Jun 26, 2026 at 04:52:41PM +0100, Sudeep Holla wrote:
> > > > On Tue, Jun 23, 2026 at 04:52:13PM +0200, Hans de Goede wrote:
> > > > > Hi All,
> > > > > 
> > > > > Currently as soon as the kernel boots with a populated DT provided then
> > > > > the arch/arm64 code sets acpi_disabled=1 and the complete ACPI subsystem
> > > > > gets disabled. On WoA Snapdragon laptops where the factory Windows OS
> > > > > actually boots using these tables this is not necessarily desirable.
> > > > > 
> > > > 
> > > > I am bit lost reading the very first statement here.
> > > > 
> > > > Who is populating DT and why ? It seems that is the source of the problem.
> > > > 
> > > > If windows can boot with ACPI tables, why is it causing issues for the
> > > > Linux kernel, any specifics?
> > > 
> > > Windows uses a separate beast called PEP, which nobody wanted to
> > > implement for these platforms up to now. You can find a lot of ACPI
> > > dumps for these devices at [1].
> > > 
> > 
> > Agreed and I assume that is the reason why we want DT.
> 
> Not completely... Using DT forces us to reimplement bits and pieces for
> these laptops. E.g. drivers for EC, battery, etc.
> 

Not entirely clear still. I mean use ACPI for those as well.

> > 
> > > > IOW why is DT populated which creates the problem you are trying to address
> > > > here.
> > > 
> > > Most of the laptops resemble other Qualcomm platforms, which use DT for
> > > hardware description. In some cases, it is the same platform being used
> > > for both mobile, IoT and laptops. It was more or less natural to reuse
> > > existing support.
> > > 
> > 
> > Sure, just use DT then, why are we even talking about mixed/hybrid mode.
> > It gives no incentive to OEMs using PEP to get away from it and use
> > standard ACPI or improve if anything is missing.
> 
> Well. Here we are talking about the laptops which were being sold since
> 2018. I doubt there will be a UEFI update for all these models.
> 

This problem is discussed multiple times and yet OEMs are not interested in
fixing it 🙁.

> > 
> > So I don't like this idea of mixing at all. Use ACPI or DT, make up you
> > mind. You can't expect to get the best of both worlds if you are not improving
> > the missing parts in either of those. This is just a shortcut.
> 
> So, if we need to append the DSDT, what would be the best way to do it?
> Something like Surface platform drivers, providing extra device nodes?
> 

CONFIG_ACPI_TABLE_UPGRADE allows to override the ACPI tables via initrd IIRC.

-- 
Regards,
Sudeep
