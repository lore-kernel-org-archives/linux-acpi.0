From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH resend 2/4] backlight: Add backlight device
 (un)registration notification
Date: Thu, 22 May 2014 10:02:15 +0100
Message-ID: <20140522090215.GO6679@lee--X1>
References: <1400679596-19663-1-git-send-email-hdegoede@redhat.com>
 <1400679596-19663-3-git-send-email-hdegoede@redhat.com>
 <82426680.ILvbY8i4gL@vostro.rjw.lan>
 <537DB904.50901@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:58267 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932AbaEVJCW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 May 2014 05:02:22 -0400
Received: by mail-ie0-f181.google.com with SMTP id rp18so1690598iec.40
        for <linux-acpi@vger.kernel.org>; Thu, 22 May 2014 02:02:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <537DB904.50901@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

> >> Some firmware drivers, ie acpi-video want to get themselves out of=
 the
> >> way (in some cases) when their also is a raw backlight device avai=
lable.
> >>
> >> Due to module loading ordering being unknown, acpi-video cannot be=
 certain
> >> that the backlight_device_registered(BACKLIGHT_RAW) it does for th=
is is
> >> the final verdict wrt there being a BACKLIGHT_RAW device.
> >>
> >> By adding notification acpi-video can listen for backlight devices=
 showing
> >> up after it has loaded, and unregister its backlight device if des=
ired.
> >>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >=20
> > Backlight maintainer's ACK is requisite here.
>=20
> Agreed, which is why I send this set to all 3 the backlight maintaine=
rs
> directly on both postings.
>=20
> What may be helpful for them is to hear from you if you're ok with th=
e
> acpi-video bits which are actually going to use this, since those wil=
l
> be the only user of the new backlight api (for now).

I'm happy to apply any Backlight patches which have either Bryan or
Jingoo's Ack, as they are the reviewers for the BL subsystem.

> >> ---
> >>  drivers/video/backlight/backlight.c | 40 ++++++++++++++++++++++++=
+++++++++++++
> >>  include/linux/backlight.h           |  7 +++++++
> >>  2 files changed, 47 insertions(+)
> >>
> >> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/b=
acklight/backlight.c
> >> index bd2172c..4280890 100644
> >> --- a/drivers/video/backlight/backlight.c
> >> +++ b/drivers/video/backlight/backlight.c
> >> @@ -23,6 +23,7 @@
> >> =20
> >>  static struct list_head backlight_dev_list;
> >>  static struct mutex backlight_dev_list_mutex;
> >> +static struct blocking_notifier_head backlight_notifier;
> >> =20
> >>  static const char *const backlight_types[] =3D {
> >>  	[BACKLIGHT_RAW] =3D "raw",
> >> @@ -370,6 +371,9 @@ struct backlight_device *backlight_device_regi=
ster(const char *name,
> >>  	list_add(&new_bd->entry, &backlight_dev_list);
> >>  	mutex_unlock(&backlight_dev_list_mutex);
> >> =20
> >> +	blocking_notifier_call_chain(&backlight_notifier,
> >> +				     BACKLIGHT_REGISTERED, new_bd);
> >> +
> >>  	return new_bd;
> >>  }
> >>  EXPORT_SYMBOL(backlight_device_register);
> >> @@ -413,6 +417,10 @@ void backlight_device_unregister(struct backl=
ight_device *bd)
> >>  		pmac_backlight =3D NULL;
> >>  	mutex_unlock(&pmac_backlight_mutex);
> >>  #endif
> >> +
> >> +	blocking_notifier_call_chain(&backlight_notifier,
> >> +				     BACKLIGHT_UNREGISTERED, bd);
> >> +
> >>  	mutex_lock(&bd->ops_lock);
> >>  	bd->ops =3D NULL;
> >>  	mutex_unlock(&bd->ops_lock);
> >> @@ -438,6 +446,36 @@ static int devm_backlight_device_match(struct=
 device *dev, void *res,
> >>  }
> >> =20
> >>  /**
> >> + * backlight_register_notifier - get notified of backlight (un)re=
gistration
> >> + * @nb: notifier block with the notifier to call on backlight (un=
)registration
> >> + *
> >> + * @return 0 on success, otherwise a negative error code
> >> + *
> >> + * Register a notifier to get notified when backlight devices get=
 registered
> >> + * or unregistered.
> >> + */
> >> +int backlight_register_notifier(struct notifier_block *nb)
> >> +{
> >> +	return blocking_notifier_chain_register(&backlight_notifier, nb)=
;
> >> +}
> >> +EXPORT_SYMBOL(backlight_register_notifier);
> >> +
> >> +/**
> >> + * backlight_unregister_notifier - unregister a backlight notifie=
r
> >> + * @nb: notifier block to unregister
> >> + *
> >> + * @return 0 on success, otherwise a negative error code
> >> + *
> >> + * Register a notifier to get notified when backlight devices get=
 registered
> >> + * or unregistered.
> >> + */
> >> +int backlight_unregister_notifier(struct notifier_block *nb)
> >> +{
> >> +	return blocking_notifier_chain_unregister(&backlight_notifier, n=
b);
> >> +}
> >> +EXPORT_SYMBOL(backlight_unregister_notifier);
> >> +
> >> +/**
> >>   * devm_backlight_device_register - resource managed backlight_de=
vice_register()
> >>   * @dev: the device to register
> >>   * @name: the name of the device
> >> @@ -544,6 +582,8 @@ static int __init backlight_class_init(void)
> >>  	backlight_class->pm =3D &backlight_class_dev_pm_ops;
> >>  	INIT_LIST_HEAD(&backlight_dev_list);
> >>  	mutex_init(&backlight_dev_list_mutex);
> >> +	BLOCKING_INIT_NOTIFIER_HEAD(&backlight_notifier);
> >> +
> >>  	return 0;
> >>  }
> >> =20
> >> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> >> index 7264742..adb14a8 100644
> >> --- a/include/linux/backlight.h
> >> +++ b/include/linux/backlight.h
> >> @@ -40,6 +40,11 @@ enum backlight_type {
> >>  	BACKLIGHT_TYPE_MAX,
> >>  };
> >> =20
> >> +enum backlight_notification {
> >> +	BACKLIGHT_REGISTERED,
> >> +	BACKLIGHT_UNREGISTERED,
> >> +};
> >> +
> >>  struct backlight_device;
> >>  struct fb_info;
> >> =20
> >> @@ -133,6 +138,8 @@ extern void devm_backlight_device_unregister(s=
truct device *dev,
> >>  extern void backlight_force_update(struct backlight_device *bd,
> >>  				   enum backlight_update_reason reason);
> >>  extern bool backlight_device_registered(enum backlight_type type)=
;
> >> +extern int backlight_register_notifier(struct notifier_block *nb)=
;
> >> +extern int backlight_unregister_notifier(struct notifier_block *n=
b);
> >> =20
> >>  #define to_backlight_device(obj) container_of(obj, struct backlig=
ht_device, dev)
> >> =20
> >>
> >=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
