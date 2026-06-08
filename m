Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A380E33FE2F
	for <linux-acpi@vger.kernel.org>; Mon,  8 Jun 2026 12:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780922615; cv=none; b=KBSTl+2U+UL0Dn4ZocQtQmBmBQmFc71tzVS3AlE6J61eCBZTFuk99ClGO0jAvCvAT0iHv01Qb49YBW9G02yA/8KcrWRRH7TUC9hFwjUyBOCFRSHRyrWZD5evagY8HyHUnRdsIEH1zDH+TDVqvKf2KVLHC8p+YcrYU0NuynJgLCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780922615; c=relaxed/simple;
	bh=tTZyw+5Uu8IoTYSbBjqeZ+1Ba88WEYBTtrn9biZ/efA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tM9jBd7mpEI/Sa9zSb9/4dNeqZIBYG+w1W7MvFF+Mp4N/PQ86+2ti5GFKKBylGVwM0jCD2MxvEPA5a/ZbrblCcIOELxSDWaS6i6Cdn4Ra50VnI7IKbx3k19iwlxWRj+fpSTNaUQv8Ca3rHsAm6hNtehnrlrTXKvFlYFG8tkYRZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GapeKDeI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GapeKDeI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2421F00893
	for <linux-acpi@vger.kernel.org>; Mon,  8 Jun 2026 12:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780922614;
	bh=2beoehzCb0BhnH7bqUBivATijCggi4WFrJzjwRQe8vA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GapeKDeI+/c0uQLSZ2/GGjJadF4/Egm6S8CbQultF7vzkd5uN6wnmtXzQf/KFLqgN
	 1X8e0cKwVhkYRrYUrHVt82SyVbF4FBmFIT8/CN54MmUYSPtf/e+IxCYMjsvgE8PFiP
	 LcHs+y1rC4kbqbDCRA1EZROGC1kgMkjPy4TK93hoWsVhU55w4Q12eWxjKH7xM3dXtB
	 Dhc3hs+ST5BcQ/PAfdDRBGAhYmhWqu9Z1IzkmeZTUXTz9o+jgev1yQfNVF3StF16/F
	 dF/3dEgv+jRIAy8wxS8o3omjo8AjFJnMmHk7zJ6Y5OQpYbkkTaPHdKWtmJRbAqWj0v
	 v3YU1BM+maKLA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aa5e9a64b4so4486588e87.3
        for <linux-acpi@vger.kernel.org>; Mon, 08 Jun 2026 05:43:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/EqPEUS+ZHJb0bgNEZj8rT+OuPZv5CufYXHVRqwC0dMRTYy1aO+JXeTQjhuXbACO+7xYZEWAi/3hGc@vger.kernel.org
X-Gm-Message-State: AOJu0YyhuC+Gkg7FlJv7qWHdVC5dYoCyk/nzk5I1G2xxNU7rLeiR1D5M
	M9HhLubnpsmhnL2IvNICB2rMxepnAgqg6J9A4ZMuyFA6O84kqmhq6edErL4xNfX9+PfDmuJdJAC
	of2VLQT5atjJpbLTxhh9u/v+P3ALQ3co=
X-Received: by 2002:ac2:4908:0:b0:5aa:854c:61df with SMTP id
 2adb3069b0e04-5aa87bc3b72mr2878490e87.19.1780922612823; Mon, 08 Jun 2026
 05:43:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <15af5635-e3a3-4ffc-9f02-82e35a95154f@huawei.com> <20260608190359.3254-1-TonyWWang-oc@zhaoxin.com>
In-Reply-To: <20260608190359.3254-1-TonyWWang-oc@zhaoxin.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Jun 2026 14:43:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hoSqYPrvLTSgekDsY4vwwL55ROrQei00NKcfyzW-ep4A@mail.gmail.com>
X-Gm-Features: AVVi8CdD8ssHTQhsW_2jXsqEOsHFqjKv35zO6PBUwU64UYVDoCG7KZgAv7TQMXk
Message-ID: <CAJZ5v0hoSqYPrvLTSgekDsY4vwwL55ROrQei00NKcfyzW-ep4A@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: processor: Add cpuidle driver check in acpi_processor_register_idle_driver
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lihuisong@huawei.com, CobeChen@zhaoxin.com, 
	LindaChai@zhaoxin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 1:04=E2=80=AFPM Tony W Wang-oc <TonyWWang-oc@zhaoxin=
.com> wrote:
>
> Commit 7a8c994cbb2d ("ACPI: processor: idle: Optimize ACPI idle
> driver registration") moved the ACPI idle driver registration to
> acpi_processor_driver_init(), but it didn't check whether a cpuidle
> driver was already registered.
>
> For example, on Intel platforms, if the intel_idle driver is already
> loaded, the code would still evaluate the _CST object in the ACPI
> table and attempt to register the acpi_idle driver. This registration
> would fail with -EBUSY due to the existing check in cpuidle_register_driv=
er.
>
> Add a check at the beginning of acpi_processor_register_idle_driver()
> to avoid unnecessary _CST evaluate and potential registration failures.
>
> Fixes: 7a8c994cbb2d ("ACPI: processor: idle: Optimize ACPI idle driver re=
gistration")
> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> ---
> Changes in v2:
> - Added comment to explain why we skip registration when a driver is
>   already present.
>
>  drivers/acpi/processor_idle.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index ee5facccbe10..390ab5f1d313 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1355,6 +1355,15 @@ void acpi_processor_register_idle_driver(void)
>         int ret =3D -ENODEV;
>         int cpu;
>
> +       /*
> +        * If a cpuidle driver is already registered, there is no need to
> +        * evaluate _CST or attempt to register the ACPI idle driver.
> +        */
> +       if (cpuidle_get_driver()) {
> +               pr_debug("cpuidle driver %pS already registered.\n", cpui=
dle_get_driver());
> +               return;
> +       }
> +
>         acpi_processor_update_max_cstate();
>
>         /*
> --

Applied as 7.2 material, thanks!
