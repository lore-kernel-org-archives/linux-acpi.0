Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CA94B95AC
	for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 17:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791825785; cv=none; b=m3yzphHJcpJuANduy3VlhUfQ8ptjV/3EBVHjdlwmmNkWUDIvq192gX9wxxxyy9AcXXV4FHpNTuQ9d5iUgETQUQFlScm7m4R9el2KtopfY4Az5LBJE1/odWpXnYLdS+34UjPYG1DgWms+a9hmYLwcniPWZrfEEuMjj6l3XMO9kK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791825785; c=relaxed/simple;
	bh=PDGs25Hsr6HCPivktzfFx0hAaABH+aw13xLQZPlzjSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mfoy3UpKXmwJdIa2XWMmLkDHOpqNNKmbVABINpkfFxH84FjJjnE6BbI4hnXj+CqN9XyXXzTOmEB/YJJIip/ygbDFfmqlIn8RzR+q+D9NUxHKFe4gn8y8mOrt8XKpstviAgFSy84tQeNnk1uWpQudsEScDSvBHq/TjyxZZ1kU/zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrCSV9WO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrCSV9WO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CD91F0089D
	for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 17:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791825782;
	bh=PJ4CFOHkZbKA9IYDiDbBByEIZ0zY0DCaaC9XalGbQxo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NrCSV9WO4OgMQGGtyyQhNtOh7Rctz5eng8UjzW+GH9RrVJsAVqRXPPb4qGipg6WoS
	 3njsyl6TRZBDS6XRHhB53bSbQ/P3KlwZUKa8CshXugr96LqHHLg+CSLg+T0z6fwxx3
	 1jh/qK8zl/9fYgC1ZMUEEW3Jj4bh3tTlTQviOUjh6KpS6KuGpuAg0ZPs7mgVP0VIju
	 bla2egwrdvaYO4ddyGuAp+Woe/IlaImPNjXyRaCgmkRPGbujHmEUUoDsLSwWcUUkUv
	 mNcN0l6Ab3WDiXu0V2NR5AQeVw3taCOPYDAiONktLpCzlZBDE12olbRwGDTo1qhCOl
	 zaqrnFpbs2b4A==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5bcb1f1358aso1370471e87.1
        for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 10:23:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzHjJVl3hYCRnAzCSEilnm57+4Yo3wh1/f2Vna/TNRFVyfxWjgQpH+TSIgrurV3fYCCyT3MI34wSmCE@vger.kernel.org
X-Gm-Message-State: AFq9FYLS2ZdHwy1KnY7e4qpRyALAjPWVfJA86DRriuXwozybD8CbrjY/
	kB44TCTIQZYKuOpCbb4+q+PSD+tsA5JmWNNDahrZyC2lZThepiD4paBy+4oF6P6b/7rXnek/4El
	9byIFpqw1J7cHh6Kt8Tcimp1jihewfg8=
X-Received: by 2002:a05:6512:3dab:b0:5bb:7aca:4cad with SMTP id
 2adb3069b0e04-5bcde357b84mr3896777e87.2.1791825780433; Mon, 12 Oct 2026
 10:23:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930222650.1883805-1-jordan@brough.org> <20260930222650.1883805-3-jordan@brough.org>
In-Reply-To: <20260930222650.1883805-3-jordan@brough.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 12 Oct 2026 19:20:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i1o5OMkUahpN5Yf41LSvqA6o_g4FRk1USyPb++g6pCpw@mail.gmail.com>
X-Gm-Features: AclHuK-V81zLdd0M7IniCEuYNe513tR8kDiRj5tnnAMHciZBx6t0kFpuiN5L_IY
Message-ID: <CAJZ5v0i1o5OMkUahpN5Yf41LSvqA6o_g4FRk1USyPb++g6pCpw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] ACPI: battery: add unified battery hook mechanism
 for ACPI and SBS batteries
