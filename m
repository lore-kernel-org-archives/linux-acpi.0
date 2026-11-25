Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795632830;
	b=Nvk5yu+RFlZIQdpbn+DgdaLkH+XCy0vMBA/vX1khHQZ4oGjaTs6QnfFGpES0tSC04PhA
	 Z0FE/brs2KB6S4Tj/62ZQVpdzclCBekS+eigp0emvGqKk0oOauz88BaoVgzbEgJ8n9BMp
	 MYTdjWAMu8dk5FqLG9N7bKv/hMb4G0OCGconKZZy+8yKf7UNuQlNHYVQJU03vy6/bjYQf
	 VXl3zApq+eQ2zTzlN++LEzY2cEmQNcQiKDMRVpYgx2taU9e6oFVqQpj8n6MLQj5iCAlhW
	 soAZsTHcvrmoy42oO3Y2JyWVJ1O8jwoF8ZvNUtDP65J0cj8c2TIPPqFPQiMRhGyno8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795632830;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZUFTgX9I3rIDWyWbEPzzLtEjDTEABzFig55bitVUR64=;
	b=1AcKSRKSPdHDc+6zm75dU1F2MOXr0XLylLtcNvE27e5NGgLn3u4lz1ciIkfRTmUbUTh8
	 /Bz6N64kV85L+vOwZZ/Szb6z9yAevKgX+d/2fq+qlTF14DCvoj7hQvYceoq1JXstzHO5s
	 ZOkJ/5BBh1mOvEzkrVHRwSSYtgYhtLl0cgrAdVypk3ZYfWalGxmRTieshCBi87TAA8W19
	 8O9G+QgrA+re4iHCq1UsLcDnQ+/zzpF18qY1vqEGbPUsRnOCqg3YPOE8gV6ABLRzVGbot
	 8NpSEAkH4YmyZOmjutOOtP+9Z/QVhkR1gD+QKhbWE+vSIv+hwf8jyG7aVpoeK2gUfug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WI0M6A8f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA3F606A32E
	for <linux-acpi@vger.kernel.org>; Wed, 25 Nov 2026 18:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WI0M6A8f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F7C1F000E0
	for <linux-acpi@vger.kernel.org>; Wed, 25 Nov 2026 18:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795632829;
	bh=ZUFTgX9I3rIDWyWbEPzzLtEjDTEABzFig55bitVUR64=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WI0M6A8fX4kGm1w7FRjqBn9QdwHmvJe7RYyHe/hjVrABkDsaoikwibWMWvJigx6aT
	 UNuXGNuHkMyEa9o9bfMHBTp8+I+CERDKk8SvfRjvHrqTLJsy8NvimJPLofrYX+7p4x
	 wDQAJz/goWW9hOmvxzSQno4AQtV7ESH6cdtTHrwfLq3nFyyRU1r3QvMI76NdQPrtXT
	 Wk8L6A3c5XSK47xdDfZa/RXAHuyZeM9d2VrwHHqNnQFN7FbHtv4VwShWnHgZUSOzbG
	 nS2m/1ltINXQeJomNJ8vHKhlTRo8CkJubWLsuij6BOU5LOoGxkR5b8o844JrMOYG91
	 keHivASxMvPzQ==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3adf9b1f5aeso61578521fa.0
        for <linux-acpi@vger.kernel.org>; Wed, 25 Nov 2026 10:53:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEqbXBu/4RHXxtFN6PwJsLTHxeQgOy+Sh3uXhgPV5J6KYtEJkuQdDyAUIs7i9ahg48YpWwla7coSVT3@vger.kernel.org
X-Gm-Message-State: APuU4Z+ETMZjpQn85z23NIkEDvOun3JuBXVtPoXygNaHeNZnfv99QiC+
	a1RBkp88pKBUMigUH5FMGP5D+OBd3YfVKWwl3C2NlPf1tWSx5wWKuOPppaKA8IevUkDrPmaxvS2
	WP5I8mxmFrGS929zobu30A1CLNdrGA3Y=
X-Received: by 2002:a05:6512:2313:b0:5c1:5457:a147 with SMTP id
 2adb3069b0e04-5c1b7c5f28fmr4778056e87.32.1795632828292; Wed, 25 Nov 2026
 10:53:48 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119-acpi-ghes-poll-interval-v1-1-6f45cc65fd62@ahmedabdelfattah.dev>
 <115ef051-31c1-4201-b60d-bfea9d413bd8@linux.alibaba.com>
