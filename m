Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07D13FD139
	for <linux-acpi@vger.kernel.org>; Tue, 30 Jun 2026 10:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816924; cv=none; b=YciWZJvu/G7p14QmfLaKvohVT+rs6x+UZ3h+McBZu7KuTOn5Y2Dh9dUmKXx1gLKFmRTYxli4WAkq7uXTrdp5GhyUKS9BOuZFfHbZ+wX/jgwp4Fr/0k/SJ9zB6EJ47f5LAmB9OGJa3OZnjM3DlbqCEPB/dJ01FzODm0Ezx60kr+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816924; c=relaxed/simple;
	bh=qSUtpQyBjxZ2D2uiJLh9kaqj5j88aU8VMGZNXW+BBOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UEgow8MMn9+bCaak4DhXi7Pzc5jR5nzxsb1+Ln4ay2LNCsWkcmO7mWxSBhZ0NwNqyKMqDgPanVtaZQS90IqEz1QrgsLwLvzdjeHt18BM6EK22/mjMcVJNoz0l03K6nI5AioeDkpvXOuRNxJn2NaSQoOYAECmjLzA/i5pnd1S6CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4sK+8R1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4sK+8R1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FD71F00AC4
	for <linux-acpi@vger.kernel.org>; Tue, 30 Jun 2026 10:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782816921;
	bh=QS02Y4ZTkCaY+8KNH+aFUHWmz4C6FfgfF/SB6ePyOlU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=a4sK+8R1ugLnIFAsbH0lz8AUe7kRH/N+y63uSUgrKVXOkND+PCeWRv4/rDdnx5VZ+
	 HEAYjfubry0IAxUVqH2gtygSX54hRtbd/gji/L+InYJsudr4Mq4+w3C/W5mBNbGXx4
	 O2MNTIAnfTm5czNImtNraZW8xQckJeYL1T0zG7bKSDuNCJOq/ctejSZHbwXJIqGslK
	 WRjP4Fgozdg17w9FwGA/HUZGQgBnsWcPGAdsV4Ey491dOrvLqSomra9Ra4V4mHcEC5
	 7fIMRI53Jkdc6trZxUuojgL6mR2wNEErxGEK/kNeaeCG6Mw0YBLSt0Wi/WKsA/T4KK
	 tY1hYwLOS2ZSw==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39b1026e171so20673881fa.1
        for <linux-acpi@vger.kernel.org>; Tue, 30 Jun 2026 03:55:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rpuyw9Q3vtmUPf9des7EcEutOIQEXvmKem4dRleVh9JKFhZlnen7V2Lh0JXECcgfBwsUVUkdmMIOMRu@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2dDBa8pM+WDbdrMXWzwNigLuROXmFxeiU8Mq1GLjHulToKri+
	qO+cevFfF5Y+ynu2iGuHVE5eLXbb4S7F7vdlruoD/X1iuuxXwjRUiTIKUKDmdyh6kRzcfxyIHtm
	c3O+cS3j8iRpvgI32+pO/UhUDGalgCfo=
X-Received: by 2002:a05:651c:41d1:b0:399:b07e:daa7 with SMTP id
 38308e7fff4ca-39b1df87889mr5327631fa.24.1782816919764; Tue, 30 Jun 2026
 03:55:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603-gic-v5-acpi-iwb-probe-deferral-v2-0-23ffa16b6ebb@kernel.org>
 <20260603-gic-v5-acpi-iwb-probe-deferral-v2-6-23ffa16b6ebb@kernel.org>
 <CAJZ5v0ibZKfzJwGyUb92-K1N9C_ab0QujpAKCrvMdyygquS1Vw@mail.gmail.com> <akOfu2EIQq3CJgqw@lpieralisi>
In-Reply-To: <akOfu2EIQq3CJgqw@lpieralisi>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 30 Jun 2026 12:55:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hUUz0TPKEdn5Z-4My2R59YeJPenU6ksF6Y6mvXoxQsSw@mail.gmail.com>
X-Gm-Features: AVVi8CckYFzmEyQcHXV6OSl_5EYAouUcgCGftnfBtVwhGCqpemZWNGkMfRNVdZQ
Message-ID: <CAJZ5v0hUUz0TPKEdn5Z-4My2R59YeJPenU6ksF6Y6mvXoxQsSw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] irqchip/gic-v5: Enable GICv5 IWB ACPI probe
 ordering detection
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Sunil V L <sunilvl@ventanamicro.com>, Marc Zyngier <maz@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Hanjun Guo <guohanjun@huawei.com>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 12:51=E2=80=AFPM Lorenzo Pieralisi
<lpieralisi@kernel.org> wrote:
>
> On Mon, Jun 08, 2026 at 07:18:15PM +0200, Rafael J. Wysocki wrote:
>
> [...]
>
> > > +#ifdef CONFIG_ACPI
> > > +       if (has_acpi_companion(&pdev->dev))
> > > +               acpi_dev_clear_dependencies(ACPI_COMPANION(&pdev->dev=
));
> > > +#endif
> >
> > I would rather add a wrapper for this, along with an empty stub for
> > the !CONFIG_ACPI case.
>
> #ifdef CONFIG_ACPI
> static inline void acpi_device_clear_dep(struct device *dev)
> {
>         if (has_acpi_companion(dev))
>                 acpi_dev_clear_dependencies(ACPI_COMPANION(dev));
>
> }
> #else
> static inline void acpi_device_clear_dep(struct device *dev) {}
> #endif
>
> Something like that ?

Yup.
