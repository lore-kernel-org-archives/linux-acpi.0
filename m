Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8394E43C076
	for <linux-acpi@vger.kernel.org>; Mon,  7 Sep 2026 08:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769480; cv=none; b=OIKSjqi66ozSmvSBXoYV0x1rJhGvPRrwMo/7X7oq0CmO3v3aWTGVw6WI41GdttXYegshiYu5QMYX0kgO4mWLMa83bduHiSMObe7TpcH2Z/MTlCw1oq5Hy724JS3JIh4EtnuSBp+DiON1j7dNp0nC46mW6z5yg5gc8faoF6do82g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769480; c=relaxed/simple;
	bh=Q7dC/WRFxfy2ZTVBn/CI0qq4K9fuw42CK8+hq8VoEhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TyQQxhWSKcsHUw3KOlkvHMwlsDSKzdnA3nmUAeGcn9WmUGKq9jgbtniAY/2DckhZU8M+EnLzeYEMBoPE8j8dV3es44iORfOal9xV7ZRRqB/Xau0+/S1ucLdiHc9G1i3yRcLTwx4oirf0RSFn5QKPAibjR+kex/Lyu1YOiO+E+4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbEJ6elf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbEJ6elf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A011F00A3A
	for <linux-acpi@vger.kernel.org>; Mon,  7 Sep 2026 08:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788769478;
	bh=PCVcsXAMckoFPKkzKtrThjz17kmFVFPOkwbdSUZv7lk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fbEJ6elfKVryfSj3Egsb58If7rF4UeAQU5ExOzx0fxhIUY/JiGAWLTvz3pylmbsur
	 PHLV/Npiu72K8GzUS5VAZCPibaDsULoOMYpFFizY4VsTADXjvHpZAHLH82WjMNILy8
	 3ixphYXK3ijcPuEuUPQsl7b395WhFY0/nD6ok1oNufT712GKjptHOIhuNEIStmmxHY
	 VZp8cAoEUWPvWaJj35kVMJg6w0XRFBYd/aM2lFVsh4eKHwQfDejpJ1w1FHQu51bAZV
	 r51AnSprAlk4R8C0yKDVw4F/qduiB1JOBAffiInpYHQ9K/k+Nybqsc9/dDAYP/u/mD
	 llSL0AuZsT2YA==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39c86ce9e29so23092081fa.3
        for <linux-acpi@vger.kernel.org>; Mon, 07 Sep 2026 01:24:38 -0700 (PDT)
X-Gm-Message-State: AFuF++mMA4gCY7tUQ/T04We5pEVIZ/i3Sm1w7FSNTG+HR2eGF+ByGIYa
	6vcF9ugE6vXC0bZuiSlEJyIZiTQf0Dn6+HrCAkvpOt8HBt2/gXsi3hEM2n2tpStarx7RVkAFgBQ
	nEs/gFGs9MlmmDNq36dL4nTsREKxH3T4=
X-Received: by 2002:a05:6512:acc:b0:5b6:421:a8fb with SMTP id
 2adb3069b0e04-5b616f3dc7emr4986729e87.27.1788769476610; Mon, 07 Sep 2026
 01:24:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8753121.T7Z3S40VBb@rafael.j.wysocki>
In-Reply-To: <8753121.T7Z3S40VBb@rafael.j.wysocki>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 7 Sep 2026 10:23:30 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iVB9RM=-shOPKqPXkyN3mkB2wyA-0b5aMpmXXwuBEqkw@mail.gmail.com>
X-Gm-Features: AcwNN1ULBo9DFxc0AiqivzArZ3dVbCVdQdBDOjj3MbqviI-1ZJcTdImDQWQ6W7Y
Message-ID: <CAJZ5v0iVB9RM=-shOPKqPXkyN3mkB2wyA-0b5aMpmXXwuBEqkw@mail.gmail.com>
Subject: Re: [PATCH v1] driver core/ACPI: Introduce companion_bus_register()
To: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Driver Core Development <driver-core@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 6:03=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The ACPI bus type does not allow drivers to be registered, so the sysfs
> attributes related to drivers created for it and its devices are
> useless, and its drivers/ directory is always empty.  All of that is
> confusing and wasteful.
>
> To allow skipping the creation of those sysfs attributes, introduce
> the concept of a "companion" bus (as a bus without drivers whose
> devices can be bound to other devices and used by their drivers) and
> add a special registration function for registering "companion" bus
> types, companion_bus_register().
>
> Use that function for registering the ACPI bus type.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/bus.c         |    8 -----
>  drivers/base/bus.c         |   66 ++++++++++++++++++++++++++++++++------=
-------
>  include/linux/device/bus.h |    1
>  3 files changed, 49 insertions(+), 26 deletions(-)
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
> @@ -735,7 +735,7 @@ int bus_add_driver(struct device_driver
>         struct driver_private *priv;
>         int error =3D 0;
>
> -       if (!sp)
> +       if (!sp || !sp->drivers_kset)

This will leak the reference to sp if sp itself is not NULL, but
sp->drivers_kset is (as dutifully reported by Sashiko).

>                 return -EINVAL;
>
>         /*
> @@ -930,15 +930,7 @@ static ssize_t bus_uevent_store(const st
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
> @@ -960,7 +952,7 @@ int bus_register(const struct bus_type *
>
>         bus_kobj->kset =3D bus_kset;
>         bus_kobj->ktype =3D &bus_ktype;
> -       priv->drivers_autoprobe =3D 1;
> +       priv->drivers_autoprobe =3D use_drivers;
>
>         retval =3D kset_register(&priv->subsys);
>         if (retval)
> @@ -976,10 +968,12 @@ int bus_register(const struct bus_type *
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
> @@ -989,9 +983,11 @@ int bus_register(const struct bus_type *
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
> @@ -1016,9 +1012,41 @@ out:
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
> @@ -1412,7 +1440,7 @@ struct device_driver *driver_find(const
>         struct kobject *k;
>         struct driver_private *priv;
>
> -       if (!sp)
> +       if (!sp || !sp->drivers_kset)

And same here, so I will send a v2.

Nevertheless, if you have any concerns or comments on this other than
the above, please let me know.

>                 return NULL;
>
>         k =3D kset_find_obj(sp->drivers_kset, name);
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
