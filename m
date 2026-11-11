Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417704;
	b=ZxsKsZjZZ5A6Dr4kPTXz9PHCPR12s17WvK3W3s82WvZJTeaAO0zGrjMG53hHc/3QEMsG
	 dVYxYNLnYfxiZyfLpsDpl1dIS2vn67LVs9USqEHzxoIQNxwRvz0xetZf4qS9KBI3V7A/W
	 UOg89AXmGNkD0SSxOlwHRtGL2vEtARKKX2PT9YbP/vYc2MEKv6vorUEi8OElp5gH31BRB
	 iwttIF4MgoScRYQrQeIELciaZyNlRG51PBmQlpAhQmx0QTRXZgYTKEvRU0kC19YEL6g70
	 lZec1lSW6lagrarCtpqWYQg52jLciYmqfN2iXWUBtc7X4F6yGoqKeZgu1Dk6bYdMPuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417704;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4qCwkQDnBtxBbh7rhq6R5sT5K9c4cD8JwdX/ZdlMM80=;
	b=oQIg/hgo7y43IslJoUwBguqgdhvm9uWciiuvdaLvLmOK6UtyKCrz5otho5XOKLkxLLLu
	 xtp/sfodG0NM5eRq8qUROsct+abwqUnSZrsIOvzTEGgVuwz57h6hH9EkJnLGsOdMPZJDi
	 sOyq+QHvkBDRD1HDyTD/0igHf5/wiTamFE9ZjCG0vYuvZwOH+xDBK+OL1NyTpNTdnmvfR
	 8tBQgh8k1YI5S1pYqhveKUxykjGsyjggmJGew69ki+4IVyheZt67ZqazBZYuThr6VGOwK
	 iO0vbP1tXzu7J0DgA33aotOHTKvr8oBu2ds9uTXzZZ1T3ZF7QYD/eXFdhuMrXrfoGDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="icw/Semq";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F3B606A33B
	for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 17:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=icw/Semq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8730A1F00A0C
	for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 17:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417704;
	bh=4qCwkQDnBtxBbh7rhq6R5sT5K9c4cD8JwdX/ZdlMM80=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=icw/SemqlYkSM0EoxDCEXEALO83kTWNNakwFTDrY0Bi1iLYSpzLY5vMLJbUtX1q/m
	 N/aALn0gNPbH6AL4sMxqmCGZm78cPS1rfs59XlrSlMD0JYfxTvPYprDdruemVHH/4v
	 Y8JJWRhsONeSIHKOSpGcDAE7UEF7t9FcNcSe6aXoDecf6MDaBscXCFj/ceaGrbLocD
	 QfwRAzlX9ACSeR5ksyf9Czh7AvLB1SlmmaP5WEjgHB8ciaIQ0gf30qAABbJP3TUkqE
	 v4iVSx3ui0vkw7mtyKtXhVBqsC5z/ekBqB1/pq0iG1CDABeoQ0gvifdxnu5mVGa7N9
	 I3EsgN/QkoNTA==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3ab53a99771so28388551fa.3
        for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 09:21:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGu6kmtV2Z5EAGLtZ3F9RgjckuSX7zrywyqa+Tg+nt04QsqcanGW5d9NGay0QKVJ/XL15h+7/Z0VbfA@vger.kernel.org
X-Gm-Message-State: APuU4Z9Lxz0BI00pUTeCGryHna8AoGKf6SdHdV71NN20fsxBznyUSuxL
	REs1yt780IOhm4YtYl7xcJvUDVIRzfAf4H7SfaQ2i7v6TtgYpHhlj1KnyZwfbYVQXWH7VPSEekS
	Lw5Pal8L58lGBzPOxdt3h20SJ2+cD+gM=
X-Received: by 2002:a05:6512:3089:b0:5c1:4cb4:2810 with SMTP id
 2adb3069b0e04-5c15d5e777fmr1278870e87.15.1794417702887; Wed, 11 Nov 2026
 09:21:42 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103084718.8222-1-paul.cercueil@bootlin.com>
 <CAJZ5v0hi_+FCGCXqV71GwgPDpymNZsUv9jRwjLK2BFJV3sqmiA@mail.gmail.com> <a4ed9e2914eff93e77842890bfaa72581d58c440.camel@bootlin.com>
In-Reply-To: <a4ed9e2914eff93e77842890bfaa72581d58c440.camel@bootlin.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 11 Nov 2026 18:21:29 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jq1yU9qmUL1=+9nAgL6vC+LFuANopRQEi8RsebeZoJug@mail.gmail.com>
X-Gm-Features: AclHuK-DPtg60uYz7aipP3S6W365TZGDc2q27pj9fE8jA8qdUb6h89LudX5mIQw
Message-ID: <CAJZ5v0jq1yU9qmUL1=+9nAgL6vC+LFuANopRQEi8RsebeZoJug@mail.gmail.com>
Subject: Re: [PATCH] ACPI: platform: Add basic support for ACPI 6.5 fixed
 clock resources
To: Paul Cercueil <paul.cercueil@bootlin.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 9:36=E2=80=AFAM Paul Cercueil <paul.cercueil@bootli=
n.com> wrote:
>
> Hi Rafael,
>
> Le mardi 10 novembre 2026 =C3=A0 18:18 +0100, Rafael J. Wysocki (Intel) a=
 =C3=A9crit :
> > On Tue, Nov 3, 2026 at 9:47=E2=80=AFAM Paul Cercueil <paul.cercueil@boo=
tlin.com>
> > wrote:
> > >
> > > ACPI 6.5 introduced a clock input resource descriptor, which allows t=
o
> > > specify in the ACPI tables what clocks are connected to a given devic=
e.
> > >
> > > This patch adds support for the most basic clock resource, which is t=
he
> > > one that represents a fixed clock. The new code will then create a
> > > clk_hw for each fixed clock resource, which is then made available to
> > > the device drivers, that can obtain it through a regular call to
> > > clk_get(NULL).
> > >
> > > Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>
> >
> > You need to look at Sashiko's feedback on this:
> >
> > https://sashiko.dev/#/patchset/20261103084718.8222-1-paul.cercueil%40bo=
otlin.com
>
> I was expecting Sashiko to send me an email, but it didn't?

For linux-acpi it doesn't send them, you need to check
https://sashiko.dev/#/?list=3Dorg.kernel.vger.linux-acpi

> I'll v2 with the feedback addressed.

Thanks!
