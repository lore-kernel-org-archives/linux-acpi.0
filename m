Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0CC481AB5
	for <linux-acpi@vger.kernel.org>; Thu, 10 Sep 2026 17:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060935; cv=none; b=QCkCRuBqBSYEBXqfbofeNtrxOevIR1atEC6ENMcNEDnyluD7MCkTjxSJwYZ7VJZtMvVoGnvr7vrPURNDWzGDxbXUppHDUmu07Ms1MH3Vgr9CA48QbQhfJHuIrgY5WThlnFRDkqCqtubiuG9+YpILWmGEEWz61hA/zWA8IvvTF7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060935; c=relaxed/simple;
	bh=EMjQ/cbpO6/hENghx0S9DU8WaegQkrGP3alYAD4/qF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fpx5on0OJ1KCWB9dsQahX6io8dKBd/htz7Ss5T9y8ATYrPBD1nXHkxcf4orqp0fD2wBNNqi211+b4/hifKUbFVBtEV0l5T0LWN5CuZWeXggepR6/L4er7s6Arji2rfB4fYFHkyqOLkQPjguCOxgEsOjVYwDg375wNt6LcZn5peg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLlOw33m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLlOw33m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5743B1F00893
	for <linux-acpi@vger.kernel.org>; Thu, 10 Sep 2026 17:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789060921;
	bh=QtsclENzPssYj3LUtNUiHYqOvstB/F9Ryi6rxEBSWvM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SLlOw33mhQMJ63LfxOP/OP+I1/A1cY8NMbWm9P5/NTxX9fwG36NvgTOSNs8hLDV5A
	 lTwYKhKxZ5xh9jSwvjp32TbsQ97xixd4OD+RjLSE2/3ERlAyelk0xMfnTI79S1BALG
	 Ny6ARw0n+avzQelHwj+AaO5GadRFxkra5D+0QC7wwX+ngJbvXmC3Rfnhw5yFZVn48n
	 EoKva0AchLiWeeEWBdbDjhPobrjnfY4zHFGqElmAaYs1Z69Av9WRcwHywk9YJjJMG7
	 4MrWTDznr94hLtJnZuEQFsbI77fO8XZtMXRLaekyHwSOjAIWKFESsg4cJTDdib0ZsM
	 72ct/cuBPFYJw==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f16f16so51814e87.0
        for <linux-acpi@vger.kernel.org>; Thu, 10 Sep 2026 10:22:01 -0700 (PDT)
X-Gm-Message-State: AFuF++m5r3g0AqQecw97v4AwLtzMbSmhfs0xqtWcKPN9g2DC3+myne8Z
	uLqeU0gbfTLMVdI735LfIvnB4A7YiMDjedJOmL+OFVm0JSpUbbu9YFmi0gZ+zVIwLYQ3EWU6Omf
	hels4gK8vcNT25yUqqT/OQe/MjN7OhpA=
X-Received: by 2002:a05:6512:15a0:b0:5b8:9eed:8963 with SMTP id
 2adb3069b0e04-5b8a0325910mr167468e87.20.1789060919655; Thu, 10 Sep 2026
 10:21:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPAw8HEMdsNN6WhizHkv2Orp2pkQ2-g009XCGFnKnhXoRhcKZQ@mail.gmail.com>
