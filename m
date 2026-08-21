Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F8637DE84
	for <linux-acpi@vger.kernel.org>; Fri, 21 Aug 2026 04:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787286443; cv=none; b=Gk1n988zu9IwNSbJTjl6ULbczHB4CMhEZ7CxAvdDxL7UyZSmqpWN3z0rhSdQWMKn42Rp0uvFnljSYMS0qIhyO9F7hnPMFF7y3mc0lmFsAXNfR9iX7K6r2chSB8FghgUwbPRPJHLyBfICz9k5in2yukBzaXr8SlyFu79otVSbxQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787286443; c=relaxed/simple;
	bh=Sjmy2ZfZit4xpzDzilLx2DZFJtenv5ruq9mWRucBucM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OH8SlVLNXEaa9iywbqz66VMFrxy1AArWU3YXo69BnG8QNjqCDomSDXFfkUqfrv7DyjgCt7CIDeF3nIB6QJsot4ByZ5C4EHQfLngk9tpGafDZXt8OhO3gMQvakNKfgIMrFKHEjH2RfisSgTPX3mqjKEEo1GZdtAbDzhE9oIx3Oio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHVz9cZT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHVz9cZT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B41E1F00ACF
	for <linux-acpi@vger.kernel.org>; Fri, 21 Aug 2026 04:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787286440;
	bh=LwpFt+LnTp+muHxqvGS3w2X5tK0X5Z5VO3o6gZf4HdM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kHVz9cZT1PpP9mIsg6yB9Mca/y0pVlq72OKiADp6ecfXHy2afj6QWHE2CjWePQO2e
	 kB4CgDsk2DBiNyI46nGt4tF4Qlu4GlG/8BWvEm+lhe5LdRn3n6FxUYiZdeQ00PtVND
	 J7Jt/QXo2tSFQ/3nFqhL/DJCAWWnaVzyYdzqhsJE/fsymJbB8y42MrrtID0kSJjWs3
	 PPsdXl+wEmAE8bJNR6TVFNrYjIRxlKfUW9yltgXgkoegwh/zEf9rP1UD0Vv8hpDOaI
	 5bSTYQEJu0vb+6fog49N1vYlknSzdSFE5ryFb0jOm6stiI22s1Cr5TkAfdDFHjWXEp
	 rmDSGl98MlukQ==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69f7fa1c548so1281811a12.2
        for <linux-acpi@vger.kernel.org>; Thu, 20 Aug 2026 21:27:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoBhGmjpGinWk8wxsdf+pG6YlcbNyDgntID0r03l5ZD9tFbz+gh9t+sewK6eNbOOK+NHpRsUSnjEbWZ@vger.kernel.org
X-Gm-Message-State: AFuF++lYgTjFXN9DlwCA4jiwxpq/egtQjidKyxWDvlVXTynXIKt+I8Wm
	SWbDip4QIZzJ2k66+HIc9mLTTjU/bHVhJspsT81mIHeMHrxQx2Md5iTsAqm70uUJhskUzlsnn+y
	iBsFX0Nax5iY76lE7LKD73WIsqxAG0yw=
X-Received: by 2002:a05:6402:42c7:b0:697:f6b2:a94e with SMTP id
 4fb4d7f45d1cf-6a42f2120dcmr3341924a12.13.1787286438893; Thu, 20 Aug 2026
 21:27:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-submit-phy-package-fwdevlink-v1-v3-0-40a905ea16b6@gmail.com>
 <20260818-submit-phy-package-fwdevlink-v1-v3-4-40a905ea16b6@gmail.com>
In-Reply-To: <20260818-submit-phy-package-fwdevlink-v1-v3-4-40a905ea16b6@gmail.com>
From: Saravana Kannan <saravanak@kernel.org>
Date: Thu, 20 Aug 2026 21:27:05 -0700
X-Gmail-Original-Message-ID: <CACRMN=fEPoyEk1oi4QRMX0whMEF=xQv=kkd62bueKTKWtxDedA@mail.gmail.com>
X-Gm-Features: AcwNN1W4jxXR15kzgJAdC7fSGJapyONShiqTKQITYhYSR59uulEemZy8CloVVys
Message-ID: <CACRMN=fEPoyEk1oi4QRMX0whMEF=xQv=kkd62bueKTKWtxDedA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/4] driver core: handle managed links for
 class devices
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Christian Marangi <ansuelsmth@gmail.com>, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-acpi@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 11:59=E2=80=AFPM James Hilliard
<james.hilliard1@gmail.com> wrote:
>
> fw_devlink deliberately lets the nearest device pick up dependencies belo=
w
> class-backed firmware nodes because driverless class devices do not
> currently progress through managed device-link states. This can leave
> consumers of class suppliers dormant, while sync-state-only links from
> class consumers never reach the successful-probe cleanup.
>
> Track class-only devices through equivalent registration and removal
> transitions. Mark them probing before device_add() publishes them, comple=
te
> their incoming and outgoing links after class interfaces run, and enter t=
he
> unbind and no-driver states during device_del(). Preserve firmware links
> below class-backed nodes so later-created descendants can acquire their o=
wn
> links.
>
> Include class registration in wait_for_device_probe() so supplier unbind
> cannot race a class consumer that is still being published. Transition
> managed links which existed before device_add(), remove stale
> waiting_for_supplier attributes and do not revive a link whose supplier h=
as
> already started unbinding.
>
> During supplier teardown, wait for class registration to finish, but move
> an already registered class consumer directly to the unbinding link state
> because it has no driver to release. Keep consumer-autoremove links valid
> until class consumer removal without triggering driver-only cleanup
> warnings.
>
> Factor the supplier-bound, consumer-bound and cleanup transitions shared
> with driver-backed devices. Activate late links involving an already
> functional class endpoint instead of trying to reprobe it, and let
> sync-state-only links retire without forcing consumer unbind. Ordinary
> supplier links cannot defer class registration, so they must not be the
> only mechanism on which a class consumer relies for functionality.
>
> Class devices do not match drivers, so distinguish a genuinely unavailabl=
e
> supplier from a probing or registered class endpoint before relaxing
> inferred links. Preserve normal probe and runtime-PM ordering for those
> links. Also recognize class-backed nodes when refreshing dependencies aft=
er
> firmware-tree overlays.
>
> Exclude the internal device-link class because device-link objects are
> registered while the device-links lock is held. Document the class-device
> state transitions and add KUnit coverage for supplier and consumer links,
> pre-existing links, inferred-link preservation, registration waiters and =
a
> concurrent supplier unbind.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> ---
> Changes v2 -> v3:
>   - Replace the framework-specific proxy cleanup API with generic
>     class-device managed-link lifecycle handling, as suggested by
>     Saravana Kannan

Please add the Suggested-by tag.

I'm okay with the use of AI to write patches, but it's not clear if
you understand the existing code base enough to use it correctly? If
not, maybe I'll take a weekend to write the patch series to add
devlink support for class devices and you can test it? You can then
write the networking part of the fix.

Just the class devices devlink support alone should be a long patch
series. And should be sent to driver core next. Not net next.

Thanks,
Saravana

