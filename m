Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5459135C6A3
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 21:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784670129; cv=pass; b=nqH7RNFsjIQxxwj3zRit5Fn8gUC+uuHgdjBwcZd2esZnTwl0ZwIHnVJsk3ILFy2IO4x8oXGwONifuUW+mpADra0J7ZNcHHQnmrdthdjzXVXyQjXYRbBrGl06q8m98znqTVz9ifsFWY00Ml3/rA1n4iNrtybfmgWCb2lM+t7Njtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784670129; c=relaxed/simple;
	bh=TprmPIBMUi9qyJzHhsRrWUWg98oqsdlA2ulv5n+TopY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WqrQL2NdnGg9oPo4bZK2UnoR7E709nJzcRdzGQFpjYEeZRlZQPvvQGQOAS1f971ef6owrTLO27rFkYWS4jI6ocDEqc14B4X30PqfWJ2aSlL/LqrVkk33pKJ4ydB4RY/xy+rB6USY8nLguqS029Xd54b8IKkFFIzbO6aHczMxhmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOKgDFhW; arc=pass smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOKgDFhW"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7475a4f8b05so1769715137.1
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 14:42:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784670126; cv=none;
        d=google.com; s=arc-20260327;
        b=HHq4mN9eX7ZIyDll7p5YBpoH7aMcDmc9MW2uEQWtw8yDuKUTp+CfYLx/LcJX2aLzW4
         y5bvLEq7A3zV8lHkbH+Epgjw0FAqHa/JJtTLUCTj7z4e9o6dqFGLRuVVhBS03oOTNbxP
         AE8R29/uSM1szsCcFM7PDITkWuxI3+D9WN+06+5wbVTAADy8RVNMVOwJaqIXCuWYDt35
         CSVS4u1yTcJIyma0fvuCuGmA+EJvqEuHRqC2eGsHXSK84Tf6b82Eu2SGWXDOMgsabqVp
         r8+xQIPDg9ubwZ8VuENZ5NLLbA0vjY+W7aj7KRqWBX9Km9KUviFxcIGpGjpBPZryqHue
         rAjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xiDmXSvEYF5dgtHYc3XGDqirnMe+wGQb9g7rFupZtmg=;
        fh=cOyRL7gudpKGTIrt+Ch29oJ9PLlXSJsH9pz7jlzSN9w=;
        b=RbQUfXQ0LuHcyWurTIYnlyWdttJam5edWf089Ra4NhYKPsnNxIkhxJDo/knWBLf5Tq
         9V4wTqhk7KwglM/p69t3hCYI+pYPJefAUCsT/sKMkfTCrSm4t3WzYb1EEeb1az+2ybvj
         5wgEvis/dNr4M9BvbJswLjHb93COMeaq6+K4fnez43OO+9IAmWX5X1tNxo4RE9dRU+15
         6NPJF9qwY4nfHgBb6G1wrMSbjRnDb/VPwLRYcn3zneEaOJ/vxGOKx9e2fJxMtJVMm/40
         O3RazqPncb/PpR/pDiYtoNaVamZWH5zf0EdueuPY5dEYNXZkqt95P13V7p7q3nOAc4Ri
         HtHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784670126; x=1785274926; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xiDmXSvEYF5dgtHYc3XGDqirnMe+wGQb9g7rFupZtmg=;
        b=UOKgDFhWm7dFaB8mglVuPU5Dn4uRFZW8UCTiLf4w5q348I9O+BqcmQzZOZ1YxqmnIj
         j8khl8AOfmzjMPZ7++IYyvhzGsCv18Vc+iu9myY+73CvorQjECfRgE+ttDhTQnKovhtr
         zJzor8Rstumyrna3ww1i0fd1U+tyz1EhTdNh3wE5zPxYfuWoFSQ7dzi9OnvhHJEwHR1S
         q+INWxei/F3q+tO+HdYYSTQxF2JtAwAh3oZMeE5nsur7w7ypknsQuCEGhxfIm3oPTRVB
         5R0i/97ltPyEo1QULauHTTmi3tyokBmro4u4a8PCcByifMPHgeQKxHZt7omjtn1CCZd5
         WSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784670126; x=1785274926;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xiDmXSvEYF5dgtHYc3XGDqirnMe+wGQb9g7rFupZtmg=;
        b=RvFdOLo4LDMjYIFr1JJghBGS9efb1jNO8Omv+FFbgkTw6tNSmGY+UID0/Q5mNGKi6G
         +kshAhRjmoqkJy+dDRpYoFlelmUkAKaiSAph38eMZXDZBtwVzot5fJE+ASUeLuUAamnZ
         ZxOxnVJRyk20bVaVXQyH6n6Eb6ISAcIfLniLA8gFKNx6Hc2wDChEPLJQpfqT+BdZFK9e
         w1cDqYi8Ux8QwOyjhsNdB/3liMCDHTy2vSwhskK/1eCfk5itdQW/bbwX8R2Fo7i9MKt+
         F6CbzZcJGmGv7YMXXUwKWzTAZfYYQrgfsLsjMvnlruO/hnKDxeQxk0DMjdFdCqxdsLSL
         /zEQ==
