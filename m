Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88213126B2;
	Wed, 22 Jul 2026 18:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784744731; cv=pass; b=lY4z1+YyHQ2a7KUyXitAzudbSaGy8V0AiRkV446Xf1ZENk2MjvUB4r5ac4TAN1dFElJfZrJfoXwAZYD2QVBHABFI4L5Xo33farFnGkGBoPP5CzWP/uls/adXcuGv8NSp1RbzconqrzZrXrXOpbSq44ncczTMClxlYfJdG4hHVB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784744731; c=relaxed/simple;
	bh=2cyLUo1rl5dM5/DS++MVVHRh9dG6K7xuiCIatM7/KrA=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=pqOKTVF+jbWEMy9I3EqgvOE+eWhcFZjCR3rVjwQ+4nv1yw1MjKnm1F+J+zshaeSoFtpj3GDnP9Yk7EYcg0PLnn0Kk7bTAuxx3/XG02I6+q3K9dSeyI24yVTcBPeQKb7uDII4OlZsoL1869LoqDCsK9KnTlvCd+Risc3+k0ZtHfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=Bmob3lkt; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="Bmob3lkt"
ARC-Seal: i=1; a=rsa-sha256; t=1784744713; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UTyWLCmGUvvrqoFmFn27kaN9FkiD0EpYHP8i80N9h8atptHawcLfcbvNYbp6BOAQmd7+KUI+IhUHPVwg+v+tG6OFG1MvzuWA9/tt6Af2SQFxTPBJVOYQAtVS9u/qqmawxmbTq7YOcUJBe7e23SbKTDjY0alHa3SzOwdiUheqsz4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784744713; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9DczhBpU8cvt4mmniVyhDcDTe8buY0lxzuJU64mkSRQ=; 
	b=g3VJIc4/p6XjaIBNw0T7yLapCJCNq4RS/YcGPunEXQn9xk1l8Qe4RVysp4gdNQ7rJmh3JiGqd51aT8Cooq++pn6jqg5E7smJUjg4aXdglkqe6edJq0F9GayjidmIO58hbB5bqK9oxR/mESsEHG5GRmHLI27Soe51cDdrmFP8n1k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784744713;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=9DczhBpU8cvt4mmniVyhDcDTe8buY0lxzuJU64mkSRQ=;
	b=Bmob3lktDAljvo5dQATvdnXHS+BOz0FtPJxS9pwwNDCDfsBG48n5Ny0Ef2V8OKM4
	0RsY+PqnYSqF3GMu4TnbqW6Zx2ZHDIFJemhUKtBIz8xLOM6Rf79GoO6PuHo1bKA0uvi
	7Bloy2XVyCDHlsG9q+BXIyiyR3v+zvIQZsJ5+Tnf1GdIdsDOPUwsNwnPSQCNsMonLuN
	zwE4cOKuPaOjJue9xtj6uCQD6xs4HpW/Jhzx2DChS6ppLrfnFiMzhoAiGX87Lxkp9ab
	A+Mm6Mjfsnl2O7SGq+x80il29EmamUKOxNkFdTmI4ogKz6Ezbfz8L/cjqMiuwcdtJQJ
	KBuTDWgO0g==
Received: by mx.zohomail.com with SMTPS id 1784744712272340.76908811260967;
	Wed, 22 Jul 2026 11:25:12 -0700 (PDT)
Message-ID: <9055f4665dfb170f7053f785c76e46dfe364fd87.camel@rong.moe>
Subject: Re: [PATCH v4 3/3] ACPI: battery: Protect all properties with a
 separated mutex
From: Rong Zhang <i@rong.moe>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki"	
 <rafael.j.wysocki@intel.com>, Avraham Hollander <anhollander516@gmail.com>,
  Jeffrey =?ISO-8859-1?Q?W=E4lti?=	 <jeffrey@waelti.dev>, Rick
 <rickk1166@gmail.com>, Mark Pearson	 <mpearson-lenovo@squebb.ca>,
 linux-acpi@vger.kernel.org, 	linux-kernel@vger.kernel.org
