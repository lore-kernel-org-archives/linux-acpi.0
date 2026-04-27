Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BD43ED113
	for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 19:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777319539; cv=none; b=DD2SuoLqAHAsL45u77RtoWNX7COeXEAE/t50sOB0skPAvuyicFihXazgneKC/sTy3afbtDYMOzlMuE0LjAU/n3ZPCjlSyo4BcDGiyWCZT6+o8QvwPfGgrto+g6IE4cdNqVRD7fXg1uDsML7r9JRTH4uGntnAOHFlJpzharVl/B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777319539; c=relaxed/simple;
	bh=xKBH6k+8yGu5Tf19HSiUpAg6D3XM7osPZWKaNdfhdIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQ17uZHWTmHJ5ZqJtzvOezycm8D8nyqRYvPL3LflKeDaiyukpa7GdBoTWT0eCT1ATzHbXq4n9ejeZRZlNSQsQ0EcYCFPM2ddm+RAxo7nPjvnZ5DI1RtajEvxnDVmTnwNLN7I9v8PtkbiqYXf4HNYm473oaYjuB6zv/DHhALhIq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1PhtJX0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1PhtJX0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E4FC4AF09
	for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 19:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777319539;
	bh=xKBH6k+8yGu5Tf19HSiUpAg6D3XM7osPZWKaNdfhdIc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O1PhtJX0+DeF0DP4is4dmeeUuXYCq5vaZF6wtfML9lLU6+dgyzQUdn5I/DDGXce5h
	 yMrRVRgM69Aw4G9K0RHJfDsukKDRBkQq4rgCm3azLz6Tx7Q9Tb96QerGwJyMtbgISn
	 yNRz3tcRJQ5rZlaLf8L2tbGm32IXAtGhXGZHmt+LkYMX5qMSBCA0EEx+ale3qwDcPt
	 x/HRNbsmYwKgqde+4v+eu91aIvEuSWRJz+hX6q/sz+jVBhhcwjS+uazigr4QsRBNz0
	 +UnOvOkKBO2djlw+I3Ctlznw9Z4+YgchgmR6pbhe4L8PRdDpLuR/8hI9XDbaBj691P
	 Lmy2qgQ9gcZgA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a413f83226so10543729e87.1
        for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 12:52:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ83f1L1apZbDsVCO/uJcD2ktseibzK4Tq2zMs4KJiRFEwsC/d2B2+ArFGg2ynqVQU0m7x6T//hJxHal@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm0c1N7pebNWhDChfNS3sj8iIsNaOsMbZQty+nk78ZwY1Ddsbr
	Cr/ESQU7+rFxIOw5rswomFkxxx0qgeSXW62P4D0ZGlS1iICO5Ue1eLxHVW25ALrw9lEeIKLqYKd
	N3K3j9nv5wC+L2IW/r5fvpHe3plZJOwE=
X-Received: by 2002:a05:6512:10cb:b0:5a1:42ae:88b6 with SMTP id
 2adb3069b0e04-5a7466800aamr46779e87.18.1777319537681; Mon, 27 Apr 2026
 12:52:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417040112.3727756-1-ruanjinjie@huawei.com> <93e1f576-cde9-4c9a-823f-84953d26f455@huawei.com>
