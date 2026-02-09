Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081383191D3
	for <linux-acpi@vger.kernel.org>; Mon,  9 Feb 2026 06:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770619971; cv=none; b=d8LSl7X+u1OxHeavwH7xsyFAgButTThtv1Iaf8siciXFAy5dbrEAE+gwNAQzoRzf11W3FdXsKzMzS0u6kHr3/sQifL7T6IJCbqUOrOMBQexqtIdv0AS6en1ST4fp+xAERIjqcwfMUiBHWtiNM9IZwQWsNfFGxHesWA2ejuRahkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770619971; c=relaxed/simple;
	bh=/kFRoYuACeQTKCTxiXjtG5+68kwbn0hfkvaxOeODr9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdE4Qy8BUbVZId6dSxciv4oVCAedXjYx/Mjt0vLJez9u7wf0nPUg7rd0fyO/ajc3R56k8Ym6B5YerHFBb4MgGEfohEAlnvrX/xYnKPj8u8k1R88FjcwXEv+CLRLzRaMKkBto0xKMtIAakYvKgdZk+cFqZw16gqelFblLZYcaS7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQjYhmi7; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQjYhmi7"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-124afd03fd1so3496684c88.0
        for <linux-acpi@vger.kernel.org>; Sun, 08 Feb 2026 22:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770619970; x=1771224770; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nlLTEe8ameB93s6BYEpWBdg65WpZgPkz7LnczmeGp9s=;
        b=DQjYhmi7JTK5EaxB3MEsMN7+EtZ2ZiOCr5cNDGWGnmZLj0poO1lThyolPu8Txfe5y6
         fE1F03ySseqrLwszT0zdfSRuP0iLZEyE8gC4VBr8Ilr1vupFwaSR6X4oc5cLOSDFkwPp
         jq1MeXqkcVgGiXRlXyTbRd6D2AHtkkkbmB1AOjIQuZ04xcXSRBsqYpDkFmoixU0arA3X
         YfGZmqqVAcN9JzqSPPP1GEgZDaBktTLHurlCVD7sKJZ4ivj7f2JOD7QbJSTuKKpu2+u3
         tlGqXa6Ak8l19mJe5N+jSPsrvBZYkXpM6qt4T+2FhO68lJ6avVmEOhJ8vghewjJC8XE0
         OViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770619970; x=1771224770;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nlLTEe8ameB93s6BYEpWBdg65WpZgPkz7LnczmeGp9s=;
        b=TNXvKIp55tBFAWF8Nzxxn0uaAzjnr5iRV5b3Luc1bgd8DUnP+vwbAqNPXno1LaE1cH
         FADSzVlGGbwGRyLYIojnIbpayIqIpADfw4nVlB3/zLhy7qXndC9X4Vjq4pLDSDruGkik
         TltZfzJ34LpKuvC3w4iyjwFFPglU1IG24lrjqnfdWiCff7S3D9Y36oH5iJMd/noMSW9X
         XWrQ6Prpsz0+ZQW4CMPO0SM1XVEukmwFIIxIFEMPk1Tlg2qtSSc3ToLV7x0Dp4xBUgtJ
         BJZv4ueaqfXdjssQ/osy+BmsFsik/8C6NehxryuG0kgBf+OhFJ6J0DCs6EjY5sOOT0sE
         BZ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHi2c8c1iHK35QpyOQ1/c0rb8pPJ84GaNL+mweXJ9g9OObOe5ZLror3oTJ6t/XQUC1STgkTUUcqTF+@vger.kernel.org
X-Gm-Message-State: AOJu0YxF9zz2TxkxynLrnTgKB9W/8b+k9L/xuKtVBr7OTfFm+JEQ651A
	ycUYbqa770Y8hwn66zJaZ1Fqg7hWvm5vUV34bVGnfs7QL+jUSK1Yw8+X
