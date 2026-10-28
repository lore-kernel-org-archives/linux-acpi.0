Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793217851;
	b=nLnVs0E97azg7GvWMVn8lxMGbv1G8iAXcxzlzfQnlejcymcaqb4iLeQAajmVy2YxuFuP
	 HACcpWIhIszqFR+/CEZFSj6iADczvn4m2JN9wjsv1SBDLFPJ8rJYJ4bg13Ity3c/nXcKM
	 FImoPO6SsSewCmDH7DfoBzkGLEfCigF7O41OhT5R9iuoWbxlJdPEmW/VYoO79uEXrSc5M
	 gHdQRfduDLNuhIswRWczP49dQxTMbxk/hzx4Nc/PeoblS39eAQ6zb1zR7695/4I0nFwej
	 bKnxll4Q7SaGOcjQnVj0sFeqT/Aw50p76yH4RCDS8NlSy53twMXePN0sIst2d23x5Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217851;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2bnS+i1A2R6WWfvOUxIqn6sk4AKrMLFDgy0fzgSFpbc=;
	b=DisuvNGypvKVamW2ND9ZVEcukdft3I6RsLL1g7SJDu85+IcHuZRyORF29uHMvFWlWdZQ
	 i/hGYmyF5NNsai27304LJgR6JuvyfmuIelV+0uVx5UIsGM96nUXo0AdD5GVxjKZw8on35
	 JjCSONTLdsFMQk9D+Hz6dgcPbukibb0lEV6aX73tVsyqiFr8frGy0gjapnn01JnbKkmNp
	 nBHtYV1efqV3enaPapFSmYa6dPf2NtTl1HPuk63EiVs7I6oSSMUZErFy+Qrg9jTWICHoM
	 9/jVwk89tE7MxPtCkIlueOBWOk6d09y2xog20BbUb6dYzg0Mng2SVxWCJg6M9Lwb69Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hC12/Gk+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291B9606A31C
	for <linux-acpi@vger.kernel.org>; Wed, 28 Oct 2026 20:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hC12/Gk+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDFF1F031E0
	for <linux-acpi@vger.kernel.org>; Wed, 28 Oct 2026 20:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793217850;
	bh=2bnS+i1A2R6WWfvOUxIqn6sk4AKrMLFDgy0fzgSFpbc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hC12/Gk+aUxV/mKxa6+e83vNWtY6DVKjvu4qsqZ57tO415R2JFEOivW9W0Ab+pv33
	 kADj8lXMFuRaIYOupKJLsrKm2ITYKSYNWD3lQTMH5GWrQUTthrzVNdMlUVZwt5Tunj
	 YMvOmHSYRYClV+K8PalwpgmAlWE2IdCIVWusgc+fWuLchBJNZYTMz7wuD8dRqYEbUL
	 hy9vHAh5APGOyQ+woMQMX1UrehRf9u3VBwrw65jlUIAvtcEbYQp8zZxzgADntToBUZ
	 k8GSSNMRlsqzdHcMVK+Q7ldKsQOMkpGtl0/bCNJ09adMNiB4evmT+Zh/qYomv2EWsT
	 FTWMeIEb+7s7Q==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5bfc346401aso1015797e87.0
        for <linux-acpi@vger.kernel.org>; Wed, 28 Oct 2026 13:04:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBysuu0cfeozmj5kRe7NHUpCSUo6o/Nev2Lp2M1N8X59zEShao6+TYVmERjzozrsqK88IcT4u6ygcH5s@vger.kernel.org
X-Gm-Message-State: AFq9FYK7MbOhz8I2ZKqK95zOG9hMrVuJpx1CTdGj3wRy4vIJb+NSrMNa
	84yej9XNxUOZYgbmJnZKk373dja9hKp5pgzR9SHAt1V8R7jQJwjjgNeTFAioTLLLJHsgkAXIyu0
	yFlQwCCe5JDrJOl7mVbjLvkbcSEt5UIg=
X-Received: by 2002:a05:6512:3983:b0:5bf:cabe:23b5 with SMTP id
 2adb3069b0e04-5bfcad7124dmr1477992e87.60.1793217849285; Wed, 28 Oct 2026
 13:04:09 -0700 (PDT)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028161600.1524682-1-sashal@kernel.org>
In-Reply-To: <20261028161600.1524682-1-sashal@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 28 Oct 2026 21:03:57 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h9JGSHyP3omJYqsJjwC6gMHMtQnJ38Nct_UorSHpyyRg@mail.gmail.com>
X-Gm-Features: AclHuK9TTxKVP1w6H492LN-rJYOEhMKsUdisrO-t6GbmynxpR0xTebDQa9Z6DBY
Message-ID: <CAJZ5v0h9JGSHyP3omJYqsJjwC6gMHMtQnJ38Nct_UorSHpyyRg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: scan: Do not hold physical_node_lock across
 device_offline() and device_online()
