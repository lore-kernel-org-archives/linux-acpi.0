Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D40F3128D9
	for <linux-acpi@vger.kernel.org>; Sat, 23 May 2026 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779557039; cv=none; b=dTsu/oVoMHByW/s0SsS8GDnH6qXeYzzSb3gO2Vn+E5yOW/XT/4IAUMiHCS+Z3chSr0wAGgUEPHuX3CXegqFi2/2Vcs9C2JDqVuI4PnGnofAq8w8JGyDc1dyNSusLjmJjIHwTY48L88TTFvIlH5714SXl/QmtLgmlJmRIX+SUPKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779557039; c=relaxed/simple;
	bh=Gx5rPnX98QpHZ8+4LYiyXp55ckB8uClTPkmWKtpel1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQ5kwRdeSIg6TkGKJX1CCVi6foymKo644NACLw+zyRr9Gg0UDPBdRvoocj2v//+QSh58Kga+gG+w5a2hgxpa8hctc/U5tsAwf3pmx/1oEjxzl6hvKGB/Uk4GLA9PekbsJA5giiH+3g2rpDpRIvjJ+HSlXBDJ2saAKPwWZPZA0EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/4zrVGE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/4zrVGE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE1F1F00A3D
	for <linux-acpi@vger.kernel.org>; Sat, 23 May 2026 17:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779557038;
	bh=0OZeTR4vprvZ9MDYo0BZvK6k27VrOlw9ROtRK0dbYKc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=b/4zrVGEXIjK+I1JtyADjkauCRs0Ju2gHFhqoTJbPgia6P4Vk43G5iJEF9CnV0uhu
	 riwHmkc6+x1Bgpt1W/8+sGtZvvJJtXHZFS8m+QvmwfztsBpkkxmDb0rgt879k9x8Jd
	 8oWspridkEE0MOK3X9a3s+5qkah4OuQ4i39RuP7MYkHNiST4HOlvqsvwmbfX3P5cQG
	 vsctvlaKXRFs4EZOL3TdCbHxTQ9HA1R1HNNb65HlivEdm3gsOU2vdxGv+23GDeWZmY
	 1UdAZynQgWBXgBv0tfNsZCAIIDZTcbn6WmWjp1otHCsH6DUwrqJb9CibJuwk5d9noa
	 NGWGpslnzZrEA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a995ab70d1so10645972e87.3
        for <linux-acpi@vger.kernel.org>; Sat, 23 May 2026 10:23:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+dQnPAEOW2FjTiFSQeNeJ1wURQzlSu7akRtnlT5TlFET7LWbgOMVQZ3Ycc8xmHBLCKoGV+Ocnu7jJp@vger.kernel.org
X-Gm-Message-State: AOJu0Yz34Qv5r8S9up/wfHA3geajkyCvrECpsFMa24CkyeV6XxEtbvfv
	wO6AkTiOkJvT7sfYxQBlrjLAsE0O1GVqhbAjdVJV4IFdqSCUPR3BVB150hDytIqymo4J72CtS3/
	CknUUc/kXKtEBP4Z5D06T/YHOuhYyPws=
X-Received: by 2002:a05:6512:6c6:b0:5aa:106e:5dd5 with SMTP id
 2adb3069b0e04-5aa323aaf36mr2453202e87.10.1779557036855; Sat, 23 May 2026
 10:23:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0ikd24Vj3H=2XAGwwHtBudDXJumL4H-whu1GgU-KjMnmQ@mail.gmail.com>
 <20260523000131.7086-1-sakunix@yahoo.com>
In-Reply-To: <20260523000131.7086-1-sakunix@yahoo.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 23 May 2026 19:23:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j5U=+vPe+RaFTd8tPwfaDN34q5jj+KFwEY0PtaZx-yLg@mail.gmail.com>
X-Gm-Features: AVHnY4ICoWRkvJW3fHZZwOgMLVpkbeC4bNNTdNLqZNbDGg6Ekte6Rn1tLf12NXM
Message-ID: <CAJZ5v0j5U=+vPe+RaFTd8tPwfaDN34q5jj+KFwEY0PtaZx-yLg@mail.gmail.com>
Subject: Re: [PATCH v3] resource: Downgrade "resource sanity check" warning to
 debug level
To: Manuel Quintero Fonseca <sakunix@yahoo.com>
Cc: akpm@linux-foundation.org, bhelgaas@google.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, 
	hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 23, 2026 at 2:01=E2=80=AFAM Manuel Quintero Fonseca
<sakunix@yahoo.com> wrote:
>
> The "resource sanity check" warning currently triggers on certain
> systems, causing unnecessary noise in the kernel logs for users.

The fact that it triggers at all is not a problem.  In principle, it
may help to diagnose a functional issue.  However, it sometimes
doesn't mean that there is a functional issue, which is a problem.

I would say something like

 The "resource sanity check" warning need not mean that there is a
functional issue
 and in the cases when there isn't one, it is just useless and confusing no=
ise.

> Following the maintainer's suggestion, this patch downgrades the log
> level from pr_warn to pr_debug.

Instead of the first part of the sentence above, you may use a
Suggested-by tag (pointing to the person whose suggestion is followed)
and the "this patch" part is redundant.

I would just say

 For this reason, downgrade the log level of it from "warn" to "debug".

> This change reduces log clutter while keeping the diagnostic
> information available for debugging purposes if needed.

The word "change" can be dropped from the above sentence.

> Signed-off-by: Manuel Quintero Fonseca <sakunix@yahoo.com>

It would be nice to add a Link: tag pointing to the discussion on the
previous version of the patch.

> ---
> v3:
>    - Downgrade 'resource sanity check' warning to debug level to reduce l=
og
>      noise, as suggested by the maintainer.
>    - Drop the previous DMI-based quirk approach as it is no longer needed=
.
>
>  kernel/resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/resource.c b/kernel/resource.c
> index d02a53fb95d8..e676ea99c93c 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -1859,7 +1859,7 @@ int iomem_map_sanity_check(resource_size_t addr, un=
signed long size)
>                 if (p->flags & IORESOURCE_BUSY)
>                         continue;
>
> -               pr_warn("resource sanity check: requesting [mem %pa-%pa],=
 which spans more than %s %pR\n",
> +               pr_debug("resource sanity check: requesting [mem %pa-%pa]=
, which spans more than %s %pR\n",
>                         &addr, &end, p->name, p);
>                 err =3D -1;
>                 break;
> --

And the code change looks good to me.
