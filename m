Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097AB2512C8
	for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2026 20:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691800; cv=none; b=QwZ4SoyjkVSn9Uptf6kwjGaAX3xjP6O3CFTIY/qHh2tQaZD7uLu7KenE0+g6bp6uXFlYzxxdEKQF3vjsWEFLGt1YMoq/ptfr0Rt1waZsrY1yqvl1Ai6B9ojaSUhJOzrtWtv+ZhL4d14T7YIpR3WItJEuDT/ip75u7Uszce4hlCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691800; c=relaxed/simple;
	bh=gfGQiS6FjJ3gLU6inPYy5hj73FyZyWp43h+ava/SylI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLFiDFp/ggX62Y4LotLU4NR8ekOp0APaFhbRJOBvMiV17OBJ9vLnei7/P7zvIxHnfVjKnVkfGjytixHnDCGnxrGCbrtKHCTKlyq/02YkJ+9LTxU1dCHybYkSz4fnEXTEFZ4aAUOh83Kq9WRG3gPSfUo+N686juqgCE0OWlmY7oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=PP7CzKir; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="PP7CzKir"
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 7B17FBC032
	for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2026 22:09:57 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id D1579BC001
	for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2026 22:09:56 +0200 (EET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id A95021FEBD9
	for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2026 22:09:55 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1773691796;
	bh=2b5iC/R2V3SF1AcrHF7eiLaF2KlKqkyjDZRd1aiH8nM=;
	h=Received:From:Subject:To;
	b=PP7CzKirzxAZfIVcT+NCShzhtKIdcS7q4k3m4/rDZ/nWSIzJz/T03c4wQrCE3F27X
	 rGIIiZxHG5fy7WpMAJnAQFE9PiYt+ntZk5yJDqDqu/v74E0UUYGUgucMuiCP1Tau2T
	 LTB+xMRJcLErtHwjpkOoT3uFBMtExdU/JxE+p/CDHMp2Yb6SNeQas5+dpykbiai5u5
	 ppU/JUKKSEtKmKpmmRe2cgk28k9NxbVQ/AhiZ7nQwrJRpd6i/jQI+0nlP/YxLSdAuw
	 6wExXP1avdZDXOnex59TcedqI53awo+/SGB4h2OfkjEek2ryu6GO1GobKqL/owUs9y
	 ZPVsV4wd1EyyA==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.214.178) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pl1-f178.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2b04e6a989eso14104835ad.3
        for <linux-acpi@vger.kernel.org>;
 Mon, 16 Mar 2026 13:09:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVOGWcSkvMuqT+8o0vtSlYqgXWOoiUevXyXnT7K82yHXBA6aazzARE6n/BgItAp94JQ6x992TtCPZkb@vger.kernel.org
X-Gm-Message-State: AOJu0YymSaNbcp5vtkhpX8dm1Eb4Xvf71LtwEo+UYMBfZBvf9jZ51Fn8
	yhLV6u8Uf4qylZbC9c2UeiF28wTYiISam+X1XIkTEh0TH7oSVpSYwMoNSf4BcrQC/wAV6XfjqF7
	VZVNIyLEM2UWiDgfF9OIcU6KaxHYAFzs=
X-Received: by 2002:a17:903:1b6e:b0:2aa:d671:e613 with SMTP id
 d9443c01a7336-2aecab22677mr143371965ad.38.1773691794380; Mon, 16 Mar 2026
 13:09:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251226102656.6296-1-lkml@antheas.dev>
 <20251226102656.6296-8-lkml@antheas.dev>
 <CAJZ5v0h=RtkgfWXiWwG3w5xEY4VRrpP=TDmfJ5=UtKd_x_nTZw@mail.gmail.com>
In-Reply-To: 
 <CAJZ5v0h=RtkgfWXiWwG3w5xEY4VRrpP=TDmfJ5=UtKd_x_nTZw@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 16 Mar 2026 21:09:43 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwFgM64GOFuKKNo65w=bo2tREouY8cg_vpH=MjXa7B_SOA@mail.gmail.com>
X-Gm-Features: AaiRm51vk9SBQK8ynbmdbE36Ex78Iwaj66oqsQrjHmNxngB9PEF1ZNpa29s4U1Y
Message-ID: 
 <CAGwozwFgM64GOFuKKNo65w=bo2tREouY8cg_vpH=MjXa7B_SOA@mail.gmail.com>
