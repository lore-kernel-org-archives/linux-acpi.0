Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907CC3CBE74
	for <linux-acpi@vger.kernel.org>; Wed, 26 Aug 2026 10:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787740362; cv=none; b=lECJPQvhpusGovRsCKyTX4vi+Xw4hKnGupJfpBFHJoEDU5huJXcQKu3/tOt6KrNCyjZzlgtJ+DE7vX4ePYAF1JXioI9fXC77sbYJKs1Bw5KS9vc5URHroLT+eqwAUy9fMhrlE/jbM+KvPognnLNjNvnKtNDJ6jyv5BmS4tlaUZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787740362; c=relaxed/simple;
	bh=5kDXB2S3/VFEh3pSQ+pFxngBCV5rUhgMDzYHk4Xq7Xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJxXTAlvQLNh2TBfChQlzfT5inPkUh0dNAr3IdYah49U8fARh1kNXeqKgyh3i5RGGjUusjjXhzeRUY7uV1kMIx4sw5dhngbfvrlio4irfn1tJYWUrk9CJGxGNxPCN41d6bvwt4rDTVlZ5/d/IZxPtHIGQqwlj6XGg4WQr7Uljx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtH5uBOe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtH5uBOe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D461F0155A
	for <linux-acpi@vger.kernel.org>; Wed, 26 Aug 2026 10:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787740360;
	bh=hFPTb5DFZvBEDOf0CVmKkFMr2m237i/+84QjJ2CpDSA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KtH5uBOezsH52euNMdVCsn7USv8bR1bk+B/QUHdSfdhr8Oy19CpZMbR6tswRAQ1TX
	 JRRg0qWiwU5yYKyjX1RGnBgc7I0lAkKbrdT2977+dvJSxy9gm8P6C3jEqPjMNJIpM6
	 /sNiCTP1DcKBWqsziX1sj0yfy13tNLxMnJQdfgJEl3dJGlHjghq5RFjzqIJ8sIW6rz
	 Ca2LDRkMTx4s7ysd+wWn8V4FCWpuCLzfRKsgq7DGjb8u1je2Pc2r/v8C71ClT7+Fcn
	 vZuQPzkR6mXetUs/NBovv3ZJDSNqKRaG54vVBa5pfSM5QNcNNvly2S7+vjeYm7Ry+v
	 /K6ro96PB1bNA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b0115b9e17so871283e87.0
        for <linux-acpi@vger.kernel.org>; Wed, 26 Aug 2026 03:32:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqfnOsMqrrfJpEi2eokDihJUJppbkGLD/izhQBPeKmKBAVPwGe+TY9GdVB+DWUoeda7Dka9X8bLb9yT@vger.kernel.org
X-Gm-Message-State: AFuF++kx+5hI/d5rmgLXyaVA3fIuOoQok0tQ6Nj1bS5IjH/BQl1Vtmrc
	6UR+8vsOCgst6PR/Euwl3nnK8+0O5XOUdk+sY3obEddsL0a0MOrleoO1NYCYKx5nIBkKYXtW75F
	TGNocqizuMFUQ+3S2X5cE+/wjDQ3t2Lc=
X-Received: by 2002:a05:651c:30ca:b0:3a1:5172:c287 with SMTP id
 38308e7fff4ca-3a1fd4a1fb5mr13941701fa.5.1787740358622; Wed, 26 Aug 2026
 03:32:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120113242.3843463-1-zhenglifeng1@huawei.com> <e83096fc-d6f8-46bf-91e6-2922ac35b751@huawei.com>
In-Reply-To: <e83096fc-d6f8-46bf-91e6-2922ac35b751@huawei.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 26 Aug 2026 12:31:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gyQvmyS4gXS-b6HT7arkO0sqt8EgjWBTrWDJ8L-Tp=rA@mail.gmail.com>
X-Gm-Features: AcwNN1XaRqruyBqE-eru_JrvwUlotnvbzVtrw1SfRm6vEZX-s1OMWsQ1iJ_zgrA
Message-ID: <CAJZ5v0gyQvmyS4gXS-b6HT7arkO0sqt8EgjWBTrWDJ8L-Tp=rA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor: Add acpi_processor_start() back to parse
 _CPC tables before CPU online
To: Pengjie Zhang <zhangpengjie2@huawei.com>
Cc: Lifeng Zheng <zhenglifeng1@huawei.com>, rafael@kernel.org, catalin.marinas@arm.com, 
	Jonathan.Cameron@huawei.com, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, gshan@redhat.com, 
	miguel.luis@oracle.com, guohanjun@huawei.com, zhanjie9@hisilicon.com, 
	lihuisong@huawei.com, yubowen8@huawei.com, wangzhi12@huawei.com, 
	linhongye@h-partners.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 10:00=E2=80=AFAM Pengjie Zhang <zhangpengjie2@huawe=
