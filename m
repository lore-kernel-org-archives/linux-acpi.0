Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19B63CF045
	for <linux-acpi@vger.kernel.org>; Wed, 15 Apr 2026 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776261810; cv=none; b=CwOEW0Oh/uvM/5lu8YZJNsWzs0/NHZKKms67KPJXMEkJwZJtSNGhuRBDuVh4ap0SO4cibMJznEn9zG0b3lzWaA543h5d2QHF9iR1WC87Q25AgyuHAeLG/5JEt3dsnDI0aLENvm/VmypKAbo3qemyivgDAqcuMh4cycICTqwQAbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776261810; c=relaxed/simple;
	bh=5pS4SfD0lWDbRwrU5/HiL/ioGrDgnmIiFIPZChr5qes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iVAdzcfXvB/hk5VSlBPl9RqZa+G9wuOJBQSIphlU9/vor0l8Ta751Gmb+eXI4i+fbIoLOkjeTnKJ9i9EtXzbGoAPgru6GZqT3BwGhjLn00u5YuIQ1oeONv71vt4Awu68u1IKySdq7xPYfxQzL8znaqJZgilVkwO4tL6AaGP6L1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8a67CT9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8a67CT9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A78C2BCB9
	for <linux-acpi@vger.kernel.org>; Wed, 15 Apr 2026 14:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776261809;
	bh=5pS4SfD0lWDbRwrU5/HiL/ioGrDgnmIiFIPZChr5qes=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G8a67CT9i9eC93CYW+yJKIVxfGColVv7omAwr4rBgTVUWXesxWhu+KWVrn+dRk4Hm
	 /D4+5p1BXqRCV0CUL469IcePDSK4wl3qSHui2mPMa6VkC8OmLxtuBEF0/HFWhOPyVo
	 YWxvQDpwYZe5t4kp8N3Vjt5PsqGGDiHavUcc+JiyRzzawH1Gfvx29FQ3E2QguA4QWT
	 9GCW3mrsTqJCQNzqb/NoyAErhdTsYe3SezAApwLys3uH+u02BZzNly77ni1fuzEJm6
	 s0A+CdRrQ59jMIf125pJNmpcAig6He+V/y00T47JjTj8mMH1KqtKKWP69caY5R6lSg
	 mfi0E7oRw2onw==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-662f30d3f1fso3870747eaf.1
        for <linux-acpi@vger.kernel.org>; Wed, 15 Apr 2026 07:03:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/DaGm3VE60yOFH118OxaCG4rTxXjbE0JKqDJy5DGDS1vmM9+EDgVaBAKmHf0YX+c8gm68S1rLM+pC7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2vvAup/9yBbcv6QkOEL9dhVbkI9/fGPM9zJ+KsMgzs9+cY0Mz
	+lpvoJEHoA5sPJIT24s1s5Y1WAcqGkxDK2jhCwceuJO+hk1fVqJ/5NRARS41f87+1GEqu3zr3f/
	xznLPb6hzJCk7RwaLKNVcmbmtxa7L34w=
X-Received: by 2002:a05:6820:218:b0:687:bbfa:2158 with SMTP id
 006d021491bc7-68bf6aebec2mr9587988eaf.13.1776261806782; Wed, 15 Apr 2026
 07:03:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-ffh-v1-1-301704f69e2f@debian.org> <af9c679d-899c-4832-b902-e621b5987f12@huawei.com>
 <ad4UWJ__dnDQtrj8@gmail.com> <6694ca7c-13bf-4e7d-9621-bc992cbf96a7@huawei.com>
 <20260414-cute-shapeless-dolphin-c5b2fc@sudeepholla> <33c15199-25ea-4d39-bff9-91af0b49633e@huawei.com>
In-Reply-To: <33c15199-25ea-4d39-bff9-91af0b49633e@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 15 Apr 2026 16:03:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hftnagiLTPCEjqviyug5g5NQCztX1o0w5NOY8d=5cz+g@mail.gmail.com>
X-Gm-Features: AQROBzARfwQzbblVS4HwmI4PAiTiOq-oHuuggUND-Sc3bt1HPaVjtyZCd_Xm8_o
Message-ID: <CAJZ5v0hftnagiLTPCEjqviyug5g5NQCztX1o0w5NOY8d=5cz+g@mail.gmail.com>
Subject: Re: [PATCH RFC] ACPI: processor: idle: Do not propagate
 acpi_processor_ffh_lpi_probe() -ENODEV
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Len Brown <lenb@kernel.org>, lpieralisi@kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pjaroszynski@nvidia.com, guohanjun@huawei.com, 
	linux-arm-kernel@lists.infradead.org, rmikey@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 3:32=E2=80=AFAM lihuisong (C) <lihuisong@huawei.com=
