Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247DC3C10A8
	for <linux-acpi@vger.kernel.org>; Fri, 31 Jul 2026 11:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785499127; cv=none; b=AqIQpJFvvTiyQ15O09xy1QJ1oyXi4QCHyBZjXc7l3johlryllFKPDlZguL191A7xhXJEE5UKdzncHWVhcGgY1Sv7Fz+KRTbg3tiK7CttnViFnU5KKdPtTFMl3Gb2VuW6aidqSaJJ0y+v8bca1y4IAbHBeI3rOqrs4pPI063AaME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785499127; c=relaxed/simple;
	bh=TSHnYULxyvbq9DzZiDKlzVyNC8UA5li7Z7zBNBOywgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EqiSrdIsIYYSDY3bS4nOGnareH8sCcqOfKLRrLzgBxK9V3qM7D0JVXWHcAXymJxV5PLYICPoZKPW0wnEGvx4rLp25/onzRgkwHwr7tUyu03X0rd/JahXtZmo9EzAzd/9sxBaT10AOeVsJCD+mrrun6lwuttJ/oZOLzfjYYYqisw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlIiBTI8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlIiBTI8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D471F000E9
	for <linux-acpi@vger.kernel.org>; Fri, 31 Jul 2026 11:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785499125;
	bh=6lIw8wVhSRWsFjOVUmbBv7/tJLVQbpSl87TRfum+qgc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DlIiBTI85zvFFHNh4uEOiklku7rTmcncwPghKXGyD+TtkpNzjXJXM/EGqzJqpVI4j
	 A0IUA3DEtjbc8HeXh6v9c+GZBh8qAz2yuj7ioKPAKrOh/dr4m3VJE6e4YJdluGbosh
	 esy9wkmFVBmMn2UsTebrkvMJjN2ZK1Ml6539ccYTrRB4tW/V/6jTY8VBoGrlET/4qT
	 9jdyqxqrxjdftYvYhAsKH8wGGrSTlwZ84jaz5dvafqUPuJWo0xHTYp0FZj4Q4SyP/R
	 MlPqK9L/2LwbOIzmM+JXc+cykpmvsnXCXIeyeLKHTAJt3xX4ow+934V3DtOeSTc9Nb
	 bIxoOFDBa9+yw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b01cb18515so782930e87.2
        for <linux-acpi@vger.kernel.org>; Fri, 31 Jul 2026 04:58:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Roht5g9VQsNAHYGqrVEVPZTp9yJ3b9i+V8GHfpiAfsrkAj6Qas6j/oVUctg6AryXvIb5+L1DEH6r3h7@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2gH8YIEGblYbAMqqs0reAqEd/FeESx/72pUzOXXDABECblvUm
	TUbT+7mjtXGRgtCw0+HYL++H3eqWfn8T9zNi3kF3Q7rg2b4PqwYNXoGB30YvOy82eR8yIt/Sf9b
	lNi5bI4b6AzPOZwUvvdFgM1s9jw6F6Ok=
X-Received: by 2002:ac2:4bc6:0:b0:5b1:5ad4:8374 with SMTP id
 2adb3069b0e04-5b2e201220amr464329e87.42.1785499124363; Fri, 31 Jul 2026
 04:58:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3353bdf3-4f33-44b1-809b-b0378bee5816@gmail.com>
 <CAJZ5v0h1kqDEBYk0k05rv6f2SJ7g+TN4FhBDJYZSVUctu-0FdA@mail.gmail.com>
 <daf0bb9b-246d-437d-87ca-16706113b201@gmail.com> <CAJZ5v0jByxtQ2tmNm_ZyyBnDMBNjuqQwD_367NRyGNzF7wQtRw@mail.gmail.com>
 <7792f017-42b0-4a09-9941-5259138e21b1@gmail.com> <CAJZ5v0jCFFNuG7WtCE2CG+hP=YNsYMdXH_945QgkgAUcr4Lryg@mail.gmail.com>
 <37daa35f-06aa-49d0-bf0a-1b5ac9f44c89@gmail.com>
In-Reply-To: <37daa35f-06aa-49d0-bf0a-1b5ac9f44c89@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 31 Jul 2026 13:58:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jyy0+hqU3=gmBrgMzLBVhdUQwDj8d0_jGCqZwqyWT=_g@mail.gmail.com>
X-Gm-Features: AUfX_mznGchtvC94CrQbsRNzMqs-ScPaYyDtYD5YLD4MgL8a7a-UyVm5Tu9F_pY
Message-ID: <CAJZ5v0jyy0+hqU3=gmBrgMzLBVhdUQwDj8d0_jGCqZwqyWT=_g@mail.gmail.com>
Subject: Re: [REGRESSION] usb controller fails to initialize on intel s1200btl
To: Julian Silver <mendaxca@gmail.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, rafael.j.wysocki@intel.com, 
	linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 1:45=E2=80=AFPM Julian Silver <mendaxca@gmail.com> =
wrote:
>
> On 2026-07-31 18:29:36, Rafael J. Wysocki (Intel) wrote:
> > grep -r . /sys/devices/system/cpu/cpu*/cpuidle/state*/

Thanks!

Please boot with "intel_idle.states_off=3D16" in the kernel command line
and see if the problem is still there.  If this doesn't help, please
also try "intel_idle.states_off=3D24".
