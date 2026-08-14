Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9590516DEB1
	for <linux-acpi@vger.kernel.org>; Fri, 14 Aug 2026 19:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786735398; cv=none; b=ZIPp4XJTGxP2zkt2eBaaz2FdtDcdmNWZzfpCuDIahghSsG69bj9I383qXmlU4CHycylVn2cDGmps7P3+Lh/61lWVXJVF/aWSinSIEXVzsKk6S5etdWh3xzximtfPxZxT8Fw6Doo+99/ko3yKHexfW69W9QMRcLS+9+aG07taG2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786735398; c=relaxed/simple;
	bh=ceFUlJmiey86Gt0oqeI5epWZmXUIriS7i1YMX664hHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pS144xPmTZJtaGcjhotK+Nvk7Q3Sewx+ow28pz2SrnpOGPrcER7bp0jOHkok2/n5Z/7EBImyIpeFAItM49DE0sqhSmj6GijLz4jqTwPRebYwA607GfGNxvCailP1KjcsDGcWs0RsCagLoyxJN2fpwwB5owi6DJmSsFtdUbkh6sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPd5lGYH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPd5lGYH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AEAA1F00A3D
	for <linux-acpi@vger.kernel.org>; Fri, 14 Aug 2026 19:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786735396;
	bh=wPkihjImNBUPHhrvhQ/zH8BnsMZaoO+LRbxOlYJqw7Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SPd5lGYHXr/9N+5XNQ13182i/rwfy2eu/aRiJiSU2/uxKFn8Dg/z9xM13NZIWQHby
	 4zsrmXNVcKQNogSyaAIZoeFmHAu3NYikkhiTgTBGo7f6BETe0IPa4nZ+0O3VQG6k6n
	 JOlAD2OGexmhK9ceOxINXhUf/G8MbDxh5bHeaejWv8gPw3Lu8udRCYEyuxW/fmbwOe
	 n/mteuiBEPojgLPivjwk/AOz6XOjITGD5wmQmHOGlxB+pH61gKdsVGyrUs3Kf4jMNd
	 hcYgCO+h8Xhrxb/eJMQv/0jhCi3Ox3DDXR8OFuDq+3tRlbzwg5kf65aMhmH6Wq5vpQ
	 xHTmRD63s2AJg==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b0115b9e17so1502869e87.0
        for <linux-acpi@vger.kernel.org>; Fri, 14 Aug 2026 12:23:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqms7CtpOtXd64+ClrbgKnxoQ2Ba9mXWllXVYxaGHYdA0rCDagNM4l38Q7nvsSGvskGY1Ps5n0zlNYK@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl/BVhboiMjoiD7ghoVt0TkjQ8MjwgFOOYzjU+3ObkBdm9Q5iO
	YXWa/yf8D7MhL+wLbMhDmNasdPOOytqiY6A7Tr0RbFwnQlIccd7ZPdzXuQ+Do61tiVeLFEX5vJq
	PudeZnBWWzNxIC8mmEjHSdCiJV7ouwEg=
X-Received: by 2002:a05:6512:15a7:b0:5aa:123d:b755 with SMTP id
 2adb3069b0e04-5b459184d1emr1013604e87.28.1786735394478; Fri, 14 Aug 2026
 12:23:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809-b4-acpi-battery-notification-v5-1-788d54fa2e35@rong.moe>
In-Reply-To: <20260809-b4-acpi-battery-notification-v5-1-788d54fa2e35@rong.moe>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 14 Aug 2026 21:22:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iB8-nLJPvis4Fm-3ANRdm_ArjDZV-2LSTmikwt+se-MA@mail.gmail.com>
X-Gm-Features: AUfX_mzHYw0xYgyCQJb-hYZaRrq-B-QMtxiVuJe88J_3PWfmuLAdBKPqk3HM8K8
Message-ID: <CAJZ5v0iB8-nLJPvis4Fm-3ANRdm_ArjDZV-2LSTmikwt+se-MA@mail.gmail.com>
Subject: Re: [PATCH v5] ACPI: battery: Protect all properties with a separated mutex
To: Rong Zhang <i@rong.moe>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Avraham Hollander <anhollander516@gmail.com>, 
	=?UTF-8?Q?Jeffrey_W=C3=A4lti?= <jeffrey@waelti.dev>, 
	Rick <rickk1166@gmail.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 9, 2026 at 1:44=E2=80=AFAM Rong Zhang <i@rong.moe> wrote:
