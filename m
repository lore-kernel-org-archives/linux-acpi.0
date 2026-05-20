Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DA035957
	for <linux-acpi@vger.kernel.org>; Wed, 20 May 2026 07:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779260739; cv=none; b=ubMWPJA2uwqCdleHKOVwRzRfLSSc+zsj2kRyOmvAu6RgM57alOuyF4fgJpYKsG2ZQu7X/532ZbtTn8juXqk67XSnGqC7xHXm3vNPd/lkGsX6M5NihC+vwmzEuvHJhrxztVFa5pe/kEj8QE2sRZRlqST0u9oudfeCULuhV0Fuzls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779260739; c=relaxed/simple;
	bh=hht1w8vuTNKlyUu0cIe3TJvjZttRuUdjfD3dz2HiCfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aDbqmweVaVmeAJWJZ6CXLD6JeN7/CQyYH6rW+JPurJXdzNyD+Qq8zwx2Q3s0BxgcgXJwKprRnUW2xcyqwFbE1R0gdbJ9Gh/T+w+4vognTfGczbGzZ4S0xKvD13BhpVU1INZB1ft0tRVMmmN5v1sycXaJkgBwHMb3q8O+btO88D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkTHLITs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkTHLITs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B5E1F0089C
	for <linux-acpi@vger.kernel.org>; Wed, 20 May 2026 07:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779260738;
	bh=hht1w8vuTNKlyUu0cIe3TJvjZttRuUdjfD3dz2HiCfM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PkTHLITs4gEC2QTC1/MW7cwBGfPRqrhwYDmJJW7fJCC7kIDOabwaIdOtEpuqwZFKC
	 EutPXM9hdeSJXEVsj4qtRiBd0nR3DPHVPczVyKPMc8jCczFeGXklo/wyEEP2B0kyZ3
	 evbzx2kX8uUu4EAiC9nonXTw4/NtCirt5abuPwhjV4ug+L3DW9U758psgazVPEP940
	 GraU4ogqLde4z+kdflnv047typ9GusSH4K7Jbf0vOIjPi0V4q8YAbGeEqYk01JCahu
	 2ZCo0dRFZXSyL5W2xnIXAelyC1sPz1zUqskc+0RvcodYQley3rqf5DvCh8yLK/mrBp
	 J0zahZkS0wg6w==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3939d2bd7ecso36052391fa.0
        for <linux-acpi@vger.kernel.org>; Wed, 20 May 2026 00:05:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+cU5zgHu1MQTwRz8p6r6c9En4iMW3VXLN5iIEofaFO66Bd0m3kTsYi4C+r94RQMrCemW/ZZu3UG8VI@vger.kernel.org
X-Gm-Message-State: AOJu0YwESO3kPWSEA4hwWnqQTp0otfP+1pdADTLqfEYqrs5k1x/zJLmk
	w2xWwdK7RHX40NhPAwaYa0Z//o72eZJTKb0ZdtEXXsADVAmfgRpkoP2hHBy/73+l8BJoYRgOKAz
	WxetTKh4fNWllBgiNNtVJKZ74m9GtCNO9wtovJf1RGQ==
X-Received: by 2002:a05:651c:4389:20b0:38b:dd55:b71 with SMTP id
 38308e7fff4ca-3945b64392bmr53652221fa.20.1779260737006; Wed, 20 May 2026
 00:05:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430-nokia770-gpio-swnodes-v7-0-c88f74c90dd6@oss.qualcomm.com>
 <CAMRc=MdN9EpQVW=1Sb-9hRdt56Y5NNbskujjq2RiXhu90t0QyA@mail.gmail.com>
 <20260513145926.2dc4d037@kemnade.info> <agYB3-T9yz9-hdr4@darkstar.musicnaut.iki.fi>
In-Reply-To: <agYB3-T9yz9-hdr4@darkstar.musicnaut.iki.fi>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Wed, 20 May 2026 09:05:25 +0200
X-Gmail-Original-Message-ID: <CAMRc=MdYPhdo4-OtJa=dEz8NZt2E2WWruHsiGwM_9UBEDLRm0g@mail.gmail.com>
X-Gm-Features: AVHnY4Jxd4VHyVbpKe7wUqMdl1gLnqLNnWj1oS8zzh-8hShk08YnuC0WaNL22GY
Message-ID: <CAMRc=MdYPhdo4-OtJa=dEz8NZt2E2WWruHsiGwM_9UBEDLRm0g@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] ARM: omap1: use real firmware node lookup for
 GPIOs on Nokia 770
To: Kevin Hilman <khilman@baylibre.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, 
	Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arnd Bergmann <arnd@arndb.de>, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, 
	Aaro Koskinen <aaro.koskinen@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 7:10=E2=80=AFPM Aaro Koskinen <aaro.koskinen@iki.fi=
> wrote:
>
> Hi,
>
> On Wed, May 13, 2026 at 02:59:26PM +0200, Andreas Kemnade wrote:
> > On Mon, 11 May 2026 15:34:39 +0200
> > Bartosz Golaszewski <brgl@kernel.org> wrote:
> > > > This converts Nokia 770 to using real firmware node lookup for GPIO=
s by
> > > > attaching the software nodes describing GPIO controllers to their t=
arget
> > > > devices.
> > > >
> > > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcom=
m.com>
> > >
> > > Hi!
> > >
> > > Gentle ping, can this be queued now for v7.2?
> > >
> > So any objections from your side, Aaro?
>
> It's fine.
>
> Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>
>
> A.

Kevin,

I think you offered to queue these patches before, can you take them for v7=
.2?

Thanks,
Bartosz