>   - Preserve inferred links to probing and registered class suppliers in
>     no-driver fallback paths and include class nodes in overlay refresh
>   - Cover pre-existing and inferred links, wait_for_device_probe()
>     integration, waiting_for_supplier cleanup and supplier-unbind races
>   - Document the limits of ordinary supplier links for driverless class
>     consumers
>   - Handle registered class consumers during supplier teardown without a
>     no-op driver release or driver-only cleanup warning
>   - Derive class handling inside the shared bound helpers and clarify the
>     lifecycle documentation
> ---
>  Documentation/driver-api/device_link.rst   |  47 ++-
>  drivers/base/base.h                        |   2 +
>  drivers/base/core.c                        | 270 +++++++++++-----
>  drivers/base/dd.c                          |  21 +-
>  drivers/base/test/Makefile                 |   1 +
>  drivers/base/test/device-link-class-test.c | 479 +++++++++++++++++++++++=
++++++
>  include/linux/device.h                     |   9 +-
>  7 files changed, 739 insertions(+), 90 deletions(-)
>
> diff --git a/Documentation/driver-api/device_link.rst b/Documentation/dri=
ver-api/device_link.rst
> index ee913ae16371..c248ec9fa9f8 100644
> --- a/Documentation/driver-api/device_link.rst
> +++ b/Documentation/driver-api/device_link.rst
> @@ -253,6 +253,18 @@ child one.
>  State machine
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> +Driverless class devices participate in the managed-link state machine a=
s
> +supplier and consumer endpoints, including as consumers of sync-state-on=
ly
> +proxy links.  Their registration is treated like a successful driver pro=
be:
> +links are completed after :c:func:`device_add()` has finished running cl=
ass
> +interfaces.  During removal, driver-backed consumers are unbound before =
the
> +class device is deleted and its links return to the no-driver state.
> +
> +Class devices are not probed, so an ordinary supplier link cannot defer =
their
> +registration in the way that it defers a driver probe.  Frameworks must =
not use
> +such a link as the only mechanism guaranteeing that a class consumer's
> +supplier is functional.
> +
>  .. kernel-doc:: include/linux/device.h
>     :functions: device_link_state
>
> @@ -271,10 +283,13 @@ State machine
>    and consumer.  If the link is created before any devices are probed, i=
t
>    is set to ``DL_STATE_DORMANT``.
>
> -* When a supplier device is bound to a driver, links to its consumers
> -  progress to ``DL_STATE_AVAILABLE``.
> -  (Call to :c:func:`device_links_driver_bound()` from
> -  :c:func:`driver_bound()`.)
> +* When a supplier device is bound to a driver, links to its consumers pr=
ogress
> +  to ``DL_STATE_AVAILABLE``.  Registering a driverless class supplier pe=
rforms
> +  the equivalent transition, or activates a late link whose consumer is
> +  already functional.
> +  The driver-backed path calls :c:func:`device_links_driver_bound()` fro=
m
> +  :c:func:`driver_bound()`, while the class-device completion path perfo=
rms
> +  the equivalent transition from :c:func:`device_add()`.
>
>  * Before a consumer device is probed, presence of supplier drivers is
>    verified by checking the consumer device is not in the wait_for_suppli=
ers
> @@ -286,17 +301,28 @@ State machine
>    (Call to :c:func:`wait_for_device_probe()` from
>    :c:func:`device_links_unbind_consumers()`.)
>
> +  Registering a driverless class consumer similarly moves existing avail=
able
> +  links to ``DL_STATE_CONSUMER_PROBE`` before publishing the device, and=
 its
