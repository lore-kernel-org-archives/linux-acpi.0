Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C28B3B7744
	for <linux-acpi@vger.kernel.org>; Mon,  6 Jul 2026 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783360691; cv=none; b=fpWReDZ+e/cTmfePdy9gaAvGZtfnTBxnKW/QqvMDipIqcd6L2GjXkr9yIu+uWLZ38283T2a0ZkAeZAkbzCAp5DtZmeybxlOr8ugwCy1yKsFu6LPF2JXkJ3gqCkr0AvFfGWQh173jTIJ9mWm+lxGTzhVsL9mwweU91mhOHMMqq8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783360691; c=relaxed/simple;
	bh=7+8Dt3E5AlQdtYHe0YnjbSy8g5QolVaF9Ug1AThzw6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkxIR8a/+Jd/ToYdZXHKXw7Cuap7q27/Q6Z2mSzYFnkaWrpRydmnS/b1rx7tg6QszoOkuMrinPllTInmCWJu4sYChzLub2W7w7GGpYTQq3iBlwNI6Wob1cpi5Fk0xKze1o2j8kZ9eG8CD4VxPz7XdLP+zkvsR8gi88ogHt/TJB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRiOTbRj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRiOTbRj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4721F01560
	for <linux-acpi@vger.kernel.org>; Mon,  6 Jul 2026 17:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783360690;
	bh=zvqCZpW6ehW5/EAJOze59do9erFs6tHYQwa81Plq9ms=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TRiOTbRjpDFDduGaHwmPG6rKQcyx1kTwRnhyWDlKHv/FSu62ZJs+QD9f74i4ZaGmJ
	 CYz0MDPeszLHVPiBeqkGcFKDSimazLJAA1DqBJ5Z6RR5X/nF2JFlofX0KQbEqWCEG0
	 tgZFDA1W6LQleyM3YD6Gpe80gJhr+HiVSCU8ZlEMALmcTzccIH07acANXHiow4udaR
	 xwJkMeMPTBT0r460KggN6mvrw79q3eFrXWD+G18nrernKHHGwVsciU8OMnYt45iLgd
	 EowwnOq9O+Ue+OpX0QlfauzCb/k3j8oRd+YB3IBUUNnaXkWFAXZgiaCtQMyvynrZA/
	 ZL8KtzXyJMxsg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aeb11c7347so2493755e87.0
        for <linux-acpi@vger.kernel.org>; Mon, 06 Jul 2026 10:58:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro+QUAMHjSPHCGT6kWkAsvPnjnAp5NHgG4u419bivCc4Nr9bNEp4e5OaCkdb/jV3J4/qGHeQ+ZbzHXP@vger.kernel.org
X-Gm-Message-State: AOJu0Yx47QQEOTmipxFFGw3izXRBr1oTio88EOlB606NwF+fLdO1gy/8
	KrxywvwEvK6dY7oH4Gs8fLMI739V21psGW4UvFvqoYde0Tm9pgfOH1tCS5KpOVa7hMm4RC403Pz
	DARNxH4BajSGMddfXP/vk53GQSnt3wEo=
X-Received: by 2002:a05:6512:1548:b0:5ae:bd1f:c835 with SMTP id
 2adb3069b0e04-5b007b77aa1mr261552e87.16.1783360688610; Mon, 06 Jul 2026
 10:58:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703041329.2797584-1-ekffu200098@gmail.com> <20260703041329.2797584-3-ekffu200098@gmail.com>
In-Reply-To: <20260703041329.2797584-3-ekffu200098@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 6 Jul 2026 19:57:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iq+SjMvFVwsfwh0Zyp+h5MUJ7eeejQAOir8ssSu7yO3Q@mail.gmail.com>
X-Gm-Features: AVVi8Cer-fCztyBRN_23Y60i679-KEiFZuAbrTyLd-3-YzEE4LLFETmiJwjEoQQ
Message-ID: <CAJZ5v0iq+SjMvFVwsfwh0Zyp+h5MUJ7eeejQAOir8ssSu7yO3Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] ACPI: NUMA: remove redundant numa_nodes_parsed node_set()
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: rppt@kernel.org, akpm@linux-foundation.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-mm@kvack.org, Andy Lutomirski <luto@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Danilo Krummrich <dakr@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 6:14=E2=80=AFAM Sang-Heon Jeon <ekffu200098@gmail.co=
m> wrote:
>
> numa_add_memblk() now sets the node in numa_nodes_parsed itself, so the
> caller's own node_set() is redundant.  Remove it.
>
> No functional change.
>
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  drivers/acpi/numa/srat.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 62d4a8df0b8c..5c407dc6401e 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -399,8 +399,6 @@ acpi_parse_memory_affinity(union acpi_subtable_header=
s *header,
>                 goto out_err_bad_srat;
>         }
>
> -       node_set(node, numa_nodes_parsed);
> -
>         pr_info("SRAT: Node %u PXM %u [mem %#010Lx-%#010Lx]%s%s\n",
>                 node, pxm,
>                 (unsigned long long) start, (unsigned long long) end - 1,
> --

Applied as 7.3 material, thanks!
