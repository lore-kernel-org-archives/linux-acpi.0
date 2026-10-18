Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A1446F495
	for <linux-acpi@vger.kernel.org>; Sun, 18 Oct 2026 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792335266; cv=pass; b=bYIawiB6XS/Fqm7SVgKQYgIGhMk829UKTEWVbg5sDq7Gd7RFrfS8IjWrUOogpV1ds5ImAgEO97L4W6LW0sKlQetoYtUz6RY59NgBdVKrLRyrroYcxyRpWGexEvu93wXE4yOr1V3186/OIBwIOl6bM8aWNTmytadIBH9CBUoTD9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792335266; c=relaxed/simple;
	bh=us5iu7Xf4jbhJWzNY5zatJGie2iJ2wd4i8aHGpW0qSs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=R8KnBxdtohY5SKEJIavLA3/kqUkpj+gMYvgyBl97NcGnypWN2+uyBBCCMjh8nRR0G6dBwNkwCr8N+pQphofrgx7f3fURXmZy1jbRrOQtWj9U0X0rE4dbv86DeL9bbtDID+zxDDiVsEAtWmz3Tq8pnOWYAAHJ59HVA6Z+QQQPoq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LC6ffU6w; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LC6ffU6w"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-679a2b5fe87so1142787d50.3
        for <linux-acpi@vger.kernel.org>; Sun, 18 Oct 2026 07:54:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792335264; cv=none;
        d=google.com; s=arc-20260327;
        b=fFOMcV5fts1A2NDA0dvuddPE3Y0qEs+7M8Mmfly+kMo5B7BgOXbFfCBnpsKDvbWQlU
         m04OS66+9EjM9bdqW+/O++uCTS3xHWyomDezo5K34z6e7Zwrqr03Km1qXW+PzXArcGRF
         nQHxY7GQ999VjR/ydf0nX0eEbQ0nEKz1l1dd9Ax9nctwt9qRsuHdJNL4biX6EYr1/Yrp
         NWDLpOI8rlK7j4MeKk1gr35Lrmpg5OX8jcysvzbJGH1QtjxuC6lHtYBAGrfAG3Up8CvR
         ywq5dYVCURncoD/rrMYaANNJtI8bpLVhBQ0NyoJ6O+pB5nS5vuXk4hLje01dOwgqwX4L
         vKiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=27GANpvUaytbvILRLXHlHUpLnChBxOoM+toFOE7EJG0=;
        fh=64/UrBDGMBH5NtiAJk2BWI/QNj6U23coLuL2o/vnHDg=;
        b=Q8tz0jF87ulELkY9ElC6xYj+wzCo/ZIWW0xRSUBG6G9FY6HXaG7Ne6THcqxVLjCRgq
         7bMKiTab+SyG+dveFy6Kc2Z7fmD1yxjfZN1KAVsZ59H+Ei5lx4aVQAxpGsDLIoDfb5JZ
         VUOT4EIJrY+AkQmkvMzYxrTTwPH/acCdAUOO25KFYt/mIyxAE8JLPKe0mWhjPUB/Maw6
         RXXM5BYpdK4Eu64F1+uNurtxn6ObApJ1kASYovSHT0h2qFOOm+zO5sBtiyCwCIPc2ndZ
         BtXfRgm7jrg8DbBRG10xH9KPgjwS3bkjPM+uPIHDSZRInQp5N869OoPt+MMUY1yrPnYk
         UDKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792335264; x=1792940064; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=27GANpvUaytbvILRLXHlHUpLnChBxOoM+toFOE7EJG0=;
        b=LC6ffU6wm6TWGaxhjR4boPQaPY2zXc2utXfHb1HoHKRwvhis6tnyY8z73VSpYVK7K2
         kwblqhGHKb84lWPjUIREhiWQ41sAfFUvQ6SK35kpWqY9PGiDtfNZbHhnxv9W7Z+vs9iO
         ELa72neDlS7HxtRlkaiVFfcBro3eY+9KKJTXebrL4MW/7xbPFbb4IGzmsP7iOiOqUkk0
         WagLLMkPMjoBexSr/IkmnekeP1oANR8O4LJ56D3zERpU3EhMNPvup9yTwix7tU5T8fei
         3RmXOcYdqQIef7eeCscwl72aoRKIzsDpMKX3cOztLKql2Iz+2mhmv8hN+cNyhFXQEgBJ
         Uc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792335264; x=1792940064;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=27GANpvUaytbvILRLXHlHUpLnChBxOoM+toFOE7EJG0=;
        b=njNvkwhF68mu3DcbeyYMF02qrLST6SoH9Vr7WLfU0BCoh6UNEAbMJ0xwfiMoEe1NSS
         WOjOhjUpGCdCWvVjOJhoUMkc7Ohzk8eWcyJgTR8OUv6rvRe3Eskwdgq1RuNoO/PMqh0C
         lc4JWeipjCfGcW35v+GbocSAAD5lXtiTbZwBxLWr19O229xs3FTGVS9fspBhqAdWs+4I
         hz0WF1mx8rzhzxW64HQAYl5DnE6JnbmXUMh0zoCUuh0G0+rFFJrZwVT16MF/oyHcVlUR
         2NKpnFEKQrNVRAaQAzH5UKWjXKbwA4+hnnNYiudrqPFQ2SL7qAnjZqPBxGe5xj1j9Y8n
         4Nuw==
