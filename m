Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296BE3451CC
	for <linux-acpi@vger.kernel.org>; Wed, 18 Mar 2026 19:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773863845; cv=none; b=YnaZjrz0ZmYKDh9kwVy6L12diph/1V4hI9ztWlvtDMyTNEAk50ec9EfD7idUVsOv0snYr4A4cIzEDyNbL2idU4+T2VGLS0SqsatLUgRz8qve0quQ7wJcToYCi4yul1rOBFdKhY87NoY4ecYDUtM5imNLD8iM7NIAXP1yXpLmqNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773863845; c=relaxed/simple;
	bh=kXWKFpg8pR8jlWCNgu3kkvqS3jucOXQ3Xc+oq1GBQwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g/A3o7TujMckzNUM8e1RkeR05bxGMTiz6gnNprOoaUeEtZXNaLwwLMWhiSScbh+pnZcg3n+N6X9enaKCDQn9gxzIyhI3GGwZBlI6e1nYbOzJRKnlgmssdvLkfaznSRNi9GQbn1Ztwg7oTPZ+vxXFtGVpcgIlK5P6jYp3DNhlOsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8T1lptl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8T1lptl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5727C2BCB4
	for <linux-acpi@vger.kernel.org>; Wed, 18 Mar 2026 19:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773863844;
	bh=kXWKFpg8pR8jlWCNgu3kkvqS3jucOXQ3Xc+oq1GBQwE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K8T1lptlySNPmksMghpS5CMvmP6YujMpO+FUsVyYvsmesXSEz+WvD5BOWv6dDzS42
	 u0w0mA82EJg9V7O8GXpKDOmCp3DmWXtUkcCXvjG4JGPliDA1+Y2JgzuALtPkl9yNZp
	 K/TZRl1xXWGt7758TBz6XTHCOlO6ZnZWhxePgAOSaP+738bjwbXqI+jdzuiZBuVqq4
	 OA21LBx9DTklCaU8HvxapHhwJ3/AX3BES5LBNj1fCb5Lrn5s1J3YXdJPzpp6tOBxbJ
	 D4rTCIzk8JlUFGwLT1BIMcJaz91pIfV99QPTT/ZcxhJWCI+mN6jDG6kFjMFZf8AbIl
	 V1eTAoadgeofg==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-404254ffe8aso158533fac.0
        for <linux-acpi@vger.kernel.org>; Wed, 18 Mar 2026 12:57:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVadSFyehY1Ikb1ONMOUKmbA+1sAXRstThhdezpT2IAmOsx7EEDqcawrCAIlp3OF2G2o08HRb+hRBag@vger.kernel.org
X-Gm-Message-State: AOJu0YyGHpFjJSz7XO62U1qdE8um2RAatB3kW6lhjAd55bEAJlaPAtTs
	Y93ArYJKDty4NmU/0O6PTq1xkbbN0NUANW1kUVwOShOkEHFOEd8KZkGIiuGDNWYEZrxSHIVpg7n
	O/AB6/KrT/Y/jEl523GcWKH7NbawS2So=
X-Received: by 2002:a05:6871:5227:b0:404:3f2b:fcb4 with SMTP id
 586e51a60fabf-41beff8259amr548554fac.25.1773863843838; Wed, 18 Mar 2026
 12:57:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317080218.1814693-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260317080218.1814693-1-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Mar 2026 20:57:12 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i65oQXkCQHtWTmvQYVJ=f6Q_7z=aKASS-DCOi1ppkmtA@mail.gmail.com>
X-Gm-Features: AaiRm52a6jgl1_OWm48p4RK-XaojPsKzdBLXMxsktFaZzPFfSzMC97DhMk8QXnI
Message-ID: <CAJZ5v0i65oQXkCQHtWTmvQYVJ=f6Q_7z=aKASS-DCOi1ppkmtA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ACPI: processor: idle: Replace strlcat() with
 better alternative
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 9:02=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> strlcpy() and strlcat() are confusing APIs and the former one already gon=
e
> from the kernel. In preparation to kill strlcat() replace it with the bet=
ter
> alternative.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>
> v2: moved to scnprintf() to avoid GCC warning (clang was and is okay)
>
>  drivers/acpi/processor_idle.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index 45b5d17443cf..479995a4c48a 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1010,9 +1010,7 @@ static bool combine_lpi_states(struct acpi_lpi_stat=
e *local,
>         result->arch_flags =3D parent->arch_flags;
>         result->index =3D parent->index;
>
> -       strscpy(result->desc, local->desc, ACPI_CX_DESC_LEN);
> -       strlcat(result->desc, "+", ACPI_CX_DESC_LEN);
> -       strlcat(result->desc, parent->desc, ACPI_CX_DESC_LEN);
> +       scnprintf(result->desc, ACPI_CX_DESC_LEN, "%s+%s", local->desc, p=
arent->desc);
>         return true;
>  }
>
> --

Applied as 7.1 material, thanks!