> +  registration participates in :c:func:`wait_for_device_probe()`.  Unlik=
e a
> +  driver probe, class registration is not deferred for unavailable suppl=
iers.
> +
>  * If the probe fails, links to suppliers revert back to ``DL_STATE_AVAIL=
ABLE``.
>    (Call to :c:func:`device_links_no_driver()` from :c:func:`really_probe=
()`.)
>
>  * If the probe succeeds, links to suppliers progress to ``DL_STATE_ACTIV=
E``.
> -  (Call to :c:func:`device_links_driver_bound()` from :c:func:`driver_bo=
und()`.)
> +  A driverless class consumer activates usable incoming links when its
> +  registration completes, drops sync-state-only proxy links and preserve=
s
> +  links whose suppliers are dormant or unbinding.  The driver-backed pat=
h
> +  calls :c:func:`device_links_driver_bound()` from :c:func:`driver_bound=
()`,
> +  while :c:func:`device_add()` performs the equivalent class-device
> +  transition.
>
>  * When the consumer's driver is later on removed, links to suppliers rev=
ert
>    back to ``DL_STATE_AVAILABLE``.
>    (Call to :c:func:`__device_links_no_driver()` from
>    :c:func:`device_links_driver_cleanup()`, which in turn is called from
> -  :c:func:`__device_release_driver()`.)
> +  :c:func:`__device_release_driver()`.)  Removing a driverless class con=
sumer
> +  performs the equivalent cleanup from :c:func:`device_del()`.
>
>  * Before a supplier's driver is removed, links to consumers that are not
>    bound to a driver are updated to ``DL_STATE_SUPPLIER_UNBIND``.
> @@ -305,14 +331,17 @@ State machine
>    This prevents the consumers from binding.
>    (Call to :c:func:`device_links_check_suppliers()` from
>    :c:func:`really_probe()`.)
> -  Consumers that are bound are freed from their driver; consumers that a=
re
> -  probing are waited for until they are done.
> +  Driver-backed consumers that are bound are freed from their driver;
> +  driverless class consumers remain registered and their links move dire=
ctly
> +  to ``DL_STATE_SUPPLIER_UNBIND``.  Consumers that are probing or being
> +  registered as class devices are waited for until they are done.
>    (Call to :c:func:`device_links_unbind_consumers()` from
>    :c:func:`__device_release_driver()`.)
>    Once all links to consumers are in ``DL_STATE_SUPPLIER_UNBIND`` state,
>    the supplier driver is released and the links revert to ``DL_STATE_DOR=
MANT``.
>    (Call to :c:func:`device_links_driver_cleanup()` from
> -  :c:func:`__device_release_driver()`.)
> +  :c:func:`__device_release_driver()`.)  Removing a driverless class sup=
plier
> +  follows the same sequence from :c:func:`device_del()`.
>
>  API
>  =3D=3D=3D
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index a5b7abc10ff0..8bdf0a709401 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -166,6 +166,8 @@ void device_release_driver_internal(struct device *de=
v, const struct device_driv
>  void driver_detach(const struct device_driver *drv);
>  void driver_deferred_probe_del(struct device *dev);
>  void device_set_deferred_probe_reason(const struct device *dev, struct v=
a_format *vaf);
> +void device_probe_begin(void);
> +void device_probe_end(void);
>  static inline int driver_match_device(const struct device_driver *drv,
>                                       struct device *dev)
>  {
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index d2f9ff65138c..0c26ba38e6cf 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -213,10 +213,10 @@ static void __fwnode_links_move_consumers(struct fw=
node_handle *from,
>   * @fwnode: fwnode from which to pick up dangling consumers
>   * @new_sup: fwnode of new supplier
>   *
> - * If the @fwnode has a corresponding struct device and the device suppo=
rts
> - * probing (that is, added to a bus), then we want to let fw_devlink cre=
ate
> - * MANAGED device links to this device, so leave @fwnode and its descend=
ant's
> - * fwnode links alone.
> + * If the @fwnode has a corresponding struct device whose device-link st=
ate is
> + * managed by the driver core (that is, a bus or class device), then we =
want to
> + * let fw_devlink create MANAGED device links to this device, so leave @=
fwnode
> + * and its descendants' fwnode links alone.
>   *
>   * Otherwise, move its consumers to the new supplier @new_sup.
>   */
> @@ -225,7 +225,7 @@ static void __fw_devlink_pickup_dangling_consumers(st=
ruct fwnode_handle *fwnode,
>  {
>         struct fwnode_handle *child;
>
> -       if (fwnode->dev && fwnode->dev->bus)
> +       if (fwnode->dev && (fwnode->dev->bus || fwnode->dev->class))
>                 return;
>
>         fwnode_set_flag(fwnode, FWNODE_FLAG_NOT_DEVICE);
> @@ -259,7 +259,7 @@ void fw_devlink_refresh_fwnode(struct fwnode_handle *=
fwnode)
>
>         /*
>          * Find the closest ancestor fwnode that has been converted to a =
device
> -        * that can bind to a driver (bus device).
> +        * whose managed-link lifecycle is handled by the driver core.
>          */
>         fwnode_handle_get(fwnode);
>         do {
> @@ -270,15 +270,15 @@ void fw_devlink_refresh_fwnode(struct fwnode_handle=
 *fwnode)
>                 if (!dev)
>                         continue;
>
> -               if (dev->bus)
> +               if (dev->bus || dev->class)
>                         break;
>
>                 put_device(dev);
>         } while ((fwnode =3D fwnode_get_next_parent(fwnode)));
>
>         /*
> -        * If none of the ancestor fwnodes have (yet) been converted to a=
 device
> -        * that can bind to a driver, there's nothing to fix up.
> +        * If none of the ancestor fwnodes have (yet) been converted to s=
uch a
> +        * device, there's nothing to fix up.
>          */
>         if (!fwnode)
>                 return;
> @@ -287,10 +287,9 @@ void fw_devlink_refresh_fwnode(struct fwnode_handle =
*fwnode)
>              "Don't multithread overlaying and probing the same device!\n=
");
>
>         /*
> -        * If the device has already bound to a driver, then we need to r=
edo
> -        * some of the work that was done after the device was bound to a
> -        * driver. If the device hasn't bound to a driver, running things=
 too
> -        * soon would incorrectly pick up consumers that it shouldn't.
> +        * If the device's managed links are available, redo some of the =
work
> +        * performed when it reached that state. Running this too soon wo=
uld
> +        * incorrectly pick up consumers that it shouldn't.
>          */
>         if (dev->links.status =3D=3D DL_DEV_DRIVER_BOUND) {
>                 fw_devlink_pickup_dangling_consumers(dev);
> @@ -1088,6 +1087,12 @@ static bool dev_is_best_effort(struct device *dev)
>                 (dev->fwnode && fwnode_test_flag(dev->fwnode, FWNODE_FLAG=
_BEST_EFFORT));
>  }
>
> +static bool dev_is_unmatchable(const struct device *dev)
> +{
> +       return READ_ONCE(dev->links.status) =3D=3D DL_DEV_NO_DRIVER &&
> +              !dev_can_match(dev);
> +}
> +
>  static struct fwnode_handle *fwnode_links_check_suppliers(
>                                                 struct fwnode_handle *fwn=
ode)
>  {
> @@ -1152,7 +1157,7 @@ int device_links_check_suppliers(struct device *dev=
)
>
>                         if (dev_is_best_effort(dev) &&
>                             device_link_test(link, DL_FLAG_INFERRED) &&
> -                           !dev_can_match(link->supplier)) {
> +                           dev_is_unmatchable(link->supplier)) {
>                                 ret =3D -EAGAIN;
>                                 continue;
>                         }
> @@ -1307,6 +1312,33 @@ static void device_link_drop_managed(struct device=
_link *link)
>         kref_put(&link->kref, __device_link_del);
>  }
>
> +static bool device_links_track_class(const struct device *dev)
> +{
> +       /* Device-link objects are class devices registered with the lock=
 held. */
> +       return dev->class && !dev->bus && dev->class !=3D &devlink_class;
> +}
> +
> +static void device_links_class_start(struct device *dev)
> +{
> +       struct device_link *link;
> +
> +       device_probe_begin();
> +       device_links_write_lock();
> +       WARN_ON(dev->links.status !=3D DL_DEV_NO_DRIVER);
> +       list_for_each_entry(link, &dev->links.suppliers, c_node) {
> +               if (!device_link_test(link, DL_FLAG_MANAGED))
> +                       continue;
> +
> +               /* Do not revive a link whose supplier is already unbindi=
ng. */
> +               if (link->status =3D=3D DL_STATE_AVAILABLE ||
> +                   (device_link_test(link, DL_FLAG_SYNC_STATE_ONLY) &&
> +                    link->status !=3D DL_STATE_SUPPLIER_UNBIND))
> +                       WRITE_ONCE(link->status, DL_STATE_CONSUMER_PROBE)=
;
> +       }
> +       dev->links.status =3D DL_DEV_PROBING;
> +       device_links_write_unlock();
> +}
> +
>  static ssize_t waiting_for_supplier_show(struct device *dev,
>                                          const struct device_attribute *a=
ttr,
>                                          char *buf)
> @@ -1356,43 +1388,11 @@ void device_links_force_bind(struct device *dev)
>         device_links_write_unlock();
>  }
>
> -/**
> - * device_links_driver_bound - Update device links after probing its dri=
ver.
> - * @dev: Device to update the links for.
> - *
> - * The probe has been successful, so update links from this device to an=
y
> - * consumers by changing their status to "available".
> - *
> - * Also change the status of @dev's links to suppliers to "active".
> - *
> - * Links without the DL_FLAG_MANAGED flag set are ignored.
> - */
> -void device_links_driver_bound(struct device *dev)
> +static void __device_links_supplier_bound(struct device *dev,
> +                                         struct list_head *sync_list)
>  {
> -       struct device_link *link, *ln;
> -       LIST_HEAD(sync_list);
> -
> -       /*
> -        * If a device binds successfully, it's expected to have created =
all
> -        * the device links it needs to or make new device links as it ne=
eds
> -        * them. So, fw_devlink no longer needs to create device links to=
 any
> -        * of the device's suppliers.
> -        *
> -        * Also, if a child firmware node of this bound device is not add=
ed as a
> -        * device by now, assume it is never going to be added. Make this=
 bound
> -        * device the fallback supplier to the dangling consumers of the =
child
> -        * firmware node because this bound device is probably implementi=
ng the
> -        * child firmware node functionality and we don't want the dangli=
ng
> -        * consumers to defer probe indefinitely waiting for a device for=
 the
> -        * child firmware node.
> -        */
> -       if (dev->fwnode && dev->fwnode->dev =3D=3D dev) {
> -               fwnode_links_purge_suppliers(dev->fwnode);
> -               fw_devlink_pickup_dangling_consumers(dev);
> -       }
> -       device_remove_file(dev, &dev_attr_waiting_for_supplier);
> -
> -       device_links_write_lock();
> +       struct device_link *link;
> +       bool class_device =3D device_links_track_class(dev);
>
>         list_for_each_entry(link, &dev->links.consumers, s_node) {
>                 if (!device_link_test(link, DL_FLAG_MANAGED))
> @@ -1409,16 +1409,35 @@ void device_links_driver_bound(struct device *dev=
)
>                         continue;
>
>                 WARN_ON(link->status !=3D DL_STATE_DORMANT);
> -               WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
> +               /*
> +                * A class interface can add a link from an already-bound=
 consumer
> +                * while the class supplier is being registered.  Likewis=
e, a class
> +                * consumer has no driver probe to retry when a late supp=
lier binds.
> +                * Those consumers are already functional, so activate th=
eir links.
> +                */
> +               if ((class_device ||
> +                    device_links_track_class(link->consumer)) &&
> +                   link->consumer->links.status =3D=3D DL_DEV_DRIVER_BOU=
ND) {
> +                       WRITE_ONCE(link->status, DL_STATE_ACTIVE);
> +               } else {
> +                       WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
>
> -               if (device_link_test(link, DL_FLAG_AUTOPROBE_CONSUMER))
> -                       driver_deferred_probe_add(link->consumer);
> +                       if (device_link_test(link, DL_FLAG_AUTOPROBE_CONS=
UMER))
> +                               driver_deferred_probe_add(link->consumer)=
;
> +               }
>         }
>
>         if (defer_sync_state_count)
>                 __device_links_supplier_defer_sync(dev);
>         else
> -               __device_links_queue_sync_state(dev, &sync_list);
> +               __device_links_queue_sync_state(dev, sync_list);
> +}
> +
> +static void __device_links_consumer_bound(struct device *dev,
> +                                         struct list_head *sync_list)
> +{
> +       struct device_link *link, *ln;
> +       bool class_device =3D device_links_track_class(dev);
>
>         list_for_each_entry_safe(link, ln, &dev->links.suppliers, c_node)=
 {
>                 struct device *supplier;
> @@ -1431,13 +1450,13 @@ void device_links_driver_bound(struct device *dev=
)
>                         /*
>                          * When DL_FLAG_SYNC_STATE_ONLY is set, it means =
no
>                          * other DL_MANAGED_LINK_FLAGS have been set. So,=
 it's
> -                        * save to drop the managed link completely.
> +                        * safe to drop the managed link completely.
>                          */
>                         device_link_drop_managed(link);
> -               } else if (dev_is_best_effort(dev) &&
> +               } else if (!class_device && dev_is_best_effort(dev) &&
>                            device_link_test(link, DL_FLAG_INFERRED) &&
>                            link->status !=3D DL_STATE_CONSUMER_PROBE &&
> -                          !dev_can_match(link->supplier)) {
> +                          dev_is_unmatchable(link->supplier)) {
>                         /*
>                          * When dev_is_best_effort() is true, we ignore d=
evice
>                          * links to suppliers that don't have a driver.  =
If the
> @@ -1446,9 +1465,17 @@ void device_links_driver_bound(struct device *dev)
>                          * (consumer probed before supplier). So delete i=
t.
>                          */
>                         device_link_drop_managed(link);
> -               } else {
> +               } else if (!class_device) {
>                         WARN_ON(link->status !=3D DL_STATE_CONSUMER_PROBE=
);
>                         WRITE_ONCE(link->status, DL_STATE_ACTIVE);
> +               } else if (link->status =3D=3D DL_STATE_CONSUMER_PROBE ||
> +                          link->status =3D=3D DL_STATE_AVAILABLE) {
> +                       WRITE_ONCE(link->status, DL_STATE_ACTIVE);
> +               } else {
> +                       WARN_ON(link->status !=3D DL_STATE_ACTIVE &&
> +                               link->status !=3D DL_STATE_DORMANT &&
> +                               link->status !=3D DL_STATE_SUPPLIER_UNBIN=
D);
> +                       continue;
>                 }
>
>                 /*
> @@ -1460,10 +1487,67 @@ void device_links_driver_bound(struct device *dev=
)
>                 if (defer_sync_state_count)
>                         __device_links_supplier_defer_sync(supplier);
>                 else
> -                       __device_links_queue_sync_state(supplier, &sync_l=
ist);
> +                       __device_links_queue_sync_state(supplier, sync_li=
st);
>         }
>
>         dev->links.status =3D DL_DEV_DRIVER_BOUND;
> +}
> +
> +static void device_links_class_bound(struct device *dev)
> +{
> +       LIST_HEAD(sync_list);
> +
> +       device_remove_file(dev, &dev_attr_waiting_for_supplier);
> +
> +       device_links_write_lock();
> +       __device_links_supplier_bound(dev, &sync_list);
> +       __device_links_consumer_bound(dev, &sync_list);
> +       device_links_write_unlock();
> +
> +       device_links_flush_sync_list(&sync_list, NULL);
> +       driver_deferred_probe_trigger();
> +       device_probe_end();
> +}
> +
> +/**
> + * device_links_driver_bound - Update device links after probing its dri=
ver.
> + * @dev: Device to update the links for.
> + *
> + * The probe has been successful, so update links from this device to an=
y
> + * consumers by changing their status to "available".
> + *
> + * Also change the status of @dev's links to suppliers to "active".
> + *
> + * Links without the DL_FLAG_MANAGED flag set are ignored.
> + */
> +void device_links_driver_bound(struct device *dev)
> +{
> +       LIST_HEAD(sync_list);
> +
> +       /*
> +        * If a device binds successfully, it's expected to have created =
all
> +        * the device links it needs to or make new device links as it ne=
eds
> +        * them. So, fw_devlink no longer needs to create device links to=
 any
> +        * of the device's suppliers.
> +        *
> +        * Also, if a child firmware node of this bound device is not add=
ed as a
> +        * device by now, assume it is never going to be added. Make this=
 bound
> +        * device the fallback supplier to the dangling consumers of the =
child
> +        * firmware node because this bound device is probably implementi=
ng the
> +        * child firmware node functionality and we don't want the dangli=
ng
> +        * consumers to defer probe indefinitely waiting for a device for=
 the
> +        * child firmware node.
> +        */
> +       if (dev->fwnode && dev->fwnode->dev =3D=3D dev) {
> +               fwnode_links_purge_suppliers(dev->fwnode);
> +               fw_devlink_pickup_dangling_consumers(dev);
> +       }
> +
> +       device_remove_file(dev, &dev_attr_waiting_for_supplier);
> +
> +       device_links_write_lock();
> +       __device_links_supplier_bound(dev, &sync_list);
> +       __device_links_consumer_bound(dev, &sync_list);
>
>         device_links_write_unlock();
>
> @@ -1548,17 +1632,7 @@ void device_links_no_driver(struct device *dev)
>         device_links_write_unlock();
>  }
>
> -/**
> - * device_links_driver_cleanup - Update links after driver removal.
> - * @dev: Device whose driver has just gone away.
> - *
> - * Update links to consumers for @dev by changing their status to "dorma=
nt" and
> - * invoke %__device_links_no_driver() to update links to suppliers for i=
t as
> - * appropriate.
> - *
> - * Links without the DL_FLAG_MANAGED flag set are ignored.
> - */
> -void device_links_driver_cleanup(struct device *dev)
> +static void device_links_cleanup(struct device *dev)
>  {
>         struct device_link *link, *ln;
>
> @@ -1568,7 +1642,8 @@ void device_links_driver_cleanup(struct device *dev=
)
>                 if (!device_link_test(link, DL_FLAG_MANAGED))
>                         continue;
>
> -               WARN_ON(device_link_test(link, DL_FLAG_AUTOREMOVE_CONSUME=
R));
> +               WARN_ON(device_link_test(link, DL_FLAG_AUTOREMOVE_CONSUME=
R) &&
> +                       !device_links_track_class(link->consumer));
>                 WARN_ON(link->status !=3D DL_STATE_SUPPLIER_UNBIND);
>
>                 /*
> @@ -1589,6 +1664,21 @@ void device_links_driver_cleanup(struct device *de=
v)
>         device_links_write_unlock();
>  }
>
> +/**
> + * device_links_driver_cleanup - Update links after driver removal.
> + * @dev: Device whose driver has just gone away.
> + *
> + * Update links to consumers for @dev by changing their status to "dorma=
nt" and
> + * invoke %__device_links_no_driver() to update links to suppliers for i=
t as
> + * appropriate.
> + *
> + * Links without the DL_FLAG_MANAGED flag set are ignored.
> + */
> +void device_links_driver_cleanup(struct device *dev)
> +{
> +       device_links_cleanup(dev);
> +}
> +
>  /**
>   * device_links_busy - Check if there are any busy links to consumers.
>   * @dev: Device to check.
> @@ -1599,7 +1689,9 @@ void device_links_driver_cleanup(struct device *dev=
)
>   * state to "supplier unbind" to prevent the consumer from being probed
>   * successfully going forward.
>   *
> - * Return 'false' if there are no probing or active consumers.
> + * Sync-state-only links are moved to "supplier unbind" without making t=
he
> + * supplier busy, since they do not require the consumer to be unbound.
> + * Return 'false' if there are no other probing or active consumers.
>   *
>   * Links without the DL_FLAG_MANAGED flag set are ignored.
>   */
> @@ -1613,6 +1705,11 @@ bool device_links_busy(struct device *dev)
>         list_for_each_entry(link, &dev->links.consumers, s_node) {
>                 if (!device_link_test(link, DL_FLAG_MANAGED))
>                         continue;
> +               /* Sync-state-only links do not require consumer unbindin=
g. */
> +               if (device_link_test(link, DL_FLAG_SYNC_STATE_ONLY)) {
> +                       WRITE_ONCE(link->status, DL_STATE_SUPPLIER_UNBIND=
);
> +                       continue;
> +               }
>
>                 if (link->status =3D=3D DL_STATE_CONSUMER_PROBE
>                     || link->status =3D=3D DL_STATE_ACTIVE) {
> @@ -1668,6 +1765,10 @@ void device_links_unbind_consumers(struct device *=
dev)
>                 if (status =3D=3D DL_STATE_ACTIVE) {
>                         struct device *consumer =3D link->consumer;
>
> +                       /* Class consumers have no driver to release. */
> +                       if (device_links_track_class(consumer))
> +                               continue;
> +
>                         get_device(consumer);
>
>                         device_links_write_unlock();
> @@ -1826,7 +1927,7 @@ static int fw_devlink_no_driver(struct device *dev,=
 void *data)
>  {
>         struct device_link *link =3D to_devlink(dev);
>
> -       if (!dev_can_match(link->supplier))
> +       if (dev_is_unmatchable(link->supplier))
>                 fw_devlink_relax_link(link);
>
>         return 0;
> @@ -3704,6 +3805,7 @@ int device_add(struct device *dev)
>         struct device *parent;
>         struct kobject *kobj;
>         struct class_interface *class_intf;
> +       bool track_class_links =3D false;
>         int error =3D -EINVAL;
>         struct kobject *glue_dir =3D NULL;
>
> @@ -3737,6 +3839,10 @@ int device_add(struct device *dev)
>         if (error)
>                 goto name_error;
>
> +       track_class_links =3D device_links_track_class(dev);
> +       if (track_class_links)
> +               device_links_class_start(dev);
> +
>         pr_debug("device: '%s': %s\n", dev_name(dev), __func__);
>
>         parent =3D get_device(dev->parent);
> @@ -3838,7 +3944,7 @@ int device_add(struct device *dev)
>          * match with any driver, don't block its consumers from probing =
in
>          * case the consumer device is able to operate without this suppl=
ier.
>          */
> -       if (dev->fwnode && fw_devlink_drv_reg_done && !dev_can_match(dev)=
)
> +       if (dev->fwnode && fw_devlink_drv_reg_done && dev_is_unmatchable(=
dev))
>                 fw_devlink_unblock_consumers(dev);
>
>         if (parent)
> @@ -3858,6 +3964,8 @@ int device_add(struct device *dev)
>                 mutex_unlock(&sp->mutex);
>                 subsys_put(sp);
>         }
> +       if (track_class_links)
> +               device_links_class_bound(dev);
>  done:
>         put_device(dev);
>         return error;
> @@ -3886,6 +3994,10 @@ int device_add(struct device *dev)
>  parent_error:
>         put_device(parent);
>  name_error:
> +       if (track_class_links) {
> +               device_links_no_driver(dev);
> +               device_probe_end();
> +       }
>         kfree(dev->p);
>         dev->p =3D NULL;
>         goto done;
> @@ -3980,9 +4092,17 @@ void device_del(struct device *dev)
>         struct device *parent =3D dev->parent;
>         struct kobject *glue_dir =3D NULL;
>         struct class_interface *class_intf;
> +       bool track_class_links =3D device_links_track_class(dev);
>         unsigned int noio_flag;
>
>         device_lock(dev);
> +       if (track_class_links) {
> +               while (device_links_busy(dev)) {
> +                       device_unlock(dev);
> +                       device_links_unbind_consumers(dev);
> +                       device_lock(dev);
> +               }
> +       }
>         kill_device(dev);
>         device_unlock(dev);
>
> @@ -4024,6 +4144,8 @@ void device_del(struct device *dev)
>         device_pm_remove(dev);
>         driver_deferred_probe_del(dev);
>         device_platform_notify_remove(dev);
> +       if (track_class_links)
> +               device_links_cleanup(dev);
>         device_links_purge(dev);
>
>         /*
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 60c005223844..61288fcceb5b 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -555,9 +555,21 @@ int device_bind_driver(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(device_bind_driver);
>
> +/* Driver probes and driverless class-device registrations in progress. =
*/
>  static atomic_t probe_count =3D ATOMIC_INIT(0);
>  static DECLARE_WAIT_QUEUE_HEAD(probe_waitqueue);
>
> +void device_probe_begin(void)
> +{
> +       atomic_inc(&probe_count);
> +}
> +
> +void device_probe_end(void)
> +{
> +       atomic_dec(&probe_count);
> +       wake_up_all(&probe_waitqueue);
> +}
> +
>  static ssize_t state_synced_store(struct device *dev,
>                                   struct device_attribute *attr,
>                                   const char *buf, size_t count)
> @@ -797,7 +809,7 @@ static int really_probe_debug(struct device *dev, con=
st struct device_driver *dr
>
>  /**
>   * driver_probe_done
> - * Determine if the probe sequence is finished or not.
> + * Determine if the probe and class-device registration sequence is fini=
shed.
>   *
>   * Should somehow figure out how to use a semaphore, not an atomic varia=
ble...
>   */
> @@ -811,7 +823,7 @@ bool __init driver_probe_done(void)
>
>  /**
>   * wait_for_device_probe
> - * Wait for device probing to be completed.
> + * Wait for device probing and driverless class registration to be compl=
eted.
>   */
>  void wait_for_device_probe(void)
>  {
> @@ -894,7 +906,7 @@ static int driver_probe_device(const struct device_dr=
iver *drv, struct device *d
>         int trigger_count =3D atomic_read(&deferred_trigger_count);
>         int ret;
>
> -       atomic_inc(&probe_count);
> +       device_probe_begin();
>         ret =3D __driver_probe_device(drv, dev);
>         if (ret =3D=3D -EPROBE_DEFER || ret =3D=3D EPROBE_DEFER) {
>                 driver_deferred_probe_add(dev);
> @@ -906,8 +918,7 @@ static int driver_probe_device(const struct device_dr=
iver *drv, struct device *d
>                     !defer_all_probes)
>                         driver_deferred_probe_trigger();
>         }
> -       atomic_dec(&probe_count);
> -       wake_up_all(&probe_waitqueue);
> +       device_probe_end();
>         return ret;
>  }
>
> diff --git a/drivers/base/test/Makefile b/drivers/base/test/Makefile
> index d871a71dbbaa..c33c615eaabf 100644
> --- a/drivers/base/test/Makefile
> +++ b/drivers/base/test/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_TEST_ASYNC_DRIVER_PROBE)   +=3D test_async_d=
river_probe.o
>
>  obj-$(CONFIG_DM_KUNIT_TEST)    +=3D root-device-test.o
>  obj-$(CONFIG_DM_KUNIT_TEST)    +=3D platform-device-test.o
> +obj-$(CONFIG_DM_KUNIT_TEST)    +=3D device-link-class-test.o
>  obj-$(CONFIG_DM_KUNIT_TEST)    +=3D fwnode-link-test.o
>
>  obj-$(CONFIG_DRIVER_PE_KUNIT_TEST) +=3D property-entry-test.o
> diff --git a/drivers/base/test/device-link-class-test.c b/drivers/base/te=
st/device-link-class-test.c
> new file mode 100644
> index 000000000000..7d52efb55aa5
> --- /dev/null
> +++ b/drivers/base/test/device-link-class-test.c
> @@ -0,0 +1,479 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <kunit/platform_device.h>
> +#include <kunit/resource.h>
> +#include <kunit/test.h>
> +
> +#include <linux/completion.h>
> +#include <linux/device.h>
> +#include <linux/device/driver.h>
> +#include <linux/fwnode.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernfs.h>
> +#include <linux/kthread.h>
> +#include <linux/platform_device.h>
> +#include <linux/sched/task.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +
> +#define TEST_CLASS_NAME                "device-link-test"
> +#define TEST_DRIVER_NAME       "device-link-test-consumer"
> +
> +enum test_class_action {
> +       TEST_CLASS_NONE,
> +       TEST_CLASS_SUPPLIER,
> +       TEST_CLASS_SYNC_CONSUMER,
> +       TEST_CLASS_OBSERVE,
> +       TEST_CLASS_WAIT,
> +       TEST_CLASS_UNBIND_RACE,
> +};
> +
> +struct device_link_class_context {
> +       enum test_class_action action;
> +       struct device *endpoint;
> +       struct device_link *link;
> +       struct completion waiter_started;
> +       struct completion waiter_done;
> +       struct task_struct *waiter;
> +       struct completion unbind_started;
> +       struct completion unbind_done;
> +       struct task_struct *unbinder;
> +       bool waiter_completed_during_add;
> +       bool unbind_completed_during_add;
> +       bool waiting_for_supplier_seen;
> +};
> +
> +struct test_class_device {
> +       struct device dev;
> +       struct fwnode_handle fwnode;
> +       struct fwnode_handle missing_supplier;
> +       bool added;
> +};
> +
> +static struct class *test_class;
> +static struct device_link_class_context *test_context;
> +static atomic_t remove_count;
> +static atomic_t sync_count;
> +
> +static int test_driver_probe(struct platform_device *pdev)
> +{
> +       return 0;
> +}
> +
> +static void test_driver_remove(struct platform_device *pdev)
> +{
> +       atomic_inc(&remove_count);
> +}
> +
> +static void test_driver_sync_state(struct device *dev)
> +{
> +       atomic_inc(&sync_count);
> +}
> +
> +static struct platform_driver test_driver =3D {
> +       .probe =3D test_driver_probe,
> +       .remove =3D test_driver_remove,
> +       .driver =3D {
> +               .name =3D TEST_DRIVER_NAME,
> +               .sync_state =3D test_driver_sync_state,
> +       },
> +};
> +
> +static bool test_has_waiting_for_supplier(struct device *dev)
> +{
> +       struct kernfs_node *kn;
> +
> +       kn =3D sysfs_get_dirent(dev->kobj.sd, "waiting_for_supplier");
> +       if (kn)
> +               kernfs_put(kn);
> +
> +       return !!kn;
> +}
> +
> +static int test_wait_for_probe(void *data)
> +{
> +       struct device_link_class_context *context =3D data;
> +
> +       complete(&context->waiter_started);
> +       wait_for_device_probe();
> +       complete(&context->waiter_done);
> +
> +       return 0;
> +}
> +
> +static int test_unbind_supplier(void *data)
> +{
> +       struct device_link_class_context *context =3D data;
> +
> +       complete(&context->unbind_started);
> +       device_release_driver(context->endpoint);
> +       complete(&context->unbind_done);
> +
> +       return 0;
> +}
> +
> +static int test_class_add(struct device *dev)
> +{
> +       struct device_link_class_context *context =3D test_context;
> +
> +       if (!context)
> +               return 0;
> +
> +       switch (context->action) {
> +       case TEST_CLASS_SUPPLIER:
> +               context->link =3D device_link_add(context->endpoint, dev,
> +                                               DL_FLAG_INFERRED |
> +                                               DL_FLAG_AUTOPROBE_CONSUME=
R);
> +               return context->link ? 0 : -ENOMEM;
> +       case TEST_CLASS_SYNC_CONSUMER:
> +               context->link =3D device_link_add(dev, context->endpoint,
> +                                               DL_FLAG_INFERRED |
> +                                               DL_FLAG_SYNC_STATE_ONLY);
> +               return context->link ? 0 : -ENOMEM;
> +       case TEST_CLASS_OBSERVE:
> +               context->waiting_for_supplier_seen =3D
> +                       test_has_waiting_for_supplier(dev);
> +               return 0;
> +       case TEST_CLASS_WAIT:
> +               context->waiter =3D kthread_create(test_wait_for_probe, c=
ontext,
> +                                                "device-link-wait");
> +               if (IS_ERR(context->waiter))
> +                       return PTR_ERR(context->waiter);
> +               get_task_struct(context->waiter);
> +               wake_up_process(context->waiter);
> +               wait_for_completion(&context->waiter_started);
> +               context->waiter_completed_during_add =3D
> +                       wait_for_completion_timeout(&context->waiter_done=
,
> +                                                   msecs_to_jiffies(50))=
;
> +               return 0;
> +       case TEST_CLASS_UNBIND_RACE:
> +               context->link =3D device_link_add(dev, context->endpoint,=
 0);
> +               if (!context->link)
> +                       return -ENOMEM;
> +               context->unbinder =3D kthread_create(test_unbind_supplier=
, context,
> +                                                  "device-link-unbind");
> +               if (IS_ERR(context->unbinder))
> +                       return PTR_ERR(context->unbinder);
> +               get_task_struct(context->unbinder);
> +               wake_up_process(context->unbinder);
> +               wait_for_completion(&context->unbind_started);
> +               context->unbind_completed_during_add =3D
> +                       wait_for_completion_timeout(&context->unbind_done=
,
> +                                                   msecs_to_jiffies(50))=
;
> +               return 0;
> +       case TEST_CLASS_NONE:
> +               return 0;
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static struct class_interface test_class_interface =3D {
> +       .add_dev =3D test_class_add,
> +};
> +
> +static void test_unregister_device(void *data)
> +{
> +       device_unregister(data);
> +}
> +
> +static void test_resume_sync_state(void *data)
> +{
> +       device_links_supplier_sync_state_resume();
> +}
> +
> +static struct platform_device *
> +test_register_platform_device(struct kunit *test)
> +{
> +       struct platform_device_info info =3D {
> +               .name =3D TEST_DRIVER_NAME,
> +               .id =3D PLATFORM_DEVID_AUTO,
> +       };
> +       struct platform_device *pdev;
> +
> +       pdev =3D kunit_platform_device_register_full(test, &info);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> +       KUNIT_ASSERT_EQ(test, pdev->dev.links.status, DL_DEV_DRIVER_BOUND=
);
> +
> +       return pdev;
> +}
> +
> +static void test_class_device_release(struct device *dev)
> +{
> +       struct test_class_device *tdev =3D
> +               container_of(dev, struct test_class_device, dev);
> +
> +       fwnode_links_purge(&tdev->fwnode);
> +       fwnode_links_purge(&tdev->missing_supplier);
> +       kfree(tdev);
> +}
> +
> +static void test_class_device_cleanup(void *data)
> +{
> +       struct test_class_device *tdev =3D data;
> +
> +       if (tdev->added)
> +               device_unregister(&tdev->dev);
> +       else
> +               put_device(&tdev->dev);
> +}
> +
> +static struct test_class_device *
> +test_class_device_alloc(struct kunit *test, const char *name)
> +{
> +       struct test_class_device *tdev;
> +       int ret;
> +
> +       tdev =3D kzalloc_obj(*tdev);
> +       KUNIT_ASSERT_NOT_NULL(test, tdev);
> +
> +       device_initialize(&tdev->dev);
> +       fwnode_init(&tdev->fwnode, NULL);
> +       fwnode_init(&tdev->missing_supplier, NULL);
> +       tdev->dev.class =3D test_class;
> +       tdev->dev.release =3D test_class_device_release;
> +       device_set_node(&tdev->dev, &tdev->fwnode);
> +       ret =3D dev_set_name(&tdev->dev, "%s", name);
> +       if (ret) {
> +               put_device(&tdev->dev);
> +               KUNIT_FAIL(test, "failed to name class device: %d", ret);
> +               return NULL;
> +       }
> +
> +       ret =3D kunit_add_action_or_reset(test, test_class_device_cleanup=
, tdev);
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +       return tdev;
> +}
> +
> +static void device_link_class_supplier_test(struct kunit *test)
> +{
> +       struct device_link_class_context *context =3D test->priv;
> +       struct platform_device *consumer;
> +       struct device *supplier;
> +       int ret;
> +
> +       consumer =3D test_register_platform_device(test);
> +       context->action =3D TEST_CLASS_SUPPLIER;
> +       context->endpoint =3D &consumer->dev;
> +
> +       supplier =3D device_create(test_class, NULL, 0, NULL,
> +                                TEST_CLASS_NAME "-supplier");
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, supplier);
> +       ret =3D kunit_add_action_or_reset(test, test_unregister_device, s=
upplier);
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +       KUNIT_ASSERT_NOT_NULL(test, context->link);
> +       KUNIT_EXPECT_EQ(test, supplier->links.status, DL_DEV_DRIVER_BOUND=
);
> +       KUNIT_EXPECT_EQ(test, READ_ONCE(context->link->status), DL_STATE_=
ACTIVE);
> +       KUNIT_EXPECT_TRUE(test, device_link_test(context->link,
> +                                                DL_FLAG_AUTOPROBE_CONSUM=
ER));
> +       KUNIT_EXPECT_FALSE(test, device_link_test(context->link,
> +                                                 DL_FLAG_SYNC_STATE_ONLY=
));
> +
> +       kunit_release_action(test, test_unregister_device, supplier);
> +       device_link_wait_removal();
> +
> +       KUNIT_EXPECT_EQ(test, atomic_read(&remove_count), 1);
> +       KUNIT_EXPECT_EQ(test, consumer->dev.links.status, DL_DEV_NO_DRIVE=
R);
> +}
> +
> +static void device_link_class_consumer_sync_test(struct kunit *test)
> +{
> +       struct device_link_class_context *context =3D test->priv;
> +       struct platform_device *supplier;
> +       struct device *consumer;
> +       int ret;
> +
> +       device_links_supplier_sync_state_pause();
> +       ret =3D kunit_add_action_or_reset(test, test_resume_sync_state, N=
ULL);
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +       supplier =3D test_register_platform_device(test);
> +       context->action =3D TEST_CLASS_SYNC_CONSUMER;
> +       context->endpoint =3D &supplier->dev;
> +
> +       consumer =3D device_create(test_class, NULL, 0, NULL,
> +                                TEST_CLASS_NAME "-consumer");
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, consumer);
> +       ret =3D kunit_add_action_or_reset(test, test_unregister_device, c=
onsumer);
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +       KUNIT_ASSERT_NOT_NULL(test, context->link);
> +       KUNIT_EXPECT_EQ(test, consumer->links.status, DL_DEV_DRIVER_BOUND=
);
> +       KUNIT_EXPECT_TRUE(test, list_empty(&consumer->links.suppliers));
> +       kunit_release_action(test, test_resume_sync_state, NULL);
> +       KUNIT_EXPECT_EQ(test, atomic_read(&sync_count), 1);
> +}
> +
> +static void device_link_class_existing_consumer_link_test(struct kunit *=
test)
> +{
> +       struct device_link_class_context *context =3D test->priv;
> +       struct test_class_device *consumer;
> +       struct platform_device *supplier;
> +       struct device_link *link;
> +       int ret;
> +
> +       supplier =3D test_register_platform_device(test);
> +       consumer =3D test_class_device_alloc(test,
> +                                          TEST_CLASS_NAME "-existing-lin=
k");
> +       KUNIT_ASSERT_NOT_NULL(test, consumer);
> +
> +       link =3D device_link_add(&consumer->dev, &supplier->dev,
> +                              DL_FLAG_AUTOREMOVE_CONSUMER);
> +       KUNIT_ASSERT_NOT_NULL(test, link);
> +       KUNIT_ASSERT_EQ(test, READ_ONCE(link->status), DL_STATE_AVAILABLE=
);
> +       ret =3D fwnode_link_add(&consumer->fwnode,
> +                             &consumer->missing_supplier, 0);
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +       context->action =3D TEST_CLASS_OBSERVE;
> +       ret =3D device_add(&consumer->dev);
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +       consumer->added =3D true;
> +
> +       KUNIT_EXPECT_EQ(test, consumer->dev.links.status, DL_DEV_DRIVER_B=
OUND);
> +       KUNIT_EXPECT_EQ(test, READ_ONCE(link->status), DL_STATE_ACTIVE);
> +       KUNIT_EXPECT_TRUE(test, context->waiting_for_supplier_seen);
> +       KUNIT_EXPECT_FALSE(test, test_has_waiting_for_supplier(&consumer-=
>dev));
> +}
> +
> +static void device_link_class_registration_wait_test(struct kunit *test)
> +{
> +       struct device_link_class_context *context =3D test->priv;
> +       struct device *dev;
> +       unsigned long timeout;
> +       int ret;
> +
> +       wait_for_device_probe();
> +       context->action =3D TEST_CLASS_WAIT;
> +       dev =3D device_create(test_class, NULL, 0, NULL,
> +                           TEST_CLASS_NAME "-wait");
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
> +       ret =3D kunit_add_action_or_reset(test, test_unregister_device, d=
ev);
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +       KUNIT_EXPECT_FALSE(test, context->waiter_completed_during_add);
> +       timeout =3D wait_for_completion_timeout(&context->waiter_done,
> +                                             msecs_to_jiffies(1000));
> +       KUNIT_EXPECT_GT(test, timeout, 0UL);
> +}
> +
> +static void device_link_class_supplier_unbind_race_test(struct kunit *te=
st)
> +{
> +       struct device_link_class_context *context =3D test->priv;
> +       struct platform_device *supplier;
> +       struct device *consumer;
> +       unsigned long timeout;
> +       int ret;
> +
> +       supplier =3D test_register_platform_device(test);
> +       context->action =3D TEST_CLASS_UNBIND_RACE;
> +       context->endpoint =3D &supplier->dev;
> +       consumer =3D device_create(test_class, NULL, 0, NULL,
> +                                TEST_CLASS_NAME "-unbind-race");
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, consumer);
> +       ret =3D kunit_add_action_or_reset(test, test_unregister_device, c=
onsumer);
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +       KUNIT_ASSERT_NOT_NULL(test, context->link);
> +       KUNIT_EXPECT_FALSE(test, context->unbind_completed_during_add);
> +       timeout =3D wait_for_completion_timeout(&context->unbind_done,
> +                                             msecs_to_jiffies(1000));
> +       KUNIT_EXPECT_GT(test, timeout, 0UL);
> +       KUNIT_EXPECT_EQ(test, atomic_read(&remove_count), 1);
> +       KUNIT_EXPECT_EQ(test, supplier->dev.links.status, DL_DEV_NO_DRIVE=
R);
> +}
> +
> +static int device_link_class_test_init(struct kunit *test)
> +{
> +       struct device_link_class_context *context;
> +
> +       context =3D kunit_kzalloc(test, sizeof(*context), GFP_KERNEL);
> +       if (!context)
> +               return -ENOMEM;
> +
> +       init_completion(&context->waiter_started);
> +       init_completion(&context->waiter_done);
> +       init_completion(&context->unbind_started);
> +       init_completion(&context->unbind_done);
> +       test->priv =3D context;
> +       test_context =3D context;
> +       atomic_set(&remove_count, 0);
> +       atomic_set(&sync_count, 0);
> +
> +       return 0;
> +}
> +
> +static void device_link_class_test_exit(struct kunit *test)
> +{
> +       struct device_link_class_context *context =3D test->priv;
> +
> +       if (context->waiter && !IS_ERR(context->waiter)) {
> +               kthread_stop(context->waiter);
> +               put_task_struct(context->waiter);
> +       }
> +       if (context->unbinder && !IS_ERR(context->unbinder)) {
> +               kthread_stop(context->unbinder);
> +               put_task_struct(context->unbinder);
> +       }
> +       test_context =3D NULL;
> +}
> +
> +static int device_link_class_suite_init(struct kunit_suite *suite)
> +{
> +       int ret;
> +
> +       test_class =3D class_create(TEST_CLASS_NAME);
> +       if (IS_ERR(test_class))
> +               return PTR_ERR(test_class);
> +
> +       ret =3D platform_driver_register(&test_driver);
> +       if (ret)
> +               goto destroy_class;
> +
> +       test_class_interface.class =3D test_class;
> +       ret =3D class_interface_register(&test_class_interface);
> +       if (ret)
> +               goto unregister_driver;
> +
> +       return 0;
> +
> +unregister_driver:
> +       platform_driver_unregister(&test_driver);
> +destroy_class:
> +       class_destroy(test_class);
> +
> +       return ret;
> +}
> +
> +static void device_link_class_suite_exit(struct kunit_suite *suite)
> +{
> +       class_interface_unregister(&test_class_interface);
> +       platform_driver_unregister(&test_driver);
> +       class_destroy(test_class);
> +       device_link_wait_removal();
> +}
> +
> +static struct kunit_case device_link_class_test_cases[] =3D {
> +       KUNIT_CASE(device_link_class_supplier_test),
> +       KUNIT_CASE(device_link_class_consumer_sync_test),
> +       KUNIT_CASE(device_link_class_existing_consumer_link_test),
> +       KUNIT_CASE(device_link_class_registration_wait_test),
> +       KUNIT_CASE(device_link_class_supplier_unbind_race_test),
> +       {}
> +};
> +
> +static struct kunit_suite device_link_class_test_suite =3D {
> +       .name =3D "device-link-class",
> +       .suite_init =3D device_link_class_suite_init,
> +       .suite_exit =3D device_link_class_suite_exit,
> +       .init =3D device_link_class_test_init,
> +       .exit =3D device_link_class_test_exit,
> +       .test_cases =3D device_link_class_test_cases,
> +};
> +
> +kunit_test_suite(device_link_class_test_suite);
> +
> +MODULE_DESCRIPTION("KUnit tests for class device links");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/device.h b/include/linux/device.h
> index aee79fd6b32b..3783744df86e 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -446,11 +446,16 @@ enum device_link_state {
>  #define DL_FLAG_CYCLE                  BIT(9)
>
>  /**
> - * enum dl_dev_state - Device driver presence tracking information.
> + * enum dl_dev_state - Device availability tracking information.
>   * @DL_DEV_NO_DRIVER: There is no driver attached to the device.
>   * @DL_DEV_PROBING: A driver is probing.
>   * @DL_DEV_DRIVER_BOUND: The driver has been bound to the device.
>   * @DL_DEV_UNBINDING: The driver is unbinding from the device.
> + *
> + * Class devices which are not on a bus use the same states for their
> + * registration lifecycle.  In that case, PROBING and DRIVER_BOUND mean =
that
> + * device_add() is in progress or has completed, respectively, and UNBIN=
DING
> + * means that device_del() is in progress.
>   */
>  enum dl_dev_state {
>         DL_DEV_NO_DRIVER =3D 0,
> @@ -480,7 +485,7 @@ enum device_removable {
>   * @suppliers: List of links to supplier devices.
>   * @consumers: List of links to consumer devices.
>   * @defer_sync: Hook to global list of devices that have deferred sync_s=
tate.
> - * @status: Driver status information.
> + * @status: Driver or class-device availability status.
>   */
>  struct dev_links_info {
>         struct list_head suppliers;
>
> --
> 2.53.0
>
