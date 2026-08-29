Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4484355048
	for <linux-acpi@vger.kernel.org>; Sat, 29 Aug 2026 18:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788026476; cv=pass; b=s9Ufiyh0q63Fn1hoE4m3ITPJyLWWIkEAY/HhAqsOc5+pmIUw+Q9Bg8CjayJOoxMkdMfLoOUvBnTGDT18B2cAR72E9yjFBsJgD2jgjnmsu0eJwRJllCkDHYEmWd0CFZbtVkJjjHiipOeEVKoWV14sZsuOvm3V2+voVmxIFcNR1q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788026476; c=relaxed/simple;
	bh=1sRd5a9TSWmSja6VRlyotOK7ik2WNHK6l/Mz8aJuXu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BnIhBYhwnt4SF9cC6rAEmA5D7tFREwALo7AMvxDyUs3J1kJeWESpglUTKHc1lK0DDACQZYE9YJgoaRG0fhwt21HpHqWMOtCjF6o4lTat/+GzGhuZhiIt8gv3Dpw3mIFTM3t4TzJyrqW3aBwPjOBsO7SbCyQt+4wqP1ESuhEQY4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lam2fuRR; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lam2fuRR"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-861feb6d61bso2400417b3.2
        for <linux-acpi@vger.kernel.org>; Sat, 29 Aug 2026 11:01:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788026473; cv=none;
        d=google.com; s=arc-20260327;
        b=elCmESs0yl44hNSFrx3fTLhXSiEDSNpAVi/QwXqUSwrV9P6H1UxCsWvVdhjHUh8Zwv
         VmS+K/c3MQYJS1MNHCQBdDaUXACzBuwRfACCrLEj0LRVpGxiT0pa/faqOm26sXGl5u/e
         HCi1QHaxCZkIW4Pwkn2mgBi+M97GIf2npfBjQg7I4Nm3nRGV8NVYy2YLK8Z0+c8jeiWz
         UkK+aDo7UAGnw9Kqau5005ivG6s3+xLs61nKIQDKtMODzMxHt+h/GK6o+De3E4b440hk
         qaNfBMJDb9JjqLJmI4cWjuVon0NHduKV7L8ZjsKUc7KGEr+67F4vGzqKi/syud5sNHVc
         W0CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zyAXQp/4jyOBzaaoOvY2wevc4HK2X1KILrGcqriZeX0=;
        fh=RsWzX1P23uhYI9BkzzgVmMNxRS5zUyb6nOcjMYx8C3g=;
        b=sJwr8AR0cKOzaSYND2B49287IFNJn6pZpaM7DQyjMJx+wJIFkShAaWPlFOEnnWmTUf
         FYhvmnuxvR/mRzYXO8QQ80fmwgyI12UZBU0a6INhOkRBZ2ZBvFzIKmze6pigRmdtLiL1
         DIBzi1Aj3DPTyUMFytOt2Q1cZyeNZxv2U9ld08i9STZJRqp8paZ4xPphioPQlRqCBmQZ
         IvWPwX/Izu/1K/ZKsaeornpu9encwrBakSbWtqFejUhFERgQeXBI/jrLb2ohcxhTly2D
         OJ6UV1/YKLD8vU6Xr1a0paBS79skS6F26igwUXpt/ZqJpTBc66a8z/8qZ4PkCEt++epa
         BP/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788026473; x=1788631273; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zyAXQp/4jyOBzaaoOvY2wevc4HK2X1KILrGcqriZeX0=;
        b=lam2fuRRCI1SABi3A+o7S3CBLkN52fBTZNtGvjrgyhoiP+vhyT9heOMbMbMBgqn1DX
         GQ6QvcXxWKPKmOo1uuqSv9UhRnevGTN2fafvhe2Lw538xFc14JkrR9UoX/EpNQ70ss4J
         0puWW5MRGr9i9IyN2nOjN6dtcMMk0hPvnMmaJuTvvrn7O+DbojgWMNJ1QHCUTI0ushmp
         0pBkc5mGbq+jTSLi0NIaTAYvWcclv1MfaKQMlTcycU3+tr2qX6wzWY0IzJgJz4Op2YXx
         CMUFwIsvXWy8X9BjoY25n8Biyw29meTMNxX9aoKvCBusW4imzFESfecfLPkECPYG14mV
         s9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788026473; x=1788631273;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zyAXQp/4jyOBzaaoOvY2wevc4HK2X1KILrGcqriZeX0=;
        b=W/j8jmrh1DB97h5YWGvk3ArDKmT0ZKDPVJwn9BBCi2vRrGSaJaKG0IsrmBAxH0LE9v
         ojaALROcvLzkJcZLagECfx918dAQgVmpfOpyUmdLHYU12bj5/vVBn1w5hQ/13d+etPai
         cRCgJCixmytsALxPPQEchf7JDj2NZjMbCysSimMrLHB9sg93bTE6kSd0yQ7q436dlWlg
         NuRfLkBW3ptK6mt83qPU6bJGZN0VEjQcbAmvp7KPk2W1IBLgqkeYX8SMXnYUU6bOo/HX
         kqHKIzbGJX833FyNyM1R5p/8ijPQXvHX7V/SfdU871RACoDHsftkY3qKucDbGfw9Ib/i
         EBHg==