To: Jordan Brough <jordan@brough.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 12:27=E2=80=AFAM Jordan Brough <jordan@brough.org> w=
rote:
>
> The battery hook API only works with ACPI Control Method batteries
> (battery.c). Machines with a Smart Battery System battery (sbs.c) have no
> equivalent, so drivers cannot attach extra power_supply properties to the=
m.
>
> Move the hook list and registration code out of battery.c into a new
> battery_hooks.c that both battery.c and sbs.c use, through
> acpi_battery_add_hooks() and acpi_battery_remove_hooks(), which are
> exported in the ACPI_BATTERY_HOOKS namespace. The exported hook functions
> are unchanged.
>
> The new file is built only when ACPI_BATTERY or ACPI_SBS is, through a
> hidden ACPI_BATTERY_HOOKS symbol that they select. Since the hook lists
> now live there, registered hooks stay registered when battery.ko or
> sbs.ko is reloaded, and battery_hook_exit() is no longer needed.
>
> Suggested-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> Signed-off-by: Jordan Brough <jordan@brough.org>

I can apply this along with the [1/3], but the last patch will need to
go through the hwmon tree.  Also please note that Sashiko is
complaining about that patch:

https://sashiko.dev/#/patchset/20260930222650.1883805-1-jordan%40brough.org

My suggestion would be to let the first two patches in the series go
into 7.4 and do the last one properly later.

Please let me know what you think.

