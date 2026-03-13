Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F23C3D9028
	for <linux-acpi@vger.kernel.org>; Fri, 13 Mar 2026 20:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773433773; cv=none; b=Y2/PNfLWSi+HJiDGrrk5bD13zSWOuCMGt1iErDZI7OE6jY7Q6MDbRiv2GN/wntgEtmZ8D6kMt5DxrR5yqbPLJoDoU5flBLUcpYqkIMAOocDRjZuRWj/6kWVEFd4Qh4mhi21fzCvaXdCbwozkkDwRm2CDFSXqdqoZychkx7Tmx8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773433773; c=relaxed/simple;
	bh=NqQv5lEDXEsBc40vuY6iqjRVxnwv8tjnUEZ8PWXAw7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WPUz6FCcJQG7Ahu18DYt8fycj7Hjd0pohT315fKjsZezIo5l9P0qaEunawW8B+EKsXSWcF/Wspo4XzOMltyHUaEa3yWSMSBmMaKOUxx0ooWSs0AraZwc6fXZzk2gCDcwITVrXgH3XYYF1xRExn5UNHXCbwJtd3voPVdGPvNl+B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MByMczDN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MByMczDN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1CAC2BCB8
	for <linux-acpi@vger.kernel.org>; Fri, 13 Mar 2026 20:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773433773;
	bh=NqQv5lEDXEsBc40vuY6iqjRVxnwv8tjnUEZ8PWXAw7M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MByMczDNVE+RcXXn0V6Us5qhZ70QT+4RgynTrGVB2dRhV6rq2f2BqiKoRvpO2CMnH
	 s91Dzped75ZowKmFf8E5dMLH+FyA7SptO0hF7Mt7GF1xO0C1tqagf/SKQyjwGiJk1S
	 pLTZm1oSK49A753b5M2x1/8r0IkVJcUSl+9goFgrdU4R4Y1U8Ovl/lX2ZLy+efh39i
	 9MvuFoM0ImcCJE5anD9tLLNtqCePr0iNwoXgCxWiV6eZUZ/zuNreao1F8ppL+Nh7Dz
	 xsLSQCUBw8RmW7t3YDMwlwWN88eN2JCTb8WYjQTM46ryPJFX41afVL76sphJ7T0xWW
	 5gHfSgh7l+CUQ==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-464bba3a9easo1786772b6e.0
        for <linux-acpi@vger.kernel.org>; Fri, 13 Mar 2026 13:29:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWVWjHNd1YCul+DKJr0fnrHdDRmScAESChuIs+Dk5JUXkPs9AZKqnDtZipUE8vwJYmrbOvxfQ7Mff+2@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7cFzTyO7UOD/K076JnceFNnDIAZO3FhQH/Oo+rErPgLgaiY3W
	TSl+stHapxduvNwhvh8OwevASMX3zwkEHvVxvowgO1imqSF1rXCWcctCbHIwZD99Yejtcm8VEvc
	DSfRgSwagDqLkHNOk6ghRHjy5LdCSpWs=
X-Received: by 2002:a05:6808:c1f9:b0:45e:6697:f983 with SMTP id
 5614622812f47-467570a1fe3mr2780180b6e.5.1773433771867; Fri, 13 Mar 2026
 13:29:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251226102656.6296-1-lkml@antheas.dev> <20251226102656.6296-4-lkml@antheas.dev>
In-Reply-To: <20251226102656.6296-4-lkml@antheas.dev>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Mar 2026 21:29:20 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jXg9LdAD9xSc=270r2W+imjzTmtM5a2rq-EfTVpxd+fw@mail.gmail.com>
X-Gm-Features: AaiRm51nBbhd2VSMc_CvxeV1RAEGlkvLGTCQN8UJ-fWkX_0zW_8ryUeCZgBOMOE
Message-ID: <CAJZ5v0jXg9LdAD9xSc=270r2W+imjzTmtM5a2rq-EfTVpxd+fw@mail.gmail.com>
Subject: Re: [RFC v1 3/8] acpi/x86: s2idle: add runtime standby transition function
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
> Add pm_standby_transition() to allow transitioning between standby
> states during runtime and implement it as part of the s2idle suspend
> sequence. Update the platform_s2idle_ops structure to include a function
> to perform firmware notifications and a function to get supported states
>
> Standby states are a way for userspace to indicate the interactivity of
> the system at the current moment. Active means that the user is
> interacting with the device, inactive that a user is not actively
> interacting with the device, and sleep that the system should appear as
> if it is suspended to the user, but may still perform small
> background tasks.
>
> For modern ACPI s0ix laptops, the inactive state turns off the
> backlight and the sleep state may limit the thermal envelope of the
> device. Either may pulse the power light. This patch introduces an ACPI
> agnostic structure to handle these transitions, so they may implemented
> by other platforms, and does not implement them for ACPI.

