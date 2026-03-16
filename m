Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9866F3382DE
	for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2026 20:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691625; cv=none; b=IniEhhT5+hpp++fgeor1YrTl3kKrXWqf3bgaMqFt5y+ybxU9bH1BIW8XVt1W4d+W/o/SXXyXvZouQ5cClRvso/KFHZa6nd58PrBzFv+xOVLQCtHZZmTKnn+e/7uhmUcJnBmQMepYqHhU3imRT7Aq4YzIUsHfgrMzgXzL2I2nfC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691625; c=relaxed/simple;
	bh=Wk5nqtoBBl4/2v0h8X4KnPGtkTBdOTdCPnmjCycahxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GIXwDMAzjvZwEBvscRfg95j5KC5wQ+lexMh+qvdsAAXMuSyRudqbfRWbg5DHglWwAR1waQQKaM9msbxmBXNAJsxeeXBs3SZ1to3NYAd75O4S3LLbz2ZBCmjWRgvPoYuUbSoxgpIvDms2T44SvD65E2s1SCNUeD0fm48ekqrcDiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=kxNqfWBe; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="kxNqfWBe"
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 126D8C7D00
	for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2026 22:07:02 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 183DFC7E41
	for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2026 22:07:01 +0200 (EET)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id E5ED01FD468
	for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2026 22:06:59 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1773691620;
	bh=8DQiOtOdiMoC5gwOFl+RiQU1JxvauLRbaXD3zWYH/dI=;
	h=Received:From:Subject:To;
	b=kxNqfWBei1LL2ootllUaReWsg4kOgajVT2vlpzc1ekACE/CkIqm0Q3+0YxNZbo9Gh
	 9k+F9q68QGgh4AFGHPlMB2H2TWCjiODHf4EWqqawgdYtHwF/tOFSnsk2AY6EQuavRf
	 igRHmtJulLtwkJz8hWjMA6x7Kk4BVr5QPTIxnUsoC68Kllpqq3YK6ARAMQMtwR8Ahp
	 /F3J8zGTemAVUhOAbCu7NDW0KNNvBT8qPpwI0zobIY4D4lSgiUFlLJwsiVMGjqcKJv
	 3BcMyV2yVnXWGiw97UZYrgRDFa+Q2ZM3X3UDlzMkO+vzzJZvIeS1fp7WTHlY4fVESy
	 x19QYAqTXsfEQ==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.215.176) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pg1-f176.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-c73d251b93bso43250a12.0
        for <linux-acpi@vger.kernel.org>;
 Mon, 16 Mar 2026 13:06:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVObNrokXMYIkehMbhf92SOIYhlcdZDMU7P+7z2QkaEdB9WyMtdp5qE/eIKsk5WfT81YAueWAOblIgP@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0eJL6J9mDkSft3qNvu+6ogopiToGyO4N0k2ZvHcoy0sVHj8D0
	HB7gPk7R0ybcXfPn8fmVhEjx98MVu5m1Wv4k3sMnHu0GGztuqUQtvsIxnP4mwuiSnffSm9Fl8F5
	CQdK5VBn8GM32MSDujcTCnIuKBBMtxJU=
X-Received: by 2002:a05:6a20:d43:b0:398:5f66:bf59 with SMTP id
 adf61e73a8af0-39b7e0766e4mr611511637.36.1773691618692; Mon, 16 Mar 2026
 13:06:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251226102656.6296-1-lkml@antheas.dev>
 <20251226102656.6296-4-lkml@antheas.dev>
 <CAJZ5v0jXg9LdAD9xSc=270r2W+imjzTmtM5a2rq-EfTVpxd+fw@mail.gmail.com>
In-Reply-To: 
 <CAJZ5v0jXg9LdAD9xSc=270r2W+imjzTmtM5a2rq-EfTVpxd+fw@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 16 Mar 2026 21:06:47 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwG4XtirfHtzz7-qLWx2LQpTJtqPW+iF6whKbicd2ecVqw@mail.gmail.com>
X-Gm-Features: AaiRm52sJsTHtW08jgzDWX5Hwb3uTDwayraO6C-RyyZVdWgLhoiLcBwsGtEL7Sg
Message-ID: 
 <CAGwozwG4XtirfHtzz7-qLWx2LQpTJtqPW+iF6whKbicd2ecVqw@mail.gmail.com>
Subject: Re: [RFC v1 3/8] acpi/x86: s2idle: add runtime standby transition
 function
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
 <177369162043.3241564.10394567239655999087@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Fri, 13 Mar 2026 at 21:29, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Dec 26, 2025 at 11:27=E2=80=AFAM Antheas Kapenekakis <lkml@anthea=