In-Reply-To: <CAJZ5v0ijiG23QWjG9C9OfZSB5jxFTg42OwYRS6KVc=Voi2s42w@mail.gmail.com>
References: 
	<20260718-b4-acpi-battery-notification-v4-0-599c8ed1072f@rong.moe>
	 <20260718-b4-acpi-battery-notification-v4-3-599c8ed1072f@rong.moe>
	 <CAJZ5v0ijiG23QWjG9C9OfZSB5jxFTg42OwYRS6KVc=Voi2s42w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 02:20:05 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-10 
X-ZohoMailClient: External

Hi Rafael,

On Tue, 2026-07-21 at 22:54 +0200, Rafael J. Wysocki (Intel) wrote:
> On Sat, Jul 18, 2026 at 1:11=E2=80=AFAM Rong Zhang <i@rong.moe> wrote:
> >=20
> > The acpi_battery_get_property() callback calls acpi_battery_get_state()
> > without any lock held, which could lead to race conditions, e.g., when
> > multiple tasks read power supply properties simultaneously, or when
> > other callbacks are called during its execution.
> >=20
> > Moreover, some devices' _BST method relies on a heavily shared ACPI
> > mutex which protects EC accesses, so it cannot tolerate too much
> > pressure or else other methods will time out. The lack of
> > synchronization sometimes nullifies the cache mechanism of
> > acpi_battery_get_state() when multiple processes read power supply
> > properties simultaneously, which usually happens after a uevent.
> > Normally, emitting a uevent implies that the cache must have been
> > refreshed due to power_supply_uevent() reading all properties, so the
> > mentioned processes should have seen cache hits. Unfortunately, these
> > fragile devices' power_supply_ext properties are somehow slow to read
> > after battery events, resulting in cache expiration before
> > power_supply_uevent() finishes. Hence, once the uevent reaches
> > userspace, the _BST method will be executed multiple times within a
> > short period due to userspace processes reading all properties again.
> > The coincidence causes lock starvation, resulting in a catastrophic
> > situation that a lot of ACPI methods fail to acquire the shared ACPI
> > mutex due to timeout and return garbage data thanks to the firmware's
> > poorly designed error paths.
> >=20
> > The said "other synchronized methods" are protected by update_lock,
> > leaving acpi_battery_get_property() to be the last desynchronized code
> > path. Unfortunately, update_lock is not applicapable for
> > acpi_battery_get_property(), as it protects too many fields, far more
> > than necessary. What's worse, some code path could call or wait for
> > acpi_battery_get_property() while an outer functions holding
> > update_lock.
> >=20
> > Therefore, introduce a mutex to protect all accesses to battery
> > properties, so that acpi_battery_get_property() can take the advantage
> > of the mutex and synchronize itself. The helper function
> > acpi_battery_handle_discharging() for quirky devices has to be inlined
> > due to the change, as the mutex must be unlocked before calling the
> > expensive power_supply_is_system_supplied() helper function.
> >=20
> > Tested-by: Avraham Hollander <anhollander516@gmail.com>
> > Reported-by: Rick <rickk1166@gmail.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D221065
> > Signed-off-by: Rong Zhang <i@rong.moe>
>=20
> I have queued up the other 2 patches in the series for 7.3,=C2=A0
>=20

Thanks a lot ;-)

> but this
> one is not quite ready IMV.
>=20
> In the first place, it is not quite clear from the changelog what
> exactly the role of the new mutex is.

It aims to eliminate lock-free access to battery properties. Especially,
synchronize the fragile update_time-based cache.

I agreed that the changelog is somehow hard to read. I was struggling to
summarize the debugging findings, and it turned out to be too
complicated. I will explain them below.

>=20
> If there are any real race conditions it prevents from occurring, it
> would be good to give examples.

This pattern can be reliably reproduced on Rick's device. I had a
detailed analysis to the sysrq stacktraces on his device, see
https://bugzilla.kernel.org/show_bug.cgi?id=3D221065#c85

>=20
> Moreover, the exact mechanism of the _BST synchronization failure is
> unclear to me because in Linux all AML evaluation is synchronized by
> the namespace and interpreter mutexes. =C2=A0
>=20

Well, _BST itself has no synchronization failure. It's always evaluated
serialized. However, the frequency of its evaluation matters on buggy
devices.