> ---
>  drivers/acpi/Kconfig         |   5 ++
>  drivers/acpi/Makefile        |   1 +
>  drivers/acpi/battery.c       | 166 +----------------------------------
>  drivers/acpi/battery_hooks.c | 159 +++++++++++++++++++++++++++++++++
>  drivers/acpi/sbs.c           |   8 +-
>  include/acpi/battery.h       |   9 ++
>  6 files changed, 185 insertions(+), 163 deletions(-)
>  create mode 100644 drivers/acpi/battery_hooks.c
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index f165d14cf61a..d0278f13e96f 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -171,8 +171,12 @@ config ACPI_AC
>           To compile this driver as a module, choose M here:
>           the module will be called ac.
>
> +config ACPI_BATTERY_HOOKS
> +       tristate
> +
>  config ACPI_BATTERY
>         tristate "Battery"
> +       select ACPI_BATTERY_HOOKS
>         select POWER_SUPPLY
>         default y
>         help
> @@ -445,6 +449,7 @@ config ACPI_HOTPLUG_IOAPIC
>  config ACPI_SBS
>         tristate "Smart Battery System"
>         depends on X86 && ACPI_EC
> +       select ACPI_BATTERY_HOOKS
>         select POWER_SUPPLY
>         help
>           This driver supports the Smart Battery System, another
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index d1b0affb844f..eb744dc81d3f 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -97,6 +97,7 @@ obj-$(CONFIG_ACPI_NHLT)               +=3D nhlt.o
>  obj-$(CONFIG_ACPI_NUMA)                +=3D numa/
>  obj-$(CONFIG_ACPI)             +=3D acpi_memhotplug.o
>  obj-$(CONFIG_ACPI_HOTPLUG_IOAPIC) +=3D ioapic.o
> +obj-$(CONFIG_ACPI_BATTERY_HOOKS)       +=3D battery_hooks.o
>  obj-$(CONFIG_ACPI_BATTERY)     +=3D battery.o
>  obj-$(CONFIG_ACPI_SBS)         +=3D sbshc.o
>  obj-$(CONFIG_ACPI_SBS)         +=3D sbs.o
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 306bb2088ca6..0d74f998eae6 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -54,6 +54,7 @@ MODULE_AUTHOR("Paul Diefenbaugh");
>  MODULE_AUTHOR("Alexey Starikovskiy <astarikovskiy@suse.de>");
>  MODULE_DESCRIPTION("ACPI Battery Driver");
>  MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("ACPI_BATTERY_HOOKS");
>
>  static int battery_bix_broken_package;
>  static int battery_notification_delay_ms;
> @@ -105,7 +106,7 @@ struct acpi_battery {
>         struct kfifo acpi_notif_fifo;
>         struct delayed_work acpi_notif_dwork;
>         struct notifier_block pm_nb;
> -       struct list_head list;
> +       struct acpi_battery_hooks_list_entry hooks_list_entry;
>         unsigned long flags;
>
>         struct mutex property_lock; /* Protects properties below. */
> @@ -808,164 +809,6 @@ static struct attribute *acpi_battery_attrs[] =3D {
>  };
>  ATTRIBUTE_GROUPS(acpi_battery);
>
> -/*
> - * The Battery Hooking API
> - *
> - * This API is used inside other drivers that need to expose
> - * platform-specific behaviour within the generic driver in a
> - * generic way.
> - *
> - */
> -
> -static LIST_HEAD(acpi_battery_list);
> -static LIST_HEAD(battery_hook_list);
> -static DEFINE_MUTEX(hook_mutex);
> -
> -static void acpi_battery_hook_unregister_unlocked(struct acpi_battery_ho=
ok *hook)
> -{
> -       struct acpi_battery *battery;
> -
> -       /*
> -        * In order to remove a hook, we first need to
> -        * de-register all the batteries that are registered.
> -        */
> -       list_for_each_entry(battery, &acpi_battery_list, list) {
> -               if (!hook->remove_battery(battery->bat, hook))
> -                       power_supply_changed(battery->bat);
> -       }
> -       list_del_init(&hook->list);
> -
> -       pr_info("hook unregistered: %s\n", hook->name);
> -}
> -
> -void acpi_battery_hook_unregister(struct acpi_battery_hook *hook)
> -{
> -       mutex_lock(&hook_mutex);
> -       /*
> -        * Ignore already unregistered battery hooks. This might happen
> -        * if a battery hook was previously unloaded due to an error when
> -        * adding a new battery.
> -        */
> -       if (!list_empty(&hook->list))
> -               acpi_battery_hook_unregister_unlocked(hook);
> -
> -       mutex_unlock(&hook_mutex);
> -}
> -EXPORT_SYMBOL_GPL(acpi_battery_hook_unregister);
> -
> -void acpi_battery_hook_register(struct acpi_battery_hook *hook)
> -{
> -       struct acpi_battery *battery;
> -
> -       mutex_lock(&hook_mutex);
> -       list_add(&hook->list, &battery_hook_list);
> -       /*
> -        * Now that the driver is registered, we need
> -        * to notify the hook that a battery is available
> -        * for each battery, so that the driver may add
> -        * its attributes.
> -        */
> -       list_for_each_entry(battery, &acpi_battery_list, list) {
> -               if (hook->add_battery(battery->bat, hook)) {
> -                       /*
> -                        * If a add-battery returns non-zero,
> -                        * the registration of the hook has failed,
> -                        * and we will not add it to the list of loaded
> -                        * hooks.
> -                        */
> -                       pr_err("hook failed to load: %s", hook->name);
> -                       acpi_battery_hook_unregister_unlocked(hook);
> -                       goto end;
> -               }
> -
> -               power_supply_changed(battery->bat);
> -       }
> -       pr_info("new hook: %s\n", hook->name);
> -end:
> -       mutex_unlock(&hook_mutex);
> -}
> -EXPORT_SYMBOL_GPL(acpi_battery_hook_register);
> -
> -static void devm_acpi_battery_hook_unregister(void *data)
> -{
> -       struct acpi_battery_hook *hook =3D data;
> -
> -       acpi_battery_hook_unregister(hook);
> -}
> -
> -int devm_acpi_battery_hook_register(struct device *dev, struct acpi_batt=
ery_hook *hook)
> -{
> -       acpi_battery_hook_register(hook);
> -
> -       return devm_add_action_or_reset(dev, devm_acpi_battery_hook_unreg=
ister, hook);
> -}
> -EXPORT_SYMBOL_GPL(devm_acpi_battery_hook_register);
> -
> -/*
> - * This function gets called right after the battery sysfs
> - * attributes have been added, so that the drivers that
> - * define custom sysfs attributes can add their own.
> - */
> -static void battery_hook_add_battery(struct acpi_battery *battery)
> -{
> -       struct acpi_battery_hook *hook_node, *tmp;
> -
> -       mutex_lock(&hook_mutex);
> -       INIT_LIST_HEAD(&battery->list);
> -       list_add(&battery->list, &acpi_battery_list);
> -       /*
> -        * Since we added a new battery to the list, we need to
> -        * iterate over the hooks and call add_battery for each
> -        * hook that was registered. This usually happens
> -        * when a battery gets hotplugged or initialized
> -        * during the battery module initialization.
> -        */
> -       list_for_each_entry_safe(hook_node, tmp, &battery_hook_list, list=
) {
> -               if (hook_node->add_battery(battery->bat, hook_node)) {
> -                       /*
> -                        * The notification of the hook has failed, to
> -                        * prevent further errors we will unload the hook=
.
> -                        */
> -                       pr_err("error in hook, unloading: %s",
> -                                       hook_node->name);
> -                       acpi_battery_hook_unregister_unlocked(hook_node);
> -               }
> -       }
> -       mutex_unlock(&hook_mutex);
> -}
> -
> -static void battery_hook_remove_battery(struct acpi_battery *battery)
> -{
> -       struct acpi_battery_hook *hook;
> -
> -       mutex_lock(&hook_mutex);
> -       /*
> -        * Before removing the hook, we need to remove all
> -        * custom attributes from the battery.
> -        */
> -       list_for_each_entry(hook, &battery_hook_list, list) {
> -               hook->remove_battery(battery->bat, hook);
> -       }
> -       /* Then, just remove the battery from the list */
> -       list_del(&battery->list);
> -       mutex_unlock(&hook_mutex);
> -}
> -
> -static void __exit battery_hook_exit(void)
> -{
> -       struct acpi_battery_hook *hook;
> -       struct acpi_battery_hook *ptr;
> -       /*
> -        * At this point, the acpi_bus_unregister_driver()
> -        * has called remove for all batteries. We just
> -        * need to remove the hooks.
> -        */
> -       list_for_each_entry_safe(hook, ptr, &battery_hook_list, list) {
> -               acpi_battery_hook_unregister(hook);
> -       }
> -       mutex_destroy(&hook_mutex);
> -}
> -
>  static int sysfs_add_battery(struct acpi_battery *battery)
>  {
>         bool extended_info_available =3D test_bit(ACPI_BATTERY_XINFO_PRES=
ENT, &battery->flags);
> @@ -1052,7 +895,7 @@ static int sysfs_add_battery(struct acpi_battery *ba=
ttery)
>                 battery->bat =3D NULL;
>                 return result;
>         }
> -       battery_hook_add_battery(battery);
> +       acpi_battery_add_hooks(&battery->hooks_list_entry, battery->bat);
>         return 0;
>  }
>
> @@ -1061,7 +904,7 @@ static void sysfs_remove_battery(struct acpi_battery=
 *battery)
