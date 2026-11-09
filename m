Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243868;
	b=ysfk33lLJn88WAT1h6h2uRw0kUQRBJClsqD6wrWadj6fiLsGa6H1TcVNVJP7+WCBQBgu
	 p3XhTd3sJM2EqGKYCYLnSc+774tcyshJQqleq1E4AEE3ItcDtsemJZyYFTrWYDomOW6Nn
	 98mwXp/3Gujbu2U8pQExTWdk4cKLpveP223ZOL9rVPNtiqjw4w4nAyiwtXO657+ZHtIof
	 ODwz80THMquN0MtKx7qEY/Q+G041GQ8epjDxmBaLu1KFpqYH9SZzc5xtznLVQcGr4OIx/
	 1jH5NkosUqwzmUkwUKgMR1LKXBY5nwbJg06RniKDotLxiXSFPdtufm0mmtSRydYXVKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243868;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=98uplep4b6LqU0B6PhASQmtAA3ME48ucaufzOGjIC4Q=;
	b=LBkzQTOt+SFlyxLSuW37qPx9Wmlr+cHFfqBzAEFW4ZLN6gd72WprMSbA1oCpMUMBKFP1
	 eKFwsScAfD8n8qC55C8Rj54HgMr/R5XeenBzI/lODdL4nz/Z8VKH6ir/OqzKFw/IOyKmi
	 GCDVPfygb3Fb6kzB8ouIAh6u1uP3iJw3+GU4bfVIVnne/eVMkdJfbrXqletoHgw4kD7Ne
	 yTgF/pYpt4LrTQ7Mn6ARjm2KmmmqLYViZGJqXlF2onyFCU0+b0b7b3vHY2RfzduJBiuRy
	 WpZLIsNX3QtAtLaasRe3/iwZwtKoDhlOTG+fRgwElIbT7Rgk+GMsFiDUt8U0WisnNzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CEDKgZl/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ED8606A334
	for <linux-acpi@vger.kernel.org>; Mon,  9 Nov 2026 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CEDKgZl/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7173E1F0092A
	for <linux-acpi@vger.kernel.org>; Mon,  9 Nov 2026 17:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794243866;
	bh=98uplep4b6LqU0B6PhASQmtAA3ME48ucaufzOGjIC4Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CEDKgZl/xaRZRuAjx30DASO6mcydIyq7HmjVgvLZ1L8dCf4QWBZZN7euKRRNsAOa5
	 nkQtEKBpUpxeJU6nUYWsnuswTvMSka3+Xr7i7cK1Hvg0899mUFcTZkfxjyC+VM1oVQ
	 0eUoybmqMCmEhluWN/c81AjhMvyXZ6NKExjIKcx+05kIIpRXM35gguJrd59CQ2QgQY
	 c3bVlXmI1+bvf9gkp09+8XBQKSixMHE1/MVQYz9+9LqRrn0G6Eo+Q1JW020tT2lZOE
	 kNoRTBZYfuXJ6ofKK8hzwahkQ8xDDQiacEPWDsVigBjd4AkSJn2w2czvHNKDD+72PP
	 qVbEDVDSgoYDQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5be47aa555cso985869e87.3
        for <linux-acpi@vger.kernel.org>; Mon, 09 Nov 2026 09:04:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGC1DcmBwR0ACwlEaMyuvpo0YzmTSf7yJV1JDFUsrX/DEpCaJwDNDIIMYSbRYzAjhxdd2Kx3UoIiFRM@vger.kernel.org
X-Gm-Message-State: APuU4Z8WLFYR9ATbZ02ekBkkI4llU+rpXdIgvJUzHewyC9FunTNNmoGL
	hgefF4O9rLO13CIsOJ91hxJRRo42oW+X5oDM9HfqZZDCO+DUFzgkKjZKBdSL+JI3/D89IKKXXkk
	9vEl/Hl8MTBxj8TrcU17LEn8HxSBFjEo=
