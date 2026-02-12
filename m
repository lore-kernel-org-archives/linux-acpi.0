Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E58346A0C
	for <linux-acpi@vger.kernel.org>; Thu, 12 Feb 2026 11:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770896668; cv=none; b=HocsjRqiTn+oWObXDxoBbrJzvvzUZwXGTiKWh4Uy6R3qrf5frCeqD9ytseGXjSbletK2H6TIOI65sBe+UCWgvzMm0tj8iD1RIdAxWXtxCZ1ShsS/N7xNa9Gms2g6PyhJ9UubzvevYW46Ogr+KXSpBQvie3bVaIaNhfvyohZxK9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770896668; c=relaxed/simple;
	bh=GusY+He8Bnnz0voVLpglddBc9mcy0CTXXscPoLQR2EU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FI65nwySZY4JK+llDs3bUY10zSCOfFvlgvqjzQPVqnFbk/ODDiLRKrd7wp0ILhhNYzIBKNHBoEHhfhQx1Rp0m5gVBvjzspFgIu5UdviHrU10DcfvGTeRb0dtCw1WU/SE9MTZfN9E35DNVsqXIwI9R1qZpPynjvydLwmOPzLtLaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qm3tCpRW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qm3tCpRW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59303C2BCAF
	for <linux-acpi@vger.kernel.org>; Thu, 12 Feb 2026 11:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770896667;
	bh=GusY+He8Bnnz0voVLpglddBc9mcy0CTXXscPoLQR2EU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qm3tCpRWfGdArPwdfm6ZBRiVNapnnblVBY0xhqG2KoW4ELcnT/6ouxAbm55szkTI0
	 YGfSqbF/I5v2t4WdLxOHxSI3G50zoqxMsHZru8zTfzGmwYE803U4uGT3VSLEzU6l5Y
	 k2mmRlaZDZFouzND5uPQ1c9V0L7bdk8uzyblBBQLCjY17DtqMC0aSsm3vUi9LcFGUW
	 H7lLucN+NPBAtMkbcWZtue0yu5dA+Uh8tl4YEqj3m46LWD6dr+bOrewjHn6MBWJ2fi
	 +wD4yWI+KIs1QcIch11q/uAzYH2xLeGgcL1HTR4hxuASXHP61yoqPgcHWcWouN8tyW
	 /2xxEtiHoHNIg==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d15b8feca3so2995606a34.3
        for <linux-acpi@vger.kernel.org>; Thu, 12 Feb 2026 03:44:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUXyiW8e0tT07NGbr3pCudMx8O1Xb0pK52L1gCw1nde5KlDo/N96tFAZhbqYm/qaNy56/eXo0eek9E6@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz/C6EGdNqFQiy6aBzVulRXjLPwLALwbZC7KxVWoUSgzFdjEhF
	ZJYEy2FiBSwFTA0YWJO9l9+ViNrtc7wfyXS+s7kzO3TaeGh1hEBe4R88LbfP0U/Rnfk0nQOU2gB
	UvxweuTTW0M+YYIQeswB+N3caO5AbknQ=
X-Received: by 2002:a4a:b2cb:0:b0:676:7cea:7910 with SMTP id
 006d021491bc7-6767cea7e9fmr122521eaf.62.1770896666347; Thu, 12 Feb 2026
 03:44:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211212254.30190-1-skelley@nvidia.com>
In-Reply-To: <20260211212254.30190-1-skelley@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 12 Feb 2026 12:44:15 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iJq6PLcaX2yXszt+PndiOQPYWtai1DZ=dz+o6treH9GQ@mail.gmail.com>
X-Gm-Features: AZwV_Qi1upQNkyl4i8SKycwfg_DbF8NPDlJjlvq71BshTuuQRGo7c3LIZD1a2F4
Message-ID: <CAJZ5v0iJq6PLcaX2yXszt+PndiOQPYWtai1DZ=dz+o6treH9GQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: CPPC: Fix remaining for_each_possible_cpu() to
 use online CPUs
To: Sean V Kelley <skelley@nvidia.com>
Cc: rafael@kernel.org, lenb@kernel.org, pprakash@codeaurora.org, 
	gautham.shenoy@amd.com, jamien@nvidia.com, mochs@nvidia.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 10:23=E2=80=AFPM Sean V Kelley <skelley@nvidia.com>=
 wrote:
>
> per_cpu(cpc_desc_ptr, cpu) object is initialized for only the online
> CPUs via acpi_soft_cpu_online() --> __acpi_processor_start() -->
> acpi_cppc_processor_probe().
>
> However send_pcc_cmd() and acpi_get_psd_map() still iterate over all
> possible CPUs. In acpi_get_psd_map(), encountering an offline CPU
> returns -EFAULT, causing cppc_cpufreq initialization to fail.
>
> This breaks systems booted with "nosmt" or "nosmt=3Dforce".
>
> Fix by using for_each_online_cpu() in both functions.
>
> Fixes: 80b8286aeec0 ("ACPI / CPPC: support for batching CPPC requests")
> Signed-off-by: Sean V Kelley <skelley@nvidia.com>
> ---
>
> Notes:
>     v2: Also fix for_each_possible_cpu() in send_pcc_cmd() (Rafael)
>
>  drivers/acpi/cppc_acpi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index a09bdabaa804..0e6ffb188fe7 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -362,7 +362,7 @@ static int send_pcc_cmd(int pcc_ss_id, u16 cmd)
>  end:
>         if (cmd =3D=3D CMD_WRITE) {
>                 if (unlikely(ret)) {
> -                       for_each_possible_cpu(i) {
> +                       for_each_online_cpu(i) {
>                                 struct cpc_desc *desc =3D per_cpu(cpc_des=
c_ptr, i);
>
>                                 if (!desc)
> @@ -524,7 +524,7 @@ int acpi_get_psd_map(unsigned int cpu, struct cppc_cp=
udata *cpu_data)
>         else if (pdomain->coord_type =3D=3D DOMAIN_COORD_TYPE_SW_ANY)
>                 cpu_data->shared_type =3D CPUFREQ_SHARED_TYPE_ANY;
>
> -       for_each_possible_cpu(i) {
> +       for_each_online_cpu(i) {
>                 if (i =3D=3D cpu)
>                         continue;
>
> --

Applied as 7.0-rc material, thanks!
