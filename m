Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243454;
	b=R+FvQmchn6ipk9JPuDi7Kzj6mV0n7bWsbZ1ztUT6AkpwA5B87KydP3bz9wNH3hd1Ivtj
	 AA4JD+lY0piJ+8+1OLTnhCR2aM8kjqBb9qWuCu49+NXlp8KxBuzy/IoUtDNdo6rY5oEpj
	 FpDhRVbFU5LJGhBLLvIQEXIlzDW00JIN+pSM+brViw9soB9sHnRpSVe6qCb/d04hpkJ0C
	 cl9cT42PPFEdqzKy39NE+ziKlCQgqQrOvqN7SmdW/qyMbzrae5BQXmF228vVeqADzcsgm
	 RZ3K7kaXKZB0Puv8YZKISsE/DeRtjYpWtWo0GAgdy122vZU1MiXx2npoTwe4aRvWPwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243454;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=or84SUgv0BeH2ACDpVutswhOxc7jEVslOk831F8ydnA=;
	b=br6bNdv13rdhEde0czsKFVdjLEsWrVYQ3LprI6ieiYOVNh8uRDt9vJdbdH3nN07J9l6b
	 q7d63z0K2M7vJt5xoTWudjmxFNPWyTK65oEY79IbZzTYU6Gk4rvtbEtGHufHyjijkGk/g
	 n1LvX6X8RNnxeo4KY+TPYjLOrNCft66ag4YCfJyCyLRkqroTHze4ta0/ylqwOzsp/HwIC
	 5jMU14rGcCZ42nhwLyW5gvU/XA91tEWD0cBTnhbjvSWzpd/eP9Jr3TcCzucKRIhJTDC7w
	 k9Zom1/XhoLJGNwDssgoroPmgOl4YBFW4sbfxVdhOgPdPEry49Z9N/XN0gOHEzRZiEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fd52kfvy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B062D606A331
	for <linux-acpi@vger.kernel.org>; Mon,  9 Nov 2026 16:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fd52kfvy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859C61F00900
	for <linux-acpi@vger.kernel.org>; Mon,  9 Nov 2026 16:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794243453;
	bh=or84SUgv0BeH2ACDpVutswhOxc7jEVslOk831F8ydnA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fd52kfvypHpLFctXWJFV5Xhk4mocUciAELKi5VXFKSSd3phcdIuxWzH5ljUSWmS3H
	 q+rxRLcP/sjUmHyl0L22oh6n79hTl1aIkKyOPiwjOwncg8W+/vF8RrgpydBpBnEhDy
	 9IER0aRJDqDMds1UyB6e5IdSaLH83xiaaCURPcZoxEWW1Omv34svRPreKwKaKIp/1g
	 LObgpPpI/HnWs3pZI/i6WcEthNolZA6eOXKoZWWiSP3W6nBcxzrfe9c/wVa1p2FzyC
	 99waGB0sAiFAvHFFHwzfSp+c2eHLAeD/N8n9w0PXPXEIpzA8JiUIOK4SNR5Aimx5kU
	 0rXycXTIVCBBw==
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5eafb65e169so627274e0c.1
        for <linux-acpi@vger.kernel.org>; Mon, 09 Nov 2026 08:57:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEdJ+EpXa03R+QfXEdLiDcHtHVoxjGlNZo38yMvG5gvwnoWAZYeIimreC8UwYQ9PPLByobSoDBosP4d@vger.kernel.org
X-Gm-Message-State: APuU4Z+nvM+1R9CiGgPL+T24pZmWW/cJgaeIBuYcBPQl09YIdqxYyM/f
	91iDv4WRS0OnmeEQVMXRho2CJLQXlt8aowdVg3WvJdrDalSXoqF0epsSsoSAXuijLpuVvhfCuBn
	SBhmPSMw/dA3Db7yuOWrOt0lllZCSV4s=
X-Received: by 2002:a05:6122:ca8:b0:5ce:b65d:22c4 with SMTP id
 71dfb90a1353d-5ece735974dmr1790071e0c.16.1794243452619; Mon, 09 Nov 2026
 08:57:32 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106193304.3347374-1-sumitg@nvidia.com> <20261106193304.3347374-2-sumitg@nvidia.com>
 <125b1872-ce72-4842-88e3-abe7f8b1e772@nvidia.com>