X-Forwarded-Encrypted: i=1; AHgh+RqfJSn3e2TLitio5O6ht8TIKYFsqPYsFpOTr6L38ZOCsfV5EhdqmyUGZNFiDwCMMmJFHIl5rWntCrgr@vger.kernel.org
X-Gm-Message-State: AOJu0YyZKFF5htkDnKr4pcryWKSJDHhdno3WCf2N/bcFI1C2nmGuAFJL
	6C3FU1o4EWRcIwKy/TSD13ueC0bUOAqs+aaffeTY/vTS1zXh7Zo5J7+j4ndfNnehW4oONSvXt1p
	KQnE93sU4/+hPmI3AvQnTmbe2JIk7eqM=
X-Gm-Gg: AR+sD123n7yqi7pVHtiqiqZ6EHmqKet4vAXDFO7jGAtqaKzGeVLxTYbtYOaZ5xjZ9ZU
	AUb/+etokSV9Q9VZGEqNCDEbh/HXnLlbU0zep3HmKWTRPjjvTxW5JY6fq1Q7/emD7GbsheIfp62
	20DHJ672+9DwNScc0U4hTE1LhEQQ79qbG/1esDZITwkPe7eTxa7cGW5XU2FYR3PxkdY6fp7Tk03
	phc8X7qEH9I0tsVOjW7qb/hdrFPhEVpaLqIrVdbiccIGMfBkdUALN4kbK5sazviRfl0TwKSMD2X
	paBhZGlSOqB9rqjRYEB0yvXTxdFvWx8t8B1pT67hZwJt/u9ztC5WT1tiUu66qxELz/rkKu8hNh5
	4pmVoCIPuyVbl5km5Cl30hznGI0su1BfWc8FnfP4gYsO4GR9m
X-Received: by 2002:a05:6102:3f44:b0:745:4d20:6b1a with SMTP id
 ada2fe7eead31-747534366a9mr8288930137.6.1784670126041; Tue, 21 Jul 2026
 14:42:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718-b4-acpi-battery-notification-v4-0-599c8ed1072f@rong.moe>
 <20260718-b4-acpi-battery-notification-v4-3-599c8ed1072f@rong.moe> <CAJZ5v0ijiG23QWjG9C9OfZSB5jxFTg42OwYRS6KVc=Voi2s42w@mail.gmail.com>
In-Reply-To: <CAJZ5v0ijiG23QWjG9C9OfZSB5jxFTg42OwYRS6KVc=Voi2s42w@mail.gmail.com>
From: Avraham Hollander <anhollander516@gmail.com>
Date: Tue, 21 Jul 2026 17:41:54 -0400
X-Gm-Features: AUfX_myW7ePwIAI3hxxKYAhpUKX1Dw-8ILHn64JiaQb00S5CO13aB0C3Ukk_qD8
Message-ID: <CAP1mzZReJCn6df5DwEPu-JCQUyr=Pu1cg5xKCMttWZkHCQtVmQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] ACPI: battery: Protect all properties with a
 separated mutex
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Rong Zhang <i@rong.moe>, Len Brown <lenb@kernel.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, =?UTF-8?Q?Jeffrey_W=C3=A4lti?= <jeffrey@waelti.dev>, 
	Rick <rickk1166@gmail.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Some examples of mutex timeouts from my IdeaPad 5 2-in-1 14AHP9 (Type
83DR), caused when unplugging or plugging in the charger:

ACPI Error: Thread 2157330176 cannot release Mutex [ECMT] acquired by
thread 2188863744 (20250807/exmutex-378)
ACPI Error: Aborting method \_SB.PCI0.LPC0.EC0.ECCC due to previous
error (AE_AML_NOT_OWNER) (20250807/psparse-531)
ACPI Error: Aborting method \_SB.PCI0.LPC0.EC0.RPAM due to previous
error (AE_AML_NOT_OWNER) (20250807/psparse-531)
ACPI Error: Aborting method \_SB.PCI0.LPC0.EC0._Q92 due to previous
error (AE_AML_NOT_OWNER) (20250807/psparse-531)