X-Forwarded-Encrypted: i=1; AKwUvBzkTwsBFpW1ZGFl2zQ0DQ46yBnW+VkxfLCS/jPTq2uLZpLDHBhka5jVc4+7sQstni84+037/w2CE8FS@vger.kernel.org
X-Gm-Message-State: AFuF++k/U745dDvKvAgMnfpcBrL8iuvFZFYhBcMa8K8HHPL9FDS7nMvn
	O5a449DVowPJyD9yYVTLLrQD8MZnQBuiJoPLSOkz11O+1ECoH2IfX3c0a4qPSu6usTpwsmY/eGx
	nXffqqnm7/S4/vTfJJ/kefj4+iXrVwH8=
X-Gm-Gg: AYBFou3j64DHxEOa0iLD1HFmKdw0GSpvqdn2H24BXmpgPGnYGrJnNzTYyKcZYSAVfqV
	3zqVYwi15fgusxIdGBrIxz49Jnx0c4XBCdThnoJqrj4hUFEV7qXJkeITfLD/Mul/3GXci3BvFcC
	ihfzC0yi5M3SAYuWDd8lLUnfhQQ7ZI004/3VJnQA/VKoevJ34rPcMcprOcnx+OEIFhJECk/FQqR
	B57Fq4It2UN0Kz+fD/gSvwI9zVZLHEwmthFX0ie2PIJZw21tRw22wi+Dhc3Bistoa/ptWtS2NbY
	52NOTviVOgmHCYtjUmJN+E8mCXBXtTdkjLb6nbM2Iy4=
X-Received: by 2002:a05:690c:e3e8:b0:833:801:f715 with SMTP id
 00721157ae682-85d6cfc1a79mr59152097b3.18.1788026472590; Sat, 29 Aug 2026
 11:01:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260829164313.20905-1-sumeet4linux@gmail.com>
In-Reply-To: <20260829164313.20905-1-sumeet4linux@gmail.com>
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
Date: Sat, 29 Aug 2026 23:31:00 +0530
X-Gm-Features: AcwNN1WYnr1uptvCdY81tIYvIva0raUvmVHygkBNedNaoKNTLwZKfsJtCDX3RAA
Message-ID: <CAJ9orWSAYpCe1jq5aPNQ9H+ikt73+mZDTKbe-5MkVGJXihjEOA@mail.gmail.com>
Subject: Re: [PATCH] powercap: intel_rapl: Fix rapl_packages list corruption
To: rafael@kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Added linux-pm mailing list now. Earlier by mistake I sent it to acpi
mailing list.


