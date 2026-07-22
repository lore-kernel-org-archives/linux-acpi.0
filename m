Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3DD27F017
	for <linux-acpi@vger.kernel.org>; Wed, 22 Jul 2026 13:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784725965; cv=none; b=BxVM9R/OYY01JGBQr45i0mRUcI2NglcKMxrrzIcG+2H8NcWP6MfnN49clnnZcf6Y0Fa6AqeMtShqo2jnGR/HnElTfY8HI9srNfB9P/6C3wdbA9r0tFPSj2nbyTmBQ/0gQg3YIORr1qfWBDC9xZhgJP0nB1V1vM4ts9a15xeTENY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784725965; c=relaxed/simple;
	bh=LxPEUSvomf+1vqaYvpYxMjHdbT0dgeUXS2CQL0dqS8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UdKDiz9HO6D9YPr3CDDbZDJPLHGCYrG1sVIcoEvwZBoAYXWBCittE8wT1EgLf+7kumPAhJQ21k6YLqaogQBr7+o+AMRjNOMO9JIBbcmuaiaQhwmEEEWUL5seuVkvxlWLmMzKGH8GWasZnMMvVoX4+Zn3WH4yCW+r4G9ASMSMqKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nou//EyN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nou//EyN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3AE1F00ACF
	for <linux-acpi@vger.kernel.org>; Wed, 22 Jul 2026 13:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784725964;
	bh=1sV5F8g8B2FIbfA/eDA0WOQI97AyvvwazMkpvJft7Qk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Nou//EyNCO95XJwDTexEA4PSFdeZYxE5OXwH5Etb6TA308WYQApXBMwz/unOqeFwL
	 p1DStUA13qSQQgHjtRinTKbmAqdxeKLvP7FjN9jLOzcQWga6xOqMEsC4+S0QRN6WMz
	 hSu33rnjLrXARdRcuzszNQ4wJGUvVEQT8t9e20uJw+zrNx0BbLgE5LScNiXTXc2eew
	 94hAhKfVhylZq5p1+Kn1oXtG+FgJaXFfnW9FJDCHB4SdIVraJFubRlGhF6urYURd2H
	 JdNowD1tUlrQX9vJ05lDSNQTqXHWHLzpNNnXTOZWrHO6WaNYxzjConlgYwQWN6hMir
	 BxU0W0m7lEMrw==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b0117d49dcso11487392e87.3
        for <linux-acpi@vger.kernel.org>; Wed, 22 Jul 2026 06:12:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoGqndZl0JHFhfUHgWEoZxK9lZ5yCJgJMothOU7xjfMqB3IIlNXzroqVOwP/w6vQP3y3Pnv8SU0gA0l@vger.kernel.org
X-Gm-Message-State: AOJu0YxIFgF2jzl1jT3hg4qd+3LU9XYtjyXi3gHD/pBafZ30FjbBNkh+
	8ThF2276yHw6rTwTLUli+1wpR2rVcog4FEFtc1dVV5z3OKKToo+JpXMuEGoP5iKHyqZTW6GvqNg
	AdRzzHQE5Xx2c/Gx3Cv1NT6FghuI1TSg=
X-Received: by 2002:a05:6512:ba0:b0:5a8:757b:80ee with SMTP id
 2adb3069b0e04-5b28f860f49mr5197295e87.17.1784725962282; Wed, 22 Jul 2026
 06:12:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722093825.1030594-1-christian.loehle@arm.com>
In-Reply-To: <20260722093825.1030594-1-christian.loehle@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 22 Jul 2026 15:12:30 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gXZ6dodT0-LYKdwx5m0oxWxY55WMe19=Z_p-Nn-4fdsw@mail.gmail.com>
X-Gm-Features: AUfX_mzcwMSvEBJaBRqr7WmO9U_xWg0FaRIX5AZLPJIt-aKsQ7ocrTUogE-yh64
Message-ID: <CAJZ5v0gXZ6dodT0-LYKdwx5m0oxWxY55WMe19=Z_p-Nn-4fdsw@mail.gmail.com>
Subject: Re: [PATCH 0/2] ACPI/CPPC: make policy-limit updates safe
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Len Brown <lenb@kernel.org>, Jie Zhan <zhanjie9@hisilicon.com>, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, Pierre Gondois <pierre.gondois@arm.com>, 
	Sumit Gupta <sumitg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 11:38=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> Commit ea3db45ae476 ("cpufreq: cppc: Update MIN_PERF/MAX_PERF in target
> callbacks") made cppc-cpufreq submit policy bounds from both target
> callbacks. Two correctness issues remain in that path.
>
> ACPI permits the CPPC controls to use different address spaces. Fast
> switching can consequently enter the sleeping PCC path when DESIRED_PERF
> is directly accessible but MIN_PERF or MAX_PERF is PCC-backed. Fix it by
> doing the simple thing and only allowing fast-switch when all controls
> are directly accessible.
>
> The policy bounds are also read without the policy lock. Because the core
> updates policy->min and policy->max separately, a lockless reader can for=
m
> an inverted pair. Patch 2 sanitizes that snapshot before converting it to
> CPPC performance values.
>
> Christian Loehle (2):
>   ACPI: CPPC: Check all controls for fast switching
>   cpufreq: cppc: Sanitize lockless policy limit snapshots
>
>  drivers/acpi/cppc_acpi.c       | 22 +++++++++++++++++-----
>  drivers/cpufreq/cppc_cpufreq.c | 33 +++++++++++++++++++++++----------
>  include/acpi/cppc_acpi.h       |  5 +++--
>  3 files changed, 43 insertions(+), 17 deletions(-)
>
> --

Applied as 7.2-rc material, thanks!