ACPI Error: Thread 2156041472 cannot release Mutex [ECMT] acquired by
thread 2188863744 (20250807/exmutex-378)
ACPI Error: Aborting method \_SB.PCI0.LPC0.EC0.ECCC due to previous
error (AE_AML_NOT_OWNER) (20250807/psparse-531)
ACPI Error: Aborting method \_SB.PCI0.LPC0.EC0.RPAM due to previous
error (AE_AML_NOT_OWNER) (20250807/psparse-531)
ACPI Error: Aborting method \_SB.PCI0.LPC0.EC0._Q9E due to previous
error (AE_AML_NOT_OWNER) (20250807/psparse-531)

ACPI Error: Thread 386093824 cannot release Mutex [ECMT] acquired by
thread 32582016 (20250807/exmutex-378)
ACPI Error: Aborting method \_SB.PCI0.LPC0.EC0.ECCC due to previous
error (AE_AML_NOT_OWNER) (20250807/psparse-529)
ACPI Error: Aborting method \_SB.PCI0.LPC0.EC0.RPAM due to previous
error (AE_AML_NOT_OWNER) (20250807/psparse-529)
ACPI Error: Aborting method \_SB.PCI0.LPC0.EC0._Q93 due to previous
error (AE_AML_NOT_OWNER) (20250807/psparse-529)

ACPI Error: Thread 348558528 cannot release Mutex [ECMT] acquired by
thread 350311168 (20250807/exmutex-378)
ACPI Error: Aborting method \_SB.PCI0.LPC0.EC0.ECCC due to previous
error (AE_AML_NOT_OWNER) (20250807/psparse-529)
ACPI Error: Aborting method \_SB.PCI0.LPC0.EC0.VPC0.DYTC due to
previous error (AE_AML_NOT_OWNER) (20250807/psparse-529)

I'm not equipped to explain the specifics of the issue within the
firmware's ACPI code which causes this to occur, so I'll leave that to
Rong Zhang.