> wrote:
>
>
> On 4/14/2026 8:25 PM, Sudeep Holla wrote:
> > On Tue, Apr 14, 2026 at 07:31:29PM +0800, lihuisong (C) wrote:
> >> On 4/14/2026 6:21 PM, Breno Leitao wrote:
> >>> Hello Huisong,
> >>>
> >>> On Tue, Apr 14, 2026 at 05:43:51PM +0800, lihuisong (C) wrote:
> >>>> But it is a real issue. Thanks for your report.
> >>>> I think the best way to fix your issue is that remove this verificat=
ion in
> >>>> psci_acpi_cpu_init_idle().
> >>>> Because it is legal for platform to report one LPI state.
> >>>> This function just needs to verify the LPI states which are FFH.
> >>> Thank you for the prompt feedback.
> >>>
> >>> Would this approach work?
> >>>
> >>> commit 6c9d52840a4f778cc989838ba76ee51416e85de3
> >>> Author: Breno Leitao <leitao@debian.org>
> >>> Date:   Tue Apr 14 03:16:08 2026 -0700
> >>>
> >>>       ACPI: processor: idle: Allow platforms with only one LPI state
> >>>       psci_acpi_cpu_init_idle() rejects platforms where power.count -=
 1 <=3D 0
> >>>       by returning -ENODEV. However, having a single LPI state (WFI) =
is a
> >>>       valid configuration. The function's purpose is to verify FFH id=
le states,
> >>>       and when count is zero, there are simply no FFH states to valid=
ate =E2=80=94
> >>>       this is not an error.
> >>>       On NVIDIA Grace (aarch64) systems with PSCIv1.1, power.count is=
 1 for
> >>>       all 72 CPUs, so the probe fails with -ENODEV. After commit cac1=
73bea57d
> >>>       ("ACPI: processor: idle: Rework the handling of
> >>>       acpi_processor_ffh_lpi_probe()"), this failure propagates up an=
d prevents
> >>>       cpuidle registration entirely.
> >>>       Change the check from (count <=3D 0) to (count < 0) so that pla=
tforms
> >>>       with only WFI are accepted. The for loop naturally handles coun=
t =3D=3D 0
> >>>       by not iterating.
> >>>       Fixes: cac173bea57d ("ACPI: processor: idle: Rework the handlin=
g of acpi_processor_ffh_lpi_probe()")
> >>>       Signed-off-by: Breno Leitao <leitao@debian.org>
> >>>
> >>> diff --git a/drivers/acpi/arm64/cpuidle.c b/drivers/acpi/arm64/cpuidl=
e.c
> >>> index 801f9c4501425..7791b751042ce 100644
> >>> --- a/drivers/acpi/arm64/cpuidle.c
> >>> +++ b/drivers/acpi/arm64/cpuidle.c
> >>> @@ -31,7 +31,7 @@ static int psci_acpi_cpu_init_idle(unsigned int cpu=
)
> >>>             return -EOPNOTSUPP;
> >>>     count =3D pr->power.count - 1;
> >>> -   if (count <=3D 0)
> >>> +   if (count < 0)
> >>>             return -ENODEV;
> >>>     for (i =3D 0; i < count; i++) {
> >> This count already verified in acpi_processor_get_lpi_info.
> >>
> >> I suggest modifing it as below:
> >>
> >> -->
> >>
> >> git diff
> >> diff --git a/drivers/acpi/arm64/cpuidle.c b/drivers/acpi/arm64/cpuidle=
.c
> >> index 801f9c450142..c68a5db8ebba 100644
> >> --- a/drivers/acpi/arm64/cpuidle.c
> >> +++ b/drivers/acpi/arm64/cpuidle.c
> >> @@ -16,7 +16,7 @@
> >>
> >>   static int psci_acpi_cpu_init_idle(unsigned int cpu)
> >>   {
> >> -       int i, count;
> >> +       int i;
> >>          struct acpi_lpi_state *lpi;
> >>          struct acpi_processor *pr =3D per_cpu(processors, cpu);
> >>
> >> @@ -30,14 +30,10 @@ static int psci_acpi_cpu_init_idle(unsigned int cp=
u)
> >>          if (!psci_ops.cpu_suspend)
> >>                  return -EOPNOTSUPP;
> >>
> >> -       count =3D pr->power.count - 1;
> >> -       if (count <=3D 0)
> >> -               return -ENODEV;
> >> -
> > It was intentionally designed this way, as there is little value in def=
ining
> > only WFI in the _LPI tables. In the absence of a cpuidle driver/LPI ent=
ry,
> > arch_cpu_idle() is invoked, which is sufficient and avoids unnecessary
> > complexity, only to ultimately execute wfi() anyway.
> Yeah, it's correct. The code flow will be more simple and high-efficiency=
.
> This looks good to me.
>
>
> But cpuidle sysfs under per CPU is created when firmware just reports
> WFI state before
> my commit cac173bea57d ("ACPI: processor: idle: Rework the handling of
> acpi_processor_ffh_lpi_probe()").
> However, these platforms will no longer be created now and some
> statistics for state0 are also missing.
> This change in behavor is visiable to user space.I'm not sure if it is
> acceptable.
> What do you think, Rafael?

I think that it would be good to restore the previous behavior,
especially if it has been changed inadvertently.