> If that is not sufficient, it
> would be good to explain why because as it stands, it is not clear
> whether or not the approach used in this patch is adequate.

The issue is about the synchronization failure of battery->update_time
due to acpi_battery_get_property() calling acpi_battery_get_state()
without any mutex held, which results in _BST being evaluated too
frequently.

The _BST method on buggy devices acquires an ACPI mutex called ECMT. As
the name suggests, the mutex protects all sorts of EC stuff. The mutex
is heavily used, but very fragile. It is prone to some sorts of lock
starvation (or deadlock? I am unsure as I don't have a buggy device)
once its acquired too frequently. Lock starvation causes mutex
acquisition timeout in other methods, which is handled by the firmware
poorly, and thus leads to catastrophic results.

Once battery->update_time has expired, multiple get_property() requests
originated from userspace will all have to try to evaluate the _BST
method. The evaluation is indeed serialized, but still causing to much
pressure on the mutex.

The patch fixes the synchronization failure of the unfortunate
combination of battery->update_time and acpi_battery_get_property(), and
thus always ensures the 1000ms gap (i.e., cache_time).


BTW, even not thinking about the buggy device, the race condition of
property access still exists. Consider:

		CPU0				CPU1
acpi_battery_get_property()
  acpi_battery_get_state()
    [update_time expired]
    extract_package()			acpi_battery_get_property()
    battery->update_time =3D jiffies	  acpi_battery_get_state()
					    [up to date]
					  [read capacity_now]
					return
    [fix capacity_now due to quirk]
    ...

where CPU1 reads raw capacity_now before CPU0 fixes it to a meaningful
value.

Does my explanation make sense to you? If so, I will refine the
changelog and resubmit the patch.

Thanks,
Rong

>=20
> > ---
> > Changes in v3:
> > - Address Sashiko's concerns on my last-minute changes:
> >   - Do not overwrite the initial value of `ret' in
> >     acpi_battery_get_property()
> >   - https://sashiko.dev/#/patchset/20260611-b4-acpi-battery-notificatio=
n-v2-0-4e8ed651a151%40rong.moe
> >=20
> > Changes in v2:
> > - Address Sashiko's concerns:
> >   - Use a separated mutex to protect all properties instead of reusing
> >     update_lock
> >   - https://sashiko.dev/#/patchset/20260527-b4-acpi-battery-notificatio=
n-v1-0-2303bed8ec0b%40rong.moe
> > - Dropped Tested-by due to massive rewrite
> > ---
> >  drivers/acpi/battery.c | 147 +++++++++++++++++++++++++++++++++--------=
--------
> >  1 file changed, 101 insertions(+), 46 deletions(-)
> >=20
> > diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> > index bd7fa93ff16f..3ad4acf3d44d 100644
> > --- a/drivers/acpi/battery.c
> > +++ b/drivers/acpi/battery.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/kfifo.h>
> >  #include <linux/list.h>
> > +#include <linux/lockdep.h>
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> >  #include <linux/platform_device.h>
> > @@ -104,6 +105,9 @@ struct acpi_battery {
> >         struct delayed_work acpi_notif_dwork;
> >         struct notifier_block pm_nb;
> >         struct list_head list;
> > +       unsigned long flags;
> > +
> > +       struct mutex property_lock; /* Protects properties below. */
> >         unsigned long update_time;
> >         int revision;
> >         int rate_now;
> > @@ -130,7 +134,6 @@ struct acpi_battery {
> >         char oem_info[MAX_STRING_LENGTH];
> >         int state;
> >         int power_unit;
> > -       unsigned long flags;
> >  };
> >=20
> >  #define to_acpi_battery(x) power_supply_get_drvdata(x)
> > @@ -187,20 +190,6 @@ static bool acpi_battery_is_degraded(struct acpi_b=
attery *battery)
> >                 battery->full_charge_capacity < battery->design_capacit=
y;
> >  }
> >=20
> > -static int acpi_battery_handle_discharging(struct acpi_battery *batter=
y)
> > -{
> > -       /*
> > -        * Some devices wrongly report discharging if the battery's cha=
rge level
> > -        * was above the device's start charging threshold atm the AC a=
dapter
> > -        * was plugged in and the device thus did not start a new charg=
e cycle.
> > -        */
> > -       if ((battery_ac_is_broken || power_supply_is_system_supplied())=
 &&
> > -           battery->rate_now =3D=3D 0)
> > -               return POWER_SUPPLY_STATUS_NOT_CHARGING;
> > -
> > -       return POWER_SUPPLY_STATUS_DISCHARGING;
> > -}
> > -
> >  static int acpi_battery_get_property(struct power_supply *psy,
> >                                      enum power_supply_property psp,
> >                                      union power_supply_propval *val)
> > @@ -208,15 +197,41 @@ static int acpi_battery_get_property(struct power=
_supply *psy,
> >         int full_capacity =3D ACPI_BATTERY_VALUE_UNKNOWN, ret =3D 0;
> >         struct acpi_battery *battery =3D to_acpi_battery(psy);
> >=20
> > -       if (acpi_battery_present(battery)) {
> > -               /* run battery update only if it is present */
> > -               acpi_battery_get_state(battery);
> > -       } else if (psp !=3D POWER_SUPPLY_PROP_PRESENT)
> > -               return -ENODEV;
> > +       /* run battery update only if it is present */
> > +       if (!acpi_battery_present(battery)) {
> > +               switch (psp) {
> > +               case POWER_SUPPLY_PROP_PRESENT:
> > +                       val->intval =3D 0;
> > +                       return 0;
> > +               default:
> > +                       return -ENODEV;
> > +               }
> > +       }
> > +
> > +       mutex_lock(&battery->property_lock);
> > +
> > +       acpi_battery_get_state(battery);
> > +
> >         switch (psp) {
> >         case POWER_SUPPLY_PROP_STATUS:
> > +               /*
> > +                * Some devices wrongly report discharging if the batte=
ry's charge level
> > +                * was above the device's start charging threshold atm =
the AC adapter
> > +                * was plugged in and the device thus did not start a n=
ew charge cycle.
> > +                */
> >                 if (battery->state & ACPI_BATTERY_STATE_DISCHARGING)
> > -                       val->intval =3D acpi_battery_handle_discharging=
(battery);
> > +                       if (battery->rate_now !=3D 0) {
> > +                               val->intval =3D POWER_SUPPLY_STATUS_DIS=
CHARGING;
> > +                       } else if (battery_ac_is_broken) {
> > +                               val->intval =3D POWER_SUPPLY_STATUS_NOT=
_CHARGING;
> > +                       } else {
> > +                               mutex_unlock(&battery->property_lock);
> > +
> > +                               val->intval =3D power_supply_is_system_=
supplied()
> > +                                       ? POWER_SUPPLY_STATUS_NOT_CHARG=
ING
> > +                                       : POWER_SUPPLY_STATUS_DISCHARGI=
NG;
> > +                               return 0;
> > +                       }
> >                 else if (battery->state & ACPI_BATTERY_STATE_CHARGING)
> >                         /* Validate the status by checking the current.=
 */
> >                         if (battery->rate_now !=3D ACPI_BATTERY_VALUE_U=
NKNOWN &&
> > @@ -318,6 +333,8 @@ static int acpi_battery_get_property(struct power_s=
upply *psy,
> >         default:
> >                 ret =3D -EINVAL;
> >         }
> > +
> > +       mutex_unlock(&battery->property_lock);
> >         return ret;
> >  }
> >=20
> > @@ -540,6 +557,8 @@ static int acpi_battery_get_info(struct acpi_batter=
y *battery)
> >         int use_bix;
> >         int result =3D -ENODEV;
> >=20
> > +       lockdep_assert_held(&battery->property_lock);
> > +
> >         if (!acpi_battery_present(battery))
> >                 return 0;
> >=20
> > @@ -579,6 +598,8 @@ static int acpi_battery_get_state(struct acpi_batte=
ry *battery)
> >         acpi_status status =3D 0;
> >         struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> >=20
> > +       lockdep_assert_held(&battery->property_lock);
> > +
> >         if (!acpi_battery_present(battery))
> >                 return 0;
> >=20
> > @@ -632,6 +653,8 @@ static int acpi_battery_set_alarm(struct acpi_batte=
ry *battery)
> >  {
> >         acpi_status status =3D 0;
> >=20
> > +       lockdep_assert_held(&battery->property_lock);
> > +
> >         if (!acpi_battery_present(battery) ||
> >             !test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags))
> >                 return -ENODEV;
> > @@ -649,6 +672,8 @@ static int acpi_battery_set_alarm(struct acpi_batte=
ry *battery)
> >=20
> >  static int acpi_battery_init_alarm(struct acpi_battery *battery)
> >  {
> > +       lockdep_assert_held(&battery->property_lock);
> > +
> >         /* See if alarms are supported, and if so, set default */
> >         if (!acpi_has_method(battery->device->handle, "_BTP")) {
> >                 clear_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags);
> > @@ -666,6 +691,8 @@ static ssize_t acpi_battery_alarm_show(struct devic=
e *dev,
> >  {
> >         struct acpi_battery *battery =3D to_acpi_battery(dev_get_drvdat=
a(dev));
> >=20
> > +       guard(mutex)(&battery->property_lock);
> > +
> >         return sysfs_emit(buf, "%d\n", battery->alarm * 1000);
> >  }
> >=20
> > @@ -681,6 +708,8 @@ static ssize_t acpi_battery_alarm_store(struct devi=
ce *dev,
> >         if (err)
> >                 return err;
> >=20
> > +       guard(mutex)(&battery->property_lock);
> > +
> >         battery->alarm =3D x / 1000;
> >         if (acpi_battery_present(battery))
> >                 acpi_battery_set_alarm(battery);
> > @@ -865,12 +894,17 @@ static int sysfs_add_battery(struct acpi_battery =
*battery)
> >                 .no_wakeup_source =3D true,
> >         };
> >         bool full_cap_broken =3D false;
> > +       int power_unit;
> >=20
> > -       if (!ACPI_BATTERY_CAPACITY_VALID(battery->full_charge_capacity)=
 &&
> > -           !ACPI_BATTERY_CAPACITY_VALID(battery->design_capacity))
> > -               full_cap_broken =3D true;
> > +       scoped_guard(mutex, &battery->property_lock) {
> > +               power_unit =3D battery->power_unit;
> >=20
> > -       if (battery->power_unit =3D=3D ACPI_BATTERY_POWER_UNIT_MA) {
> > +               if (!ACPI_BATTERY_CAPACITY_VALID(battery->full_charge_c=
apacity) &&
> > +                   !ACPI_BATTERY_CAPACITY_VALID(battery->design_capaci=
ty))
> > +                       full_cap_broken =3D true;
> > +       }
> > +
> > +       if (power_unit =3D=3D ACPI_BATTERY_POWER_UNIT_MA) {
> >                 if (full_cap_broken) {
> >                         battery->bat_desc.properties =3D
> >                             charge_battery_full_cap_broken_props;
> > @@ -924,6 +958,9 @@ static void sysfs_remove_battery(struct acpi_batter=
y *battery)
> >  static void find_battery(const struct dmi_header *dm, void *private)
> >  {
> >         struct acpi_battery *battery =3D (struct acpi_battery *)private=
;
> > +
> > +       lockdep_assert_held(&battery->property_lock);
> > +
> >         /* Note: the hardcoded offsets below have been extracted from
> >          * the source code of dmidecode.
> >          */
> > @@ -955,6 +992,8 @@ static void find_battery(const struct dmi_header *d=
m, void *private)
> >   */
> >  static void acpi_battery_quirks(struct acpi_battery *battery)
> >  {
> > +       lockdep_assert_held(&battery->property_lock);
> > +
> >         if (test_bit(ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY, &battery->=
flags))
> >                 return;
> >=20
> > @@ -1007,30 +1046,38 @@ static void acpi_battery_quirks(struct acpi_bat=
tery *battery)
> >  static int acpi_battery_update(struct acpi_battery *battery, bool resu=
me)
> >  {
> >         int result =3D acpi_battery_get_status(battery);
> > +       bool wakeup;
> >=20
> >         if (result)
> >                 return result;
> >=20
> >         if (!acpi_battery_present(battery)) {
> >                 sysfs_remove_battery(battery);
> > -               battery->update_time =3D 0;
> > +               scoped_guard(mutex, &battery->property_lock)
> > +                       battery->update_time =3D 0;
> >                 return 0;
> >         }
> >=20
> >         if (resume)
> >                 return 0;
> >=20
> > -       if (!battery->update_time) {
> > -               result =3D acpi_battery_get_info(battery);
> > +       scoped_guard(mutex, &battery->property_lock) {
> > +               if (!battery->update_time) {
> > +                       result =3D acpi_battery_get_info(battery);
> > +                       if (result)
> > +                               return result;
> > +                       acpi_battery_init_alarm(battery);
> > +               }
> > +
> > +               result =3D acpi_battery_get_state(battery);
> >                 if (result)
> >                         return result;
> > -               acpi_battery_init_alarm(battery);
> > -       }
> > +               acpi_battery_quirks(battery);
> >=20
> > -       result =3D acpi_battery_get_state(battery);
> > -       if (result)
> > -               return result;
> > -       acpi_battery_quirks(battery);
> > +               wakeup =3D ((battery->state & ACPI_BATTERY_STATE_CRITIC=
AL) ||
> > +                         (test_bit(ACPI_BATTERY_ALARM_PRESENT, &batter=
y->flags) &&
> > +                          (battery->capacity_now <=3D battery->alarm))=
);
> > +       }
> >=20
> >         if (!battery->bat) {
> >                 result =3D sysfs_add_battery(battery);
> > @@ -1042,9 +1089,7 @@ static int acpi_battery_update(struct acpi_batter=
y *battery, bool resume)
> >          * Wakeup the system if battery is critical low
> >          * or lower than the alarm level
> >          */
> > -       if ((battery->state & ACPI_BATTERY_STATE_CRITICAL) ||
> > -           (test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags) &&
> > -            (battery->capacity_now <=3D battery->alarm)))
> > +       if (wakeup)
> >                 acpi_pm_wakeup_event(battery->phys_dev);
> >=20
> >         return result;
> > @@ -1057,12 +1102,14 @@ static void acpi_battery_refresh(struct acpi_ba=
ttery *battery)
> >         if (!battery->bat)
> >                 return;
> >=20
> > -       power_unit =3D battery->power_unit;
> > +       scoped_guard(mutex, &battery->property_lock) {
> > +               power_unit =3D battery->power_unit;
> >=20
> > -       acpi_battery_get_info(battery);
> > +               acpi_battery_get_info(battery);
> >=20
> > -       if (power_unit =3D=3D battery->power_unit)
> > -               return;
> > +               if (power_unit =3D=3D battery->power_unit)
> > +                       return;
> > +       }
> >=20
> >         /* The battery has changed its reporting units. */
> >         sysfs_remove_battery(battery);
> > @@ -1154,17 +1201,21 @@ static int battery_notify(struct notifier_block=
 *nb,
> >                 } else {
> >                         int result;
> >=20
> > -                       result =3D acpi_battery_get_info(battery);
> > -                       if (result)
> > -                               return result;
> > +                       scoped_guard(mutex, &battery->property_lock) {
> > +                               result =3D acpi_battery_get_info(batter=
y);
> > +                               if (result)
> > +                                       return result;
> > +                       }
> >=20
> >                         result =3D sysfs_add_battery(battery);
> >                         if (result)
> >                                 return result;
> >                 }
> >=20
> > -               acpi_battery_init_alarm(battery);
> > -               acpi_battery_get_state(battery);
> > +               scoped_guard(mutex, &battery->property_lock) {
> > +                       acpi_battery_init_alarm(battery);
> > +                       acpi_battery_get_state(battery);
> > +               }
> >         }
> >=20
> >         return 0;
> > @@ -1329,6 +1380,10 @@ static int acpi_battery_probe(struct platform_de=
vice *pdev)
> >         if (result)
> >                 return result;
> >=20
> > +       result =3D devm_mutex_init(&pdev->dev, &battery->property_lock)=
;
> > +       if (result)
> > +               return result;
> > +
> >         if (acpi_has_method(battery->device->handle, "_BIX"))
> >                 set_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags);
> >=20
> >=20
> > --
> > 2.53.0
> >=20