On Sat, Aug 29, 2026 at 10:13=E2=80=AFPM Sumeet Pawnikar <sumeet4linux@gmai=
l.com> wrote:
>
> The rapl_packages list was previously documented as being guarded by the
> CPU hotplug lock (cpus_read_lock()). However, cpus_read_lock() is a
> reader-writer semaphore taken for shared read access. This provides zero
> mutual exclusion between multiple concurrent callers.
>
> Because auxiliary device probes (such as intel_rapl_tpmi_probe) can
> execute concurrently on different CPUs, multiple packages can race on
> list operations (list_add and list_del) inside
> rapl_add_package_cpuslocked() and rapl_remove_package_cpuslocked(),
> leading to list corruption.
>
> Introduce a dedicated rapl_packages_lock mutex to protect all additions,
> removals and iterations of the rapl_packages list.
>
> Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
> ---
>  drivers/powercap/intel_rapl_common.c | 29 ++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/inte=
l_rapl_common.c
> index 70cab5f08bc6..e544629dbe30 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -175,7 +175,8 @@ static u64 rapl_unit_xlate(struct rapl_domain *rd,
>                            enum unit_type type, u64 value, int to_raw);
>  static void package_power_limit_irq_save(struct rapl_package *rp);
>
> -static LIST_HEAD(rapl_packages);       /* guarded by CPU hotplug lock */
> +static DEFINE_MUTEX(rapl_packages_lock);
> +static LIST_HEAD(rapl_packages);       /* guarded by rapl_packages_lock =
*/
>
>  static const char *const rapl_domain_names[] =3D {
>         "package",
> @@ -1360,12 +1361,14 @@ static int rapl_pmu_event_init(struct perf_event =
*event)
>                 return -EINVAL;
>
>         /* Find out which Package the event belongs to */
> +       mutex_lock(&rapl_packages_lock);
>         list_for_each_entry(pos, &rapl_packages, plist) {
>                 if (is_rp_pmu_cpu(pos, event->cpu)) {
>                         rp =3D pos;
>                         break;
>                 }
>         }
> +       mutex_unlock(&rapl_packages_lock);
>         if (!rp)
>                 return -ENODEV;
>
> @@ -1445,9 +1448,11 @@ static ssize_t cpumask_show(struct device *dev,
>         cpumask_clear(cpu_mask);
>
>         /* Choose a cpu for each RAPL Package */
> +       mutex_lock(&rapl_packages_lock);
>         list_for_each_entry(rp, &rapl_packages, plist) {
>                 set_pmu_cpumask(rp, cpu_mask);
>         }
> +       mutex_unlock(&rapl_packages_lock);
>         cpus_read_unlock();
>
>         ret =3D sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpu_mask));
> @@ -1655,11 +1660,15 @@ void rapl_package_remove_pmu_locked(struct rapl_p=
ackage *rp)
>         if (!rp->has_pmu)
>                 return;
>
> +       mutex_lock(&rapl_packages_lock);
>         list_for_each_entry(pos, &rapl_packages, plist) {
>                 /* PMU is still needed */
> -               if (pos->has_pmu && pos !=3D rp)
> +               if (pos->has_pmu && pos !=3D rp) {
> +                       mutex_unlock(&rapl_packages_lock);
>                         return;
> +               }
>         }
> +       mutex_unlock(&rapl_packages_lock);
>
>         if (rapl_pmu.registered)
>                 perf_pmu_unregister(&rapl_pmu.pmu);
> @@ -1704,7 +1713,9 @@ void rapl_remove_package_cpuslocked(struct rapl_pac=
kage *rp)
>         /* do parent zone last */
>         powercap_unregister_zone(rp->priv->control_type,
>                                  &rd_package->power_zone);
> +       mutex_lock(&rapl_packages_lock);
>         list_del(&rp->plist);
> +       mutex_unlock(&rapl_packages_lock);
>         kfree(rp);
>  }
>  EXPORT_SYMBOL_NS_GPL(rapl_remove_package_cpuslocked, "INTEL_RAPL");
> @@ -1749,11 +1760,15 @@ struct rapl_package *rapl_find_package_domain_cpu=
slocked(int id, struct rapl_if_
>         else
>                 uid =3D id;
>
> +       mutex_lock(&rapl_packages_lock);
>         list_for_each_entry(rp, &rapl_packages, plist) {
> -               if (rp->id =3D=3D uid
> -                   && rp->priv->control_type =3D=3D priv->control_type)
> +               if (rp->id =3D=3D uid &&
> +                   rp->priv->control_type =3D=3D priv->control_type) {
> +                       mutex_unlock(&rapl_packages_lock);
>                         return rp;
> +               }
>         }
> +       mutex_unlock(&rapl_packages_lock);
>
>         return NULL;
>  }
> @@ -1810,7 +1825,9 @@ struct rapl_package *rapl_add_package_cpuslocked(in=
t id, struct rapl_if_priv *pr
>         ret =3D rapl_package_register_powercap(rp);
>         if (!ret) {
>                 INIT_LIST_HEAD(&rp->plist);
> +               mutex_lock(&rapl_packages_lock);
>                 list_add(&rp->plist, &rapl_packages);
> +               mutex_unlock(&rapl_packages_lock);
>                 return rp;
>         }
>
> @@ -1835,6 +1852,7 @@ static void power_limit_state_save(void)
>         int ret, i;
>
>         cpus_read_lock();
> +       mutex_lock(&rapl_packages_lock);
>         list_for_each_entry(rp, &rapl_packages, plist) {
>                 if (!rp->power_zone)
>                         continue;
> @@ -1846,6 +1864,7 @@ static void power_limit_state_save(void)
>                                 rd->rpl[i].last_power_limit =3D 0;
>                 }
>         }
> +       mutex_unlock(&rapl_packages_lock);
>         cpus_read_unlock();
>  }
>
> @@ -1856,6 +1875,7 @@ static void power_limit_state_restore(void)
>         int i;
>
>         cpus_read_lock();
> +       mutex_lock(&rapl_packages_lock);
>         list_for_each_entry(rp, &rapl_packages, plist) {
>                 if (!rp->power_zone)
>                         continue;
> @@ -1865,6 +1885,7 @@ static void power_limit_state_restore(void)
>                                 rapl_write_pl_data(rd, i, PL_LIMIT,
>                                                rd->rpl[i].last_power_limi=
t);
>         }
> +       mutex_unlock(&rapl_packages_lock);
>         cpus_read_unlock();
>  }
>
> --
> 2.43.0
>
