Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6EC4DAF91
	for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2026 18:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584438; cv=none; b=rwt5KM16JbEYd3YxNsMRBZAhue5JL7Cfe8b5Tq+hvDsvwny0lG2OWniPgNx0jtUoG5LMguWqkvW6xA+cIfusmRMQGigMRjNJQtoqmiHGd5YCLjRScK2suYmmwlCvOjIpi2sbgLmvCczC9z3gzeHV8h9NNvjWClAEqO+o8fRGq08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584438; c=relaxed/simple;
	bh=yvv8LMKz9LtYI3xqHkjIYrRGDkfHlFNSP9M3SO9epto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DSJeZDrJkuy8X/OvXs4WGLv5nWX1HKldJ0S4I8D2QD0GW5t5fntFhfuS1VDrD5TLLIGzRFzvZN5/xot7YQ8ANCUcH/nTo7rAEWqeDOPv+v49kdxoGK1NJQF71w7J1HVjzi/eCwcW4xCkRBY4HJcphp1GZJzT6BUUN7PXQniMWYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjeVOhBk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjeVOhBk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15F91F008A1
	for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2026 18:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584433;
	bh=4jiUvRz2xzBBtQ7C75rWeguyMQEVO7haRwsq2vm6ttw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fjeVOhBkKUlyJn93hirV7NsniN5d1kvwdxfMqOP5gu06LRod7olhmAvZchKuklb6g
	 HPQzfH+8YAEBc084Qv4bqiB2vQzrkWhqWHx2Xn9IQGh0eakyRpUG3Bn9Y4o4lxsTgU
	 rbQs/hZS/BHsYYE53u6vnUqocsYyNH9zboOLFixZteI8uA0vExXVILeL+W+K2m8wR2
	 vzuXl0OCdGQanClQjuyfx3OgCfVig7hQFWrC82OUMnHuvkEM5BWqV2XSutPrGygT42
	 EbwSCTeKLxAOZ8SJI7zbd74wvaLIcD7SJPAxumSHokRsGYKGaZCiYvAnuF1avD+gQs
	 N3aDBXTAoSIQg==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f15d00so1292408e87.2
        for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2026 11:47:13 -0700 (PDT)
X-Gm-Message-State: AFuF++lUjmy28aARC6Z+mlOP3Qu5d4mzJjL7nMgwFB15l8S/+NYyLbPH
	+aOmR9MExBeo5rtZ5vMb6ZuTt+BtW+u+s/UUL/QFgtWPeCl9dK7XzeYeLr1jo8XmBtGe+tFNn/a
	cU35XZaiFepTqdAq505IAEc+RCGYXvmU=
X-Received: by 2002:a05:6512:3c8a:b0:5b1:5a2d:55f9 with SMTP id
 2adb3069b0e04-5b8b66135bamr1068200e87.21.1789584432009; Wed, 16 Sep 2026
 11:47:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6329043.lOV4Wx5bFT@rafael.j.wysocki>
In-Reply-To: <6329043.lOV4Wx5bFT@rafael.j.wysocki>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 16 Sep 2026 20:45:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0geju99B56CqAQjKwZcwg7mqXPUxx_a=kQ1KpaKpQztuw@mail.gmail.com>
X-Gm-Features: AcwNN1VWW1dM32A_yMxCWEo-nNNXbKEFGtckxg39KzA9hSlPJShbVmUIbKQ1JF4
Message-ID: <CAJZ5v0geju99B56CqAQjKwZcwg7mqXPUxx_a=kQ1KpaKpQztuw@mail.gmail.com>
Subject: Re: [PATCH v2] driver core/ACPI: Introduce companion_bus_register()
To: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Driver Core Development <driver-core@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 6:41=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The ACPI bus type does not allow drivers to be registered, so the sysfs
> attributes related to drivers created for it and its devices are
> useless, and its drivers/ directory is always empty.  All of that is
> confusing and wasteful.
>
> To allow skipping the creation of those sysfs attributes, introduce a
> "companion" bus type concept and add a special registration function for
> registering "companion" bus types, companion_bus_register().
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It's been a while since this was posted, so any feedback would be appreciat=
ed.

In the absence thereof, I'll trust Sashiko that there are no issues
with it and pick it up.

Thanks!

