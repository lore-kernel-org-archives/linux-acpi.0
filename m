Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BF73B83E0
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 20:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667306; cv=none; b=kTIzL4AA/098zOBS56qumMrssJrazomEZdyOPpmXiN5CTRVGHcI0JRGEd0ZZOF9WOrI33Zz3xImyqu/eZr2e6CwQU78pGK7GtWcRAb5F6MMAjHzH2VmSSoa1FE/kFnL9SeWhctR3BSOYbG2hc7564QoTxcGie2chkl3CNCkJq3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667306; c=relaxed/simple;
	bh=99l65B05EZqplQpkSt72g+qtTykwxDAbr3iqeY6JfnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rgh6AOd4jorT1WgrZwxzNyLLePTdvVUxj2rxhtnrM8ZtuuoQhDFWpPIh5O9CDwARyK9n9PBOwRWNhayhdQzDorxVw+tKZ/8HhFZHMSj+SAPNLzogEOtDSQnh2VAPhlZKoXOHu2/i489O2/eni0J1zE5odkvoJ9FIyKzOpQ3XgTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFV3bwf2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFV3bwf2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0271F00A3E
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 20:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784667305;
	bh=PIPxUtOyMDw25ArbgXM8B4vuFeJIRYk0SsAFf4a28QQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nFV3bwf2ObuOQcqpHmTFAXt7ctbjka9HrMxOHSut2MPfwS4X85o96UsSgBTtoNeFY
	 QvWvVX0k4clAJgzBDFo7x/PiMSnmTSmVDWPjHvQLQZeKuu3bAYpoYxDQ7AjMmqXsB5
	 Dvr6USIfA9799Rkk2rHB9Yc+Ajb8bAfJtE6ysOQwwJ18Rax/PRCe9i4espe0hEcO0Y
	 huPmdKj8TraWPEJsVqNOKKZW80sLfCFS4tWFQxjv2Yl7/baZByqQaZgJ2u9aXOYW3h
	 9wfUXhET1SBD18/JnTwuIVTnaSfvCWRDzrRBFf1UbixJ9wI4zeBpA0SjkgebQhufxR
	 ZrVWWqI72y/Tg==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aea0fff535so9495132e87.3
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 13:55:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpYLJdPwtwuYvZ9YnxwVWsupuGo0a5w1c/69o2wyjl/mmBob1UaSThGYw2IJnMPyXDJq05RWvGdIV6Z@vger.kernel.org
X-Gm-Message-State: AOJu0YwgqjKXJsxZW/8o38HfjxdGDyMpjZhzGpqjxgHE+xsd7GK+4RZ0
	cGQupPUlpehINCN4t+DIfdNb01a7vLVvYsBwiyN0/tg/kCIUjE4SKjmKxtaVloVJIATK72MzRuO
	ZCBl8M1VVUDauEBdFr9szXAM4XlXBUgs=
X-Received: by 2002:a05:6512:65:b0:5b0:cce:d9e9 with SMTP id
 2adb3069b0e04-5b28f874d01mr2697755e87.19.1784667303253; Tue, 21 Jul 2026
 13:55:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718-b4-acpi-battery-notification-v4-0-599c8ed1072f@rong.moe> <20260718-b4-acpi-battery-notification-v4-3-599c8ed1072f@rong.moe>
In-Reply-To: <20260718-b4-acpi-battery-notification-v4-3-599c8ed1072f@rong.moe>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 21 Jul 2026 22:54:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ijiG23QWjG9C9OfZSB5jxFTg42OwYRS6KVc=Voi2s42w@mail.gmail.com>
X-Gm-Features: AUfX_mz7xqO5yaZ5ZuSnNYAtw_TcL47S6tOq8OoUINuyIcWjxhXLA9X8iqGrV2A
Message-ID: <CAJZ5v0ijiG23QWjG9C9OfZSB5jxFTg42OwYRS6KVc=Voi2s42w@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] ACPI: battery: Protect all properties with a
 separated mutex
