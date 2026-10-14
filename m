Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F554FC8E6
	for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791977351; cv=pass; b=medTh0qrcAB59sI+qy3RB9gUJx0qJv1VDTj99lHBgN9vVtGQUJLVyfNm8dvdpwt7TwNSaf55zwKl1JkI7QIAyoFci4VzXjeWKjarzJwTRKm087g8bKJ3vmIgaaliBlchyc2FASKGLW9ySs2BV0USPLJOVBiw1h/fOOJ4Td+c7K0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791977351; c=relaxed/simple;
	bh=Bm8IXeZCCjjHRHqufoiH0uSm7tIaA4fZ4x02DGLBDgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVqB/6xHHNjf60I7D//KsjbOpZQMAidfRy69frq+P1Vt2GnPVhecm7l2GEqJA/WKfpMCgb4lNg5a37CtJIS0VUVoIeMrQTZ5T1Q/QjJZ4HtztPdcRomuZIQjN8ziRJ5sobc/muY+ECoPnUyoODPG5I+dBKQslKOKL6R7rbGj5mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkAqllS7; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkAqllS7"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-35159e0092aso446331eec.2
        for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 04:29:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791977348; cv=none;
        d=google.com; s=arc-20260327;
        b=eYqHGASQ5pfoNqk7oQ1UQG3vB8doFILsHNkX22+0b1t0CjteyDoYY8SEmmcUTADR1S
         OB50dpud7XQ6hB6AnXeSec8MDnruvqBCqsI9E53pE023Dtw3xMg/UyamRIPFFLNxoK76
         LuzPNC7KplmaDoBLjGhLCBQ+3vA7y4jXWXwd6VgSzuJVnvVXAbJymEWFN7jq86nch7nB
         2qtzaQfWeK9Zt8Vf1rgMlBeLGAhie1yBuFyY3OPElUO7seL9wogfkSAvvU0tU2ScShAF
         Odqy5RBrEajx6+LsYE2QzYIqonLnZR1G64FEabw0aF809tFc55WL4yeN2vcv3V7b3ZVe
         Lm+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xWJCwZOmpC49YtbA7QzlowrBvokYI4WD90uvALsrwIA=;
        fh=rZWPlpnah4yq5DLR8XorlgWFf467wHok13KqPNLv5go=;
        b=ZUZtESQv8i2T3h4ugZI6WwX/Etxd01p1mnpZ4zaA1pSm1ReWwNow4E7BkTG1W0Z2Rv
         DKvHMoyT8XW7BuHK32qhsAc6M8dv2pvaG4ICMkZNRAc05RpxMD2JZWMFz+SM51mEUe5k
         jcDvGScko/aDnOVnVYw1KR4pQlJCvee1S/Hb479ZBH81SRdRDKF03hyqe0R+LD8ByIHS
         +UwMFy2fymREqhM2lw3dQCWEQfoFEZwYum6RHVGj+j6JUECfJaE0EfYNG9QKEUpmKy88
         1v0K6j8W2jTXAlm5wimRAz8RAdPYD638oXGPYJdO6xSy3VyfSCizYsa9C0V1uH6BxR38
         8jyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791977348; x=1792582148; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xWJCwZOmpC49YtbA7QzlowrBvokYI4WD90uvALsrwIA=;
        b=EkAqllS7uOOZxDGJ4I1yKdIi3WQSBbyUhPsWLoVzgJERDBlfP0X9cEpWzjyHAR90JC
         Z1zW2YqVc7X46XPiuAerNf9mNnAJ0uUF6PLz0rzePzi7U1lf5J9vz/gZr1IuRwk27MI/
         4/D886vhZESIUjDPJZRvHbQYWiiMvCS3NjhX5siJV1JzVFlBVMBE4d5Q1ZOlRDw5uGo0
         qEQHzjWEYvo+agj8c1xw4Nkq2SVQg9Ys3jvU8s3NkIQ4fYLQcX3kMyght8wz2N51o7tV
         AXXBZTinlSID6wvgzNqIrr0dJv5ZGB14N23uEZXq5jf7doeVho73k08XFK/CJX/hTW5i
         pPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791977348; x=1792582148;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xWJCwZOmpC49YtbA7QzlowrBvokYI4WD90uvALsrwIA=;
        b=PitodjqLijyi/G5uE/ezHcBail8MBOSZpz2K6e0gJ+zUXvLn5V+MYXej5yzklqeKZd
         JujwfjSgXmMlNnvsZ9dYC8dqX/z4tPQiiUw3E9vbLdTPQlbrKGvx9ndw+Bl/U5DjMOqv
         ySZilFcaTfQKznBdnErpTyBZRHm0D5pFlJ8BT3foHOpgGrZl+cUuqjt8kKlK7zvVd8x2
         +xPauvEwKWjajfN+dUzQqodRx9essn9Z7Ykf0h00dUHtfYe1z46FPXX5Kav7N92QlYeO
         IR4WBMxnS+5PYchkXXbz6P7bVUkDJ00fKQTS7CDKhZFnq+/A+WPjv6f+VddVdntIpVfx
         OyKw==