>
> The acpi_battery_get_property() callback calls acpi_battery_get_state()
> without any lock held. On some devices, it happens that the property
> cache has expired before a uevent reaches userspace, triggering
> simultaneous attempts to evaluate _BST. See [1] for an analysis to sysrq
> stacktraces on one of the these devices.
>
> In a few cases, including when the AML is sleeping or acquiring a mutex,
> ACPICA drops the namespace and interpreter locks and allows the
> evaluation of _BST to start while another task is still evaluating it.
> This could somehow confuse the interpreter and lead to chaos in AML
> mutexes on some devices, see [2] for an example.
>
> Not holding the lock is also prone to race conditions, for example:
>
>                 CPU0                |            CPU1
> acpi_battery_get_property()         |
>   acpi_battery_get_state()          |
>     [update_time expired]           |
>     extract_package()               | acpi_battery_get_property()
>     battery->update_time =3D jiffies  |   acpi_battery_get_state()
>     kfree()                         |     [up to date]
>                                     |   [read capacity_now]
>     [fix capacity_now due to quirk] |
>
> where CPU1 gets raw capacity_now before CPU0 fixes it to a meaningful
> value.
>
> The existing mutex update_lock is not applicapable for
> acpi_battery_get_property(), as some code path could call or wait for
> acpi_battery_get_property() while holding update_lock.
>
> Therefore, introduce a mutex called property_lock to protect all
> accesses to battery properties, so that acpi_battery_get_property() can
> take the advantage of the mutex and synchronize itself. With the mutex,
> acpi_battery_get_state() are synchronized in all code paths calling it,
> and its cache mechanism can always clamp the frequency of _BST
> evaluations according to cache_time.
>
> The helper function acpi_battery_handle_discharging() for quirky devices
> has to be inlined due to the change, as the mutex must be unlocked
> before calling the expensive power_supply_is_system_supplied() helper
> function.
>
> Fixes: 86bfd21a0baf ("ACPI: battery: Drop redundant locking")
> Tested-by: Avraham Hollander <anhollander516@gmail.com>
> Reported-by: Rick <rickk1166@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D221065#c85 [1]
> Reported-by: Avraham Hollander <anhollander516@gmail.com>
> Closes: https://lore.kernel.org/linux-acpi/CAP1mzZReJCn6df5DwEPu-JCQUyr=
=3DPu1cg5xKCMttWZkHCQtVmQ@mail.gmail.com [2]
> Signed-off-by: Rong Zhang <i@rong.moe>

Applied as 7.3 material, thanks!

