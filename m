Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4682B4594A
	for <linux-acpi@vger.kernel.org>; Wed, 15 Apr 2026 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776273029; cv=none; b=lzYsMXy0xCEy+qlUn+rYhEqVlDkN/BQAMV2cMgVWdr4dwDpF3y1/9jULd+BBdnEQhcr7R4IFfXpLLzgFbg2LpzMv0uKAhoM0qeOr7gZfhnzJ5AN+vdjoGsGVA1dOc2o0QGc0gspCCGFNrP0TLt7C6aQhINC3iODW/jQFyOMrbv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776273029; c=relaxed/simple;
	bh=BHm4G+DISlf5XJTfxSlC1IUeBoYC4hKUPRUtScT+KIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=phP8loom394Y5G7W7fEQWMXTRObF1/JyOpa0YcDnV1YBb8xpjnSyBWpaAXA50EwLZglyYDDWSxAh5UTQIXrRGF/Z1u7VhrfYxrPYHXt2JiMgFlDuxQhn0kRU3yU8yN4f4KVy23sAbm/t7OX205PnH74W6g+Uv5u7/Eh90M5J370=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCy8NPIO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCy8NPIO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A447C4AF09
	for <linux-acpi@vger.kernel.org>; Wed, 15 Apr 2026 17:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776273029;
	bh=BHm4G+DISlf5XJTfxSlC1IUeBoYC4hKUPRUtScT+KIA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fCy8NPIO6h9ZRPYaNYATEFME6MCiv3FdNuSqEYvgYz3pnKmcmJquhNzMbMamDqShT
	 ZrIV6tST7R3VmPV0DW0pOMBOBze/XsUN0itJ/EPlawsXuL/WPbhZHifgqrbz4IV6vY
	 g6YZW/KIC3FiEYC1l2wzEQs36EdUr8Kc4HqZIvtR/R64mgwoMsMFfkCizYfOfCRLcB
	 YGxiSCUkBrYPjULLe0uxyAHF//p/V62vPxSVICcuR6UjGNKH2qMEauHcpO+E22Grxm
	 V45D50tFweNpIQq03/Z0bb8QKS8j9GSS0DAI0yuhv+/Bojcck5LldCkQr5aSPgklLk
	 3CXWiMYHHWdAA==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-471bf5157d7so3087489b6e.3
        for <linux-acpi@vger.kernel.org>; Wed, 15 Apr 2026 10:10:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8Lpy8CwlAO15PdLFqCrU8N0RIZ/mAR2Xeelcsdm9NR1KiGXewJpJGnc6cQFug3rd8SBK7OPzGZJYte@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4SiQvAyRC9kYGx+u+/Ic4QVT1GijR53fKA/yfT+ReUDStER8G
	MOLczQXotieyIRxiXJNjqAZjiAj48TpxvgpoR8DbP8X7BI/406dCZHkk12Qidwtmm9U+LseSt56
	eogmM87pIrlN7qTSjcTNV3NaMPgfEs6A=
X-Received: by 2002:a05:6820:168a:b0:685:d2b6:6df7 with SMTP id
 006d021491bc7-68be5e52ec0mr11032545eaf.9.1776273028280; Wed, 15 Apr 2026
 10:10:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413070132.3828606-1-arnd@kernel.org> <97c186b3-e9dc-464e-af0b-934aaa5a9538@huawei.com>
In-Reply-To: <97c186b3-e9dc-464e-af0b-934aaa5a9538@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 15 Apr 2026 19:10:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0igRxUcydSdbtK7AZ6YRJnmtqv-FCS0X-WffOMFpcFL3g@mail.gmail.com>
X-Gm-Features: AQROBzA_OaMf77T0pp8JpABBU6AUWSRZJ5eJXXNH1e-VTpzQNR56xNj9HL_yfeA
Message-ID: <CAJZ5v0igRxUcydSdbtK7AZ6YRJnmtqv-FCS0X-WffOMFpcFL3g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: add acpi_get_cpu_uid() stub helper
To: fengchengwen <fengchengwen@huawei.com>, Arnd Bergmann <arnd@kernel.org>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Gavin Shan <gshan@redhat.com>, 
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, James Morse <james.morse@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Kees Cook <kees@kernel.org>, Ben Horgan <ben.horgan@arm.com>, 
	Dave Jiang <dave.jiang@intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 1:42=E2=80=AFPM fengchengwen <fengchengwen@huawei.c=
om> wrote:
>
> Acked-by: Chengwen Feng <fengchengwen@huawei.com>
> Thanks
>
> On 4/13/2026 3:01 PM, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > When ACPI is disabled, x86 Xen support fails to build:
> >
> > arch/x86/xen/enlighten_hvm.c: In function 'xen_cpu_up_prepare_hvm':
> > arch/x86/xen/enlighten_hvm.c:165:13: error: implicit declaration of fun=
ction 'acpi_get_cpu_uid' [-Wimplicit-function-declaration]
> >   165 |         if (acpi_get_cpu_uid(cpu, &cpu_uid) =3D=3D 0)
> >       |             ^~~~~~~~~~~~~~~~
> >
> > Add a trivial stub that can be used in place of the real function.
> >
> > Fixes: f652d0a4e13c ("ACPI: Centralize acpi_get_cpu_uid() declaration i=
n include/linux/acpi.h")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> ...

Applied as 7.1-rc material, thanks!
