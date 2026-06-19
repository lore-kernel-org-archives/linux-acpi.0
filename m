Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBC029D26E
	for <linux-acpi@vger.kernel.org>; Fri, 19 Jun 2026 18:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781893233; cv=none; b=inwMDdhilqRjFFpJNrm7inkFYsnxnevdnp8EZG7Rrq5GhtnDspUxpMw2CQhn7AZobxZRDnlpljgo76rA8DwIIhSoCAAUemUyO8EGri2J8lMI9QSb2KYCM552XZLL95TbTYqA2R54Vm6qgosuwCvIOtOBaGVpvBzZSOUfjqOWoOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781893233; c=relaxed/simple;
	bh=1nx4sRIu5Fni1Iy0Wkwz6+dhHE/NzD7BGmrXCGMaXTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCuHRYLD4bcIv3h6QqZoQx3X3Lg43pj6bjO2PCgSilnj6JbkKi/6T+729W7XKldSeXHoi2r/dsyB6tRdl8iTHRijDYta0JKjYV0c18UhQuTdZ9+vR0//zpkk+fyrQYyV0kcfmtTLrkMnIGG4OV+XxEjNGcadQIUeXKj9yR4rkdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leQ2Qv7m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leQ2Qv7m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408D41F000E9
	for <linux-acpi@vger.kernel.org>; Fri, 19 Jun 2026 18:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781893232;
	bh=/R58nQtB2XBavzU/Z4xCtwlNmIx+i+BxDLgStnJ6yT0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=leQ2Qv7mTY1EHCh/R0UfHLNmjAQfPWex0PW42u6rkdyZXiE/cVG/+ab2eikcICAAD
	 g3Mpek+eyN2b/+YlNoqljF6ZzRd+WdUrQxFy59PwNYGoO+fwGKAVU7Dm3rYxSghidl
	 OCgY1daVg6iu8ARhUdLOHXdC9RxEHNmVjsI9LfuGQDedsdN3H1LcWc0Br5AA/uxkuz
	 YUzWlEAnCjw1mIY8ZdGzMEMP/6LyhW2UrbcMHAf2/E+f4it3DNrkcpB+W3QbZQe1wQ
	 iD+3OJbi4rVMlV8bwgKISMt6p0R+t+bSx3LNR0HQNEQOZNtk8PwPZBH8mFn0pJG279
	 syOF3lPP8AUXA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-399389dae7fso24498661fa.0
        for <linux-acpi@vger.kernel.org>; Fri, 19 Jun 2026 11:20:32 -0700 (PDT)
X-Gm-Message-State: AOJu0YzquynltGn8LROXcpYw67GZXa7aUVA96t1YDVLB4GauXUKUbkVq
	QhjO5AFzyVLyDuFfv6gyXEYJtiQTkFKHtDkMvIfFHZ9esZGV842XMf3qdY2xCWvcTzIZYJNPMUd
	YGixmcVG5D621d5vjkQIwT7Of+p7HpLI=
X-Received: by 2002:a2e:bea6:0:b0:38e:8c66:c02e with SMTP id
 38308e7fff4ca-3998b700344mr12723251fa.4.1781893230726; Fri, 19 Jun 2026
 11:20:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611142518.77343-1-zenghui.yu@linux.dev>
In-Reply-To: <20260611142518.77343-1-zenghui.yu@linux.dev>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 19 Jun 2026 20:20:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gP9RmQ-gfSu949=g3yMJFBZ2MbKcVGxrS0CkfUfmJJbA@mail.gmail.com>
X-Gm-Features: AVVi8CfDhncgfTrY1rWBLEhzBiyJCe7gu--NbYPBtENkuM9i4VFHHhI53YCqc0o
Message-ID: <CAJZ5v0gP9RmQ-gfSu949=g3yMJFBZ2MbKcVGxrS0CkfUfmJJbA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: sysfs: Fix path of module parameters in comments
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rafael@kernel.org, lenb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 4:25=E2=80=AFPM Zenghui Yu <zenghui.yu@linux.dev> w=
rote:
>
> The correct path of module parameters should be
> /sys/module/acpi/parameters/xxx. Fix them.
>
> Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
> ---
>  drivers/acpi/sysfs.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index a625de3c3c8b..908cc5c7e643 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -17,12 +17,12 @@
>  #ifdef CONFIG_ACPI_DEBUG
>  /*
>   * ACPI debug sysfs I/F, including:
> - * /sys/modules/acpi/parameters/debug_layer
> - * /sys/modules/acpi/parameters/debug_level
> - * /sys/modules/acpi/parameters/trace_method_name
> - * /sys/modules/acpi/parameters/trace_state
> - * /sys/modules/acpi/parameters/trace_debug_layer
> - * /sys/modules/acpi/parameters/trace_debug_level
> + * /sys/module/acpi/parameters/debug_layer
> + * /sys/module/acpi/parameters/debug_level
> + * /sys/module/acpi/parameters/trace_method_name
> + * /sys/module/acpi/parameters/trace_state
> + * /sys/module/acpi/parameters/trace_debug_layer
> + * /sys/module/acpi/parameters/trace_debug_level
>   */
>
>  struct acpi_dlayer {
> @@ -269,7 +269,7 @@ module_param_call(trace_state, param_set_trace_state,=
 param_get_trace_state,
>  #endif /* CONFIG_ACPI_DEBUG */
>
>
> -/* /sys/modules/acpi/parameters/aml_debug_output */
> +/* /sys/module/acpi/parameters/aml_debug_output */
>
>  module_param_named(aml_debug_output, acpi_gbl_enable_aml_debug_object,
>                    byte, 0644);
> --

Applied as 7.2-rc material, thanks!