To: Sasha Levin <sashal@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+cea7285bc17b76ffe39f@syzkaller.appspotmail.com, 
	syzbot+a265816368571f78ab88@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 5:16=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> acpi_bus_offline() and acpi_bus_online() hold the physical_node_lock of
> the ACPI device being hot-removed while they call device_offline() and
> device_online() for its physical nodes.  Offlining a CPU this way takes
> cpu_add_remove_lock and the CPU hotplug lock under physical_node_lock,
> and lockdep connects that to the uevent attribute of platform devices,
> whose store method takes physical_node_lock in
> acpi_primary_dev_companion():
>
>   physical_node_lock (acpi_bus_offline())
>     -> cpu_add_remove_lock -> cpu_hotplug_lock
>     -> cpuhp_state-down (mce_cpu_pre_down() unregistering a device)
>     -> device_links_lock (device_links_purge())
>     -> kn->active of a uevent attribute (device link unregistration)
>     -> physical_node_lock (uevent_store() -> acpi_companion_match())
>
> syzbot has reported this cycle twice.  The uevent attribute waited for in
> the link unregistration is the device link's, not a platform device's,
> and the physical_node_lock taken at the end is that of the platform
> device's ACPI companion, not of the processor being ejected, so lockdep
> only connects them because they share lock classes and this is unlikely
> to deadlock.  However, lockdep turns itself off after reporting it.

Yeah, fair enough, and thanks for the patch!

> It can be reproduced in a QEMU guest by writing to the uevent attribute
> of an ACPI-enumerated platform device, reading the uevent attribute of a
> device link while the link is removed, offlining a CPU and ejecting one
> through sysfs.
>
> physical_node_lock only needs to protect the list of physical nodes,

There is somewhat more to it because acpi_unbind_one() blocks on
physical_node_lock of the device's ACPI companion, so holding it
prevents device_offline() from running in parallel with whatever
happens after acpi_unbind_one().  I don't think this would be a
problem in practice though.