> ---
>
> v1 -> v2:
>    * Address Sashiko feedback regarding possible leaks of references in t=
wo
>      places:
>
>      https://sashiko.dev/#/patchset/8753121.T7Z3S40VBb%40rafael.j.wysocki
>
> ---
>  drivers/acpi/bus.c         |    8 -----
>  drivers/base/bus.c         |   72 ++++++++++++++++++++++++++++++++++----=
-------
>  include/linux/device/bus.h |    1
>  3 files changed, 57 insertions(+), 24 deletions(-)
>
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -1120,11 +1120,6 @@ EXPORT_SYMBOL_GPL(acpi_driver_match_devi
>                                ACPI Bus operations
>     ---------------------------------------------------------------------=
----- */
>
> -static int acpi_bus_match(struct device *dev, const struct device_driver=
 *drv)
> -{
> -       return 0;
> -}
> -
>  static int acpi_device_uevent(const struct device *dev, struct kobj_ueve=
nt_env *env)
>  {
>         return __acpi_device_uevent_modalias(to_acpi_device(dev), env);
> @@ -1132,7 +1127,6 @@ static int acpi_device_uevent(const stru
>
>  const struct bus_type acpi_bus_type =3D {
>         .name           =3D "acpi",
> -       .match          =3D acpi_bus_match,
>         .uevent         =3D acpi_device_uevent,
>  };
>
> @@ -1451,7 +1445,7 @@ static int __init acpi_bus_init(void)
>          */
>         acpi_root_dir =3D proc_mkdir(ACPI_BUS_FILE_ROOT, NULL);
>
> -       result =3D bus_register(&acpi_bus_type);
> +       result =3D companion_bus_register(&acpi_bus_type);
>         if (!result)
>                 return 0;
>
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -738,6 +738,11 @@ int bus_add_driver(struct device_driver
>         if (!sp)
>                 return -EINVAL;
>
> +       if (!sp->drivers_kset) {
> +               error =3D -ENXIO;
> +               goto out_put_bus;
> +       }
> +
>         /*
>          * Reference in sp is now incremented and will be dropped when
>          * the driver is removed from the bus
> @@ -930,15 +935,7 @@ static ssize_t bus_uevent_store(const st
>  static struct bus_attribute bus_attr_uevent =3D __ATTR(uevent, 0200, NUL=
L,
>                                                      bus_uevent_store);
>
> -/**
> - * bus_register - register a driver-core subsystem
> - * @bus: bus to register
> - *
> - * Once we have that, we register the bus with the kobject
> - * infrastructure, then register the children subsystems it has:
> - * the devices and drivers that belong to the subsystem.
> - */
> -int bus_register(const struct bus_type *bus)
> +static int bus_register_internal(const struct bus_type *bus, bool use_dr=
ivers)
>  {
>         int retval;
>         struct subsys_private *priv;
> @@ -960,7 +957,7 @@ int bus_register(const struct bus_type *
>
>         bus_kobj->kset =3D bus_kset;
>         bus_kobj->ktype =3D &bus_ktype;
> -       priv->drivers_autoprobe =3D 1;
> +       priv->drivers_autoprobe =3D use_drivers;
>
>         retval =3D kset_register(&priv->subsys);
>         if (retval)
> @@ -976,10 +973,12 @@ int bus_register(const struct bus_type *
>                 goto bus_devices_fail;
>         }
>
> -       priv->drivers_kset =3D kset_create_and_add("drivers", NULL, bus_k=
obj);
> -       if (!priv->drivers_kset) {
> -               retval =3D -ENOMEM;
> -               goto bus_drivers_fail;
> +       if (use_drivers) {
> +               priv->drivers_kset =3D kset_create_and_add("drivers", NUL=
L, bus_kobj);
> +               if (!priv->drivers_kset) {
> +                       retval =3D -ENOMEM;
> +                       goto bus_drivers_fail;
> +               }
>         }
>
>         INIT_LIST_HEAD(&priv->interfaces);
> @@ -989,9 +988,11 @@ int bus_register(const struct bus_type *
>         klist_init(&priv->klist_devices, klist_devices_get, klist_devices=
_put);
>         klist_init(&priv->klist_drivers, NULL, NULL);
>
> -       retval =3D add_probe_files(bus);
> -       if (retval)
> -               goto bus_probe_files_fail;
> +       if (use_drivers) {
> +               retval =3D add_probe_files(bus);
> +               if (retval)
> +                       goto bus_probe_files_fail;
> +       }
>
>         retval =3D sysfs_create_groups(bus_kobj, bus->bus_groups);
>         if (retval)
> @@ -1016,9 +1017,41 @@ out:
>         kfree(priv);
>         return retval;
>  }
> +
> +/**
> + * bus_register - register a driver-core subsystem
> + * @bus: bus to register
> + *
> + * Once we have that, we register the bus with the kobject
> + * infrastructure, then register the children subsystems it has:
> + * the devices and drivers that belong to the subsystem.
> + */
> +int bus_register(const struct bus_type *bus)
> +{
> +       return bus_register_internal(bus, true);
> +}
>  EXPORT_SYMBOL_GPL(bus_register);
>
>  /**
> + * companion_bus_register - register a companion bus type
> + * @bus: companion bus to register
> + *
> + * A companion bus is a bus without drivers.  Devices that belong to it =
can be
> + * bound to other devices as their "companions" and represent interfaces=
 that
> + * can be used by the drivers of those other devices.  They may also be =
used for
> + * the enumeration of those other devices.
> + *
> + * The ACPI bus is a specific example of a companion bus.
> + *
> + * Registering a companion bus is like registering a regular bus except =
that it
> + * skips the creation of sysfs interfaces related to drivers for @bus.
> + */
> +int companion_bus_register(const struct bus_type *bus)
> +{
> +       return bus_register_internal(bus, false);
> +}
> +
> +/**
>   * bus_unregister - remove a bus from the system
>   * @bus: bus.
>   *
> @@ -1415,6 +1448,11 @@ struct device_driver *driver_find(const
>         if (!sp)
>                 return NULL;
>
> +       if (!sp->drivers_kset) {
> +               subsys_put(sp);
> +               return NULL;
> +       }
> +
>         k =3D kset_find_obj(sp->drivers_kset, name);
>         subsys_put(sp);
>         if (!k)
> --- a/include/linux/device/bus.h
> +++ b/include/linux/device/bus.h
> @@ -113,6 +113,7 @@ struct bus_type {
>         bool need_parent_lock;
>  };
>
> +int __must_check companion_bus_register(const struct bus_type *bus);
>  int __must_check bus_register(const struct bus_type *bus);
>
>  void bus_unregister(const struct bus_type *bus);
>
>
>
>