X-Gm-Gg: AZuq6aI1+CBCwZTWNM7W9R/QZoJFHM1vnZyt7iEOJBZYKO4ku8CDDAZvcUPBP3i9d41
	XwGU6q8xGahHKDzwC65sdq4xxIAOpK1jlxb9oN3JzruzuHo6wf4yrV0a9aWPUVST+Edugpl5v1T
	P/y5GNBisHp0ZkXEyaoWyrQ+hAsvL8kghdkx9gTZYMVqUKjs9P1I1aeeLjkCJfUCSbyJ0kVPRgK
	L7qauPFtUTTOta/kBskbLy6C7qsZXbKcnlALsxHCfS2ZqJYzUqb+MDDoATSMhYBkqtLB8N1EB2x
	K32JyRPLVqtCuybgSAWxUvBKEL10GVckFLltMM1j42OL+Duui2IpG+GDz33WOSkAyYMR9Em5SCX
	QiV3fi79TXhEY6TY+Lfv33sfGMGMcFDV5pz8r95RyMHqA4LVOgF+bsMhyHJOy1nxIGlE+GXPpDc
	B3I6KKPSpJISHeXDITvTNb8TWlxFDr+Wo1TRH5hLPd07emdbjYrw==
X-Received: by 2002:a05:7022:222a:b0:11a:2e9c:1130 with SMTP id a92af1059eb24-12703f54480mr4347778c88.7.1770619969983;
        Sun, 08 Feb 2026 22:52:49 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:d70d:15:1011:7b14])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1270414f28bsm8837954c88.0.2026.02.08.22.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 22:52:49 -0800 (PST)
Date: Sun, 8 Feb 2026 22:52:46 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Linus Walleij <linusw@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <brgl@kernel.org>, patches@opensource.cirrus.com, 
	Yauhen Kharuzhy <jekhor@gmail.com>
Subject: Re: [PATCH v4 04/10] gpio: swnode: don't use the swnode's name as
 the key for GPIO lookup
Message-ID: <aYmDlY1yURae37l5@google.com>
References: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
 <20251103-reset-gpios-swnodes-v4-4-6461800b6775@linaro.org>
 <aRyf7qDdHKABppP8@opensource.cirrus.com>
 <CAMRc=MfD7ZbwU4akkCJNgmRPwgSOqSVi2-L2dJDOBHrfdD-yZw@mail.gmail.com>
 <aRy31U8EQA1DO/R6@opensource.cirrus.com>
 <CAMRc=MfNf+WMtSW=Wag0QHAaYzcRe9igrbOeRZiY92KmOH70oQ@mail.gmail.com>
 <CAMRc=MdKN4Uj4RZk=3L82c0-0Z0CihbAfzVK0zMBb9Tsjh3BqQ@mail.gmail.com>
 <CAMRc=MeYEoiXWCdYNSmmbquMwmt99vPgzW+0gmX22Of9o127+A@mail.gmail.com>
 <aYmBYlEcbVJ2ELZ_@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYmBYlEcbVJ2ELZ_@google.com>

[ resending to the right addresses for Bartosz and Linus ]

On Sun, Feb 08, 2026 at 10:44:45PM -0800, Dmitry Torokhov wrote:
> On Wed, Nov 19, 2025 at 10:13:30AM +0100, Bartosz Golaszewski wrote:
> > On Wed, Nov 19, 2025 at 9:41 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > >
> > > On Wed, Nov 19, 2025 at 9:35 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > > >
> > > > I have an idea for fixing it, let me cook up a patch. It'll still be a
> > > > bit hacky but will at least create a true link.
> > > >
> > >
> > > Scratch that, I didn't notice before but we register both devices from
> > > MFD core. We can just set up software nodes there.
> > >
> > 
> > Here you go: https://lore.kernel.org/all/20251119-cs42l43-gpio-swnodes-v1-1-25996afebd97@linaro.org/
> > 
> > Please give it a try. This is independent from this series and should
> > probably be backported to stable.
> 
> So think breaks more drivers:
> 
> https://lore.kernel.org/all/aYkdKfP5fg6iywgr@jekhomev/
> 
> I think it may also break:
> 
> arch/arm/mach-omap1/board-nokia770.c
> arch/arm/mach-pxa/devices.c
> arch/arm/mach-pxa/devices.h
> arch/arm/mach-pxa/gumstix.c
> arch/arm/mach-pxa/pxa25x.c
> arch/arm/mach-pxa/pxa27x.c
> arch/arm/mach-pxa/spitz.c
> arch/arm/mach-tegra/board-paz00.c
> arch/x86/platform/geode/geode-common.c
> drivers/platform/x86/barco-p50-gpio.c
> drivers/platform/x86/pcengines-apuv2.c
> 
> Thanks.
> 

-- 
Dmitry