On Tue, Jul 21, 2026 at 4:55=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Sat, Jul 18, 2026 at 1:11=E2=80=AFAM Rong Zhang <i@rong.moe> wrote:
> >
> > The acpi_battery_get_property() callback calls acpi_battery_get_state()
> > without any lock held, which could lead to race conditions, e.g., when
> > multiple tasks read power supply properties simultaneously, or when
> > other callbacks are called during its execution.
> >
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
> >
> > The said "other synchronized methods" are protected by update_lock,
> > leaving acpi_battery_get_property() to be the last desynchronized code
> > path. Unfortunately, update_lock is not applicapable for
> > acpi_battery_get_property(), as it protects too many fields, far more
> > than necessary. What's worse, some code path could call or wait for
> > acpi_battery_get_property() while an outer functions holding
> > update_lock.
> >
> > Therefore, introduce a mutex to protect all accesses to battery
> > properties, so that acpi_battery_get_property() can take the advantage
> > of the mutex and synchronize itself. The helper function
> > acpi_battery_handle_discharging() for quirky devices has to be inlined
> > due to the change, as the mutex must be unlocked before calling the
> > expensive power_supply_is_system_supplied() helper function.
> >
> > Tested-by: Avraham Hollander <anhollander516@gmail.com>
> > Reported-by: Rick <rickk1166@gmail.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D221065
> > Signed-off-by: Rong Zhang <i@rong.moe>
>
> I have queued up the other 2 patches in the series for 7.3, but this
> one is not quite ready IMV.
>
> In the first place, it is not quite clear from the changelog what
> exactly the role of the new mutex is.
>
> If there are any real race conditions it prevents from occurring, it
> would be good to give examples.
>
> Moreover, the exact mechanism of the _BST synchronization failure is
> unclear to me because in Linux all AML evaluation is synchronized by
> the namespace and interpreter mutexes.  If that is not sufficient, it
> would be good to explain why because as it stands, it is not clear
> whether or not the approach used in this patch is adequate.
>
> > ---
> > Changes in v3:
> > - Address Sashiko's concerns on my last-minute changes:
> >   - Do not overwrite the initial value of `ret' in
> >     acpi_battery_get_property()
> >   - https://sashiko.dev/#/patchset/20260611-b4-acpi-battery-notificatio=
n-v2-0-4e8ed651a151%40rong.moe
> >
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
> >
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
> >
> >  #define to_acpi_battery(x) power_supply_get_drvdata(x)
> > @@ -187,20 +190,6 @@ static bool acpi_battery_is_degraded(struct acpi_b=
attery *battery)
> >                 battery->full_charge_capacity < battery->design_capacit=
y;
> >  }
> >
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
> >
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
> >
> > @@ -540,6 +557,8 @@ static int acpi_battery_get_info(struct acpi_batter=
y *battery)
> >         int use_bix;
> >         int result =3D -ENODEV;
> >
> > +       lockdep_assert_held(&battery->property_lock);
> > +
> >         if (!acpi_battery_present(battery))
> >                 return 0;
> >
> > @@ -579,6 +598,8 @@ static int acpi_battery_get_state(struct acpi_batte=
ry *battery)
> >         acpi_status status =3D 0;
> >         struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> >
> > +       lockdep_assert_held(&battery->property_lock);
> > +
> >         if (!acpi_battery_present(battery))
> >                 return 0;
> >
> > @@ -632,6 +653,8 @@ static int acpi_battery_set_alarm(struct acpi_batte=
ry *battery)
> >  {
> >         acpi_status status =3D 0;
> >
> > +       lockdep_assert_held(&battery->property_lock);
> > +
> >         if (!acpi_battery_present(battery) ||
> >             !test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags))
> >                 return -ENODEV;
> > @@ -649,6 +672,8 @@ static int acpi_battery_set_alarm(struct acpi_batte=
ry *battery)
> >
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
> >
> > +       guard(mutex)(&battery->property_lock);
> > +
> >         return sysfs_emit(buf, "%d\n", battery->alarm * 1000);
> >  }
> >
> > @@ -681,6 +708,8 @@ static ssize_t acpi_battery_alarm_store(struct devi=
ce *dev,
> >         if (err)
> >                 return err;
> >
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
> >
> > -       if (!ACPI_BATTERY_CAPACITY_VALID(battery->full_charge_capacity)=
 &&
> > -           !ACPI_BATTERY_CAPACITY_VALID(battery->design_capacity))
> > -               full_cap_broken =3D true;
> > +       scoped_guard(mutex, &battery->property_lock) {
> > +               power_unit =3D battery->power_unit;
> >
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
> >
> > @@ -1007,30 +1046,38 @@ static void acpi_battery_quirks(struct acpi_bat=
tery *battery)
> >  static int acpi_battery_update(struct acpi_battery *battery, bool resu=
me)
> >  {
> >         int result =3D acpi_battery_get_status(battery);
> > +       bool wakeup;
> >
> >         if (result)
> >                 return result;
> >
> >         if (!acpi_battery_present(battery)) {
> >                 sysfs_remove_battery(battery);
> > -               battery->update_time =3D 0;
> > +               scoped_guard(mutex, &battery->property_lock)
> > +                       battery->update_time =3D 0;
> >                 return 0;
> >         }
> >
> >         if (resume)
> >                 return 0;
> >
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
> >
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
> >
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
> >
> >         return result;
> > @@ -1057,12 +1102,14 @@ static void acpi_battery_refresh(struct acpi_ba=
ttery *battery)
> >         if (!battery->bat)
> >                 return;
> >
> > -       power_unit =3D battery->power_unit;
> > +       scoped_guard(mutex, &battery->property_lock) {
> > +               power_unit =3D battery->power_unit;
> >
> > -       acpi_battery_get_info(battery);
> > +               acpi_battery_get_info(battery);
> >
> > -       if (power_unit =3D=3D battery->power_unit)
> > -               return;
> > +               if (power_unit =3D=3D battery->power_unit)
> > +                       return;
> > +       }
> >
> >         /* The battery has changed its reporting units. */
> >         sysfs_remove_battery(battery);
> > @@ -1154,17 +1201,21 @@ static int battery_notify(struct notifier_block=
 *nb,
> >                 } else {
> >                         int result;
> >
> > -                       result =3D acpi_battery_get_info(battery);
> > -                       if (result)
> > -                               return result;
> > +                       scoped_guard(mutex, &battery->property_lock) {
> > +                               result =3D acpi_battery_get_info(batter=
y);
> > +                               if (result)
> > +                                       return result;
> > +                       }
> >
> >                         result =3D sysfs_add_battery(battery);
> >                         if (result)
> >                                 return result;
> >                 }
> >
> > -               acpi_battery_init_alarm(battery);
> > -               acpi_battery_get_state(battery);
> > +               scoped_guard(mutex, &battery->property_lock) {
> > +                       acpi_battery_init_alarm(battery);
> > +                       acpi_battery_get_state(battery);
> > +               }
> >         }
> >
> >         return 0;
> > @@ -1329,6 +1380,10 @@ static int acpi_battery_probe(struct platform_de=
vice *pdev)
> >         if (result)
> >                 return result;
> >
> > +       result =3D devm_mutex_init(&pdev->dev, &battery->property_lock)=
;
> > +       if (result)
> > +               return result;
> > +
> >         if (acpi_has_method(battery->device->handle, "_BIX"))
> >                 set_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags);
> >
> >
> > --
> > 2.53.0
> >
