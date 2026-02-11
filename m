Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7A036C0C4
	for <linux-acpi@vger.kernel.org>; Wed, 11 Feb 2026 21:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770844011; cv=none; b=jRAhhaYynV/04efYQHC7zFfdnWmkjeWLu9qbyXazTfxMg14oeP5pqDofHRaKoTmjrFg/TPprIju7jkwbKlcuh5haVQ9wakJCJ1Z+Wa5TFAZ/lAr8vnw7DSfe62f8V4ZZ6dR3YSEOM11lIED29KpuQQcDgUJfsFw6Nexkm4lL5PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770844011; c=relaxed/simple;
	bh=Fu3RjCg0RLBA/vpGcEz6a0zlaMTBpiiBxragBoHBFbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5QvlzMwO0jB7RRUYUya2/j7poCvQGUEKBv79dLxBtEWq1x+gHiCBySNGle/wh+3wEorARqsbknEKqaeyBMaeuEzjo6OmipRWG/BcLz+JU5Aczte6ca6R/hfElMQW7uAf6If1PpgFVld6FEAITJNtxUMwnKjongJl6wx5bjXVHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFnowv1P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFnowv1P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EB1C2BC87
	for <linux-acpi@vger.kernel.org>; Wed, 11 Feb 2026 21:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770844011;
	bh=Fu3RjCg0RLBA/vpGcEz6a0zlaMTBpiiBxragBoHBFbI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oFnowv1P+3AqBbcIJmBDYlSBLt2/2EdZNNfPPYfJTeGgtxzwI/HuTk2AQ+pdLHua1
	 5jR/f8VZ2g82WXXcz30qncoEWfq2JfJyHlT3PPH+AuKTxVEdHRAwLa30z0ifGMeymJ
	 WuZa4CnNxP8+134Klv1YyzSUIr+eJYaldkgjHa0zHb7R83pQJN+0MsS3HP4ZY+y5xv
	 WIYZs91lR9d0+xRATY/IUjJweElrMFM/Q2TXVT40+ciU/qQuH4XX+fm6naWsz8P093
	 w6ENWnDE5oCB44zzbQ02DhJNydzb+nlNUiD4wRmPPyBSDasF1M8bgl3luJ1psjphnC
	 Q1B1B950qM25A==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4094fbd1808so2355652fac.1
        for <linux-acpi@vger.kernel.org>; Wed, 11 Feb 2026 13:06:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWTuj+gPBI3eXXJLTTtL18NkkfgAbFCkkmDsTTMcNqibqZaOJopwWISOUyqswB54iOt4TpH5qwfsB7Y@vger.kernel.org
X-Gm-Message-State: AOJu0YxAuGLTMd/nmEXrGjftSl2hq2EEjIJmRSTXK8nAVtIE0diukrKw
	ASlWUx/RSHx03Jv/+7F8PBq0j/iOx81WJ7rXJnfAXKfvHZEgpfeEBogBo8ITKp594DOAK7lWyV7
	IbUUFLSKcgkw1rTWcIi4OHW9dwpdVVR4=
X-Received: by 2002:a05:6820:160a:b0:663:bfa4:86b4 with SMTP id
 006d021491bc7-6759a559375mr293589eaf.43.1770844010830; Wed, 11 Feb 2026
 13:06:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211204838.21269-1-skelley@nvidia.com>
In-Reply-To: <20260211204838.21269-1-skelley@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 11 Feb 2026 22:06:39 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i_nGinh8ZJjEK0vbn0hoMj41cRt_NuwvrN2JdJen=9HA@mail.gmail.com>
X-Gm-Features: AZwV_QjafV8qDBGLZLGg4Gg4b1IeXK9d86hKwfip6zQxy_qmHnLxRWKDVtko-ow
Message-ID: <CAJZ5v0i_nGinh8ZJjEK0vbn0hoMj41cRt_NuwvrN2JdJen=9HA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: CPPC: Fix acpi_get_psd_map() to iterate only online CPUs
To: Sean V Kelley <skelley@nvidia.com>
Cc: rafael@kernel.org, lenb@kernel.org, pprakash@codeaurora.org, 
	gautham.shenoy@amd.com, jamien@nvidia.com, mochs@nvidia.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 9:49=E2=80=AFPM Sean V Kelley <skelley@nvidia.com> =
wrote:
>
> per_cpu(cpc_desc_ptr, cpu) object is initialized for only the online
> CPUs via acpi_soft_cpu_online() -> __acpi_processor_start() ->
> acpi_cppc_processor_probe().
>
> However the function acpi_get_psd_map() iterates over all possible CPUs
> when building the P-state domain map. When it encounters an offline CPU,
> it returns -EFAULT, causing cppc_cpufreq initialization to fail.
>
> This breaks systems booted with "nosmt" or "nosmt=3Dforce".
>
> Fix by using for_each_online_cpu() so that only CPUs with valid CPC
> descriptors are considered.

Thanks for the patch, but there's one more instance of this in send_pcc_cmd=
().

Maybe fix both in one go while at it?

> Fixes: 80b8286aeec0 ("ACPI / CPPC: support for batching CPPC requests")
> Signed-off-by: Sean V Kelley <skelley@nvidia.com>
> ---
>  drivers/acpi/cppc_acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index a09bdabaa804..e7cfd4cf029a 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
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
