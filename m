Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795185119;
	b=POv4Buzd9LiqjZf7Cn0p4/y354ZcEJrgJubIgHQPKUPeywcagRYeYjsyHs0+xraGS+3J
	 JmShgYGEe8o6630/Ki1VgW/8bTGBjD4YH7mHTEzrpQ7NuXoKTLXqu77HZfKf0DmdOC/Ng
	 WfTVXTWwgcl2ja+WPj8PVhmlfM/060F6rvrRFsdEOfI4kUhh8OGUZwVNsAWKkMToT4dMt
	 trqsRmodxVlxDD4ZY0tfz35pTEdTzIPKFXiXjelK7AeHhrP9PYI42kGbXuPFRigt80/tA
	 vlRNHxOVJA7fPsZzZZAQ/2hYjFEvu3J37EuORbS4j3wwzNB/B6lNL4xDVwFIelynz2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795185119;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=o7rTaAsHFk/tyQjF/KkLQG7BkQRWi0iSLzAHM4JNo3g=;
	b=thibFf+ZMLKbjStfrH7mWZGSUMN+j9qSSvOIkUpazv4Vl1P2etziXd53KYwbHuniqjfp
	 gU8W+hCWTObLG9BP0CSoGB+jVhHiIB0qHjMfHzibbUCpMN5Krvg1AK+zINuTlJG0eW/qK
	 d7zIhIepnGK5skCqEYqtAyjzpbwhVC5C4d9lsjRNsT/TY2yNzqQKVvDT/nrHUdoZQU/p2
	 xSj0H9xC5E7X+wAWvLwIIWpEXj1BSrx5K5bJxb5PFzTstYtXNmrOnsk3XqNQmH3d6kNlb
	 SIlrgU7Oj7Im3YsiqHUZysfibqpCJVKsxIVojdqF+l+ashm5KXcdboMjiHUTlWtBilw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JJutmftZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7056360A260F
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 14:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JJutmftZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F621F00A3D
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 14:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795185119;
	bh=o7rTaAsHFk/tyQjF/KkLQG7BkQRWi0iSLzAHM4JNo3g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JJutmftZH/J1SIO05hmjDLTFCC92pR72ldIBM1PODII2oyoICOs3aE2vSDtI+hoLm
	 sXTbRAiKa5kEQNNBDEVgtVvh+Si0wBo4+5+EEfeThnkXTm0eFW5IGbK/PO3qwaBQ86
	 kJeDQYTjRLsp9iR2u3ktpc7jsVzNP6ghsP79oItpdtlHPfNZybTmL6nb2KbxJRqHql
	 nrgRFYSrPSlkjZS+df2ZJFVWAaI2+iyuN49uKEk6C1ZnGD38/QMRBV2i3+YmvkqZg2
	 IIZcCLM7O7eFcOVZAs61+5hFjNnBRd1GQXpvJOSjdyGw8zEq372hETtrSLQbMQnIdY
	 jPXJEknSOi/pQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5c148d4dbfbso817014e87.3
        for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 06:31:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGd1RIm7HrscR+OH8+ivY3pCIQ2MHR90fo7qyJEuWMk9v9pC2hSUsLm1FAoVUOfNYYV7rvNY6Uv9ipC@vger.kernel.org
X-Gm-Message-State: APuU4Z92ZYi4oP17hsIrxx1XR9O+OA8+MP8fu5FB+yasr0ZZnhomm9H+
	E7DJUutP6j1CClM8nx/s3+U4i6zingppNb348PuFya0gz7hj37B+PXNPWTgPopLkdBZ7EBbtL7z
	du/Gi+QFHjUF7pOf+5CdkA6onNfi0Iis=
X-Received: by 2002:a05:6512:1153:b0:5ba:3443:aa2e with SMTP id
 2adb3069b0e04-5c1bc7c3484mr1161827e87.21.1795185117367; Fri, 20 Nov 2026
 06:31:57 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120125722.209609-1-paul.cercueil@bootlin.com>
In-Reply-To: <20261120125722.209609-1-paul.cercueil@bootlin.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 15:31:44 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i4ybwsOKfj_LS_m7EL-AYAhPQJmLNWBm8gdZ5uvfcJug@mail.gmail.com>
X-Gm-Features: Aa3M54o-jgZ0qds3pKp74aFKU-859gv8bMIPLYPPqZ_KY6XXerlWsab212FP_V8
Message-ID: <CAJZ5v0i4ybwsOKfj_LS_m7EL-AYAhPQJmLNWBm8gdZ5uvfcJug@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] ACPI: platform: ACPI 6.5 fixed clock support
To: Paul Cercueil <paul.cercueil@bootlin.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 1:57=E2=80=AFPM Paul Cercueil <paul.cercueil@bootli=
n.com> wrote:
>
> Hi Rafael, Russell,
>
> Here's the v4 of my patchset that adds partial support for ACPI 6.5
> clock resources.
>
> Sashiko complained about the clock names being too long still, as
> ACPI device names can be up to 17 characters and the limit of clock
> names is 16 characters; so I now name them "acpi-clkX".
>
> Note that I expect warnings from Sashiko that I got on my v3 and didn't
> correct, because they are bogus.
>
> On the clkdev patch:
> "When clk_find(dev_id, NULL) is called, does incrementing match here
> give a (dev_id, con_id) entry a higher score than an exact
> (dev_id, NULL) entry?"
>
> My answer is that you call clk_find(dev_id, NULL) when you know you only
> have one clock provided, so you don't need to care about matching
> priorities.

Sashiko has a new comment on the first patch though:

https://sashiko.dev/#/patchset/20261120125722.209609-1-paul.cercueil%40boot=
lin.com

> On the ACPI patch:
> "Should the con_id argument to devm_clk_hw_register_clkdev() be NULL
> instead of name? [...] Setting con_id to "<dev_name>-<idx>" instead of
> NULL prevents wildcard connection matching in clk_find(), so any
> consumer driver calling clk_get(dev, con_id) with a non-NULL con_id
> fails with -ENOENT."

This time Sashiko complains about something else in this patch AFAICS
(link above).