In-Reply-To: <93e1f576-cde9-4c9a-823f-84953d26f455@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 27 Apr 2026 21:52:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ioeZGEv63dDuftqz7StcO2uNg-8y00Y1L074-7usLk3A@mail.gmail.com>
X-Gm-Features: AVHnY4KIxSvOj0DMlNJ4BiQj1y4IbllWryfuX9r-q3Ynmm9EIBGEjxP-S0j6qQQ
Message-ID: <CAJZ5v0ioeZGEv63dDuftqz7StcO2uNg-8y00Y1L074-7usLk3A@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: CPPC: Fix related_cpus inconsistency during CPU hotplug
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, skelley@nvidia.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 4:29=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:
>
>
>
> On 4/17/2026 12:01 PM, Jinjie Ruan wrote:
> > When concurrently bringing up and down two SMT threads of a physical
> > core, many warning call traces occur as below:
> >
> > The issue timeline is as follows:
> >
> > 1. when the system starts,
> >       cpufreq: cpu: 220, policy->related_cpus: 220-221, policy->cpus: 2=
20-221
> >
> > 2. Offline cpu 220 and cpu 221.
> >
> > 3. Online cpu 220
> > - cpu 221 is now offline, as acpi_get_psd_map() use for_each_online_cpu=
(),
> >   so the cpu_data->shared_cpu_map, policy->cpus, and related_cpus has o=
nly
> >   cpu 220.
> >       cpufreq: cpu: 220, policy->related_cpus: 220, policy->cpus: 220
> >
> > 4. offline cpu 220
> >
> > 5. online cpu 221, the below call trace occurs:
> > - Because cpu 220 and cpu 221 share one policy, and policy->related_cpu=
s
> >   =3D 220 after step 3, so cpu 221 is not in policy->related_cpus
> >   but per_cpu(cpufreq_cpu_data, cpu221) is not NULL.
> >
> > After revert commit 56eb0c0ed345 ("ACPI: CPPC: Fix remaining
> > for_each_possible_cpu() to use online CPUs"), the issue disappeared.
> >
> > The _PSD (P-State Dependency) defines the hardware-level dependency of
> > frequency control across CPU cores. Since this relationship is a physic=
al
> > attribute of the hardware topology, it remains constant regardless of t=
he
> > online or offline status of the CPUs.
> >
> > Using for_each_online_cpu() in acpi_get_psd_map() is problematic. If a
> > CPU is offline, it will be excluded from the shared_cpu_map.
> > Consequently, if that CPU is brought online later, the kernel will fail=
 to
> > recognize it as part of any shared frequency domain.
> >
> > Switch back to for_each_possible_cpu() to ensure that all cores defined
> > in the ACPI tables are correctly mapped into their respective performan=
ce
> > domains from the start. This aligns with the logic of policy->related_c=
pus,
> > which must encompass all potentially available cores in the domain to
> > prevent logic gaps during CPU hotplug operations.
> >
> > To resolve the original issue regarding the "nosmt" or "nosmt=3Dforce"
> > boot parameter, as send_pcc_cmd() function already does if (!desc)
> > continue, so reverting that loop back to for_each_possible_cpu() is ok,
> > only need to change the match_cpc_ptr NULL case in acpi_get_psd_map() t=
o
> > continue as Sean suggested.
> >
> > How to reproduce, on arm64 machine with SMT support which use acpi cppc
> > cpufreq driver:
> >
> >       bash test.sh 220 & bash test.sh 221 &
> >
> >       The test.sh is as below:
> >               while true
> >                       do
> >                       echo 0 > /sys/devices/system/cpu/cpu${1}/online
> >                       sleep 0.5
> >                       cat /sys/devices/system/cpu/cpu${1}/cpufreq/relat=
ed_cpus
> >                       echo 1 >  /sys/devices/system/cpu/cpu${1}/online
> >                       cat /sys/devices/system/cpu/cpu${1}/cpufreq/relat=
ed_cpus
> >               done
> >
> >       CPU: 221 PID: 1119 Comm: cpuhp/221 Kdump: loaded Not tainted 6.6.=
0debug+ #5
> >       Hardware name: To be filled by O.E.M. S920X20/BC83AMDA01-7270Z, B=
IOS 20.39 09/04/2024
> >       pstate: a1400009 (NzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=3D--)
> >       pc : cpufreq_online+0x8ac/0xa90
> >       lr : cpuhp_cpufreq_online+0x18/0x30
> >       sp : ffff80008739bce0
> >       x29: ffff80008739bce0 x28: 0000000000000000 x27: ffff28400ca32200
> >       x26: 0000000000000000 x25: 0000000000000003 x24: ffffd483503ff000
> >       x23: ffffd483504051a0 x22: ffffd48350024a00 x21: 00000000000000dd
> >       x20: 000000000000001d x19: ffff28400ca32000 x18: 0000000000000000
> >       x17: 0000000000000020 x16: ffffd4834e6a3fc8 x15: 0000000000000020
> >       x14: 0000000000000008 x13: 0000000000000001 x12: 00000000ffffffff
> >       x11: 0000000000000040 x10: ffffd48350430728 x9 : ffffd4834f087c78
> >       x8 : 0000000000000001 x7 : ffff2840092bdf00 x6 : ffffd483504264f0
> >       x5 : ffffd48350405000 x4 : ffff283f7f95cc60 x3 : 0000000000000000
> >       x2 : ffff53bc2f94b000 x1 : 00000000000000dd x0 : 0000000000000000
> >       Call trace:
> >        cpufreq_online+0x8ac/0xa90
> >        cpuhp_cpufreq_online+0x18/0x30
> >        cpuhp_invoke_callback+0x128/0x580
> >        cpuhp_thread_fun+0x110/0x1b0
> >        smpboot_thread_fn+0x140/0x190
> >        kthread+0xec/0x100
> >        ret_from_fork+0x10/0x20
> >       ---[ end trace 0000000000000000 ]---
>
> Gentle ping.

I've noticed it.

Now applied as 7.1 material, thanks!

> >
> > Cc: stable@vger.kernel.org
> > Fixes: 56eb0c0ed345 ("ACPI: CPPC: Fix remaining for_each_possible_cpu()=
 to use online CPUs")
> > Co-developed-by: Sean Kelley <skelley@nvidia.com>
> > Signed-off-by: Sean Kelley <skelley@nvidia.com>
> > Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> > ---
> > v2:
> > - Fix the original issue by continue if per_cpu(cpc_desc_ptr, i) is NUL=
L.
> > - Update the commit message
> > ---
> >  drivers/acpi/cppc_acpi.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> > index f0e513e9ed5d..bcfe2e6b8445 100644
> > --- a/drivers/acpi/cppc_acpi.c
> > +++ b/drivers/acpi/cppc_acpi.c
> > @@ -362,7 +362,7 @@ static int send_pcc_cmd(int pcc_ss_id, u16 cmd)
> >  end:
> >       if (cmd =3D=3D CMD_WRITE) {
> >               if (unlikely(ret)) {
> > -                     for_each_online_cpu(i) {
> > +                     for_each_possible_cpu(i) {
> >                               struct cpc_desc *desc =3D per_cpu(cpc_des=
c_ptr, i);
> >
> >                               if (!desc)
> > @@ -524,13 +524,13 @@ int acpi_get_psd_map(unsigned int cpu, struct cpp=
c_cpudata *cpu_data)
> >       else if (pdomain->coord_type =3D=3D DOMAIN_COORD_TYPE_SW_ANY)
> >               cpu_data->shared_type =3D CPUFREQ_SHARED_TYPE_ANY;
> >
> > -     for_each_online_cpu(i) {
> > +     for_each_possible_cpu(i) {
> >               if (i =3D=3D cpu)
> >                       continue;
> >
> >               match_cpc_ptr =3D per_cpu(cpc_desc_ptr, i);
> >               if (!match_cpc_ptr)
> > -                     goto err_fault;
> > +                     continue;
> >
> >               match_pdomain =3D &(match_cpc_ptr->domain_info);
> >               if (match_pdomain->domain !=3D pdomain->domain)
>
>