i.com> wrote:
>
> Hi Lifeng,
>
> On 1/20/2026 7:32 PM, Lifeng Zheng wrote:
> > Currently, if boot with maxcpus less than NR_CPUS, the cppc_cpufreq dri=
ver
> > will fail to register. Because it requires the domain information of al=
l
> > possible CPUs to construct shared_cpu_map, which shows the CPUs that sh=
are
> > the same domain.
> >
> > Commit c1385c1f0ba3 ("ACPI: processor: Simplify initial onlining to use
> > same path for cold and hotplug") removes probe() of acpi_processor_driv=
er
> > and makes acpi_cppc_processor_probe() only being called the first time =
CPU
> > goes online. This means that CPUs that haven't yet gone online will not
> > have pre-parsed _CPC objects and causes cppc_cpufreq driver register fa=
il.
> >
> > Add acpi_processor_start() back as the probe() callback of
> > acpi_processor_driver and call acpi_cppc_processor_probe() in it to mak=
e
> > sure all _CPC tables will be parsed when acpi_processor_driver register=
ed.
> >
> > Fixes: c1385c1f0ba3 ("ACPI: processor: Simplify initial onlining to use=
 same path for cold and hotplug")
> > Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> > ---
> >   drivers/acpi/processor_driver.c | 30 ++++++++++++++++++++++++++----
> >   1 file changed, 26 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_d=
river.c
> > index 65e779be64ff..c8b4daf580b0 100644
> > --- a/drivers/acpi/processor_driver.c
> > +++ b/drivers/acpi/processor_driver.c
> > @@ -33,6 +33,7 @@ MODULE_AUTHOR("Paul Diefenbaugh");
> >   MODULE_DESCRIPTION("ACPI Processor Driver");
> >   MODULE_LICENSE("GPL");
> >
> > +static int acpi_processor_start(struct device *dev);
> >   static int acpi_processor_stop(struct device *dev);
> >
> >   static const struct acpi_device_id processor_device_ids[] =3D {
> > @@ -46,6 +47,7 @@ static struct device_driver acpi_processor_driver =3D=
 {
> >       .name =3D "processor",
> >       .bus =3D &cpu_subsys,
> >       .acpi_match_table =3D processor_device_ids,
> > +     .probe =3D acpi_processor_start,
> >       .remove =3D acpi_processor_stop,
> >   };
> >
> > @@ -162,10 +164,6 @@ static int __acpi_processor_start(struct acpi_devi=
ce *device)
> >       if (!pr)
> >               return -ENODEV;
> >
> > -     result =3D acpi_cppc_processor_probe(pr);
> > -     if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
> > -             dev_dbg(&device->dev, "CPPC data invalid or not present\n=
");
> > -
> >       if (!cpuidle_get_driver() || cpuidle_get_driver() =3D=3D &acpi_id=
le_driver)
> >               acpi_processor_power_init(pr);
> >
> > @@ -192,6 +190,30 @@ static int __acpi_processor_start(struct acpi_devi=
ce *device)
> >       return result;
> >   }
> >
> > +static int acpi_processor_start(struct device *dev)
> > +{
> > +     struct acpi_device *device =3D ACPI_COMPANION(dev);
> > +     struct acpi_processor *pr;
> > +     int result;
> > +
> > +     if (!device)
> > +             return -ENODEV;
> > +
> > +     pr =3D acpi_driver_data(device);
> > +     if (!pr)
> > +             return -ENODEV;
> > +
> > +     /* Protect against concurrent CPU hotplug operations */
> > +     cpu_hotplug_disable();
> > +     result =3D acpi_cppc_processor_probe(pr);
> > +     cpu_hotplug_enable();
> > +
> > +     if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
> > +             dev_dbg(&device->dev, "CPPC data invalid or not present\n=
");
> > +
> > +     return 0;
> > +}
> > +
> >   static int acpi_processor_stop(struct device *dev)
> >   {
> >       struct acpi_device *device =3D ACPI_COMPANION(dev);
> I reproduced the issue described by this patch on the latest kernel at
> commit 45c13f3f9e3bb15f.
>
> On my system, CPU0 and CPU1 belong to the same software-coordinated
> frequency domain. After booting with maxcpus=3D1, CPU1 is present but
> offline, and its CPC descriptor is not parsed.
>
> Consequently, acpi_get_psd_map() skips CPU1 and constructs an
> incomplete shared_cpu_map containing only CPU0.
>
> When CPU1 is subsequently brought online:
>
> echo 1 > /sys/devices/system/cpu/cpu1/online
>
> the cpufreq core creates an overlapping policy and attempts to create
> the existing cpu0/cpufreq symbolic link again, resulting in the
> following warnings:
> ...
> sysfs_warn_dup
> sysfs_do_create_link_sd
> sysfs_create_link
> add_cpu_dev_symlink
> cpufreq_policy_online
> cpufreq_online
> cpuhp_cpufreq_online
> ...
> processor cpu0: cpufreq symlink creation failed
>
> freq_qos_add_request() called for active request
> WARNING: kernel/power/qos.c:658 at freq_qos_add_request
>
> The affected CPU masks are also inconsistent:
>
> $ cat /sys/devices/system/cpu/cpu0/cpufreq/affected_cpus
> 0
>
> $ cat /sys/devices/system/cpu/cpu1/cpufreq/affected_cpus
> 0 1
>
> After applying this patch on top of commit 45c13f3f9e3bb15f, the CPC
> descriptors are parsed before the CPUs are brought online. The
> shared_cpu_map is constructed correctly, and CPU1 can be brought
> online without triggering the duplicate sysfs link or active QoS
> request warnings.
>
> This patch fixes the issue in my testing. so=EF=BC=8C
>
> Tested-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> Reviewed-by: Pengjie Zhang <zhangpengjie2@huawei.com>

Thanks for this information!

I'll consider queuing up the patch as a fix for 7.3-rc next week.
