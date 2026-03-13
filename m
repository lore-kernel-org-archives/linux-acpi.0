Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C07377013
	for <linux-acpi@vger.kernel.org>; Fri, 13 Mar 2026 20:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773434018; cv=none; b=njKKbpXAX+1JzD4wFt/LkpyKuF9zeFAqNHWVNi9KlImLl6pIcqlM5v8PgYSCHEyWpSlp83h5CHv3grsD1+vhNFU721OmJbKq17WQZ/LvWHWVQx7HQD+zNiM74WYo/sYrEKHf/ubxSP+IcJ2j8rogr2QRYtvqhHZecvgMJuvv7DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773434018; c=relaxed/simple;
	bh=m3+M5+OULAFeHCpSmp11b7WVM+mtpz0VGLew+P/Flas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kh2JrMNj+kDmrsLax5oSesamPptpQgJykqJX0NOsFXDfNGliMX4n8vBhYSEMRFdAO5ZTEqVYwP5P0JX1hbUCtQRcfZj4hnBpH5L9ISJcwL5BMfd/EbGDd86uxCtGRuyTcP2S2j67nhCjuJFS/L/HZAeNMncq6NbHesqtEiOwgGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMIAisHG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMIAisHG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A89C2BCB5
	for <linux-acpi@vger.kernel.org>; Fri, 13 Mar 2026 20:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773434018;
	bh=m3+M5+OULAFeHCpSmp11b7WVM+mtpz0VGLew+P/Flas=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qMIAisHGQuw7h30IKezVN6BWsWdjn3btU91iif4JlgPXlDc+kPl9b53jxsG9lzk3F
	 OHSubBf2OLcXGGuO8UON2G6vfijOdoxXnhNy/AiAg20pGHorDKgKUwy74RrEtrctBR
	 QRMZsLaHSRUwfyi+ZvQyI2WaPM9+f561tmwMfb5XsGRHtXbGUSqxTxGuRsxNmr8Rn6
	 YhfRWDF5ZMOQs3AgSW/bESk+1ttYTGiOd4tx5fGhrtnBkqHl9UjQh0NpWMxv07bg/L
	 IRo2OcsxFKZnj6xi+vL9uliV+DC69pdhGID4RP+qLrHZtmpcG4jMQQtzLZX2rE4QTd
	 x9tb4ids20ELg==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d744d9acbeso1052628a34.1
        for <linux-acpi@vger.kernel.org>; Fri, 13 Mar 2026 13:33:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWB59n2YQqanC+pl1rtVWTr4xXSZRbI/eBB0pRvzspvzkA5hyCtxAujJ/s4TljSFtyGjSQb4wkHzKzI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Z6Ad4nOKw6FzAB73nVbO3KcX+3SDkv1ubCjDYDtiJk4xs0nG
	AxeayVpiT52RsSqwUp/l/hlsyIuF1a8D6GqBZDBXkH3ktCHio67iKKNWTfcKzw3JtfwNX7Ak5wl
	qoSyroM8H4CODHEnVJTyE86D/lRvtcgE=
X-Received: by 2002:a05:6820:151b:b0:67b:e203:6ca7 with SMTP id
 006d021491bc7-67be2037159mr1543017eaf.55.1773434017251; Fri, 13 Mar 2026
 13:33:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251226102656.6296-1-lkml@antheas.dev> <20251226102656.6296-8-lkml@antheas.dev>
In-Reply-To: <20251226102656.6296-8-lkml@antheas.dev>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Mar 2026 21:33:26 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h=RtkgfWXiWwG3w5xEY4VRrpP=TDmfJ5=UtKd_x_nTZw@mail.gmail.com>
X-Gm-Features: AaiRm51J4yHZCH3CB-xR2diBFWq0_GSaxuwwIcGe4clcgHeFuXOStvlNi9WRdw4
Message-ID: <CAJZ5v0h=RtkgfWXiWwG3w5xEY4VRrpP=TDmfJ5=UtKd_x_nTZw@mail.gmail.com>
Subject: Re: [RFC v1 7/8] PM: hibernate: Enter s2idle sleep state before hibernation
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: dmitry.osipenko@collabora.com, bob.beckett@collabora.com, 
	bookeldor@gmail.com, hadess@hadess.net, jaap@haitsma.org, 
	kernel@collabora.com, lennart@poettering.net, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mccann@jhu.edu, rafael@kernel.org, 
	richard@hughsie.com, sebastian.reichel@collabora.com, superm1@kernel.org, 
	systemd-devel@lists.freedesktop.org, xaver.hugl@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 26, 2025 at 11:27=E2=80=AFAM Antheas Kapenekakis <lkml@antheas.=
dev> wrote:
>
> Implement the standby states as part of hibernation. Specifically,
> ensure we are in the inactive state before hibernation entry, and
> sync the state as active after hibernation resume. In case of a failed
> hibernation, restore the previous standby state.

We've not mixed up "modern standby" _DSM calls with hibernation so
far, so this change is potentially risky.

> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  kernel/power/hibernate.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index af8d07bafe02..85a5ca8f6537 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -787,7 +787,11 @@ static int load_image_and_restore(void)
>   */
>  int hibernate(void)
>  {
> +#ifdef CONFIG_SUSPEND
> +       standby_state_t previous_standby;
> +#endif
>         bool snapshot_test =3D false;
> +       bool powered_down =3D false;
>         unsigned int sleep_flags;
>         int error;
>
> @@ -815,6 +819,13 @@ int hibernate(void)
>         }
>
>         pr_info("hibernation entry\n");
> +
> +#if CONFIG_SUSPEND
> +       /* Enter the standby screen off state in case userspace has not. =
*/
> +       previous_standby =3D pm_standby_get_state();
> +       pm_standby_transition(PM_STANDBY_INACTIVE);
> +#endif
> +
>         pm_prepare_console();
>         error =3D pm_notifier_call_chain_robust(PM_HIBERNATION_PREPARE, P=
M_POST_HIBERNATION);
>         if (error)
> @@ -867,10 +878,12 @@ int hibernate(void)
>                 error =3D swsusp_write(flags);
>                 swsusp_free();
>                 if (!error) {
> -                       if (hibernation_mode =3D=3D HIBERNATION_TEST_RESU=
ME)
> +                       if (hibernation_mode =3D=3D HIBERNATION_TEST_RESU=
ME) {
>                                 snapshot_test =3D true;
> -                       else
> +                       } else {
> +                               powered_down =3D true;
>                                 power_down();
> +                       }
>                 }
>                 in_suspend =3D 0;
>                 pm_restore_gfp_mask();
> @@ -897,6 +910,18 @@ int hibernate(void)
>   Notify:
>         pm_notifier_call_chain(PM_POST_HIBERNATION);
>   Restore:
> +#if CONFIG_SUSPEND
> +       /*
> +        * If we resumed from S5, we are in the active standby state. How=
ever,
> +        * the kernel restored a stale value. Sync it. Otherwise, in e.g.=
, the
> +        * case of a failed hibernation, transition to the previous value=
.
> +        */
> +       if (powered_down)
> +               pm_standby_set_state(PM_STANDBY_ACTIVE);
> +       else
> +               pm_standby_transition(previous_standby);
> +#endif
> +
>         pm_restore_console();
>         hibernate_release();
>   Unlock:
> --
> 2.52.0
>
>
>