X-Received: by 2002:a05:6512:3e04:b0:5c0:cba:7d30 with SMTP id
 2adb3069b0e04-5c14bfff517mr1529840e87.14.1794243864765; Mon, 09 Nov 2026
 09:04:24 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106193304.3347374-1-sumitg@nvidia.com> <20261106193304.3347374-7-sumitg@nvidia.com>
 <CAJZ5v0h=iH01rZeXARa3F3rE61qgp0K6U4Fm9wRp+LYq_zD94w@mail.gmail.com>
In-Reply-To: <CAJZ5v0h=iH01rZeXARa3F3rE61qgp0K6U4Fm9wRp+LYq_zD94w@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 9 Nov 2026 18:04:12 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gYO4cw8CFbeRJAv1_cQ1WxrsTBC9yJ15NsrBX4rDM6LQ@mail.gmail.com>
X-Gm-Features: AclHuK-WBxJsK7zT3GOZHOAjjrXQX2TasxeJszPwN6pPO8DsKH9AdlJccVyZZeM
Message-ID: <CAJZ5v0gYO4cw8CFbeRJAv1_cQ1WxrsTBC9yJ15NsrBX4rDM6LQ@mail.gmail.com>
Subject: Re: [PATCH v9 6/8] ACPI: CPPC: Add ospm_nominal_perf support
To: Sumit Gupta <sumitg@nvidia.com>
Cc: viresh.kumar@linaro.org, pierre.gondois@arm.com, christian.loehle@arm.com, 
	ionela.voinescu@arm.com, zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, 
	ray.huang@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com, 
	kprateek.nayak@amd.com, maciej.wieczor-retman@intel.com, 
	pawel.chmielewski@intel.com, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, treding@nvidia.com, 
	jonathanh@nvidia.com, vsethi@nvidia.com, ksitaraman@nvidia.com, 
	sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 6:01=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Fri, Nov 6, 2026 at 8:35=E2=80=AFPM Sumit Gupta <sumitg@nvidia.com> wr=
ote:
> >
> > Expose the OSPM Nominal Performance register (ACPI 6.6, Section
> > 8.4.6.1.2.6), which conveys the nominal performance level at which the
> > platform may run. Unlike the read-only Nominal Performance register, it
> > is writable, so OSPM can ask for a nominal level below the
> > platform-reported one, which then becomes the boundary between boosted
> > and throttled operation.
> >
> > Add cppc_set_ospm_nominal_perf() to write the register. Per the spec,
> > the value must lie in [Lowest Performance, Nominal Performance], which
> > the caller is responsible for validating.
> >
> > Add cppc_ospm_nominal_perf_supported() to report whether the platform
> > implements the register as writable, since a write-only register cannot
> > be probed by reading it. It uses the same cpc_is_writable() test as the
> > setter, so support is never reported for a register that a write would
> > reject, and takes cpc_desc_lock while looking the descriptor up.
> >
> > The register also joins the writable set that the SystemMemory overlap
> > validation uses, as the driver now writes it and can compete with
> > another control sharing an access unit.
> >
> > Reviewed-by: Christian Loehle <christian.loehle@arm.com>
> > Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> > ---
> >  drivers/acpi/cppc_acpi.c | 44 ++++++++++++++++++++++++++++++++++++++++
> >  include/acpi/cppc_acpi.h | 10 +++++++++
> >  2 files changed, 54 insertions(+)
> >
> > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> > index 5a1f84fddb7f..3a0ecdd1ab11 100644
> > --- a/drivers/acpi/cppc_acpi.c
> > +++ b/drivers/acpi/cppc_acpi.c
> > @@ -463,6 +463,7 @@ static bool cpc_reg_is_writable(unsigned int reg_id=
x)
> >         case AUTO_SEL_ENABLE:
> >         case AUTO_ACT_WINDOW:
> >         case ENERGY_PERF:
> > +       case OSPM_NOMINAL_PERF:
>
> Sashiko is unhappy about this change:
>
> https://sashiko.dev/#/patchset/20261106193304.3347374-1-sumitg%40nvidia.c=
om

So I've queued up patches [1-5/8] for 7.5 and I'll wait for a
clarification here.