> ---
> Changes in v5:
> - Reword commit message (thanks Rafael J. Wysocki)
> - Rebase onto linux-pm after other patches in the series have been
>   applied
> - Link to v4: https://patch.msgid.link/20260718-b4-acpi-battery-notificat=
ion-v4-0-599c8ed1072f@rong.moe
>
> Changes in v4:
> - Rebase and adopt devres-based resource management
> - Refactor acpi_battery_notify() to hold the mutex across the entire
>   function to improve readability and drop unnecessary variables (thanks
>   Rafael J. Wysocki)
> - Link to v3: https://patch.msgid.link/20260611-b4-acpi-battery-notificat=
ion-v3-0-f9390382c5a4@rong.moe
>
> Changes in v3:
> - Address Sashiko's concerns on my last-minute changes:
>   - Set the number base to 10 in order not to break the ABI
>   - Do not overwrite the initial value of `ret' in
>     acpi_battery_get_property()
>   - https://sashiko.dev/#/patchset/20260611-b4-acpi-battery-notification-=
v2-0-4e8ed651a151%40rong.moe
> - Link to v2: https://patch.msgid.link/20260611-b4-acpi-battery-notificat=
ion-v2-0-4e8ed651a151@rong.moe
>
> Changes in v2:
> - Address Sashiko's concerns:
>   - Return from acpi_battery_notification_worker() early when the fifo
>     is empty
>   - Use pr_err_ratelimited() for potential event storms
>   - Add missing `\n' in a printk message
>   - Use a separated mutex to protect all properties instead of reusing
>     update_lock
>   - https://sashiko.dev/#/patchset/20260527-b4-acpi-battery-notification-=
v1-0-2303bed8ec0b%40rong.moe
> - Minimalize the critical section of acpi_battery_notify()
> - Rearrange the series
> - Dropped Tested-by from patch 3 due to massive rewrite
> - Link to v1: https://patch.msgid.link/20260527-b4-acpi-battery-notificat=
ion-v1-0-2303bed8ec0b@rong.moe
> ---
>  drivers/acpi/battery.c | 147 +++++++++++++++++++++++++++++++++----------=
------
>  1 file changed, 101 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 0084f308b790..670853ec3a4d 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -17,6 +17,7 @@
>  #include <linux/kernel.h>
>  #include <linux/kfifo.h>
>  #include <linux/list.h>
> +#include <linux/lockdep.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/platform_device.h>
> @@ -105,6 +106,9 @@ struct acpi_battery {
>         struct delayed_work acpi_notif_dwork;
>         struct notifier_block pm_nb;
>         struct list_head list;
> +       unsigned long flags;
> +
> +       struct mutex property_lock; /* Protects properties below. */
>         unsigned long update_time;
>         int revision;
>         int rate_now;
> @@ -131,7 +135,6 @@ struct acpi_battery {
>         char oem_info[MAX_STRING_LENGTH];
>         int state;
>         int power_unit;
> -       unsigned long flags;
>  };
>
>  #define to_acpi_battery(x) power_supply_get_drvdata(x)
> @@ -189,20 +192,6 @@ static bool acpi_battery_is_degraded(struct acpi_bat=
tery *battery)
>                 battery->full_charge_capacity < battery->design_capacity;
>  }
>
> -static int acpi_battery_handle_discharging(struct acpi_battery *battery)
> -{
> -       /*
> -        * Some devices wrongly report discharging if the battery's charg=
e level
> -        * was above the device's start charging threshold atm the AC ada=
pter
> -        * was plugged in and the device thus did not start a new charge =
cycle.
> -        */
> -       if ((battery_ac_is_broken || power_supply_is_system_supplied()) &=
&
> -           battery->rate_now =3D=3D 0)
> -               return POWER_SUPPLY_STATUS_NOT_CHARGING;
> -
> -       return POWER_SUPPLY_STATUS_DISCHARGING;
> -}
> -
>  static int acpi_battery_get_property(struct power_supply *psy,
>                                      enum power_supply_property psp,
>                                      union power_supply_propval *val)
> @@ -210,15 +199,41 @@ static int acpi_battery_get_property(struct power_s=
upply *psy,
>         int full_capacity =3D ACPI_BATTERY_VALUE_UNKNOWN, ret =3D 0;
>         struct acpi_battery *battery =3D to_acpi_battery(psy);
>
> -       if (acpi_battery_present(battery)) {
> -               /* run battery update only if it is present */
> -               acpi_battery_get_state(battery);
> -       } else if (psp !=3D POWER_SUPPLY_PROP_PRESENT)
> -               return -ENODEV;
> +       /* run battery update only if it is present */
> +       if (!acpi_battery_present(battery)) {
> +               switch (psp) {
> +               case POWER_SUPPLY_PROP_PRESENT:
> +                       val->intval =3D 0;
> +                       return 0;
> +               default:
> +                       return -ENODEV;
> +               }
> +       }
> +
> +       mutex_lock(&battery->property_lock);
> +
> +       acpi_battery_get_state(battery);
> +
>         switch (psp) {
>         case POWER_SUPPLY_PROP_STATUS:
> +               /*
> +                * Some devices wrongly report discharging if the battery=
's charge level
> +                * was above the device's start charging threshold atm th=
e AC adapter
> +                * was plugged in and the device thus did not start a new=
 charge cycle.
> +                */
>                 if (battery->state & ACPI_BATTERY_STATE_DISCHARGING)
> -                       val->intval =3D acpi_battery_handle_discharging(b=
attery);
> +                       if (battery->rate_now !=3D 0) {
> +                               val->intval =3D POWER_SUPPLY_STATUS_DISCH=
ARGING;
> +                       } else if (battery_ac_is_broken) {
> +                               val->intval =3D POWER_SUPPLY_STATUS_NOT_C=
HARGING;
> +                       } else {
> +                               mutex_unlock(&battery->property_lock);
> +
> +                               val->intval =3D power_supply_is_system_su=
pplied()
> +                                       ? POWER_SUPPLY_STATUS_NOT_CHARGIN=
G
> +                                       : POWER_SUPPLY_STATUS_DISCHARGING=
;
> +                               return 0;
> +                       }
>                 else if (battery->state & ACPI_BATTERY_STATE_CHARGING)
>                         /* Check the rate and capacity to validate the st=
atus. */
>                         if (!acpi_battery_is_full(battery) ||
> @@ -321,6 +336,8 @@ static int acpi_battery_get_property(struct power_sup=
ply *psy,
>         default:
>                 ret =3D -EINVAL;
>         }
> +
> +       mutex_unlock(&battery->property_lock);
>         return ret;
>  }
>
> @@ -556,6 +573,8 @@ static int acpi_battery_get_info(struct acpi_battery =
*battery)
>         int use_bix;
>         int result =3D -ENODEV;
>
> +       lockdep_assert_held(&battery->property_lock);
> +
>         if (!acpi_battery_present(battery))
>                 return 0;
>
> @@ -595,6 +614,8 @@ static int acpi_battery_get_state(struct acpi_battery=
 *battery)
>         acpi_status status =3D 0;
>         struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
>
> +       lockdep_assert_held(&battery->property_lock);
> +
>         if (!acpi_battery_present(battery))
>                 return 0;
>
> @@ -648,6 +669,8 @@ static int acpi_battery_set_alarm(struct acpi_battery=
 *battery)
>  {
>         acpi_status status =3D 0;
>
> +       lockdep_assert_held(&battery->property_lock);
> +
>         if (!acpi_battery_present(battery) ||
>             !test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags))
>                 return -ENODEV;
> @@ -665,6 +688,8 @@ static int acpi_battery_set_alarm(struct acpi_battery=
 *battery)
>
>  static int acpi_battery_init_alarm(struct acpi_battery *battery)
>  {
> +       lockdep_assert_held(&battery->property_lock);
> +
>         /* See if alarms are supported, and if so, set default */
>         if (!acpi_has_method(battery->device->handle, "_BTP")) {
>                 clear_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags);
> @@ -682,6 +707,8 @@ static ssize_t acpi_battery_alarm_show(struct device =
*dev,
>  {
>         struct acpi_battery *battery =3D to_acpi_battery(dev_get_drvdata(=
dev));
>
> +       guard(mutex)(&battery->property_lock);
> +
>         return sysfs_emit(buf, "%d\n", battery->alarm * 1000);
>  }
>
> @@ -697,6 +724,8 @@ static ssize_t acpi_battery_alarm_store(struct device=
 *dev,
>         if (err)
>                 return err;
>
> +       guard(mutex)(&battery->property_lock);
> +
>         battery->alarm =3D x / 1000;
>         if (acpi_battery_present(battery))
>                 acpi_battery_set_alarm(battery);
> @@ -881,12 +910,17 @@ static int sysfs_add_battery(struct acpi_battery *b=
attery)
>                 .no_wakeup_source =3D true,
>         };
>         bool full_cap_broken =3D false;
> +       int power_unit;
>
> -       if (!ACPI_BATTERY_CAPACITY_VALID(battery->full_charge_capacity) &=
&
> -           !ACPI_BATTERY_CAPACITY_VALID(battery->design_capacity))
> -               full_cap_broken =3D true;
> +       scoped_guard(mutex, &battery->property_lock) {
> +               power_unit =3D battery->power_unit;
>
> -       if (battery->power_unit =3D=3D ACPI_BATTERY_POWER_UNIT_MA) {
> +               if (!ACPI_BATTERY_CAPACITY_VALID(battery->full_charge_cap=
acity) &&
> +                   !ACPI_BATTERY_CAPACITY_VALID(battery->design_capacity=
))
> +                       full_cap_broken =3D true;
> +       }
> +
> +       if (power_unit =3D=3D ACPI_BATTERY_POWER_UNIT_MA) {
>                 if (full_cap_broken) {
>                         battery->bat_desc.properties =3D
>                             charge_battery_full_cap_broken_props;
> @@ -940,6 +974,9 @@ static void sysfs_remove_battery(struct acpi_battery =
*battery)
>  static void find_battery(const struct dmi_header *dm, void *private)
>  {
>         struct acpi_battery *battery =3D (struct acpi_battery *)private;
> +
> +       lockdep_assert_held(&battery->property_lock);
> +
>         /* Note: the hardcoded offsets below have been extracted from
>          * the source code of dmidecode.
>          */
> @@ -971,6 +1008,8 @@ static void find_battery(const struct dmi_header *dm=
, void *private)
>   */
>  static void acpi_battery_quirks(struct acpi_battery *battery)
>  {
> +       lockdep_assert_held(&battery->property_lock);
> +
>         if (test_bit(ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY, &battery->fl=
ags))
>                 return;
>
> @@ -1023,30 +1062,38 @@ static void acpi_battery_quirks(struct acpi_batte=
ry *battery)
>  static int acpi_battery_update(struct acpi_battery *battery, bool resume=
)
>  {
>         int result =3D acpi_battery_get_status(battery);
> +       bool wakeup;
>
>         if (result)
>                 return result;
>
>         if (!acpi_battery_present(battery)) {
>                 sysfs_remove_battery(battery);
> -               battery->update_time =3D 0;
> +               scoped_guard(mutex, &battery->property_lock)
> +                       battery->update_time =3D 0;
>                 return 0;
>         }
>
>         if (resume)
>                 return 0;
>
> -       if (!battery->update_time) {
> -               result =3D acpi_battery_get_info(battery);
> +       scoped_guard(mutex, &battery->property_lock) {
> +               if (!battery->update_time) {
> +                       result =3D acpi_battery_get_info(battery);
> +                       if (result)
> +                               return result;
> +                       acpi_battery_init_alarm(battery);
> +               }
> +
> +               result =3D acpi_battery_get_state(battery);
>                 if (result)
>                         return result;
> -               acpi_battery_init_alarm(battery);
> -       }
> +               acpi_battery_quirks(battery);
>
> -       result =3D acpi_battery_get_state(battery);
> -       if (result)
> -               return result;
> -       acpi_battery_quirks(battery);
> +               wakeup =3D ((battery->state & ACPI_BATTERY_STATE_CRITICAL=
) ||
> +                         (test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery-=
>flags) &&
> +                          (battery->capacity_now <=3D battery->alarm)));
> +       }
>
>         if (!battery->bat) {
>                 result =3D sysfs_add_battery(battery);
> @@ -1058,9 +1105,7 @@ static int acpi_battery_update(struct acpi_battery =
*battery, bool resume)
>          * Wakeup the system if battery is critical low
>          * or lower than the alarm level
>          */
> -       if ((battery->state & ACPI_BATTERY_STATE_CRITICAL) ||
> -           (test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags) &&
> -            (battery->capacity_now <=3D battery->alarm)))
> +       if (wakeup)
>                 acpi_pm_wakeup_event(battery->phys_dev);
>
>         return result;
> @@ -1073,12 +1118,14 @@ static void acpi_battery_refresh(struct acpi_batt=
ery *battery)
>         if (!battery->bat)
>                 return;
>
> -       power_unit =3D battery->power_unit;
> +       scoped_guard(mutex, &battery->property_lock) {
> +               power_unit =3D battery->power_unit;
>
> -       acpi_battery_get_info(battery);
> +               acpi_battery_get_info(battery);
>
> -       if (power_unit =3D=3D battery->power_unit)
> -               return;
> +               if (power_unit =3D=3D battery->power_unit)
> +                       return;
> +       }
>
>         /* The battery has changed its reporting units. */
>         sysfs_remove_battery(battery);
> @@ -1170,17 +1217,21 @@ static int battery_notify(struct notifier_block *=
nb,
>                 } else {
>                         int result;
>
> -                       result =3D acpi_battery_get_info(battery);
> -                       if (result)
> -                               return result;
> +                       scoped_guard(mutex, &battery->property_lock) {
> +                               result =3D acpi_battery_get_info(battery)=
;
> +                               if (result)
> +                                       return result;
> +                       }
>
>                         result =3D sysfs_add_battery(battery);
>                         if (result)
>                                 return result;
>                 }
>
> -               acpi_battery_init_alarm(battery);
> -               acpi_battery_get_state(battery);
> +               scoped_guard(mutex, &battery->property_lock) {
> +                       acpi_battery_init_alarm(battery);
> +                       acpi_battery_get_state(battery);
> +               }
>         }
>
>         return 0;
> @@ -1345,6 +1396,10 @@ static int acpi_battery_probe(struct platform_devi=
ce *pdev)
>         if (result)
>                 return result;
>
> +       result =3D devm_mutex_init(&pdev->dev, &battery->property_lock);
> +       if (result)
> +               return result;
> +
>         if (acpi_has_method(battery->device->handle, "_BIX"))
>                 set_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags);
>
>
> ---
> base-commit: 92ec461acad4a92722634aafab38cfd3236e884d
> change-id: 20260520-b4-acpi-battery-notification-90d781a3f217
>
> Thanks,
> Rong
>
