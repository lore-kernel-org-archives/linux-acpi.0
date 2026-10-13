Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E512C4DEC3B
	for <linux-acpi@vger.kernel.org>; Tue, 13 Oct 2026 10:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791888920; cv=none; b=ZNvhkbR5cLS2q8EMSDGcRGoug8EeKeQMJmN5k4EaTHko1LWFfCMChBDuoqxJ0uXuyQKKBdMGI96v+gsh2+SkpL1QA20eWylooNm+lrB9/max+FrEoSNFUX2LIAj10RvzGmR1gX1/5KkMDMxhZFGlYP1auXR2dPiNk/miG6WWrp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791888920; c=relaxed/simple;
	bh=ds1QPT8yzHdZMuQq3UstL9pPJ7Ci2QOTxip+6JopTkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=buT36CxjQ4Bgz87g/e+L4labClMM7/O31CYBaUuhIkoZnTFjkFLpHsU2hAX+nmHXVfb/Pn+k3pTBGBRnql2IvNomOdJAkAzRE1g41uWXJ/qlEB6r04nq6chTMCMPuKk3MU/KdEiwrI1+BkfDnSC27z1TaXss/SThHVFVXEqMo/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZPJ/boY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZPJ/boY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61CAE1F000FF
	for <linux-acpi@vger.kernel.org>; Tue, 13 Oct 2026 10:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791888915;
	bh=N8rZHN5vr5YYaECJ7sq3JBgr9vWpcUuBt8+2CkZYjRY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BZPJ/boYlaWZJwbOXFprggfIMOaaR0o3HwwlHITrs8md2mUYhZhFkeCcs0Gp+wUti
	 Wr2px3OpOHikuey4NpAIHjPxdIc1FFrVe3HadHqxMxghqT5k/M99cSN0Za3Edk4E9/
	 RWMkG2jPKmAUnpAcXRIGi4LTN9UF3DCwKXwTr8goW8i4PXK3uvdGExRcLXGBbJ7h4b
	 M46NqQoFrtJvFRjSxd8s5GaZ7yBvS2cgdG7evyhu1ZQmLkYmb4Nr/+eiNCeJkodBgJ
	 Zh3+UgyZmt9iPrwY+sd8mfTscFUpqgBnK3R1b6gEGWIU5R2YLwD6OUdjnG6wgwo+uR
	 6hs1CB6vKZrUg==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3aae898c0afso1320261fa.1
        for <linux-acpi@vger.kernel.org>; Tue, 13 Oct 2026 03:55:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxYlzJDelEjviROMhUnNbUaiTegszubx1ijN308bgp2L+df7o9/S3DjTwXfnDP76GUxpvpoOy6pHhWN@vger.kernel.org
X-Gm-Message-State: AFq9FYIOg6v3gV6dWctlNeMPkZMy1kbakm77rJYMR0GwdV4tytHdrn/r
	beO/aXEZg7WDyNgHTTctxdzqQ7I9g4lh3V+PXxLc0wDeWgqg6RMXKYpLb8v0ChkEMXCjRGPAr3Z
	u0jOGtwMHVC+cdeyDHNdC3datIYz5yag=
X-Received: by 2002:a05:6512:1256:b0:5b8:9ef4:2bdf with SMTP id
 2adb3069b0e04-5bcde6c3b8dmr4148449e87.26.1791888913690; Tue, 13 Oct 2026
 03:55:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012230632.3574987-1-jamien@nvidia.com> <20261012230632.3574987-3-jamien@nvidia.com>
 <20261013021258.3843871-1-jamien@nvidia.com>
In-Reply-To: <20261013021258.3843871-1-jamien@nvidia.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 13 Oct 2026 12:53:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ixQ_5jmrfm4mz50tZtCEq6nJt1b2eMoBdhr0f3AY+k7w@mail.gmail.com>
X-Gm-Features: AclHuK8XoMtTs7ME2ZEErW2qatvCRY42FZqBIO0txNvRt7YnZAoZnNgZfF4qoWI
Message-ID: <CAJZ5v0ixQ_5jmrfm4mz50tZtCEq6nJt1b2eMoBdhr0f3AY+k7w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ACPI: sysfs: Expose BDAT data region
To: Jamie Nguyen <jamien@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	Punit Agrawal <punitagrawal@gmail.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 4:13=E2=80=AFAM Jamie Nguyen <jamien@nvidia.com> wr=
ote:
>
> The Sashiko review of this patch [1] notes that acpi_data_show() maps
> the whole data region on every read(), and that the unmaps are deferred
> by RCU, so repeated reads could pile up mappings and exhaust vmalloc
> space.
>
> That code isn't changed by this series. acpi_data_show() has mapped the
> whole region on every read since BERT support was added in 7dae6326ed76
> ("ACPI / sysfs: Extend ACPI sysfs to provide access to boot error
> region"), and BERT and CCEL use the same path.
>
> I measured it with v2 on an arm64 server, with 4K and 64K pages and the
> 90754-byte BDAT region:
>
> - Looping full-file reads, with 1 to 64 readers, kept at most about 4500
>   deferred mappings (426 MiB) in flight. The count stayed flat and went
>   back to baseline within 2 s of stopping.
> - The worst case, tight loops of 1-byte reads, peaked at about 34k
>   mappings and 4.6 GiB of address space, and also drained within 2 s.
>
> At those rates, exhausting the 126 TiB of vmalloc space would need the
> deferred unmaps to stop completing for more than half an hour.
>
> If it's worth tightening anyway, acpi_data_show() could map only the
> range being read, which caps each mapping at two pages for all three
> tables. I can send that as a separate patch.

Yes, please!

> [1] https://sashiko.dev/#/patchset/20261012230632.3574987-1-jamien%40nvid=
ia.com