To: Rong Zhang <i@rong.moe>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Avraham Hollander <anhollander516@gmail.com>, 
	=?UTF-8?Q?Jeffrey_W=C3=A4lti?= <jeffrey@waelti.dev>, 
	Rick <rickk1166@gmail.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 18, 2026 at 1:11=E2=80=AFAM Rong Zhang <i@rong.moe> wrote:
>
> The acpi_battery_get_property() callback calls acpi_battery_get_state()
> without any lock held, which could lead to race conditions, e.g., when
> multiple tasks read power supply properties simultaneously, or when
> other callbacks are called during its execution.
>
> Moreover, some devices' _BST method relies on a heavily shared ACPI
> mutex which protects EC accesses, so it cannot tolerate too much
> pressure or else other methods will time out. The lack of
> synchronization sometimes nullifies the cache mechanism of
> acpi_battery_get_state() when multiple processes read power supply
> properties simultaneously, which usually happens after a uevent.
> Normally, emitting a uevent implies that the cache must have been
> refreshed due to power_supply_uevent() reading all properties, so the
> mentioned processes should have seen cache hits. Unfortunately, these
> fragile devices' power_supply_ext properties are somehow slow to read
> after battery events, resulting in cache expiration before
> power_supply_uevent() finishes. Hence, once the uevent reaches
> userspace, the _BST method will be executed multiple times within a
> short period due to userspace processes reading all properties again.
> The coincidence causes lock starvation, resulting in a catastrophic
> situation that a lot of ACPI methods fail to acquire the shared ACPI
> mutex due to timeout and return garbage data thanks to the firmware's
> poorly designed error paths.
>
> The said "other synchronized methods" are protected by update_lock,
> leaving acpi_battery_get_property() to be the last desynchronized code
> path. Unfortunately, update_lock is not applicapable for
> acpi_battery_get_property(), as it protects too many fields, far more
> than necessary. What's worse, some code path could call or wait for
> acpi_battery_get_property() while an outer functions holding
> update_lock.
>
> Therefore, introduce a mutex to protect all accesses to battery
> properties, so that acpi_battery_get_property() can take the advantage
> of the mutex and synchronize itself. The helper function
> acpi_battery_handle_discharging() for quirky devices has to be inlined
> due to the change, as the mutex must be unlocked before calling the
> expensive power_supply_is_system_supplied() helper function.
>
> Tested-by: Avraham Hollander <anhollander516@gmail.com>
> Reported-by: Rick <rickk1166@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D221065
> Signed-off-by: Rong Zhang <i@rong.moe>

I have queued up the other 2 patches in the series for 7.3, but this
one is not quite ready IMV.

In the first place, it is not quite clear from the changelog what
exactly the role of the new mutex is.

If there are any real race conditions it prevents from occurring, it
would be good to give examples.

Moreover, the exact mechanism of the _BST synchronization failure is
unclear to me because in Linux all AML evaluation is synchronized by
the namespace and interpreter mutexes.  If that is not sufficient, it
would be good to explain why because as it stands, it is not clear
whether or not the approach used in this patch is adequate.