s.dev> wrote:
> >
> > Add pm_standby_transition() to allow transitioning between standby
> > states during runtime and implement it as part of the s2idle suspend
> > sequence. Update the platform_s2idle_ops structure to include a functio=
n
> > to perform firmware notifications and a function to get supported state=
s
> >
> > Standby states are a way for userspace to indicate the interactivity of
> > the system at the current moment. Active means that the user is
> > interacting with the device, inactive that a user is not actively
> > interacting with the device, and sleep that the system should appear as
> > if it is suspended to the user, but may still perform small
> > background tasks.
> >
> > For modern ACPI s0ix laptops, the inactive state turns off the
> > backlight and the sleep state may limit the thermal envelope of the
> > device. Either may pulse the power light. This patch introduces an ACPI
> > agnostic structure to handle these transitions, so they may implemented
> > by other platforms, and does not implement them for ACPI.
>
> As already stated multiple times, the state-based terminology is not
> particularly useful in my view.

I can reword the commit message. However, here, can you be a bit more
specific? Are you also referring to the underlying implementation? If
yes, how should that change.

If the user goes from active -> snooze, there needs to be a transition
in the underlying implementation (ie we cannot skip the inactive
callbacks).

> I would prefer switching over to condition-indication-based terminology, =
like
>
> inactive - indicate to the user that there's no activity related to
> running user workloads in the system
> snooze - indicate to the user that <the above> and the thermal
> envelope may have changed
> active - the system is active
>
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >  include/linux/suspend.h |  26 +++++++
> >  kernel/power/suspend.c  | 153 ++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 179 insertions(+)
> >
> > diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> > index b02876f1ae38..916dee124758 100644
> > --- a/include/linux/suspend.h
> > +++ b/include/linux/suspend.h
> > @@ -40,6 +40,25 @@ typedef int __bitwise suspend_state_t;
> >  #define PM_SUSPEND_MIN         PM_SUSPEND_TO_IDLE
> >  #define PM_SUSPEND_MAX         ((__force suspend_state_t) 4)
> >
> > +typedef int __bitwise standby_state_t;
> > +
> > +#define PM_STANDBY_ACTIVE      ((__force standby_state_t) 0)
> > +#define PM_STANDBY_INACTIVE    ((__force standby_state_t) 1)
> > +#define PM_STANDBY_SLEEP       ((__force standby_state_t) 2)
> > +#define PM_STANDBY_RESUME      ((__force standby_state_t) 3)
> > +#define PM_STANDBY_MIN         PM_STANDBY_ACTIVE
> > +#define PM_STANDBY_MAX         ((__force standby_state_t) 4)
> > +
> > +typedef int __bitwise standby_notification_t;
> > +
> > +#define PM_SN_INACTIVE_ENTRY   ((__force standby_notification_t) 0)
> > +#define PM_SN_INACTIVE_EXIT    ((__force standby_notification_t) 1)
> > +#define PM_SN_SLEEP_ENTRY      ((__force standby_notification_t) 2)
> > +#define PM_SN_SLEEP_EXIT       ((__force standby_notification_t) 3)
> > +#define PM_SN_RESUME           ((__force standby_notification_t) 4)
> > +#define PM_SN_MIN              PM_STANDBY_DISPLAY_OFF
> > +#define PM_SN_MAX              ((__force standby_notification_t) 5)
> > +
> >  /**
> >   * struct platform_suspend_ops - Callbacks for managing platform depen=
dent
> >   *     system sleep states.
> > @@ -132,6 +151,8 @@ struct platform_suspend_ops {
> >  };
> >
> >  struct platform_s2idle_ops {
> > +       u8 (*get_standby_states)(void);
> > +       int (*do_notification)(standby_notification_t state);
>
> No, this needs to be separate from platform_s2idle_ops and maybe less ad-=
hoc.

Can you suggest an alternative location? I would prefer to avoid
introducing a new struct.

> >         int (*begin)(void);
> >         int (*prepare)(void);
> >         int (*prepare_late)(void);
> > @@ -276,6 +297,11 @@ extern void arch_suspend_enable_irqs(void);
> >
> >  extern int pm_suspend(suspend_state_t state);
> >  extern bool sync_on_suspend_enabled;
> > +
> > +extern void pm_standby_refresh_states(void);
> > +extern int pm_standby_transition(standby_state_t state);
> > +extern void pm_standby_set_state(standby_state_t state);
> > +extern int pm_standby_get_state(void);
> >  #else /* !CONFIG_SUSPEND */
> >  #define suspend_valid_only_mem NULL
> >
> > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > index 2da4482bb6eb..ede1ba483fa5 100644
> > --- a/kernel/power/suspend.c
> > +++ b/kernel/power/suspend.c
> > @@ -46,12 +46,21 @@ static const char * const mem_sleep_labels[] =3D {
> >         [PM_SUSPEND_MEM] =3D "deep",
> >  };
> >  const char *mem_sleep_states[PM_SUSPEND_MAX];
> > +static const char * const standby_labels[] =3D {
> > +       [PM_STANDBY_ACTIVE] =3D "active",
> > +       [PM_STANDBY_INACTIVE] =3D "inactive",
> > +       [PM_STANDBY_SLEEP] =3D "sleep",
> > +       [PM_STANDBY_RESUME] =3D "resume",
> > +};
> > +const char *standby_states[PM_STANDBY_MAX];
> >
> >  suspend_state_t mem_sleep_current =3D PM_SUSPEND_TO_IDLE;
> >  suspend_state_t mem_sleep_default =3D PM_SUSPEND_MAX;
> >  suspend_state_t pm_suspend_target_state;
> >  EXPORT_SYMBOL_GPL(pm_suspend_target_state);
> >
> > +standby_state_t standby_current =3D PM_STANDBY_ACTIVE;
> > +
> >  unsigned int pm_suspend_global_flags;
> >  EXPORT_SYMBOL_GPL(pm_suspend_global_flags);
> >
> > @@ -195,6 +204,9 @@ void __init pm_states_init(void)
> >          * initialize mem_sleep_states[] accordingly here.
> >          */
> >         mem_sleep_states[PM_SUSPEND_TO_IDLE] =3D mem_sleep_labels[PM_SU=
SPEND_TO_IDLE];
> > +
> > +       /* Always support the active runtime standby state. */
> > +       standby_states[PM_STANDBY_ACTIVE] =3D standby_labels[PM_STANDBY=
_ACTIVE];
> >  }
> >
> >  static int __init mem_sleep_default_setup(char *str)
> > @@ -334,6 +346,141 @@ static bool platform_suspend_again(suspend_state_=
t state)
> >                 suspend_ops->suspend_again() : false;
> >  }
> >
> > +static int platform_standby_notify(standby_notification_t state)
> > +{
> > +       return s2idle_ops && s2idle_ops->do_notification ?
> > +                      s2idle_ops->do_notification(state) :
> > +                      0;
> > +}
> > +
> > +/**
> > + * pm_standby_refresh_states - Refresh the supported runtime standby s=
tates
> > + */
> > +void pm_standby_refresh_states(void)
> > +{
> > +       u8 standby_support =3D s2idle_ops && s2idle_ops->get_standby_st=
ates ?
> > +                                    s2idle_ops->get_standby_states() :
> > +                                    0;
> > +
> > +       standby_states[PM_STANDBY_INACTIVE] =3D
> > +               standby_support & BIT(PM_STANDBY_INACTIVE) ?
> > +                       standby_labels[PM_STANDBY_INACTIVE] :
> > +                       NULL;
> > +       standby_states[PM_STANDBY_SLEEP] =3D
> > +               standby_support & BIT(PM_STANDBY_SLEEP) ?
> > +                       standby_labels[PM_STANDBY_SLEEP] :
> > +                       NULL;
> > +       standby_states[PM_STANDBY_RESUME] =3D
> > +               standby_support & BIT(PM_STANDBY_RESUME) ?
> > +                       standby_labels[PM_STANDBY_RESUME] :
> > +                       NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(pm_standby_refresh_states);
> > +
> > +/**
> > + * pm_standby_transition - Transition between standby states
> > + *
> > + * Configure the runtime standby state of the system. Entering these s=
tates
> > + * may change the appearance of the system (e.g., keyboard backlight) =
or limit
> > + * the thermal envelope of the system (e.g., PLx to 5W).
> > + *
> > + * Returns an error if the transition fails. The function does not rol=
lback.
> > + */
> > +int pm_standby_transition(standby_state_t state)
> > +{
> > +       int error;
> > +
> > +       if (state =3D=3D standby_current)
> > +               return 0;
> > +       if (state > PM_STANDBY_MAX)
> > +               return -EINVAL;
> > +
> > +       pm_standby_refresh_states();
> > +
> > +       pm_pr_dbg("Transitioning from standby state %s to %s\n",
> > +                 standby_states[standby_current], standby_states[state=
]);
> > +
> > +       /* Resume can only be entered if we are on the sleep state. */
> > +       if (state =3D=3D PM_STANDBY_RESUME) {
> > +               if (standby_current !=3D PM_STANDBY_SLEEP)
> > +                       return -EINVAL;
> > +               standby_current =3D PM_STANDBY_RESUME;
> > +               return platform_standby_notify(PM_SN_RESUME);
> > +       }
> > +
> > +       /*
> > +        * The system should not be able to re-enter Sleep from resume =
as it
> > +        * is undefined behavior. As part of setting the state to "Resu=
me",
> > +        * userspace promised a transition to "Inactive" or "Active".
> > +        */
> > +       if (standby_current =3D=3D PM_STANDBY_RESUME && state =3D=3D PM=
_STANDBY_SLEEP)
> > +               return -EINVAL;
> > +
> > +       /* Resume is the Sleep state logic-wise. */
> > +       if (standby_current =3D=3D PM_STANDBY_RESUME)
> > +               standby_current =3D PM_STANDBY_SLEEP;
> > +
> > +       if (standby_current < state) {
> > +               for (; standby_current < state; standby_current++) {
> > +                       switch (standby_current + 1) {
> > +                       case PM_STANDBY_INACTIVE:
> > +                               error =3D platform_standby_notify(PM_SN=
_INACTIVE_ENTRY);
> > +                               break;
> > +                       case PM_STANDBY_SLEEP:
> > +                               error =3D platform_standby_notify(PM_SN=
_SLEEP_ENTRY);
> > +                               break;
> > +                       }
> > +
> > +                       if (error) {
> > +                               /* Rollback to previous valid state */
> > +                               while (standby_current > PM_STANDBY_ACT=
IVE &&
> > +                                      !standby_states[standby_current]=
)
> > +                                       standby_current--;
> > +                               return error;
> > +                       }
> > +               }
> > +       } else if (standby_current > state) {
> > +               for (; standby_current > state; standby_current--) {
> > +                       switch (standby_current) {
> > +                       case PM_STANDBY_SLEEP:
> > +                               error =3D platform_standby_notify(PM_SN=
_SLEEP_EXIT);
> > +                               break;
> > +                       case PM_STANDBY_INACTIVE:
> > +                               error =3D platform_standby_notify(PM_SN=
_INACTIVE_EXIT);
> > +                               break;
> > +                       }
> > +
> > +                       if (error) {
> > +                               /* Rollback to previous valid state */
> > +                               while (standby_current < PM_STANDBY_SLE=
EP &&
> > +                                      !standby_states[standby_current]=
)
> > +                                       standby_current++;
> > +                               return error;
> > +                       }
> > +               }
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +/**
> > + * pm_standby_set_state - Set the current standby state and skip the t=
ransition
> > + */
> > +void pm_standby_set_state(standby_state_t state)
> > +{
> > +       standby_current =3D state;
> > +}
> > +EXPORT_SYMBOL_GPL(pm_standby_set_state);
> > +
> > +/**
> > + * pm_standby_get_state - Returns the current standby state
> > + */
> > +int pm_standby_get_state(void)
> > +{
> > +       return standby_current;
> > +}
> > +EXPORT_SYMBOL_GPL(pm_standby_get_state);
> > +
> >  #ifdef CONFIG_PM_DEBUG
> >  static unsigned int pm_test_delay =3D 5;
> >  module_param(pm_test_delay, uint, 0644);
> > @@ -572,6 +719,7 @@ static void suspend_finish(void)
> >   */
> >  static int enter_state(suspend_state_t state)
> >  {
> > +       standby_state_t standby_prior;
> >         int error;
> >
> >         trace_suspend_resume(TPS("suspend_enter"), state, true);
> > @@ -588,6 +736,9 @@ static int enter_state(suspend_state_t state)
> >         if (!mutex_trylock(&system_transition_mutex))
> >                 return -EBUSY;
> >
> > +       standby_prior =3D standby_current;
> > +       pm_standby_transition(PM_STANDBY_SLEEP);
>
> I'm not sure if it is actually safe to evaluate PNP0D80 _DSM function
> 7 (sleep entry notification) at this point because of possible
> ordering constraints.
>
> As I said once before in another thread, I would like the platform
> notifications to be moved to the places in which you want them to take
> place before making any other changes and only once this is proven to
> work, further changes can be made.

Following the conclusion of this discussion I can spin a non-RFC
keeping the rename and doing a simple re-ordering, plus cleaning up
the asus related code for the Ally so that it works correctly. This
way, the re-ordering can be tested individually and merged first.

Antheas

> > +
> >         if (state =3D=3D PM_SUSPEND_TO_IDLE)
> >                 s2idle_begin();
> >
> > @@ -619,6 +770,8 @@ static int enter_state(suspend_state_t state)
> >         pm_pr_dbg("Finishing wakeup.\n");
> >         suspend_finish();
> >   Unlock:
> > +       pm_standby_transition(standby_prior);
> > +
> >         mutex_unlock(&system_transition_mutex);
> >         return error;
> >  }
> > --
>