X-Gm-Message-State: AFq9FYLTg5kEUId7NYssBac37n4CfQziDOK6NLPzfTRXq/9x8SVlwb6X
	jlWuFWsVzu5VwuxLz0xigXDYACw7ZVHZjPK90ag7meX6CPSHuZ2CMXMWxgkGOIvDdRaTHuxwUwX
	xxF5csHosIqT4SFczA4F4mCalFkaArP8=
X-Gm-Gg: AYBFou2GbYrzmoFA4KHQqi+4fRpa0OoDqaooiE064hiZJeDs06xar6dYGn0frq/7TOI
	ZBm+3RdUMxg5b2jJghs7p7Xm0TzvdoQ1UVOWQcOkujYuqEdsqycxCmqPzVjAsvydzrqwHyTpK0w
	musRG2XRkvwIduX+EpVARRZwzFDSprFQPDDinn+ey67ChXf6lmH1PBROx8BIVnELvoBuR24i1v+
	qZ9n7MDx0TFM9eBp/3ZT/HuNGMrh1ayTvd1jVZtjoiGHevVovOERf6baqJxSxlaWpymXLSIJEFL
	vevmO7FMGM763Sm5g1UkQ4SAULboWiPgdyqh9qYm8iaaWQVqzaTC
X-Received: by 2002:a05:690c:c58d:b0:8b0:f116:11fe with SMTP id
 00721157ae682-8b0f21b53ddmr11613087b3.50.1792335263774; Sun, 18 Oct 2026
 07:54:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zhang DM <jixianqiang1540@gmail.com>
Date: Sun, 18 Oct 2026 22:54:11 +0800
X-Gm-Features: AclHuK8ilgUfNnbLioZxoVOUsVo2jNQ8742md6YglSbmB-20JRYe7veeKgjVBvg
Message-ID: <CAKtWk0YJS_+Wonysfo1DB41stP30FMm824vdp5DTjO=bVT_oLw@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] platform profile: Separate handler locking from
 sysfs lifetime
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

Confirming the lock/lifetime inversion this series fixes is reachable in
production: we hit it as a hard, SIGKILL-immune D-state wedge, 3/3 boots,
on 7.3.0-rc6 (AMD Zen, CachyOS build of stock rc6) =E2=80=94 three days aft=
er v1
was posted.

Trigger and cycle, matching your 1/4 analysis exactly:

  Writing `dynamic` to policyX/energy_performance_preference runs
  store_energy_performance_preference under down_write(&policy->rwsem)
  (cpufreq core store wrapper, guard(cpufreq_policy_write)). On the
  non-dynamic->dynamic transition, amd_pstate_set_dynamic_epp() calls
  platform_profile_register() from under that rwsem. platform_profile_
  register() holds profile_lock across device_register(), sysfs_notify()
  and sysfs_update_group(); the update removes/recreates the
  `platform_profile` attribute, and kernfs_drain() then waits for the
  =E2=86=93 the repo goes public now. please add reference to the draft
                                       22:45
 =E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=
=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=
=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=
=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=
=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=
=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=
=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=
=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=
=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=
=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=
=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=
=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=
=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=
=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80
  immediately before the update wakes inotify watchers of
  /sys/firmware/acpi/platform_profile (asusd here) that enter the file
  inside the window. The store never returns, policy->rwsem stays
  write-held, and every cpufreq/platform_profile/power_supply sysfs user
  wedges in TASK_UNINTERRUPTIBLE. Same cycle exists in
  platform_profile_remove().

So: ABBA between profile_lock and the kernfs active-ref drain, exactly as
described in your patch; we believe 1/4 is the right fix (separate
registration lock, unlink under profile_lock before device_unregister,
drop the mutex before anything that can drain active refs).

Secondary ask, for amd-pstate (not your patch's problem, but it is why
this bug is so destructive here): amd_pstate_set_dynamic_epp()/
clear_dynamic_epp() do blocking device/sysfs registration plus
power_supply_(un)reg_notifier from inside the cpufreq store callback,
i.e. long, lock-heavy work under a hot per-policy rwsem. Deferring that
registration to a workqueue (or to cpu init/exit) would take
policy->rwsem out of the blast radius.

Evidence: reproduced 3/3 boots with a concurrent platform_profile
watcher at register time, 0/1 without; lockdep is off in this config
(no splat). Full write-up, public in ZhangDM-520/system-tuning:
  attribution (source <-> vmlinux mapping):
    https://github.com/ZhangDM-520/system-tuning/blob/master/docs/research/=
2026-10-17-epp-deadlock-kernel-attribution.md
  boot journals and initial forensics:
    https://github.com/ZhangDM-520/system-tuning/blob/master/docs/research/=
2026-10-17-boot-epp-deadlock-report.md

Thanks,
ZhangDM
