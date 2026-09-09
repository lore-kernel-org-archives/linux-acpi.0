Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34405678CD
	for <linux-acpi@vger.kernel.org>; Wed,  9 Sep 2026 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969090; cv=none; b=id/8eU4yXRN9WZ3GOebojOa1Gpp7ci2TIWGDYTSsDJhmkSD6FMBtkp/PqrbEs/OfTOj602G69Bsl1ReIaDhMCxbCcetbLFnhDoAhyYX0oWD+5dxr9Q4B0rba9sHUx7UIydrUkzmsLE89YOQicnPbHX2UvgK2PtAHqVU/hW5Z3hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969090; c=relaxed/simple;
	bh=J84DnhF2iNA+Z0YQIt+R3q+B0m8blDvEMZw+S27BxhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1s8va6/sxQQOD5yK5SQ/cJUmZUQQl4YM7NV6px4ROcjzXfSI7L8gX8ra07VElJ3OCi4xcxRBdTCnYftoeqlnTPvZ+nB9z1GkF8bCfO0aJPdzR2gDB1zvooPda65MhGXyNhezPIHPfKrnA0RqWMFPet08JuVuP5VJG/KDvkQOtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H33K90gY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H33K90gY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904A01F00A3D
	for <linux-acpi@vger.kernel.org>; Wed,  9 Sep 2026 15:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788969088;
	bh=psZ4LqGN1zUJTB7Z5ulSLkiFWMNZREF5JXAlayWlxdk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=H33K90gY74B5WMl2GTG5ZOWpFMS6LgY3tDsaunIVJtqbmZwTg4UM+Kn7h5IGolia6
	 WM0gFD+tgiV77k2gaViW9rBfj7d+smX2zJVQsuASV+4Ap/E+Iz+U5vEcIorIY0nxjd
	 zpym8bT4ACpM9e/C5Fc/xerDumzHS4qcTmv4wxJ0y4nBpuVI2Am8I5zb1AIYhdzloH
	 mdPKb2O5dO69c+/DU+NwF7rUyLHYZ6fAThBmA9EbSM5gB9xD4SpbzOIDMuIOmpLm7p
	 CO0Qzs7g5UMpgqTK0EQqySrfOMZhlckirsPRoFEuZ0V0chvZEWOMVv+1RA1iDdo75X
	 /bNeJ8iBQUhjA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b7674fcb26so848526e87.3
        for <linux-acpi@vger.kernel.org>; Wed, 09 Sep 2026 08:51:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx427fTA37b2hHfDkCa5wWMRf8rBw5qdno1GK+GEG+rooX5xIhPiN8ltiz7UzZ3RGxyTvVa2gZyFSDc@vger.kernel.org
X-Gm-Message-State: AFuF++kT/b+Kz4aq4b200EV+63fAEd4MdYbBOU2Zic9ok+0QzV+ykaeU
	qAqC/F+RKUg1Lxp4TQjakL5DWSRauRbA9zQOSVzT9gRHy6SjAkQz1iyREwbuY6vGiVT5hBHk4JY
	Wbgf+1SPzjAIqpk7niZyH+xiDMYvNHAQ=
X-Received: by 2002:a05:6512:108b:b0:5b0:23cb:91ea with SMTP id
 2adb3069b0e04-5b616f41fbdmr5969063e87.22.1788969086896; Wed, 09 Sep 2026
 08:51:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831053420.1729024-1-superm1@kernel.org>
In-Reply-To: <20260831053420.1729024-1-superm1@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 9 Sep 2026 17:50:16 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ip5QM62Xc+xFAXDu8bv-nyXNmqd647AoERXO99HfkvTw@mail.gmail.com>
X-Gm-Features: AcwNN1Uf_eyrBhZR6SuyVKpiuUK5_Jw4a5iAheQZD6tm3TNZbtd_NpgtyVkt0js
Message-ID: <CAJZ5v0ip5QM62Xc+xFAXDu8bv-nyXNmqd647AoERXO99HfkvTw@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Add ACPI_MSG_DEBUG to set KERN_DEBUG for debug output
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: mario.limonciello@amd.com, maciej.wieczor-retman@intel.com, 
	pawel.chmielewski@intel.com, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 7:34=E2=80=AFAM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> acpi_debug_print() emits ACPI debug output using multi-part
> acpi_os_printf() and acpi_os_vprintf() calls without any loglevel
> prefix.
>
> When acpi_os_vprintf() processes a chunk without a loglevel prefix
> (printk_get_level() returns 0), it prepends KERN_CONT. Because the initia=
l
> header chunk lacks a loglevel prefix, it either attaches to a preceding
> unfinalized log message (inheriting its level) or, when split across
> printk buffer records, falls back to the default message loglevel rather
> than KERN_DEBUG. This can cause dmesg to misinterpret and colorize debug
> messages as errors.
>
> Define ACPI_MSG_DEBUG as KERN_DEBUG in aclinux.h (with an empty fallback
> in acutils.h for ACPICA OS-independence) and prefix debug message headers
> and context switch output in acpi_debug_print() with ACPI_MSG_DEBUG so
> that printk records are properly tagged with KERN_DEBUG.
>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> Given this is purely for Linux - it's not obvious to me if it should
> go upstream to ACPICA or directly to Linux.  Sending here for now.

Defining ACPI_MSG_DEBUG upstream would make sense in my view, so why
don't you submit it there?

> ---
>  drivers/acpi/acpica/acutils.h   | 3 +++
>  drivers/acpi/acpica/utdebug.c   | 4 ++--
>  include/acpi/platform/aclinux.h | 1 +
>  3 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.=
h
> index 9049bfee409c4..766a3080b5ea1 100644
> --- a/drivers/acpi/acpica/acutils.h
> +++ b/drivers/acpi/acpica/acutils.h
> @@ -100,6 +100,9 @@ extern const char *acpi_gbl_clock_input_scale[];
>  #ifndef ACPI_MSG_BIOS_WARNING
>  #define ACPI_MSG_BIOS_WARNING   "Firmware Warning (ACPI): "
>  #endif
> +#ifndef ACPI_MSG_DEBUG
> +#define ACPI_MSG_DEBUG          ""
> +#endif
>
>  /*
>   * Common message suffix
> diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.=
c
> index a31e07400c34d..1f2cab491637f 100644
> --- a/drivers/acpi/acpica/utdebug.c
> +++ b/drivers/acpi/acpica/utdebug.c
> @@ -156,7 +156,7 @@ acpi_debug_print(u32 requested_debug_level,
>         if (thread_id !=3D acpi_gbl_previous_thread_id) {
>                 if (ACPI_LV_THREADS & acpi_dbg_level) {
>                         acpi_os_printf
> -                           ("\n**** Context Switch from TID %u to TID %u=
 ****\n\n",
> +                           (ACPI_MSG_DEBUG "\n**** Context Switch from T=
ID %u to TID %u ****\n\n",
>                              (u32)acpi_gbl_previous_thread_id, (u32)threa=
d_id);
>                 }
>
> @@ -168,7 +168,7 @@ acpi_debug_print(u32 requested_debug_level,
>          * Display the module name, current line number, thread ID (if re=
quested),
>          * current procedure nesting level, and the current procedure nam=
e
>          */
> -       acpi_os_printf("%9s-%04d ", module_name, line_number);
> +       acpi_os_printf(ACPI_MSG_DEBUG "%9s-%04d ", module_name, line_numb=
er);
>
>  #ifdef ACPI_APPLICATION
>         /*
> diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/acli=
nux.h
> index 9b30bb9ed711c..5e2ed5e79d3b8 100644
> --- a/include/acpi/platform/aclinux.h
> +++ b/include/acpi/platform/aclinux.h
> @@ -169,6 +169,7 @@
>
>  #define ACPI_MSG_BIOS_ERROR     KERN_ERR "ACPI BIOS Error (bug): "
>  #define ACPI_MSG_BIOS_WARNING   KERN_WARNING "ACPI BIOS Warning (bug): "
> +#define ACPI_MSG_DEBUG          KERN_DEBUG
>
>  /*
>   * Linux wants to use designated initializers for function pointer struc=
ts.
> --
> 2.53.0
>