In-Reply-To: <125b1872-ce72-4842-88e3-abe7f8b1e772@nvidia.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 9 Nov 2026 17:57:18 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jQVRQhJzLoAy3btKovHGYkqGKJAP_5VfENM_WAREQnyQ@mail.gmail.com>
X-Gm-Features: AclHuK8uIgCcA54cV6Osu4KoIR1Jd3EdCuObjZ0e2qwpL6iy8qO36-B97HRTaLQ
Message-ID: <CAJZ5v0jQVRQhJzLoAy3btKovHGYkqGKJAP_5VfENM_WAREQnyQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/8] ACPI: CPPC: Order performance-control updates
To: Sumit Gupta <sumitg@nvidia.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, pierre.gondois@arm.com, 
	christian.loehle@arm.com, ionela.voinescu@arm.com, zhenglifeng1@huawei.com, 
	zhanjie9@hisilicon.com, lenb@kernel.org, ray.huang@amd.com, 
	mario.limonciello@amd.com, perry.yuan@amd.com, kprateek.nayak@amd.com, 
	maciej.wieczor-retman@intel.com, pawel.chmielewski@intel.com, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com, 
	vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com, 
	mochs@nvidia.com, bbasu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 10:38=E2=80=AFPM Sumit Gupta <sumitg@nvidia.com> wro=
te:
>
> Hi Rafael,
>
>
> On 07/11/26 01:02, Sumit Gupta wrote:
> > From: Christian Loehle <christian.loehle@arm.com>
> >
> > The ACPI specification requires Minimum Performance to remain below
> > Maximum Performance. When autonomous selection is disabled, Desired
> > Performance must also remain within those limits.
> >
> > cppc_set_perf() writes the three controls in a fixed order. This can ex=
pose
> > an invalid tuple after firmware resets the controls or while policy bou=
nds
> > move across the current desired value.
> >
> > Read the live limits. Apply non-atomic updates in three phases: widen t=
he
> > interval, update Desired Performance, then narrow it. Submit PCC contro=
ls
> > in each phase together. Keep the existing single-command path when the
> > complete tuple is in PCC, reject invalid requests, and stop after the f=
irst
> > failed access.
> >
> > Make cppc_cpufreq fast switches include the limits only when they diffe=
r
> > from the last successful request. Invalidate the cache across resume an=
d
> > after a failed request, since firmware may have reset the controls or a=
n
> > earlier phase of a failed update may have reached the platform. Publish
> > slow-path limits only after the complete request succeeds.
> >
> > At policy teardown, lower Minimum Performance together with Desired
> > Performance so the final request remains valid. On initialization, clam=
p
> > Desired Performance to the live interval left by firmware or an earlier
> > driver instance.
> >
> > [sumitg:
> >   - In cppc_read_perf_limits(), skip an unimplemented MIN or MAX, and
> >     do not fail on a live MIN above MAX.
> >   - Clamp Desired into the new MIN and MAX instead of rejecting it, as
> >     amd-pstate resume can round it above MAX.
> >   - In init(), request the full range if the live MAX is zero or below =
MIN.
> >   - Clamp Desired in set_target(), fast_switch() and store_auto_select(=
),
> >     to keep the cached value in range.
> >   - In store_auto_select(), publish the request only after success.]
> >
> > Fixes: 76531df5e13b ("ACPI: CPPC: Add min and max perf register writing=
 support")
> > Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> > Link: https://lore.kernel.org/all/01d7f07e-839c-428b-833d-713ed2128f4d@=
nvidia.com/
> > Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> > ---
>
>
> Sashiko flagged three issues on this patch [1].
> I think none of them needs a change in this patch:
>
> 1) SHARED_TYPE_ANY, when policy->cpu changes: the driver uses one set
>     of controls for all CPUs in the policy, and always writes them
>     through policy->cpu. So the MIN and MAX written earlier still apply.
>
> 2) MIN and MAX not written when the requested frequency is the current
>     one: not new with this patch. Since commit 9801be8bef65 ("cpufreq:
>     Avoid redundant target() calls for unchanged limits"), the core
>     skips ->target() in that case unless the limits changed, also for
>     the first request after the governor starts. I will send a core fix
>     for this separately.

The core expects policy->cur to be set adequately before starting the
governor, so if this doesn't happen, it is not the core's problem.

Though I'm not going to defer the series because of this.

> 3) store_auto_select() racing with the governor: this is not new
>     either. Before this patch, both edited the shared
>     cpu_data->perf_ctrls. Now each builds its own request.
>     store_auto_select() holds policy->rwsem, so the policy limits cannot
>     change while it runs. store_auto_select() and the governor both take
>     MIN and MAX from these limits, and keep Desired between them. So
>     MIN <=3D Desired <=3D MAX holds, whichever write lands first. At wors=
t,
>     Desired keeps the older value until the next governor update.
>
> [1]
> https://sashiko.dev/#/patchset/20261106193304.3347374-1-sumitg@nvidia.com
>
> Thanks,
> Sumit
>
> ....
>