X-Forwarded-Encrypted: i=1; AKwUvBx3XJJzXWsb4H/xCkgNkkU+jNLrM1osycT/0EbpztfeaNguOXeRtI2jkvJUjCW0fkXdxUMwTNNgcVu+@vger.kernel.org
X-Gm-Message-State: AFq9FYIssrrdo8yBJYfZ1lifhKPPg5VryDlNRAkG5w1DSaz24hAeNLcA
	6j5kwZ2/dG8JUQGT6uHtD5UNFNU5AVnzBqJOwna04VGV3X7jk46oppIr/utIBTXs49uuMfxei6Z
	wm1rk/Va9vY9I6ShujfAPv3AC9JbjuCM=
X-Gm-Gg: AYBFou0Hj0eLOzYZvpwxpUFSIE1KRIEQ6VgoTa4MYM7HKj5x0vS/Qv9EDZ+zAtolHQy
	HIpv8cuHCnLSe9xRC0G1LB+4677FzRlPRVCZzdaXEZ6eLtWAF+SmYb2lgRM0TPWNloSkZTGXrHc
	Ny0FmWgJknM/5wMlLoqXL9f8TeB3Dg4GahHU0ji6gHVy9UKjh2WpiwjtHI5GhVo/hamWnN1qppP
	253P2w1eRMvtE4ebgH51B1bgLMwdsDAajjB5wl65jZRsRR2c84xdDzhEVzAUnfO2qsb6VG/hIeZ
	dAkaWTpV92AvhPMiP/YRvMLp286f7+IBQ1vnP9qKd5kXp44P5JSYwuT7W9cYImfAbV0YO3xs79R
	rnOEjTISkssuSXqrKlPXJg0Gp6xiut07BVIByEIIW+YXVvM559a2HzNsCQwgsJRrr1Y+3vq85eq
	WXWFNySg2zJ5SqZzdbj5kcvl5eIO4sWIZ98g57mjflEyMU/O1XlnM=
X-Received: by 2002:a05:693c:6215:b0:35b:cb8a:8ce7 with SMTP id
 5a478bee46e88-35bcb8a919dmr14326600eec.1.1791977347656; Wed, 14 Oct 2026
 04:29:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com> <20261013223946.1836757-2-irogers@google.com>
In-Reply-To: <20261013223946.1836757-2-irogers@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 14 Oct 2026 13:28:55 +0200
X-Gm-Features: AclHuK8qVHO7HVQy6LgzcUgjYcQf3EimC6SJcN58PVqcWVdOf6T45eXZNeTLsEY
Message-ID: <CANiq72mLUh1JB=9e=tqStuL_H3=Ormx5v-uFkCDp-0zZm7tBrQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] Compiler Attributes: Add __require_explicit_initialization
 macro
To: Ian Rogers <irogers@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Viresh Kumar <viresh.kumar@linaro.org>, 
	David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
	linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 12:40=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> +/*
> + * Optional: not supported by gcc
> + *
> + * clang: https://clang.llvm.org/docs/AttributeReference.html#require-ex=
plicit-initialization
> + */
> +#if __has_attribute(__require_explicit_initialization__)
> +# define __require_explicit_initialization __attribute__((__require_expl=
icit_initialization__))
> +#else
> +# define __require_explicit_initialization
> +#endif

The LPC slides mention Clang 14+, but from a quick test in Compiler
Explorer and a `git log --grep` on the LLVM repository to confirm, it
seems the attribute was introduced in Clang 20+, no?

If that is correct, then it is not available in all LLVM versions we
support (LLVM 17+), so we should add:

     * Optional: only supported since clang >=3D 20.0

With that:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel
