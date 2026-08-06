Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A916442B16
	for <linux-acpi@vger.kernel.org>; Thu,  6 Aug 2026 10:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786012605; cv=none; b=ZkG3ChhUoWMAKGoGo7zsG9AnnKcalavL8NnoC6gnvqDF22uZl7ILQfcmQCSpajco57W0/c5K6O2EmB3laQ1+VBu8xMRdUzztYQbZKpBVMTnOcUoGE8Rpm5TLsO+c3EB4w98HLr8rBJ1hsBBOrs0iglxiY0oB94cO7PhZZ3VsDYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786012605; c=relaxed/simple;
	bh=0Z85Ii9mEAj9FJKyQEUEvFKjn2b2y7gz+eeXvWPENBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mt5j4jvKjo9wSzrUkOvCVe+ScVyjbyS05GwRXdCe3IDNtvZscXID+GGfOSO2dfzcFVBA54XvZIDFdaSgVzjoO+snjIW/SFxofovwRnRb2fu7FNgt+QpvfXm5X2zXsYRXGxux7anC74YkfCslv0rXX+u+jzVuEjh9ykQYxzYw6SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghDRKrth; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghDRKrth"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316321F00ACF
	for <linux-acpi@vger.kernel.org>; Thu,  6 Aug 2026 10:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786012602;
	bh=Tko6x0UqtEXgGgQ/eQ28JSNMR1IpckAb7EIjIBlDr2o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ghDRKrth10kDOPaQuKXdpgiAS4DqMjrOnOXgP0o0Vhj4Yn/vPInQnG2KXVrxnRI6o
	 OS6/eXTBCXECHCyCHt9tSVwTtgYi+Z1IhdJRC9KKWZuETErFl/fcG9slzQGGLnhYFg
	 vGmIdDmyVgN2fCjAOfxVJmuWKt6UbqtJD+D7UvtSjW23RTBPcfQ2BX+s1J5PyyAzYf
	 7Fb48CUuS6yaGFD5nd/YqeSnm9ylYVFGmz97gPovjE1Xm4K8OaeGPTzxtcAAeGcLkv
	 ccBZfu9C90WYyuPPeYCuvSOdvxn/b/6q5Yv+hfIaRuOEMYZ4LIdUEzrj2TyjITxPDC
	 Np7LdCgImUmkg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aeba09900bso1464398e87.2
        for <linux-acpi@vger.kernel.org>; Thu, 06 Aug 2026 03:36:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqvizVoPS8hkmi29+TQnptEAohnQjT7GMTWD7N3k/fn5Lt8IQOFmyZVgjc5FbNMjCWYHdEKuu8CMY5M@vger.kernel.org
X-Gm-Message-State: AOJu0Yymq1DOrbha4eO6nyrhLyoZkQU2cypR6mbIVjqjF4ubs1xXfC+/
	haO0fmWqdH7B5jU5NZFTAAYJeEiazsx0tbQjgn4m5nYUHNMzQnYEBPqA1m+9fd46cIwM9xh+amH
	6arpFSiS8eTXyQXp2HTf6NVnBLNT0bD4=
X-Received: by 2002:a05:6512:a81:b0:5ae:c27b:f7a0 with SMTP id
 2adb3069b0e04-5b2f4c91c76mr1939783e87.11.1786012600571; Thu, 06 Aug 2026
 03:36:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803210527.1285229-1-christian.loehle@arm.com>
 <f48c36fe-446f-4f83-8d2d-0913aafc377e@arm.com> <4bae4fa9-b2fc-48e8-9f11-b3cf520e9c0d@arm.com>
In-Reply-To: <4bae4fa9-b2fc-48e8-9f11-b3cf520e9c0d@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 6 Aug 2026 12:36:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hkE708Qn5rX26X9i1+tGgoYOYyBmoc0zUw4N7m=r8m3w@mail.gmail.com>
X-Gm-Features: AUfX_my44NQN43w9SgkFob0BspNIj1uuZo2dMEBzeHs0ZGAVyCmVE18AZRQ33SA
Message-ID: <CAJZ5v0hkE708Qn5rX26X9i1+tGgoYOYyBmoc0zUw4N7m=r8m3w@mail.gmail.com>
Subject: Re: [RESEND][PATCH 0/3] ACPI: CPPC: Reduce .target() callback overhead
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Len Brown <lenb@kernel.org>, Jie Zhan <zhanjie9@hisilicon.com>, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, Pierre Gondois <pierre.gondois@arm.com>, 
	Sumit Gupta <sumitg@nvidia.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Ionela Voinescu <ionela.voinescu@arm.com>, zhongqiu.han@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 12:05=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 8/3/26 23:28, Christian Loehle wrote:
