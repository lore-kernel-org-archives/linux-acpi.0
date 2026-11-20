Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795184751;
	b=HKqp3O2KKASizNTDSloAINgjWOcIPyYHt8EUNskoNG2R0GR0A07A/dbE71eSLUbVCITp
	 NA/yKUKN7T3ZiQNipK1c++MyNfEQAT07OiEb/gL7x3T+Wway6DYDZBYIvrSOuxBMUTDCB
	 p7M95s/+zmPiXFwO1g6GSO4kYVFfL0qo9w6dk7OAgwryIsumWWZVPeSJJimzR4hTAkyoU
	 lDxlHJw1NxCHyFzzcx5Sh9kA2HVSt5riJ66Pg2AthvhSUz/J3KD1Kx8hLfgRNl07URSrE
	 WsvB57L1gWfjR3zK+tHcS99hCOqFST1S5+0QjoDxD7pgrMDicNaooRB+RYNVXTlQWLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795184751;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Q1QGjoYaE6UMgYTk/6OhkgIovHiFq9oX5Rd20qQXkcM=;
	b=UthxPk/YkOLw5GTDSVJg0JbLgr0Lq7vWLpzMieyXloMEPJZQxzrVX5d98ypxx6X+kS44
	 DsE/goZ5iNrPF9372cLQUvJcRZXDybca/C9qzVJmcnzf66vVm3Jtqxv95SysCJvjgbvf9
	 qFNrp7BUtMm5qnRgMK5Umj5z9seQwUeyDtguK6FFx2Ln9A3ZSDDzhaeeHccgS7mYQ+sf1
	 iUIZVYO3GT0L6OiaUuQVI+0TkguPRUT2xWI6p4lspgrPgEWwgfMg3mMUKTX8hWLN9HiXt
	 Q8XfhYvaUza0zVHpgn8922f4xkn+QmYdpVq68AQiGLPBSTVVJBG38Lsjkz8PBGRuPCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RSW7egoy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5498D606A331
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 14:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RSW7egoy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDF51F000C6
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 14:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795184750;
	bh=Q1QGjoYaE6UMgYTk/6OhkgIovHiFq9oX5Rd20qQXkcM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RSW7egoy9rhg8xJqUJfVlTEMIPnXfmxsfrzMietR33CDO/vMXcIJb8S7O97FRX6X0
	 jQMkYRSteW/+ukOvx77auvDZByVeqIuRl9H+p8Tc/Rf9oPhd8b1pnQkusUyB5PjZaG
	 Hp5KtsQhnFA/cEF2zHz471AFXMlCLV02xKAetKzzNqRGklWotzvN194O+RdQXXpLya
	 X7+D1xlE7pN+y8hAvta7NuDExL+8ijyd78DOwzoTPznOTDj5O6yyJYcIozA/YATaQ/
	 aBLTDXaF7Da5r46R5Qe5LCPFfv2k02zJm2ciPswr0yoq4KiQ+QENRJgVk5OEHHKLWG
	 sD39FHBWjP3Gg==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5c10dc41270so920451e87.2
        for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 06:25:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHgPPKtPey+vdDIfx64V9VnakZsrxxdG71ThH6Z0wYt4MuEGl0wZK68pbk9FFOwnMqf3RvwFiGBjJiX@vger.kernel.org
X-Gm-Message-State: APuU4Z+4rntHrFVlH/BE6SIEACNnGe/Ayb+CNb5f5grWvS0BxS/GwwB/
	34KazJCOg5qsUYEjYX7pZUPniUjRJszM13VlrrpED8bJ0gM3SLz8y0FeSyX+7+ysql8gLlMTgMX
	VqhZGI1wqBxioEarQztMG+gvvd5QCjp8=
X-Received: by 2002:a05:6512:1393:b0:5c0:b5c:4044 with SMTP id
 2adb3069b0e04-5c1bc690966mr1003471e87.1.1795184748672; Fri, 20 Nov 2026
 06:25:48 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120125722.209609-1-paul.cercueil@bootlin.com> <CAJZ5v0jNd7GofuUwWHvebMg6Sptwi_t_tV8ooncCA-DJjfyDbw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jNd7GofuUwWHvebMg6Sptwi_t_tV8ooncCA-DJjfyDbw@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 15:25:36 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hfRXxT4TwFvTLbWLTr7zQwBR+dOGFHGDob6YM6eu8d+g@mail.gmail.com>
X-Gm-Features: Aa3M54povqz_jWT6xQy-9VjAiLWN-eILkjZ44bDZBGY43v6tsG8vP17rvzL8oWU
Message-ID: <CAJZ5v0hfRXxT4TwFvTLbWLTr7zQwBR+dOGFHGDob6YM6eu8d+g@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] ACPI: platform: ACPI 6.5 fixed clock support
To: Paul Cercueil <paul.cercueil@bootlin.com>
Cc: Russell King <linux@armlinux.org.uk>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 3:24=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Fri, Nov 20, 2026 at 1:57=E2=80=AFPM Paul Cercueil <paul.cercueil@boot=
lin.com> wrote:
> >
> > Hi Rafael, Russell,
> >
> > Here's the v4 of my patchset that adds partial support for ACPI 6.5
> > clock resources.
> >
> > Sashiko complained about the clock names being too long still, as
> > ACPI device names can be up to 17 characters and the limit of clock
> > names is 16 characters; so I now name them "acpi-clkX".
> >
> > Note that I expect warnings from Sashiko that I got on my v3 and didn't
> > correct, because they are bogus.
> >
> > On the clkdev patch:
> > "When clk_find(dev_id, NULL) is called, does incrementing match here
> > give a (dev_id, con_id) entry a higher score than an exact
> > (dev_id, NULL) entry?"
> >
> > My answer is that you call clk_find(dev_id, NULL) when you know you onl=
y
> > have one clock provided, so you don't need to care about matching
> > priorities.
> >
> > On the ACPI patch:
> > "Should the con_id argument to devm_clk_hw_register_clkdev() be NULL
> > instead of name? [...] Setting con_id to "<dev_name>-<idx>" instead of
> > NULL prevents wildcard connection matching in clk_find(), so any
> > consumer driver calling clk_get(dev, con_id) with a non-NULL con_id
> > fails with -ENOENT."
> >
> > That's completely ignoring the first patch, which addresses this issue.
> >
> > So I consider that those two issues can be ignored.
> >
> > Changelog since v3:
> >
> > - [2/2]:
> >   - Change clock names to "acpi-clkX", because ACPI devices names can b=
e
> >     up to 17 characters long, and our clock name must be 16 characters
> >     max.
> >
> > Cheers,
> > -Paul
> >
> > Paul Cercueil (2):
> >   clkdev: Improve clock discovery with clk_find()
> >   ACPI: platform: Add basic support for ACPI 6.5 fixed clock resources
> >
> >  drivers/acpi/acpi_platform.c | 64 ++++++++++++++++++++++++++++++++++++
> >  drivers/clk/clkdev.c         |  4 ++-
> >  2 files changed, 67 insertions(+), 1 deletion(-)
> >
> > --
>
> Sashiko has feedback on this series:
>
> https://sashiko.dev/#/patchset/20261120125722.209609-1-paul.cercueil%40bo=
otlin.com
>
> Please let me know what you think about it.

Ah, you've already done it, sorry for the noise!