As already stated multiple times, the state-based terminology is not
particularly useful in my view.

I would prefer switching over to condition-indication-based terminology, li=
ke

inactive - indicate to the user that there's no activity related to
running user workloads in the system
snooze - indicate to the user that <the above> and the thermal
envelope may have changed
active - the system is active

> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  include/linux/suspend.h |  26 +++++++
>  kernel/power/suspend.c  | 153 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 179 insertions(+)
>
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index b02876f1ae38..916dee124758 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -40,6 +40,25 @@ typedef int __bitwise suspend_state_t;
>  #define PM_SUSPEND_MIN         PM_SUSPEND_TO_IDLE
>  #define PM_SUSPEND_MAX         ((__force suspend_state_t) 4)
>
> +typedef int __bitwise standby_state_t;
> +
> +#define PM_STANDBY_ACTIVE      ((__force standby_state_t) 0)
> +#define PM_STANDBY_INACTIVE    ((__force standby_state_t) 1)
> +#define PM_STANDBY_SLEEP       ((__force standby_state_t) 2)
> +#define PM_STANDBY_RESUME      ((__force standby_state_t) 3)
> +#define PM_STANDBY_MIN         PM_STANDBY_ACTIVE
> +#define PM_STANDBY_MAX         ((__force standby_state_t) 4)
> +
> +typedef int __bitwise standby_notification_t;
> +
> +#define PM_SN_INACTIVE_ENTRY   ((__force standby_notification_t) 0)
> +#define PM_SN_INACTIVE_EXIT    ((__force standby_notification_t) 1)
> +#define PM_SN_SLEEP_ENTRY      ((__force standby_notification_t) 2)
> +#define PM_SN_SLEEP_EXIT       ((__force standby_notification_t) 3)
> +#define PM_SN_RESUME           ((__force standby_notification_t) 4)
> +#define PM_SN_MIN              PM_STANDBY_DISPLAY_OFF
> +#define PM_SN_MAX              ((__force standby_notification_t) 5)
> +
>  /**
>   * struct platform_suspend_ops - Callbacks for managing platform depende=
nt
>   *     system sleep states.
> @@ -132,6 +151,8 @@ struct platform_suspend_ops {
>  };
>
>  struct platform_s2idle_ops {
> +       u8 (*get_standby_states)(void);
> +       int (*do_notification)(standby_notification_t state);

No, this needs to be separate from platform_s2idle_ops and maybe less ad-ho=
c.

>         int (*begin)(void);
>         int (*prepare)(void);
>         int (*prepare_late)(void);
> @@ -276,6 +297,11 @@ extern void arch_suspend_enable_irqs(void);
>
>  extern int pm_suspend(suspend_state_t state);
>  extern bool sync_on_suspend_enabled;
> +
> +extern void pm_standby_refresh_states(void);
> +extern int pm_standby_transition(standby_state_t state);
> +extern void pm_standby_set_state(standby_state_t state);
> +extern int pm_standby_get_state(void);
>  #else /* !CONFIG_SUSPEND */
>  #define suspend_valid_only_mem NULL
>
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 2da4482bb6eb..ede1ba483fa5 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -46,12 +46,21 @@ static const char * const mem_sleep_labels[] =3D {
>         [PM_SUSPEND_MEM] =3D "deep",
>  };
>  const char *mem_sleep_states[PM_SUSPEND_MAX];
> +static const char * const standby_labels[] =3D {
> +       [PM_STANDBY_ACTIVE] =3D "active",
> +       [PM_STANDBY_INACTIVE] =3D "inactive",
> +       [PM_STANDBY_SLEEP] =3D "sleep",
> +       [PM_STANDBY_RESUME] =3D "resume",
> +};
> +const char *standby_states[PM_STANDBY_MAX];
>
>  suspend_state_t mem_sleep_current =3D PM_SUSPEND_TO_IDLE;
>  suspend_state_t mem_sleep_default =3D PM_SUSPEND_MAX;
>  suspend_state_t pm_suspend_target_state;
>  EXPORT_SYMBOL_GPL(pm_suspend_target_state);
>
> +standby_state_t standby_current =3D PM_STANDBY_ACTIVE;
> +
>  unsigned int pm_suspend_global_flags;
>  EXPORT_SYMBOL_GPL(pm_suspend_global_flags);
>
> @@ -195,6 +204,9 @@ void __init pm_states_init(void)
>          * initialize mem_sleep_states[] accordingly here.
>          */
>         mem_sleep_states[PM_SUSPEND_TO_IDLE] =3D mem_sleep_labels[PM_SUSP=
END_TO_IDLE];
> +
> +       /* Always support the active runtime standby state. */
> +       standby_states[PM_STANDBY_ACTIVE] =3D standby_labels[PM_STANDBY_A=
CTIVE];
>  }
>
>  static int __init mem_sleep_default_setup(char *str)
> @@ -334,6 +346,141 @@ static bool platform_suspend_again(suspend_state_t =
state)
>                 suspend_ops->suspend_again() : false;
>  }
>
> +static int platform_standby_notify(standby_notification_t state)
> +{
> +       return s2idle_ops && s2idle_ops->do_notification ?
> +                      s2idle_ops->do_notification(state) :
> +                      0;
> +}
> +
> +/**
> + * pm_standby_refresh_states - Refresh the supported runtime standby sta=
tes
> + */
> +void pm_standby_refresh_states(void)
> +{
> +       u8 standby_support =3D s2idle_ops && s2idle_ops->get_standby_stat=
es ?
> +                                    s2idle_ops->get_standby_states() :
> +                                    0;
> +
> +       standby_states[PM_STANDBY_INACTIVE] =3D
> +               standby_support & BIT(PM_STANDBY_INACTIVE) ?
> +                       standby_labels[PM_STANDBY_INACTIVE] :
> +                       NULL;
> +       standby_states[PM_STANDBY_SLEEP] =3D
> +               standby_support & BIT(PM_STANDBY_SLEEP) ?
> +                       standby_labels[PM_STANDBY_SLEEP] :
> +                       NULL;
> +       standby_states[PM_STANDBY_RESUME] =3D
> +               standby_support & BIT(PM_STANDBY_RESUME) ?
> +                       standby_labels[PM_STANDBY_RESUME] :
> +                       NULL;
> +}
> +EXPORT_SYMBOL_GPL(pm_standby_refresh_states);
> +
> +/**
> + * pm_standby_transition - Transition between standby states
> + *
> + * Configure the runtime standby state of the system. Entering these sta=
tes
> + * may change the appearance of the system (e.g., keyboard backlight) or=
 limit
> + * the thermal envelope of the system (e.g., PLx to 5W).
> + *
> + * Returns an error if the transition fails. The function does not rollb=
ack.
> + */
> +int pm_standby_transition(standby_state_t state)
> +{
> +       int error;
> +
> +       if (state =3D=3D standby_current)
> +               return 0;
> +       if (state > PM_STANDBY_MAX)
> +               return -EINVAL;
> +
> +       pm_standby_refresh_states();
> +
> +       pm_pr_dbg("Transitioning from standby state %s to %s\n",
> +                 standby_states[standby_current], standby_states[state])=
;
> +
> +       /* Resume can only be entered if we are on the sleep state. */
> +       if (state =3D=3D PM_STANDBY_RESUME) {
> +               if (standby_current !=3D PM_STANDBY_SLEEP)
> +                       return -EINVAL;
> +               standby_current =3D PM_STANDBY_RESUME;
> +               return platform_standby_notify(PM_SN_RESUME);
> +       }
> +
> +       /*
> +        * The system should not be able to re-enter Sleep from resume as=
 it
> +        * is undefined behavior. As part of setting the state to "Resume=
",
> +        * userspace promised a transition to "Inactive" or "Active".
> +        */
> +       if (standby_current =3D=3D PM_STANDBY_RESUME && state =3D=3D PM_S=
TANDBY_SLEEP)
> +               return -EINVAL;
> +
> +       /* Resume is the Sleep state logic-wise. */
> +       if (standby_current =3D=3D PM_STANDBY_RESUME)
> +               standby_current =3D PM_STANDBY_SLEEP;
> +
> +       if (standby_current < state) {
> +               for (; standby_current < state; standby_current++) {
> +                       switch (standby_current + 1) {
> +                       case PM_STANDBY_INACTIVE:
> +                               error =3D platform_standby_notify(PM_SN_I=
NACTIVE_ENTRY);
> +                               break;
> +                       case PM_STANDBY_SLEEP:
> +                               error =3D platform_standby_notify(PM_SN_S=
LEEP_ENTRY);
> +                               break;
> +                       }
> +
> +                       if (error) {
> +                               /* Rollback to previous valid state */
> +                               while (standby_current > PM_STANDBY_ACTIV=
E &&
> +                                      !standby_states[standby_current])
> +                                       standby_current--;
> +                               return error;
> +                       }
> +               }
> +       } else if (standby_current > state) {
> +               for (; standby_current > state; standby_current--) {
> +                       switch (standby_current) {
> +                       case PM_STANDBY_SLEEP:
> +                               error =3D platform_standby_notify(PM_SN_S=
LEEP_EXIT);
> +                               break;
> +                       case PM_STANDBY_INACTIVE:
> +                               error =3D platform_standby_notify(PM_SN_I=
NACTIVE_EXIT);
> +                               break;
> +                       }
> +
> +                       if (error) {
> +                               /* Rollback to previous valid state */
> +                               while (standby_current < PM_STANDBY_SLEEP=
 &&
> +                                      !standby_states[standby_current])
> +                                       standby_current++;
> +                               return error;
> +                       }
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +/**
> + * pm_standby_set_state - Set the current standby state and skip the tra=
nsition
> + */
> +void pm_standby_set_state(standby_state_t state)
> +{
> +       standby_current =3D state;
> +}
> +EXPORT_SYMBOL_GPL(pm_standby_set_state);
> +
> +/**
> + * pm_standby_get_state - Returns the current standby state
> + */
> +int pm_standby_get_state(void)
> +{
> +       return standby_current;
> +}
> +EXPORT_SYMBOL_GPL(pm_standby_get_state);
> +
>  #ifdef CONFIG_PM_DEBUG
>  static unsigned int pm_test_delay =3D 5;
>  module_param(pm_test_delay, uint, 0644);
> @@ -572,6 +719,7 @@ static void suspend_finish(void)
>   */
>  static int enter_state(suspend_state_t state)
>  {
> +       standby_state_t standby_prior;
>         int error;
>
>         trace_suspend_resume(TPS("suspend_enter"), state, true);
> @@ -588,6 +736,9 @@ static int enter_state(suspend_state_t state)
>         if (!mutex_trylock(&system_transition_mutex))
>                 return -EBUSY;
>
> +       standby_prior =3D standby_current;
> +       pm_standby_transition(PM_STANDBY_SLEEP);

I'm not sure if it is actually safe to evaluate PNP0D80 _DSM function
7 (sleep entry notification) at this point because of possible
ordering constraints.

As I said once before in another thread, I would like the platform
notifications to be moved to the places in which you want them to take
place before making any other changes and only once this is proven to
work, further changes can be made.

> +
>         if (state =3D=3D PM_SUSPEND_TO_IDLE)
>                 s2idle_begin();
>
> @@ -619,6 +770,8 @@ static int enter_state(suspend_state_t state)
>         pm_pr_dbg("Finishing wakeup.\n");
>         suspend_finish();
>   Unlock:
> +       pm_standby_transition(standby_prior);
> +
>         mutex_unlock(&system_transition_mutex);
>         return error;
>  }
> --