> > On 8/3/26 22:05, Christian Loehle wrote:
> >> cppc-cpufreq reaches cppc_set_perf() from every target callback.  For
> >> direct SystemMemory controls, that path currently does several steps
> >> which are unnecessary once the immutable _CPC layout is known:
> >>
> >>   - a full-width write first reads the access unit and merges the valu=
e.
> >>   - every write takes the descriptor's RMW lock, even when its access =
unit
> >>     is not shared with another _CPC entry.
> >>   - cppc_set_perf() evaluates the same three PCC predicates at each ph=
ase
> >>     of the transaction.
> >>
> >> Remove those costs while retaining the existing conservative paths for
> >> partial fields, overlapping or malformed access units, and PCC control=
s.
> >>
> >> The series was tested on Arm Power-Orion O6 and AmpereOne systems usin=
g
> >> cppc-cpufreq and schedutil.  An rt-app task pinned to one CPU ran for
> >> 500 us every 2 ms with uclamp.min=3D512, for 5000 periods per run.  sc=
hedutil
> >> rate_limit_us was 1000.  cppc_cpufreq_fast_switch() latency was measur=
ed
> >> for 100 ten-second runs.  Each sample is the mean callback latency wit=
hin
> >> one run, and the table reports the median and sample standard deviatio=
n
> >> of those samples.
> >>
> >> Orion O6               median       stdev       callbacks
> >> baseline               5703 ns      307 ns       188017
> >> complete series        5023 ns      240 ns       188209
> >> =3D=3D> 680 ns (11.9%) reduction
> >>
> >> AmpereOne              median       stdev
> >> baseline               2090 ns      157 ns
> >> complete series      1907.5 ns      140 ns
> >> =3D=3D> 182.5 ns (8.7%) reduction
> >>
> >> The cumulative intermediate results on the Orion O6 attribute roughly =
half
> >> of the gain to each of the first two patches: avoiding the read reduce=
d
> >> the median by 284 ns (5.0%), and avoiding the lock reduced it by anoth=
er
> >> 336 ns (6.2%).
> >> Together they account for 620 ns of the 680 ns total reduction.
> >>
> >> With the same arm64 configuration and GCC 11.4, caching the PCC predic=
ate
> >> also reduces cppc_set_perf() from 1124 to 884 bytes.  The generated
> >> function has 60 fewer instructions, 17 fewer loads and 20 fewer branch=
es.
> >>
> >> This series is based on the CPPC fixes posted at (already queued):
> >> https://lore.kernel.org/lkml/20260722093825.1030594-1-christian.loehle=
@arm.com/
> >>
> >> and the separately posted fix still under review:
> >> https://lore.kernel.org/lkml/20260724104042.1481804-1-christian.loehle=
@arm.com/
> >>
> >> PS:
> >> There's a final optimization that I actually wanted to make but decide=
d to
> >> split it out for now as it somewhat replicated Sumit's series:
> >> Skipping redundant perf ctrl writes in cpufreq-cppc if registers are n=
on-PCC
> >> and !shared (because the values are unchanged, the
> >> !autonomous-common-case), but that requires the driver to have a more
> >> complex caching- and atomic-updating machinery in place, similar to
> >> hotplug. As opposed to this series the optimization would be for the
> >> microcontroller handling the CPPC requests, which may be shared across
> >> many CPUs and therefore redundant requests can increase the dvfs
> >> transition latency.
> >> That patch will follow once Sumit's is queued:
> >> https://lore.kernel.org/lkml/20260716153820.2007095-1-sumitg@nvidia.co=
m/
> >>
> >> [RESEND] for the new base-commit specifier below
> >>
> >> Christian Loehle (3):
> >>   ACPI: CPPC: Avoid unnecessary reads for full-width writes
> >>   ACPI: CPPC: Avoid locking standalone full-width registers
> >>   ACPI: CPPC: Evaluate performance-control PCC use once
> >>
> >>  drivers/acpi/cppc_acpi.c | 135 +++++++++++++++++++++++++++++++-------=
-
> >>  include/acpi/cppc_acpi.h |   5 +-
> >>  2 files changed, 113 insertions(+), 27 deletions(-)
> >>
> >>
> >> base-commit: 075b74841bd0065a3bda3440873c747938e69b68
> >
> > Nice, so that worked:
> > https://sashiko.dev/#/patchset/20260803210527.1285229-1-christian.loehl=
e@arm.com
> > Seems no findings on $SUBJECT but the rest of the comments it has
> > look legit to me? I'll go take another look tomorrow:
>
> So I have patches for these all and will post them in a minute.
>
> >
> > 1. Using per-CPU cpc_desc->rmw_lock for SYSTEM_MEMORY CPPC control regi=
ster that
> > may be shared.
>
> The solution here sucks unfortunately.
> Obviously expanding the per-CPU rmw_lock to per-policy is reasonable, but=
 unfortunately
> that doesn't prevent something like:
> Policy 0 Desired: address X, bits 7:0,  access size 32
> Policy 1 Desired: address X, bits 15:8, access size 32
> which would be a compliant GAS description and would require a global loc=
k for rmw.
>
> And of course even worse, now that Desired is write-only rmw isn't possib=
le at all
> anymore.
> I'm leaning to just reject these edge-cases that hopefully don't actually=
 exist
> (and require _CPC rev4 to be full access-unit width)
> Opinions?

Fail initialization on insane platform setups I'd say.

There's no promise that Linux will support compliant setups that are
too much pain to deal with.
