Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE77B471406
	for <linux-acpi@vger.kernel.org>; Wed,  5 Aug 2026 13:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785935041; cv=none; b=gmj4vz6y7roiQ6RmOa9ZdTURSSrgwuBMBEVPni0VQAbVTiifHE4T1Gn35POXs6sTbVxLLBIGQOksxiYOwNQRBQ9i2EsENe1c5vIs06rl1a6BREBdc1QEgKHbrJaLDANkxw91htoQWaqFqjwNjhV1ZHUIKQ8RAGI9U2ZS5+LxmHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785935041; c=relaxed/simple;
	bh=uvdv92A5fUACZ6C65B3w/DvWb3SrKb4c5Kf7q0wgzk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MA3rAvk4Tj9L+X3jm41TQscDYKg/eL9l9PH3YOScvn0++twCpe+no1sBqEYFihQJqdnAGNeLWmRRmxgK2E/z6eWYJsj2osjtbTMdByEOd25MHpBGAAte3g1yHxzSHh9pVSm9zWtjuNCKoBHQLs7fPNbQjBS7GNfSv+j4uuSSeYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWpz8I9M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWpz8I9M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF4D1F000E9
	for <linux-acpi@vger.kernel.org>; Wed,  5 Aug 2026 13:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785935028;
	bh=Wov0tjYd2izQVvZVikeFInnSXkoR0uH+MKvUZ+/n2RQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JWpz8I9MSSySSMkcRGdi92N48lPU3YPouz4F2cz9dh3pmIxYehUHcRp5DfA9Gw2qS
	 +IYvroGQK4LQEw7C+MearwsMIRVf6I3v+p7vCNCNVjHVmemymMi/w4VPFlLk7QdBEC
	 mWjL364MX29sA31bZpUMRvpZYeWxEEZD3zO142012B0FzvfMEgojN39RFwiDCN7i94
	 uHw0j9kvHd21uST+TgQtESm8cRj7y89qeqCN9neLgYW4MGDlae3uYkE1pwe+TF73ok
	 AjWxLkteNHRQk82ahhKe9oXOyv0A9MWTBYKdUs/lTjr70pu/3BPtnY9JOTALD6x5oQ
	 x1eLdiwUDTWyQ==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39faf9e2c62so6223001fa.3
        for <linux-acpi@vger.kernel.org>; Wed, 05 Aug 2026 06:03:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro1+4b+6r2tc3HkfUsRZsjR37xAU0Ly0/5bKDeTs+PksEIUQtbMZE6dY27A/GjJ2SVncQ51X7oubY20@vger.kernel.org
X-Gm-Message-State: AOJu0YxljWCozFehHcvnre7OcdOmo2a1CHRzBSynDb5DJjGwJkYW1tdU
	yuIf9tf2E9FVjyQYlCzwsSWFTg+a5rlMlgBAMKTnJsqhqZa6irHHEky/tBVZ0aX80TKyiBVi4Dr
	SBObR8D828RrNJoBHhK7EuqKzz40Nf/0=
X-Received: by 2002:a05:651c:150b:b0:39c:6d3a:2dd7 with SMTP id
 38308e7fff4ca-39fbb2562fbmr8187751fa.17.1785935027415; Wed, 05 Aug 2026
 06:03:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803203531.1268651-1-christian.loehle@arm.com>
In-Reply-To: <20260803203531.1268651-1-christian.loehle@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 5 Aug 2026 15:03:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iodtV+kMcck9Yq9beMt5DUOp=d2+Ooje97WbgCUtDZ2A@mail.gmail.com>
X-Gm-Features: AUfX_myKkOivimKKxxRM5y-JlEju1okWYjIUVXrlZgMICY5eBftXpH9S85Lx_Nk
Message-ID: <CAJZ5v0iodtV+kMcck9Yq9beMt5DUOp=d2+Ooje97WbgCUtDZ2A@mail.gmail.com>
Subject: Re: [PATCH 0/3] ACPI: CPPC: Avoid Desired Performance reads on _CPC 4+
To: Christian Loehle <christian.loehle@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng <zhenglifeng1@huawei.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Sumit Gupta <sumitg@nvidia.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	zhongqiu.han@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 10:35=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> ACPI 6.6 introduced _CPC revision 4 which changed the attribute of
> Desired Performance from Read/Write to Write.
>
> cppc-cpufreq reads Desired Performance when feedback counters cannot
> provide a usable sample because some older platforms repurpose the
> register to report actual delivered performance. Preserve that workaround
> on systems reporting an older _CPC revision, but do not attempt the read
> on _CPC revision 4 or later, where firmware no longer promises a readable
> value and cppc-cpufreq can fall back to its cached OSPM request instead.
>
> cppc_get_perf() also reads Desired Performance while populating the
> control values used during cppc-cpufreq initialization. Its only in-tree
> caller overwrites that value with highest_perf before the controls are
> first written, so the value is never consumed.
>
> Patches 1 and 2 provide minimal, backportable fixes for the two read
> paths. Patch 3 simplifies the mainline API by no longer reading
> Desired Performance through cppc_get_perf() on any ACPI revision.
>
> Changes since v3:
> Detect on _CPC revision not ACPI version (Rafael)
>
> Christian Loehle (3):
>   ACPI: CPPC: Reject desired_perf reads on _CPC revision 4+
>   ACPI: CPPC: Skip desired_perf read in cppc_get_perf()
>   ACPI: CPPC: Stop reading desired_perf in cppc_get_perf()
>
>  drivers/acpi/cppc_acpi.c       | 36 ++++++++++++++++++++++------------
>  drivers/cpufreq/cppc_cpufreq.c |  2 +-
>  2 files changed, 24 insertions(+), 14 deletions(-)
>
> --

All applied as 7.3 material, thanks!