> ---
> Changes in v3:
> - Address Sashiko's concerns on my last-minute changes:
>   - Do not overwrite the initial value of `ret' in
>     acpi_battery_get_property()
>   - https://sashiko.dev/#/patchset/20260611-b4-acpi-battery-notification-=
v2-0-4e8ed651a151%40rong.moe
>
> Changes in v2:
> - Address Sashiko's concerns:
>   - Use a separated mutex to protect all properties instead of reusing
>     update_lock
>   - https://sashiko.dev/#/patchset/20260527-b4-acpi-battery-notification-=
v1-0-2303bed8ec0b%40rong.moe
> - Dropped Tested-by due to massive rewrite
> ---
>  drivers/acpi/battery.c | 147 +++++++++++++++++++++++++++++++++----------=
------
>  1 file changed, 101 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index bd7fa93ff16f..3ad4acf3d44d 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -16,6 +16,7 @@
>  #include <linux/kernel.h>
>  #include <linux/kfifo.h>
>  #include <linux/list.h>
> +#include <linux/lockdep.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/platform_device.h>
> @@ -104,6 +105,9 @@ struct acpi_battery {
>         struct delayed_work acpi_notif_dwork;
>         struct notifier_block pm_nb;
>         struct list_head list;
> +       unsigned long flags;
> +
> +       struct mutex property_lock; /* Protects properties below. */
>         unsigned long update_time;
>         int revision;
>         int rate_now;
> @@ -130,7 +134,6 @@ struct acpi_battery {
>         char oem_info[MAX_STRING_LENGTH];
>         int state;
>         int power_unit;
> -       unsigned long flags;
>  };
>
>  #define to_acpi_battery(x) power_supply_get_drvdata(x)
> @@ -187,20 +190,6 @@ static bool acpi_battery_is_degraded(struct acpi_bat=
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
> @@ -208,15 +197,41 @@ static int acpi_battery_get_property(struct power_s=
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
>                         /* Validate the status by checking the current. *=
/
>                         if (battery->rate_now !=3D ACPI_BATTERY_VALUE_UNK=
NOWN &&
> @@ -318,6 +333,8 @@ static int acpi_battery_get_property(struct power_sup=
ply *psy,
>         default:
>                 ret =3D -EINVAL;
>         }
> +
> +       mutex_unlock(&battery->property_lock);
>         return ret;
>  }
>
> @@ -540,6 +557,8 @@ static int acpi_battery_get_info(struct acpi_battery =
*battery)
>         int use_bix;
>         int result =3D -ENODEV;
>
> +       lockdep_assert_held(&battery->property_lock);
> +
>         if (!acpi_battery_present(battery))
>                 return 0;
>
> @@ -579,6 +598,8 @@ static int acpi_battery_get_state(struct acpi_battery=
 *battery)
>         acpi_status status =3D 0;
>         struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
>
> +       lockdep_assert_held(&battery->property_lock);
> +
>         if (!acpi_battery_present(battery))
>                 return 0;
>
> @@ -632,6 +653,8 @@ static int acpi_battery_set_alarm(struct acpi_battery=
 *battery)
>  {
>         acpi_status status =3D 0;
>
> +       lockdep_assert_held(&battery->property_lock);
> +
>         if (!acpi_battery_present(battery) ||
>             !test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags))
>                 return -ENODEV;
> @@ -649,6 +672,8 @@ static int acpi_battery_set_alarm(struct acpi_battery=
 *battery)
>
>  static int acpi_battery_init_alarm(struct acpi_battery *battery)
>  {
> +       lockdep_assert_held(&battery->property_lock);
> +
>         /* See if alarms are supported, and if so, set default */
>         if (!acpi_has_method(battery->device->handle, "_BTP")) {
>                 clear_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags);
> @@ -666,6 +691,8 @@ static ssize_t acpi_battery_alarm_show(struct device =
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
> @@ -681,6 +708,8 @@ static ssize_t acpi_battery_alarm_store(struct device=
 *dev,
>         if (err)
>                 return err;
>
> +       guard(mutex)(&battery->property_lock);
> +
>         battery->alarm =3D x / 1000;
>         if (acpi_battery_present(battery))
>                 acpi_battery_set_alarm(battery);
> @@ -865,12 +894,17 @@ static int sysfs_add_battery(struct acpi_battery *b=
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
> @@ -924,6 +958,9 @@ static void sysfs_remove_battery(struct acpi_battery =
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
> @@ -955,6 +992,8 @@ static void find_battery(const struct dmi_header *dm,=
 void *private)
>   */
>  static void acpi_battery_quirks(struct acpi_battery *battery)
>  {
> +       lockdep_assert_held(&battery->property_lock);
> +
>         if (test_bit(ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY, &battery->fl=
ags))
>                 return;
>
> @@ -1007,30 +1046,38 @@ static void acpi_battery_quirks(struct acpi_batte=
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
> @@ -1042,9 +1089,7 @@ static int acpi_battery_update(struct acpi_battery =
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
> @@ -1057,12 +1102,14 @@ static void acpi_battery_refresh(struct acpi_batt=
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
> @@ -1154,17 +1201,21 @@ static int battery_notify(struct notifier_block *=
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
> @@ -1329,6 +1380,10 @@ static int acpi_battery_probe(struct platform_devi=
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
> --
> 2.53.0
>