> so drop it around device_offline() and device_online().  Mark the nodes t=
o
> offline with a new offline_pending flag, hold a reference to each device
> while the lock is dropped, and look its node up again afterwards to
> record whether it needs to be put back online, because it may have been
> unbound in the meantime.  Physical nodes added while the lock is not
> held are not offlined by the current pass, which is no different from
> adding them right after it.
>
> Since acpi_container_offline() no longer runs under the container's
> physical_node_lock, the nesting annotation added to
> acpi_scan_is_offline() by commit 4c533c801d1c ("ACPI / scan: Annotate
> physical_node_lock in acpi_scan_is_offline()") is not needed anymore, so
> drop it.
>
> Fixes: 683058e315f0 ("ACPI / hotplug: Use device offline/online for grace=
ful hot-removal")
> Reported-by: syzbot+cea7285bc17b76ffe39f@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/r/6ae18ed0.6200f071.51519.0f60.GAE@google=
.com
> Reported-by: syzbot+a265816368571f78ab88@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/r/6adf293a.67317f00.38c4bc.00af.GAE@googl=
e.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/acpi/scan.c     | 112 ++++++++++++++++++++++++++++++++--------
>  include/acpi/acpi_bus.h |   1 +
>  2 files changed, 92 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 0b17a7e519569..3a6420872651f 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -114,11 +114,7 @@ bool acpi_scan_is_offline(struct acpi_device *adev, =
bool uevent)
>         bool offline =3D true;
>         char *envp[] =3D { "EVENT=3Doffline", NULL };
>
> -       /*
> -        * acpi_container_offline() calls this for all of the container's
> -        * children under the container's physical_node_lock lock.
> -        */
> -       mutex_lock_nested(&adev->physical_node_lock, SINGLE_DEPTH_NESTING=
);
> +       mutex_lock(&adev->physical_node_lock);
>
>         list_for_each_entry(pn, &adev->physical_node_list, node)
>                 if (device_supports_offline(pn->dev) && !dev_offline(pn->=
dev)) {
> @@ -133,6 +129,59 @@ bool acpi_scan_is_offline(struct acpi_device *adev, =
bool uevent)
>         return offline;
>  }
>
> +static struct acpi_device_physical_node *
> +acpi_find_physical_node(struct acpi_device *adev, struct device *dev)
> +{
> +       struct acpi_device_physical_node *pn;
> +
> +       lockdep_assert_held(&adev->physical_node_lock);
> +
> +       list_for_each_entry(pn, &adev->physical_node_list, node)
> +               if (pn->dev =3D=3D dev)
> +                       return pn;
> +
> +       return NULL;
> +}
> +
> +/*
> + * Find the first physical node of @adev that is still to be offlined, c=
lear its
> + * offline_pending flag and return its device with a reference held.
> + */

I'd slightly prefer this comment to go into the function body, next to
the loop (and analogously for the next one).

> +static struct device *acpi_next_offline_pending(struct acpi_device *adev=
)
> +{
> +       struct acpi_device_physical_node *pn;
> +
> +       lockdep_assert_held(&adev->physical_node_lock);
> +
> +       list_for_each_entry(pn, &adev->physical_node_list, node)
> +               if (pn->offline_pending) {
> +                       pn->offline_pending =3D false;
> +                       return get_device(pn->dev);
> +               }
> +
> +       return NULL;
> +}
> +
> +/*
> + * Find the first physical node of @adev that has been offlined by
> + * acpi_bus_offline(), clear its put_online flag and return its device w=
ith a
> + * reference held.
> + */
> +static struct device *acpi_next_put_online(struct acpi_device *adev)
> +{
> +       struct acpi_device_physical_node *pn;
> +
> +       lockdep_assert_held(&adev->physical_node_lock);
> +
> +       list_for_each_entry(pn, &adev->physical_node_list, node)
> +               if (pn->put_online) {
> +                       pn->put_online =3D false;
> +                       return get_device(pn->dev);
> +               }
> +
> +       return NULL;
> +}
> +
>  static acpi_status acpi_bus_offline(acpi_handle handle, u32 lvl, void *d=
ata,
>                                     void **ret_p)
>  {
> @@ -140,6 +189,7 @@ static acpi_status acpi_bus_offline(acpi_handle handl=
e, u32 lvl, void *data,
>         struct acpi_device_physical_node *pn;
>         bool second_pass =3D (bool)data;
>         acpi_status status =3D AE_OK;
> +       struct device *dev;
>
>         if (!device)
>                 return AE_OK;
> @@ -152,25 +202,44 @@ static acpi_status acpi_bus_offline(acpi_handle han=
dle, u32 lvl, void *data,
>         mutex_lock(&device->physical_node_lock);
>
>         list_for_each_entry(pn, &device->physical_node_list, node) {
> -               int ret;
> -
>                 if (second_pass) {
>                         /* Skip devices offlined by the first pass. */
> -                       if (pn->put_online)
> -                               continue;
> +                       pn->offline_pending =3D !pn->put_online;
>                 } else {
> +                       pn->offline_pending =3D true;
>                         pn->put_online =3D false;
>                 }
> -               ret =3D device_offline(pn->dev);
> +       }
> +
> +       /*
> +        * Drop physical_node_lock around device_offline(), because the l=
atter
> +        * acquires locks, like the CPU hotplug ones, that must not nest =
under
> +        * it.
> +        */
> +       while ((dev =3D acpi_next_offline_pending(device))) {
> +               int ret;
> +
> +               mutex_unlock(&device->physical_node_lock);
> +               ret =3D device_offline(dev);
> +               mutex_lock(&device->physical_node_lock);
> +
> +               /* The device may have been unbound in the meantime. */
> +               pn =3D acpi_find_physical_node(device, dev);
>                 if (ret >=3D 0) {
> -                       pn->put_online =3D !ret;
> +                       if (pn)
> +                               pn->put_online =3D !ret;
>                 } else {
> -                       *ret_p =3D pn->dev;
> -                       if (second_pass) {
> +                       *ret_p =3D pn ? pn->dev : &device->dev;

Returning pn->dev via ret_p and then using it for printing messages is
bogus both here and in the original code (sorry about that) because in
theory the device may be gone by the time the message gets printed.
It would be good to fix that beforehand and then you won't need to
return &device->dev here if pn is NULL which is a bit confusing.

> +                       if (second_pass)
>                                 status =3D AE_ERROR;
> -                               break;
> -                       }
>                 }
> +
> +               mutex_unlock(&device->physical_node_lock);

Does the lock really need to be dropped here?

put_device() can be called from under it and substituting "break" for
"return status" below should take care of the loop termination.

> +               put_device(dev);
> +               if (ACPI_FAILURE(status))
> +                       return status;
> +
> +               mutex_lock(&device->physical_node_lock);
>         }
>
>         mutex_unlock(&device->physical_node_lock);
> @@ -182,18 +251,19 @@ static acpi_status acpi_bus_online(acpi_handle hand=
le, u32 lvl, void *data,
>                                    void **ret_p)
>  {
>         struct acpi_device *device =3D acpi_fetch_acpi_dev(handle);
> -       struct acpi_device_physical_node *pn;
> +       struct device *dev;
>
>         if (!device)
>                 return AE_OK;
>
>         mutex_lock(&device->physical_node_lock);
>
> -       list_for_each_entry(pn, &device->physical_node_list, node)
> -               if (pn->put_online) {
> -                       device_online(pn->dev);
> -                       pn->put_online =3D false;
> -               }
> +       while ((dev =3D acpi_next_put_online(device))) {
> +               mutex_unlock(&device->physical_node_lock);
> +               device_online(dev);
> +               put_device(dev);
> +               mutex_lock(&device->physical_node_lock);
> +       }
>
>         mutex_unlock(&device->physical_node_lock);
>
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index a755b15af9db9..29c59ea1e3e48 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -320,6 +320,7 @@ struct acpi_device_physical_node {
>         struct device *dev;
>         unsigned int node_id;
>         bool put_online:1;
> +       bool offline_pending:1;
>  };
>
>  struct acpi_device_properties {
> --