Subject: Re: [RFC v1 7/8] PM: hibernate: Enter s2idle sleep state before
 hibernation
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: dmitry.osipenko@collabora.com, bob.beckett@collabora.com,
	bookeldor@gmail.com, hadess@hadess.net, jaap@haitsma.org,
	kernel@collabora.com, lennart@poettering.net, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, mccann@jhu.edu, richard@hughsie.com,
	sebastian.reichel@collabora.com, superm1@kernel.org,
	systemd-devel@lists.freedesktop.org, xaver.hugl@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <177369179616.3254746.5926988593281257390@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Fri, 13 Mar 2026 at 21:33, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Dec 26, 2025 at 11:27=E2=80=AFAM Antheas Kapenekakis <lkml@anthea=
s.dev> wrote:
> >
> > Implement the standby states as part of hibernation. Specifically,
> > ensure we are in the inactive state before hibernation entry, and
> > sync the state as active after hibernation resume. In case of a failed
> > hibernation, restore the previous standby state.
>
> We've not mixed up "modern standby" _DSM calls with hibernation so
> far, so this change is potentially risky.

Hi,
this patch can be dropped. I added it because I found in certain
devices, entering the hibernation flow and the subsequent ad hoc
reattaching of the USB subsystem to store the hibernation image can
cause these devices to turn on their vibration motor and leave it
stuck until hibernation completes (here, I assume the underlying cause
is the device briefly vibrates when initializing, but due to absent
initialization, it ends up stuck in that state).

So it is a bug fix. In any case, the commit message should state as
much if it is kept.

Antheas

> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >  kernel/power/hibernate.c | 29 +++++++++++++++++++++++++++--
> >  1 file changed, 27 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > index af8d07bafe02..85a5ca8f6537 100644
> > --- a/kernel/power/hibernate.c
> > +++ b/kernel/power/hibernate.c
> > @@ -787,7 +787,11 @@ static int load_image_and_restore(void)
> >   */
> >  int hibernate(void)
> >  {
> > +#ifdef CONFIG_SUSPEND
> > +       standby_state_t previous_standby;
> > +#endif
> >         bool snapshot_test =3D false;
> > +       bool powered_down =3D false;
> >         unsigned int sleep_flags;
> >         int error;
> >
> > @@ -815,6 +819,13 @@ int hibernate(void)
> >         }
> >
> >         pr_info("hibernation entry\n");
> > +
> > +#if CONFIG_SUSPEND
> > +       /* Enter the standby screen off state in case userspace has not=
. */
> > +       previous_standby =3D pm_standby_get_state();
> > +       pm_standby_transition(PM_STANDBY_INACTIVE);
> > +#endif
> > +
> >         pm_prepare_console();
> >         error =3D pm_notifier_call_chain_robust(PM_HIBERNATION_PREPARE,=
 PM_POST_HIBERNATION);
> >         if (error)
> > @@ -867,10 +878,12 @@ int hibernate(void)
> >                 error =3D swsusp_write(flags);
> >                 swsusp_free();
> >                 if (!error) {
> > -                       if (hibernation_mode =3D=3D HIBERNATION_TEST_RE=
SUME)
> > +                       if (hibernation_mode =3D=3D HIBERNATION_TEST_RE=
SUME) {
> >                                 snapshot_test =3D true;
> > -                       else
> > +                       } else {
> > +                               powered_down =3D true;
> >                                 power_down();
> > +                       }
> >                 }
> >                 in_suspend =3D 0;
> >                 pm_restore_gfp_mask();
> > @@ -897,6 +910,18 @@ int hibernate(void)
> >   Notify:
> >         pm_notifier_call_chain(PM_POST_HIBERNATION);
> >   Restore:
> > +#if CONFIG_SUSPEND
> > +       /*
> > +        * If we resumed from S5, we are in the active standby state. H=
owever,
> > +        * the kernel restored a stale value. Sync it. Otherwise, in e.=
g., the
> > +        * case of a failed hibernation, transition to the previous val=
ue.
> > +        */
> > +       if (powered_down)
> > +               pm_standby_set_state(PM_STANDBY_ACTIVE);
> > +       else
> > +               pm_standby_transition(previous_standby);
> > +#endif
> > +
> >         pm_restore_console();
> >         hibernate_release();
> >   Unlock:
> > --
> > 2.52.0
> >
> >
> >
>