In-Reply-To: <115ef051-31c1-4201-b60d-bfea9d413bd8@linux.alibaba.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 25 Nov 2026 19:53:36 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hAT_wnoyjqW+P4SYCE49Eq7V8Xa_CRVoWfk+pNpAoF0w@mail.gmail.com>
X-Gm-Features: Aa3M54q2sGywI-9-qhviPWNjL1kVKc40QfkFo9jrfVxwYbE3y7InpDpSgFEWVf4
Message-ID: <CAJZ5v0hAT_wnoyjqW+P4SYCE49Eq7V8Xa_CRVoWfk+pNpAoF0w@mail.gmail.com>
Subject: Re: [PATCH] ACPI: APEI: GHES: Poll error sources at their poll interval
To: Shuai Xue <xueshuai@linux.alibaba.com>, me@ahmedabdelfattah.dev
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Ying Huang <huang.ying.caritas@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 2:50=E2=80=AFAM Shuai Xue <xueshuai@linux.alibaba.c=
om> wrote:
>
>
>
> On 11/20/26 2:36 AM, Ahmed Abdelfattah via B4 Relay wrote:
> > From: Ahmed Abdelfattah <me@ahmedabdelfattah.dev>
> >
> > ghes_add_timer() passes an absolute time to round_jiffies_relative(),
> > which takes a delay:
> >
> >       expire =3D jiffies + msecs_to_jiffies(g->notify.poll_interval);
> >       ghes->timer.expires =3D round_jiffies_relative(expire);
> >
> > round_jiffies_relative(j) rounds jiffies + j to a whole second and
> > subtracts jiffies again, so what gets rounded here is 2 * jiffies plus
> > the interval, and the timer fires up to a second away from the Poll
> > Interval in the HEST. With a 1000 ms interval, on some boots the polls
> > come every 1.5 s on average, for seconds or for minutes, and the rest
> > of the time they are anywhere from 0.75 s to 1.95 s apart. A 250 ms
> > source settles at one poll a second.
> >
> > Rounding the delay instead would still move every interval that is not
> > a whole number of seconds; a 250 ms source would still be polled once a
> > second. Drop the rounding and use the interval as it is.
> >
> > Fixes: 81e88fdc432a ("ACPI, APEI, Generic Hardware Error Source POLL/IR=
Q/NMI notification type support")
> > Signed-off-by: Ahmed Abdelfattah <me@ahmedabdelfattah.dev>
> > ---
> > I found this while timing a polled GHES in a QEMU guest, with a HEST
> > built for the test (one polled GHESv2) and given to the guest as an
> > extra ACPI table.
> >
> > Tested on v7.4-rc3+ (4405c18c95d2) at HZ=3D300, tracing ghes_poll_func(=
)
> > with a kprobe. With a 1000 ms Poll Interval and without the patch, the
> > intervals on three 10-minute boots ranged from 0.77 s to 1.95 s: one
> > boot averaged 1.5 s for its first two minutes, and the others
> > alternated between 280 and 320 jiffies, and between 240 and 360. With
> > the patch, every interval on three 3-minute boots was 304 jiffies
> > (1.013 s). With a 250 ms Poll Interval, the polls settled at about one
> > a second within the first minute without the patch; with it they come
> > every 80 jiffies (267 ms). The extra 4 and 5 jiffies are the timer
> > wheel's granularity at those timeouts.
> > ---
> >   drivers/acpi/apei/ghes.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > index 5d888c82efea..92d54c6b209a 100644
> > --- a/drivers/acpi/apei/ghes.c
> > +++ b/drivers/acpi/apei/ghes.c
> > @@ -1276,7 +1276,7 @@ static void ghes_add_timer(struct ghes *ghes)
> >               return;
> >       }
> >       expire =3D jiffies + msecs_to_jiffies(g->notify.poll_interval);
> > -     ghes->timer.expires =3D round_jiffies_relative(expire);
> > +     ghes->timer.expires =3D expire;
> >       add_timer(&ghes->timer);
> >   }
> >
>
> LGTM.
>
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Applied as 7.5 material, thanks!
