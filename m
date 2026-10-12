Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F78A4BEE25
	for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 17:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826576; cv=none; b=nsd33x80TlJuGZNBGh0Oj1FzWDBUhct/mWyeiGb53NKQp+J4XRBxnkJkoqFXXzKjKwp8mS2YZY/Q/G6J9p8MNCltgsYYbS+KS+IlGGpXTVsKGuAXd8LR+pp4K1wYoNWF34s+SR3USZWND7kFSmmTyCNRWjs+XVrvvUZAd9wO01g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826576; c=relaxed/simple;
	bh=R8EeE7l7yGHjB6CHEYlgtujYryT9v0EaKRM0+8EF93o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cNU9Eq0iNY7bGeD8GvKaWfmx0kK7Ojhm7edvZWeilidPENpZCyIJeIL/BANThPPgUrBGDl3FBnqNLGpICttNc9+PnPpujaZ3PzkW2qPEoj397aJelxniczg9W9lBCKWgQ3i6pBfBjOzLuK927qyrPGFRqLD2Na8e1d4w7bSNk6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gr4VmeSN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gr4VmeSN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA281F008A7
	for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 17:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791826575;
	bh=PMF8ozn9ZW6fxlEoYIFtmrl5gAuD46WkyHLX4zSJAzg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gr4VmeSNCELsZHNUSKW9h4/c3LL+hILyi7SZ5wfxoVe/CGgt0q/WxQRlY0Ynbmg7W
	 cIJvv0TT/Wxoj+/7Ecb35vxqsXNgJcM0FUZZS0DO8eqYe6GDYaZAbViCwvYVsPd0pJ
	 CD4m75yf4zQWytsst9Z5AhKP7fNYr4gXYRahTlcaULpoRO7kT+GuHaD/DfwUk4nFYI
	 qjQDUsSNX3o07SIMhED/Bupe26vx4ZRwWoZ9pERi3+EN6GN1lBJ8DAUiGXFj+xv5Xe
	 zFuhHxQDpBPNHIig+pT6ShP28SWC5B94rwOovP2YthGwWx2yHFr5rQVlk+pbBhfVqR
	 bSf7gZOZGxy6A==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5bcbb82dbadso1501455e87.2
        for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 10:36:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy3XhdhBuAEKWn5YtazzbOjiJRbGn+1kigdkrslbfE5QpTrsvE4y6nKu+kMTExMPVJRh3DgSJ6QT0uY@vger.kernel.org
X-Gm-Message-State: AFq9FYJZhCN40NA0+vv/Ko5U/sZgFwhAhr7j1OuohmGeCd5EWgHpTOXH
	YGwYK49JXAyIk6zay3PzBxg0EjGK1DL1Rb556Puft05rU+CJ0FLzw/fhOaDirMLk+sri+KKRWTy
	Vyib62HCPq7+kJ17LEPs+PfGKEO/WRMc=
X-Received: by 2002:a05:6512:33c9:b0:5b8:ec96:3bea with SMTP id
 2adb3069b0e04-5bcde6bf74bmr3610495e87.20.1791826573195; Mon, 12 Oct 2026
 10:36:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008212832.354382-1-christian.loehle@arm.com>
In-Reply-To: <20261008212832.354382-1-christian.loehle@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 12 Oct 2026 19:34:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iW==OmyA=ZbJNS0jXrCYRaSRS2at2twnW0gBV-rsnW0A@mail.gmail.com>
X-Gm-Features: AclHuK9WGyJH3mzjeL_bNNS33d3gzQtOOUEtys8LIhYn5vd7zFcJlEqZH0fmeoY
Message-ID: <CAJZ5v0iW==OmyA=ZbJNS0jXrCYRaSRS2at2twnW0gBV-rsnW0A@mail.gmail.com>
Subject: Re: [PATCH 0/2] MAINTAINERS: Update CPPC responsibilities
To: Christian Loehle <christian.loehle@arm.com>
Cc: rafael@kernel.org, zhenglifeng1@huawei.com, zhongqiu.han@oss.qualcomm.com, 
	viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Mario Limonciello <mario.limonciello@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Huang Rui <ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	Vanshidhar Konda <vanshikonda@os.amperecomputing.com>, Shubhang Kaushik <sh@gentwo.org>, 
	Pierre Gondois <pierre.gondois@arm.com>, Beata Michalska <beata.michalska@arm.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Jeremy Linton <jeremy.linton@arm.com>, jonathanh@nvidia.com, zhanjie9@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Thu, Oct 8, 2026 at 11:28=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> Hi Rafael,
>
> This series replaces Pierre with me as a reviewer for cppc_cpufreq and
> adds a dedicated ACPI CPPC entry with you and me as maintainers.
>
> The separate entry should help direct CPPC changes to people familiar
> with its performance control semantics, register access mechanisms and
> the platforms implementing it.
>
> Thanks to Pierre for his work on CPPC.

Thanks for stepping up!

> Christian Loehle (2):
>   MAINTAINERS: cpufreq: Replace CPPC reviewer
>   MAINTAINERS: ACPI: Add a separate CPPC entry
>
>  MAINTAINERS | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Both patches applied as 7.4 material, thanks!
