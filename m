Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0EB37F8D3
	for <linux-acpi@vger.kernel.org>; Fri,  7 Aug 2026 17:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786123325; cv=none; b=ur0UIAGedcL7qp7Kw83KSxvEifLmHL8owTV6CZnLdrXXmftPoDoQlT+YmGD7Pk+6yeLcOpcC5P+4cz7zTXl7ct7OhYt9AsSHT+pC+G+qTvee2R7BgPxcH8WiApC+xPiG2OHC6k+O2By6H1oZZSi4YxVJB2sB1vESEwG22g89ito=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786123325; c=relaxed/simple;
	bh=e5paooe1WtfAzLv/OcD0PO1w/KE+LgYkh6Xn21aDrKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LdgUMP8tR1dpBrQ3n2aJ9XkwUAR6iJ3Rqn9VHT0ENK4cod3mze1zKjhkGF4rCYO+CsieAhoH/mJKcfQJZ3bjrtXpBQXHQlb6AB5OddnlIixMiZRkETWsI9DJXeB7esuzzsfZp/VCOSKij93sUBmjphSuPFr7ghQHFhyGbtbvpGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9zWpSnF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9zWpSnF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB161F00A3A
	for <linux-acpi@vger.kernel.org>; Fri,  7 Aug 2026 17:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786123324;
	bh=QZwCMlYfQUln+Ha7mVhguaAvomIhwAzNTTm47AocAIw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=m9zWpSnFtiqGHACQHD6GS/U6Id1zJXeiZfFz/NI7Dev1PSEqB5fFZ4vD8dp0w/EA4
	 ZOjBu34xD9nkDkwKu3/yO5/5agbmiFDufMg9Cdzi9nczI9VrDzuCunWGqW25YuK7M3
	 CaRWomqRMLx0bTamFJAEwrwCgRG7Mia6dVP5QV0RIS3+m8EPIrO7bglV6bPMvWjcjo
	 EfsUl0yaFhp4GYvTI4z/UGPGlWOINtcd6RtmxPik6iP+uh892UVYqU6lbx9ttf6J3N
	 KpyiF/St32MKjuW9RiRPZ3abToIpycQGhdnRiD7A8+cSu9cK5Uc0DY4Bxb+ZHC5J+A
	 va5NcLFc1dSWA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39faf9e2c62so22642591fa.3
        for <linux-acpi@vger.kernel.org>; Fri, 07 Aug 2026 10:22:04 -0700 (PDT)
X-Gm-Message-State: AOJu0YytWCAF7lw6hxuJQtSYOV2YTRMoXi3a6hH0Wkdog/EZMOp53Tyw
	4hEW/jyZnqMgXPz5cswyYCoeA+0vL6xLTqz0F1jSe3tCeY7K4FMOVMqyFAvBWE+VcygAjuPwS3L
	TR5AK6DjMY0l4zcUaLHVcr6JC3YED8wo=
X-Received: by 2002:a2e:a99f:0:b0:39c:7ef1:a640 with SMTP id
 38308e7fff4ca-39fbb1eca14mr31691211fa.12.1786123322873; Fri, 07 Aug 2026
 10:22:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721182551.2434933-1-nirmoyd@nvidia.com> <943f855a-67d8-7a8e-a7aa-374845807d8e@huawei.com>
In-Reply-To: <943f855a-67d8-7a8e-a7aa-374845807d8e@huawei.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 7 Aug 2026 19:21:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iB-3saQjzTwKPovLV8FLrYeG=vX756qZYvyby2Ph879Q@mail.gmail.com>
X-Gm-Features: AUfX_mxy6b8oBHm8CQRoH0CXkYV_dn05pCSMq0OKOwEo0msx1m0cst1RtVywTcM
Message-ID: <CAJZ5v0iB-3saQjzTwKPovLV8FLrYeG=vX756qZYvyby2Ph879Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI: APEI: Fix ERST timeout unit conversion
To: Hanjun Guo <guohanjun@huawei.com>, Nirmoy Das <nirmoyd@nvidia.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, Borislav Petkov <bp@alien8.de>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, 
	Jeshua Smith <jeshuas@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 4:22=E2=80=AFAM Hanjun Guo <guohanjun@huawei.com> w=
rote:
>
> On 2026/7/22 2:25, Nirmoy Das wrote:
> > The ACPI specification defines bits 63:32 returned by
> > GET_EXECUTE_OPERATION_TIMINGS as the maximum execution time in
> > microseconds. erst_get_timeout() instead multiplies the value by
> > NSEC_PER_MSEC.
> >
> > Use NSEC_PER_USEC to express the firmware-provided microsecond timeout
> > in the nanosecond units expected by erst_timedout().
> >
> > Fixes: fac475aab70b ("ACPI: APEI: Use ERST timeout for slow devices")
> > Cc: stable@vger.kernel.org
> > Assisted-by: Codex:gpt-5.6-sol
> > Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
> > ---
> >   drivers/acpi/apei/erst.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
> > index bf65e34615314..15ab797641cfc 100644
> > --- a/drivers/acpi/apei/erst.c
> > +++ b/drivers/acpi/apei/erst.c
> > @@ -108,7 +108,7 @@ static inline u64 erst_get_timeout(void)
> >
> >       if (erst_erange.attr & ERST_RANGE_SLOW) {
> >               timeout =3D ((erst_erange.timings & ERST_EXEC_TIMING_MAX_=
MASK) >>
> > -                     ERST_EXEC_TIMING_MAX_SHIFT) * NSEC_PER_MSEC;
> > +                     ERST_EXEC_TIMING_MAX_SHIFT) * NSEC_PER_USEC;
>
> Good catch! In the latest ACPI 6.6 spec, it says:
>
> [63:32] value in *microseconds* that the platform expects
> would be the maximum amount of time it will take to
> process and complete an EXECUTE_OPERATION.

Applied as 7.3 material, thanks!