In-Reply-To: <CAPAw8HEMdsNN6WhizHkv2Orp2pkQ2-g009XCGFnKnhXoRhcKZQ@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 10 Sep 2026 19:20:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iOvjTz5viMUwAovjiMi80eaS-YxU8Uu5yL+2a4oggDWA@mail.gmail.com>
X-Gm-Features: AcwNN1W612Xc95wBSeUTwMKpC5TAtJaLJRgDklSbz9hhud0pfBdxNh68HheI1TY
Message-ID: <CAJZ5v0iOvjTz5viMUwAovjiMi80eaS-YxU8Uu5yL+2a4oggDWA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: osl: use vsnprintf() in acpi_os_vprintf()
To: Vlatko Kosturjak <vlatko.kosturjak@gmail.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 6:51=E2=80=AFAM Vlatko Kosturjak
<vlatko.kosturjak@gmail.com> wrote:
>
> acpi_os_vprintf() formats every ACPICA diagnostic into a 512-byte static
> buffer with an unbounded vsprintf():
>
>     static char buffer[512];
>
>     vsprintf(buffer, fmt, args);
>
> ACPICA interpolates table-derived namespace paths into its messages, so t=
he
> length is driven by table content. A malformed ACPI table can therefore
> produce a diagnostic longer than the buffer and overwrite whatever follow=
s
> it.
>
> From the System.map of an x86_64_defconfig build, acpi_ioremap_lock sits =
624
> bytes into that buffer - 112 bytes past its end - so bytes 624..631 of an
> over-long message land on the mutex's owner field, which __mutex_lock() t=
hen
> dereferences.
>
> The overwritten bytes are attacker-influenced but not attacker-controlled=
:
> they are printable ASCII from a NUL-terminated string, so the resulting
> pointer is always non-canonical and always faults. This is a reliable den=
ial
> of service, not a demonstrated pointer-control primitive.
>
> Because acpi_tb_load_namespace() parses the DSDT and every SSDT during
> acpi_init(), a table supplied by firmware triggers this in PID 1 inside
> do_one_initcall(), panicking the kernel before userspace exists.
>
> Bound the write with vsnprintf(). Truncating a diagnostic is strictly bet=
ter
> than corrupting adjacent kernel objects.
>
> Tested on pristine Linux 7.2.2 - tag: v7.2.2., Stock x86_64_defconfig
> (no KASAN, no debug options), table supplied by firmware via
> "qemu -acpitable":
> [    0.022259] ACPI: SSDT 0x000000003FFE1C52 000640 (v01 _ASUS_
> Notebook 00000005 MSFT 0100000D)
> [    0.353684] Oops: general protection fault, probably for
> non-canonical address
>                0x41435f2e345f2e64: 0000 [#1] SMP NOPTI
> [    0.353727] RIP: 0010:__mutex_lock.constprop.0+0xbd/0xa40
> [    0.353727] RAX: 41435f2e345f2e30 RBX: 00000000fed00000
> [    0.353727] R15: ffffffff8c248530
> [    0.353727] Call Trace:
> [    0.353727]  acpi_os_map_iomem
> [    0.353727]  acpi_ex_system_memory_space_handler
> [    0.353727]  acpi_ev_address_space_dispatch
> [    0.353727]  acpi_ex_access_region
> [    0.353727]  acpi_ex_read_data_from_field
> [    0.353727]  acpi_ex_resolve_node_to_value
> [    0.353727]  acpi_ds_evaluate_name_path
> [    0.353727]  acpi_ps_parse_loop
> [    0.353727]  acpi_ps_execute_method
> [    0.354729] Kernel panic - not syncing: Attempted to kill init!
> exitcode=3D0x00000009
>
> RAX is the corrupted owner; the faulting address is RAX + 0x34.
> R15 matches acpi_ioremap_lock. On a KASAN build the overflow is
> reported directly as:
> BUG: KASAN: global-out-of-bounds in string.
>
> Signed-off-by: Vlatko Kosturjak <vlatko.kosturjak@gmail.com>
> ---
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index ed2162a97..5b7aefb48 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -159,7 +159,7 @@ void __printf(1, 0) acpi_os_vprintf(const char
> *fmt, va_list args)
>  {
>         static char buffer[512];
>
> -       vsprintf(buffer, fmt, args);
> +       vsnprintf(buffer, sizeof(buffer), fmt, args);
>
>  #ifdef ENABLE_DEBUGGER
>         if (acpi_in_debugger) {

Applied as 7.4 material, thanks!