>         if (!battery->bat)
>                 return;
>
> -       battery_hook_remove_battery(battery);
> +       acpi_battery_remove_hooks(&battery->hooks_list_entry);
>         power_supply_unregister(battery->bat);
>         battery->bat =3D NULL;
>  }
> @@ -1571,7 +1414,6 @@ static int __init acpi_battery_init(void)
>  static void __exit acpi_battery_exit(void)
>  {
>         platform_driver_unregister(&acpi_battery_driver);
> -       battery_hook_exit();
>  }
>
>  module_init(acpi_battery_init);
> diff --git a/drivers/acpi/battery_hooks.c b/drivers/acpi/battery_hooks.c
> new file mode 100644
> index 000000000000..ca3f9876cb09
> --- /dev/null
> +++ b/drivers/acpi/battery_hooks.c
> @@ -0,0 +1,159 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ACPI Battery Hooks
> + *
> + * Provides helpers for registering and unregistering battery hooks for
> + * drivers that use platform-specific extensions to ACPI-enumerated
> + * batteries (both ACPI Control Method batteries and Smart Battery Syste=
m
> + * batteries).
> + */
> +
> +#define pr_fmt(fmt) "ACPI: battery: " fmt
> +
> +#include <linux/cleanup.h>
> +#include <linux/device.h>
> +#include <linux/export.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/power_supply.h>
> +#include <acpi/battery.h>
> +
> +static LIST_HEAD(acpi_battery_list);
> +static LIST_HEAD(battery_hook_list);
> +static DEFINE_MUTEX(hook_mutex);
> +
> +static void acpi_battery_hook_unregister_unlocked(struct acpi_battery_ho=
ok *hook)
> +{
> +       struct acpi_battery_hooks_list_entry *entry;
> +
> +       /*
> +        * In order to remove a hook, we first need to
> +        * de-register all the batteries that are registered.
> +        */
> +       list_for_each_entry(entry, &acpi_battery_list, list_entry) {
> +               if (!hook->remove_battery(entry->battery, hook))
> +                       power_supply_changed(entry->battery);
> +       }
> +       list_del_init(&hook->list);
> +
> +       pr_info("hook unregistered: %s\n", hook->name);
> +}
> +
> +void acpi_battery_hook_unregister(struct acpi_battery_hook *hook)
> +{
> +       guard(mutex)(&hook_mutex);
> +
> +       /*
> +        * Ignore already unregistered battery hooks. This might happen
> +        * if a battery hook was previously unloaded due to an error when
> +        * adding a new battery.
> +        */
> +       if (!list_empty(&hook->list))
> +               acpi_battery_hook_unregister_unlocked(hook);
> +}
> +EXPORT_SYMBOL_GPL(acpi_battery_hook_unregister);
> +
> +void acpi_battery_hook_register(struct acpi_battery_hook *hook)
> +{
> +       struct acpi_battery_hooks_list_entry *entry;
> +
> +       guard(mutex)(&hook_mutex);
> +
> +       list_add(&hook->list, &battery_hook_list);
> +       /*
> +        * Now that the driver is registered, we need
> +        * to notify the hook that a battery is available
> +        * for each battery, so that the driver may add
> +        * its attributes.
> +        */
> +       list_for_each_entry(entry, &acpi_battery_list, list_entry) {
> +               if (hook->add_battery(entry->battery, hook)) {
> +                       /*
> +                        * If a add-battery returns non-zero,
> +                        * the registration of the hook has failed,
> +                        * and we will not add it to the list of loaded
> +                        * hooks.
> +                        */
> +                       pr_err("hook failed to load: %s\n", hook->name);
> +                       acpi_battery_hook_unregister_unlocked(hook);
> +                       return;
> +               }
> +
> +               power_supply_changed(entry->battery);
> +       }
> +       pr_info("new hook: %s\n", hook->name);
> +}
> +EXPORT_SYMBOL_GPL(acpi_battery_hook_register);
> +
> +static void devm_acpi_battery_hook_unregister(void *data)
> +{
> +       struct acpi_battery_hook *hook =3D data;
> +
> +       acpi_battery_hook_unregister(hook);
> +}
> +
> +int devm_acpi_battery_hook_register(struct device *dev,
> +                                   struct acpi_battery_hook *hook)
> +{
> +       acpi_battery_hook_register(hook);
> +
> +       return devm_add_action_or_reset(dev, devm_acpi_battery_hook_unreg=
ister, hook);
> +}
> +EXPORT_SYMBOL_GPL(devm_acpi_battery_hook_register);
> +
> +/*
> + * This function gets called right after the battery sysfs
> + * attributes have been added, so that the drivers that
> + * define custom sysfs attributes can add their own.
> + */
> +void acpi_battery_add_hooks(struct acpi_battery_hooks_list_entry *entry,
> +                           struct power_supply *battery)
> +{
> +       struct acpi_battery_hook *hook_node, *tmp;
> +
> +       entry->battery =3D battery;
> +
> +       guard(mutex)(&hook_mutex);
> +
> +       list_add(&entry->list_entry, &acpi_battery_list);
> +       /*
> +        * Since we added a new battery to the list, we need to
> +        * iterate over the hooks and call add_battery for each
> +        * hook that was registered. This usually happens
> +        * when a battery gets hotplugged or initialized
> +        * during the battery module initialization.
> +        */
> +       list_for_each_entry_safe(hook_node, tmp, &battery_hook_list, list=
) {
> +               if (hook_node->add_battery(entry->battery, hook_node)) {
> +                       /*
> +                        * The notification of the hook has failed, to
> +                        * prevent further errors we will unload the hook=
.
> +                        */
> +                       pr_err("error in hook, unloading: %s\n", hook_nod=
e->name);
> +                       acpi_battery_hook_unregister_unlocked(hook_node);
> +               }
> +       }
> +}
> +EXPORT_SYMBOL_NS_GPL(acpi_battery_add_hooks, "ACPI_BATTERY_HOOKS");
> +
> +void acpi_battery_remove_hooks(struct acpi_battery_hooks_list_entry *ent=
ry)
> +{
> +       struct acpi_battery_hook *hook;
> +
> +       guard(mutex)(&hook_mutex);
> +       /*
> +        * Before removing the hook, we need to remove all
> +        * custom attributes from the battery.
> +        */
> +       list_for_each_entry(hook, &battery_hook_list, list)
> +               hook->remove_battery(entry->battery, hook);
> +
> +       /* Then, just remove the battery from the list */
> +       list_del(&entry->list_entry);
> +       entry->battery =3D NULL;
> +}
> +EXPORT_SYMBOL_NS_GPL(acpi_battery_remove_hooks, "ACPI_BATTERY_HOOKS");
> +
> +MODULE_DESCRIPTION("ACPI battery hooks");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
> index f10bbf13c242..f80a6294953a 100644
> --- a/drivers/acpi/sbs.c
> +++ b/drivers/acpi/sbs.c
> @@ -36,6 +36,7 @@
>  MODULE_AUTHOR("Alexey Starikovskiy <astarikovskiy@suse.de>");
>  MODULE_DESCRIPTION("Smart Battery System ACPI interface driver");
>  MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("ACPI_BATTERY_HOOKS");
>
>  static unsigned int cache_time =3D 1000;
>  module_param(cache_time, uint, 0644);
> @@ -54,6 +55,7 @@ struct acpi_battery {
>         struct power_supply *bat;
>         struct power_supply_desc bat_desc;
>         struct acpi_sbs *sbs;
> +       struct acpi_battery_hooks_list_entry hooks_list_entry;
>         unsigned long update_time;
>         char name[8];
>         char manufacturer_name[ACPI_SBS_BLOCK_MAX];
> @@ -555,6 +557,8 @@ static int acpi_battery_add(struct acpi_sbs *sbs, int=
 id)
>                 goto end;
>         }
>
> +       acpi_battery_add_hooks(&battery->hooks_list_entry, battery->bat);
> +
>        end:
>         pr_info("%s [%s]: Battery Slot [%s] (battery %s)\n",
>                ACPI_SBS_DEVICE_NAME, acpi_device_bid(sbs->device),
> @@ -566,8 +570,10 @@ static void acpi_battery_remove(struct acpi_sbs *sbs=
, int id)
>  {
>         struct acpi_battery *battery =3D &sbs->battery[id];
>
> -       if (battery->bat)
> +       if (battery->bat) {
> +               acpi_battery_remove_hooks(&battery->hooks_list_entry);
>                 power_supply_unregister(battery->bat);
> +       }
>  }
>
>  static int acpi_charger_add(struct acpi_sbs *sbs)
> diff --git a/include/acpi/battery.h b/include/acpi/battery.h
> index 08c7e37996bf..6360f102a4e8 100644
> --- a/include/acpi/battery.h
> +++ b/include/acpi/battery.h
> @@ -18,9 +18,18 @@ struct acpi_battery_hook {
>         struct list_head list;
>  };
>
> +struct acpi_battery_hooks_list_entry {
> +       struct list_head list_entry;
> +       struct power_supply *battery;
> +};
> +
>  void acpi_battery_hook_register(struct acpi_battery_hook *hook);
>  void acpi_battery_hook_unregister(struct acpi_battery_hook *hook);
>  int devm_acpi_battery_hook_register(struct device *dev,
>                                     struct acpi_battery_hook *hook);
>
> +void acpi_battery_add_hooks(struct acpi_battery_hooks_list_entry *entry,
> +                           struct power_supply *battery);
> +void acpi_battery_remove_hooks(struct acpi_battery_hooks_list_entry *ent=
ry);
> +
>  #endif
> --
> 2.56.0
>
