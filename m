Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E19D3F4DCF
	for <linux-acpi@vger.kernel.org>; Fri, 21 Aug 2026 05:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787288745; cv=pass; b=oEYWKGQDSoF8c3v9WN32DzJ16ZJUQJqRzDIXJu55jqG1UxFo+5+BKHDC/+iklipYt8LV50no/Aeyp0fTVWzHg2RAeRT0xe6eGkhPwGRM7V2VLhx7n14F7nh4j0madvu8SPacRcpsjwXL+uM/vh86WqYAHjUhaDbDQOQvJtq9reg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787288745; c=relaxed/simple;
	bh=Dke7rAx63B1Y+qm8TUNgDE2SEK5eWQ/jjgYEUluTTgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3JkrEUkPSyDA/TXym3zLDC/E2OyN/12lcMB1eWaPOsMHq943B/H86Dwi8gsbWlxdzPm9U8p1GXy+nsODBXTtSD7cdEw5Vxu26cFhw7fZ2rvAY09otWxMM5x3L1MXjhG0OI1tz/FQCwUy02JJSuoRylj1EC95vMRWz7Q5U+dKzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjqLmgaY; arc=pass smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjqLmgaY"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5c38565e774so253557e0c.2
        for <linux-acpi@vger.kernel.org>; Thu, 20 Aug 2026 22:05:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787288740; cv=none;
        d=google.com; s=arc-20260327;
        b=JjW5nxf0XRFKJG5r0APoVdp+CUW2ET0yhlwAFqGOVE2BB98WIoCcqsdKP/ErBmG1yw
         rpkZB1bSQ/bji0e5Kj5biZrqA4nI99hdcu/mK0XLgqThBL2S8Lbk5leBJ3R/LOttliHN
         WLtQUMLJQQJtkU67T7coCd0nkAxSPTna4XnOBy3QLto1qAGdhE1VSe2b8kiv2m9hT5vk
         BnzlihZzRUd4gjPLkeBAsnXgJwvwWqnpZeXRVFhVnrI1MQXV6q0aI0OdPzbbng7p3pkr
         eeZ20M6HscSXEPuniMx7rSmDQu7heW4g2xHReHrZCkgFyUnC5E3u0kK0GMcAeZLNV7ay
         m48A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jmpe1hLDj+ivkEpS/rwgGGC0+pP/wOQo/9NrjqshOdY=;
        fh=QdDGTPrz7TOO2CeAErGBM+ZPKaZQaech6uFhlWt5yEM=;
        b=SsPX2rMUXbDinrMrJ1a1GQJ+JCS24PuxRdS5XktfXhXzjFPH3HjCotsOwmQTVDA8l0
         gjD/Z4uZzKHkCdKd3BNzuQJmB7Q9DfRAW0ahGktnjSN82tu6gv4PqmoTV3AlgLOlyKuc
         6IBZVvwmUxcNVp7R7jffkajJJ+zkjzv5tDqUOF1T5nSwKNnjNM2SgyOX8K00QwAi1bgc
         Erw59J3CsGcez1aij05fj5rZyBfU1WeVpRzP0nqIcdIAXIqmyHpdD5wjJv6r9e/fnJ7q
         aikwFzgEPc1vZItjpF0a/oJem0uV5SoEeFOi4V8v67Hi8Bd34DL3CrZRnih6QCISIU59
         xLFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787288740; x=1787893540; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jmpe1hLDj+ivkEpS/rwgGGC0+pP/wOQo/9NrjqshOdY=;
        b=FjqLmgaYkaeYrgtkq+iXueAa3BjnJBW8bEbZbBc5ZzULq1R5dGlNePtc6+lqTQsTFA
         fquwHeZHPqMM9ZIAuBzYi/DpfXQb5cOsCN8m6rCtBCHgrSLDxQuh/gwDllDTcCJNUO5i
         AbBlWCh66RyUmi3bTGP7uW5eu9vRARYIEYVPBCqxZ3RCu9zfJ0hurViyfGZtzKT17HPJ
         wampa/RMUTn5my/UbdfkhNR/Mz+7oFUtbeSnrMFh087T7t1msjlW7nWJz1fA4WyTzTdz
         sMbO0EAZuYa2H3t5wmHfTdXiJU7eTqVT8SgfnMM+hjoOybMzEkKz3x+ELpn9MGsGmBxb
         34wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787288740; x=1787893540;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jmpe1hLDj+ivkEpS/rwgGGC0+pP/wOQo/9NrjqshOdY=;
        b=VDtaP4uNFeP0Lyi0xq6jDvUk+V4EYpExL0CnAElY9BbmDOT18ZS2pM1VJogODAXJ0o
         lmPOkhZvtYV7eD/3j4K63uQUkL9rq1jphTNbKQNOSyK3xUlJ2Mrlk6RxfOaIb2X1kGMy
         jLqS+4CvnzaYXZGGjgvoE9PHF7K2UBo+yFhP+nrbj7LT1Tr0dHcCQ2iyzs+8uS8bfevM
         lNRouapmuDYv+4ok4SOHbHdfTdZGfiKvHPsfOegDim8qC/V0GvYflSJ2aul5u46gCqDS
         bKNC5ROWDtufGKeDXLrcDln+ln712vRzYl1Oy1g2jK8dcJBUk6WMEmDygIeYN9VznSYU
         +wPQ==
X-Forwarded-Encrypted: i=1; AHgh+RqledVU2tdI4FMy79pMR1hkcqpd0zSJu81Sci3AM4cBWoCZI1ZsYNa3X2O1f8uEvIYZ3dmRVm2TOGoX@vger.kernel.org
X-Gm-Message-State: AFuF++nS1ZB37BGEPOt4egPu0ZYA6mLxcEFWHenJFt9zDyg2arOle5Pt
	f1MtNdEU7d9yTICGcHl2lt3dEFDbkftYkg0hf2eupR6LCj0pTzbP+wKchMMDJ3l597h5Mq5z63R
	xMns4RyF/jnDLwljzK73j4jNd/a+JxGU=
X-Gm-Gg: AR+sD13QST8ftxh5aydmfVdV3hqJem4l87B6m0Tt8LmAPon3vAXr54gxxwgLYvHeW6/
	FZmxuyPeW+GFS+BkUGe9ab+wjnBScEjbWcSeDby8WvhaaOLzwvbcuEwlxPdRIf1wd5WVSIh9/7D
	rcHcLMqSAV6hrxauC7AUohlV8YeNAvAJ7oFohe+RbaLsq4db9jXQ9W+tNDI67oQtvHhXTmTKjUP
	e4dtrkYkeEQOyHqb9vDEVmKAPBqvbaArmb+5vAh6r0QGQ+XcvPNWtozqVXJ0p2TtDySAZu9id/A
	cvXMMsVcUV8rRYRgc7QucCPo5v0oGBpu4j+MbjOaZKc1fmRApA0lo1W6lL9IE5gDm4Q0higctEl
	9p4mFCu6j8d6dnGJQPwH9xQcazcx1JsargB76Nm0WEWmpehfsSWem8+TvunQsXcxQCrfPidwqlT
	YIy7XegXXAJIV8K8QNugr1gYbIELLZG1Z6iTGA
X-Received: by 2002:a05:6102:918:b0:631:4cd8:b6aa with SMTP id
 ada2fe7eead31-77a64967e23mr1341131137.13.1787288739824; Thu, 20 Aug 2026
 22:05:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-submit-phy-package-fwdevlink-v1-v3-0-40a905ea16b6@gmail.com>
 <20260818-submit-phy-package-fwdevlink-v1-v3-4-40a905ea16b6@gmail.com> <CACRMN=fEPoyEk1oi4QRMX0whMEF=xQv=kkd62bueKTKWtxDedA@mail.gmail.com>
In-Reply-To: <CACRMN=fEPoyEk1oi4QRMX0whMEF=xQv=kkd62bueKTKWtxDedA@mail.gmail.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 20 Aug 2026 23:05:26 -0600
X-Gm-Features: AcwNN1WnNGJFLiVo-5aREZYCSGGRQv4DiRxF1nYUywpficcXa1v1D-Q8X9NWFa0
Message-ID: <CADvTj4qN=juV2j+iNAzpou70fOLZpkF-OjjF=sTDVisNwS81fw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/4] driver core: handle managed links for
 class devices
To: Saravana Kannan <saravanak@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
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

On Thu, Aug 20, 2026 at 10:27=E2=80=AFPM Saravana Kannan <saravanak@kernel.=
org> wrote:
>
> On Mon, Aug 17, 2026 at 11:59=E2=80=AFPM James Hilliard
> <james.hilliard1@gmail.com> wrote:
> >
> > fw_devlink deliberately lets the nearest device pick up dependencies be=
low
> > class-backed firmware nodes because driverless class devices do not
> > currently progress through managed device-link states. This can leave
> > consumers of class suppliers dormant, while sync-state-only links from
> > class consumers never reach the successful-probe cleanup.
> >
> > Track class-only devices through equivalent registration and removal
> > transitions. Mark them probing before device_add() publishes them, comp=
lete
> > their incoming and outgoing links after class interfaces run, and enter=
 the
> > unbind and no-driver states during device_del(). Preserve firmware link=
s
> > below class-backed nodes so later-created descendants can acquire their=
 own
> > links.
> >
> > Include class registration in wait_for_device_probe() so supplier unbin=
d
> > cannot race a class consumer that is still being published. Transition
> > managed links which existed before device_add(), remove stale
> > waiting_for_supplier attributes and do not revive a link whose supplier=
 has
> > already started unbinding.
> >
> > During supplier teardown, wait for class registration to finish, but mo=
ve
> > an already registered class consumer directly to the unbinding link sta=
te
> > because it has no driver to release. Keep consumer-autoremove links val=
id
> > until class consumer removal without triggering driver-only cleanup
> > warnings.
> >
> > Factor the supplier-bound, consumer-bound and cleanup transitions share=
d
> > with driver-backed devices. Activate late links involving an already
> > functional class endpoint instead of trying to reprobe it, and let
> > sync-state-only links retire without forcing consumer unbind. Ordinary
> > supplier links cannot defer class registration, so they must not be the
> > only mechanism on which a class consumer relies for functionality.
> >
> > Class devices do not match drivers, so distinguish a genuinely unavaila=
ble
> > supplier from a probing or registered class endpoint before relaxing
> > inferred links. Preserve normal probe and runtime-PM ordering for those
> > links. Also recognize class-backed nodes when refreshing dependencies a=
fter
> > firmware-tree overlays.
> >
> > Exclude the internal device-link class because device-link objects are
> > registered while the device-links lock is held. Document the class-devi=
ce
> > state transitions and add KUnit coverage for supplier and consumer link=
s,
> > pre-existing links, inferred-link preservation, registration waiters an=
d a
> > concurrent supplier unbind.
> >
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> >
> > ---
> > Changes v2 -> v3:
> >   - Replace the framework-specific proxy cleanup API with generic
> >     class-device managed-link lifecycle handling, as suggested by
> >     Saravana Kannan
>
> Please add the Suggested-by tag.
>
> I'm okay with the use of AI to write patches, but it's not clear if
> you understand the existing code base enough to use it correctly? If
> not, maybe I'll take a weekend to write the patch series to add
> devlink support for class devices and you can test it? You can then
> write the networking part of the fix.

Yeah, this is not an area of the codebase that I'm super familiar with
so I'm probably not able to guide the AI as much as typical to get
this into the expected shape.

I do have pretty solid hardware in the loop test setup however so I
can certainly test a series and try to write the networking part.

> Just the class devices devlink support alone should be a long patch
> series. And should be sent to driver core next. Not net next.
>
> Thanks,
> Saravana
>
> >   - Preserve inferred links to probing and registered class suppliers i=
n
> >     no-driver fallback paths and include class nodes in overlay refresh
> >   - Cover pre-existing and inferred links, wait_for_device_probe()
> >     integration, waiting_for_supplier cleanup and supplier-unbind races
> >   - Document the limits of ordinary supplier links for driverless class
> >     consumers
> >   - Handle registered class consumers during supplier teardown without =
a
> >     no-op driver release or driver-only cleanup warning
> >   - Derive class handling inside the shared bound helpers and clarify t=
he
> >     lifecycle documentation
> > ---
> >  Documentation/driver-api/device_link.rst   |  47 ++-
> >  drivers/base/base.h                        |   2 +
> >  drivers/base/core.c                        | 270 +++++++++++-----
> >  drivers/base/dd.c                          |  21 +-
> >  drivers/base/test/Makefile                 |   1 +
> >  drivers/base/test/device-link-class-test.c | 479 +++++++++++++++++++++=
++++++++
> >  include/linux/device.h                     |   9 +-
> >  7 files changed, 739 insertions(+), 90 deletions(-)
> >
> > diff --git a/Documentation/driver-api/device_link.rst b/Documentation/d=
river-api/device_link.rst
> > index ee913ae16371..c248ec9fa9f8 100644
> > --- a/Documentation/driver-api/device_link.rst
> > +++ b/Documentation/driver-api/device_link.rst
> > @@ -253,6 +253,18 @@ child one.
> >  State machine
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > +Driverless class devices participate in the managed-link state machine=
 as
> > +supplier and consumer endpoints, including as consumers of sync-state-=
only
> > +proxy links.  Their registration is treated like a successful driver p=
robe:
> > +links are completed after :c:func:`device_add()` has finished running =
class
> > +interfaces.  During removal, driver-backed consumers are unbound befor=
e the
> > +class device is deleted and its links return to the no-driver state.
> > +
> > +Class devices are not probed, so an ordinary supplier link cannot defe=
r their
> > +registration in the way that it defers a driver probe.  Frameworks mus=
t not use
> > +such a link as the only mechanism guaranteeing that a class consumer's
> > +supplier is functional.
> > +
> >  .. kernel-doc:: include/linux/device.h
> >     :functions: device_link_state
> >
> > @@ -271,10 +283,13 @@ State machine
> >    and consumer.  If the link is created before any devices are probed,=
 it
> >    is set to ``DL_STATE_DORMANT``.
> >
> > -* When a supplier device is bound to a driver, links to its consumers
> > -  progress to ``DL_STATE_AVAILABLE``.
> > -  (Call to :c:func:`device_links_driver_bound()` from
> > -  :c:func:`driver_bound()`.)
> > +* When a supplier device is bound to a driver, links to its consumers =
progress
> > +  to ``DL_STATE_AVAILABLE``.  Registering a driverless class supplier =
performs
> > +  the equivalent transition, or activates a late link whose consumer i=
s
> > +  already functional.
> > +  The driver-backed path calls :c:func:`device_links_driver_bound()` f=
rom
> > +  :c:func:`driver_bound()`, while the class-device completion path per=
forms
> > +  the equivalent transition from :c:func:`device_add()`.
> >
> >  * Before a consumer device is probed, presence of supplier drivers is
> >    verified by checking the consumer device is not in the wait_for_supp=
liers
> > @@ -286,17 +301,28 @@ State machine
> >    (Call to :c:func:`wait_for_device_probe()` from
> >    :c:func:`device_links_unbind_consumers()`.)
> >
> > +  Registering a driverless class consumer similarly moves existing ava=
ilable
> > +  links to ``DL_STATE_CONSUMER_PROBE`` before publishing the device, a=
nd its
> > +  registration participates in :c:func:`wait_for_device_probe()`.  Unl=
ike a
> > +  driver probe, class registration is not deferred for unavailable sup=
pliers.
> > +
> >  * If the probe fails, links to suppliers revert back to ``DL_STATE_AVA=
ILABLE``.
> >    (Call to :c:func:`device_links_no_driver()` from :c:func:`really_pro=
be()`.)
> >
> >  * If the probe succeeds, links to suppliers progress to ``DL_STATE_ACT=
IVE``.
> > -  (Call to :c:func:`device_links_driver_bound()` from :c:func:`driver_=
bound()`.)
> > +  A driverless class consumer activates usable incoming links when its
> > +  registration completes, drops sync-state-only proxy links and preser=
ves
> > +  links whose suppliers are dormant or unbinding.  The driver-backed p=
ath
> > +  calls :c:func:`device_links_driver_bound()` from :c:func:`driver_bou=
nd()`,
> > +  while :c:func:`device_add()` performs the equivalent class-device
> > +  transition.
> >
> >  * When the consumer's driver is later on removed, links to suppliers r=
evert
> >    back to ``DL_STATE_AVAILABLE``.
> >    (Call to :c:func:`__device_links_no_driver()` from
> >    :c:func:`device_links_driver_cleanup()`, which in turn is called fro=
m
> > -  :c:func:`__device_release_driver()`.)
> > +  :c:func:`__device_release_driver()`.)  Removing a driverless class c=
onsumer
> > +  performs the equivalent cleanup from :c:func:`device_del()`.
> >
> >  * Before a supplier's driver is removed, links to consumers that are n=
ot
> >    bound to a driver are updated to ``DL_STATE_SUPPLIER_UNBIND``.
> > @@ -305,14 +331,17 @@ State machine
> >    This prevents the consumers from binding.
> >    (Call to :c:func:`device_links_check_suppliers()` from
> >    :c:func:`really_probe()`.)
> > -  Consumers that are bound are freed from their driver; consumers that=
 are
> > -  probing are waited for until they are done.
> > +  Driver-backed consumers that are bound are freed from their driver;
> > +  driverless class consumers remain registered and their links move di=
rectly
> > +  to ``DL_STATE_SUPPLIER_UNBIND``.  Consumers that are probing or bein=
g
> > +  registered as class devices are waited for until they are done.
> >    (Call to :c:func:`device_links_unbind_consumers()` from
> >    :c:func:`__device_release_driver()`.)
> >    Once all links to consumers are in ``DL_STATE_SUPPLIER_UNBIND`` stat=
e,
> >    the supplier driver is released and the links revert to ``DL_STATE_D=
ORMANT``.
> >    (Call to :c:func:`device_links_driver_cleanup()` from
> > -  :c:func:`__device_release_driver()`.)
> > +  :c:func:`__device_release_driver()`.)  Removing a driverless class s=
upplier
> > +  follows the same sequence from :c:func:`device_del()`.
> >
> >  API
> >  =3D=3D=3D
> > diff --git a/drivers/base/base.h b/drivers/base/base.h
> > index a5b7abc10ff0..8bdf0a709401 100644
> > --- a/drivers/base/base.h
> > +++ b/drivers/base/base.h
> > @@ -166,6 +166,8 @@ void device_release_driver_internal(struct device *=
dev, const struct device_driv
> >  void driver_detach(const struct device_driver *drv);
> >  void driver_deferred_probe_del(struct device *dev);
> >  void device_set_deferred_probe_reason(const struct device *dev, struct=
 va_format *vaf);
> > +void device_probe_begin(void);
> > +void device_probe_end(void);
> >  static inline int driver_match_device(const struct device_driver *drv,
> >                                       struct device *dev)
> >  {
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index d2f9ff65138c..0c26ba38e6cf 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -213,10 +213,10 @@ static void __fwnode_links_move_consumers(struct =
fwnode_handle *from,
> >   * @fwnode: fwnode from which to pick up dangling consumers
> >   * @new_sup: fwnode of new supplier
> >   *
> > - * If the @fwnode has a corresponding struct device and the device sup=
ports
> > - * probing (that is, added to a bus), then we want to let fw_devlink c=
reate
> > - * MANAGED device links to this device, so leave @fwnode and its desce=
ndant's
> > - * fwnode links alone.
> > + * If the @fwnode has a corresponding struct device whose device-link =
state is
> > + * managed by the driver core (that is, a bus or class device), then w=
e want to
> > + * let fw_devlink create MANAGED device links to this device, so leave=
 @fwnode
> > + * and its descendants' fwnode links alone.
> >   *
> >   * Otherwise, move its consumers to the new supplier @new_sup.
> >   */
> > @@ -225,7 +225,7 @@ static void __fw_devlink_pickup_dangling_consumers(=
struct fwnode_handle *fwnode,
> >  {
> >         struct fwnode_handle *child;
> >
> > -       if (fwnode->dev && fwnode->dev->bus)
> > +       if (fwnode->dev && (fwnode->dev->bus || fwnode->dev->class))
> >                 return;
> >
> >         fwnode_set_flag(fwnode, FWNODE_FLAG_NOT_DEVICE);
> > @@ -259,7 +259,7 @@ void fw_devlink_refresh_fwnode(struct fwnode_handle=
 *fwnode)
> >
> >         /*
> >          * Find the closest ancestor fwnode that has been converted to =
a device
> > -        * that can bind to a driver (bus device).
> > +        * whose managed-link lifecycle is handled by the driver core.
> >          */
> >         fwnode_handle_get(fwnode);
> >         do {
> > @@ -270,15 +270,15 @@ void fw_devlink_refresh_fwnode(struct fwnode_hand=
le *fwnode)
> >                 if (!dev)
> >                         continue;
> >
> > -               if (dev->bus)
> > +               if (dev->bus || dev->class)
> >                         break;
> >
> >                 put_device(dev);
> >         } while ((fwnode =3D fwnode_get_next_parent(fwnode)));
> >
> >         /*
> > -        * If none of the ancestor fwnodes have (yet) been converted to=
 a device
> > -        * that can bind to a driver, there's nothing to fix up.
> > +        * If none of the ancestor fwnodes have (yet) been converted to=
 such a
> > +        * device, there's nothing to fix up.
> >          */
> >         if (!fwnode)
> >                 return;
> > @@ -287,10 +287,9 @@ void fw_devlink_refresh_fwnode(struct fwnode_handl=
e *fwnode)
> >              "Don't multithread overlaying and probing the same device!=
\n");
> >
> >         /*
> > -        * If the device has already bound to a driver, then we need to=
 redo
> > -        * some of the work that was done after the device was bound to=
 a
> > -        * driver. If the device hasn't bound to a driver, running thin=
gs too
> > -        * soon would incorrectly pick up consumers that it shouldn't.
> > +        * If the device's managed links are available, redo some of th=
e work
> > +        * performed when it reached that state. Running this too soon =
would
> > +        * incorrectly pick up consumers that it shouldn't.
> >          */
> >         if (dev->links.status =3D=3D DL_DEV_DRIVER_BOUND) {
> >                 fw_devlink_pickup_dangling_consumers(dev);
> > @@ -1088,6 +1087,12 @@ static bool dev_is_best_effort(struct device *de=
v)
> >                 (dev->fwnode && fwnode_test_flag(dev->fwnode, FWNODE_FL=
AG_BEST_EFFORT));
> >  }
> >
> > +static bool dev_is_unmatchable(const struct device *dev)
> > +{
> > +       return READ_ONCE(dev->links.status) =3D=3D DL_DEV_NO_DRIVER &&
> > +              !dev_can_match(dev);
> > +}
> > +
> >  static struct fwnode_handle *fwnode_links_check_suppliers(
> >                                                 struct fwnode_handle *f=
wnode)
> >  {
> > @@ -1152,7 +1157,7 @@ int device_links_check_suppliers(struct device *d=
ev)
> >
> >                         if (dev_is_best_effort(dev) &&
> >                             device_link_test(link, DL_FLAG_INFERRED) &&
> > -                           !dev_can_match(link->supplier)) {
> > +                           dev_is_unmatchable(link->supplier)) {
> >                                 ret =3D -EAGAIN;
> >                                 continue;
> >                         }
> > @@ -1307,6 +1312,33 @@ static void device_link_drop_managed(struct devi=
ce_link *link)
> >         kref_put(&link->kref, __device_link_del);
> >  }
> >
> > +static bool device_links_track_class(const struct device *dev)
> > +{
> > +       /* Device-link objects are class devices registered with the lo=
ck held. */
> > +       return dev->class && !dev->bus && dev->class !=3D &devlink_clas=
s;
> > +}
> > +
> > +static void device_links_class_start(struct device *dev)
> > +{
> > +       struct device_link *link;
> > +
> > +       device_probe_begin();
> > +       device_links_write_lock();
> > +       WARN_ON(dev->links.status !=3D DL_DEV_NO_DRIVER);
> > +       list_for_each_entry(link, &dev->links.suppliers, c_node) {
> > +               if (!device_link_test(link, DL_FLAG_MANAGED))
> > +                       continue;
> > +
> > +               /* Do not revive a link whose supplier is already unbin=
ding. */
> > +               if (link->status =3D=3D DL_STATE_AVAILABLE ||
> > +                   (device_link_test(link, DL_FLAG_SYNC_STATE_ONLY) &&
> > +                    link->status !=3D DL_STATE_SUPPLIER_UNBIND))
> > +                       WRITE_ONCE(link->status, DL_STATE_CONSUMER_PROB=
E);
> > +       }
> > +       dev->links.status =3D DL_DEV_PROBING;
> > +       device_links_write_unlock();
> > +}
> > +
> >  static ssize_t waiting_for_supplier_show(struct device *dev,
> >                                          const struct device_attribute =
*attr,
> >                                          char *buf)
> > @@ -1356,43 +1388,11 @@ void device_links_force_bind(struct device *dev=
)
> >         device_links_write_unlock();
> >  }
> >
> > -/**
> > - * device_links_driver_bound - Update device links after probing its d=
river.
> > - * @dev: Device to update the links for.
> > - *
> > - * The probe has been successful, so update links from this device to =
any
> > - * consumers by changing their status to "available".
> > - *
> > - * Also change the status of @dev's links to suppliers to "active".
> > - *
> > - * Links without the DL_FLAG_MANAGED flag set are ignored.
> > - */
> > -void device_links_driver_bound(struct device *dev)
> > +static void __device_links_supplier_bound(struct device *dev,
> > +                                         struct list_head *sync_list)
> >  {
> > -       struct device_link *link, *ln;
> > -       LIST_HEAD(sync_list);
> > -
> > -       /*
> > -        * If a device binds successfully, it's expected to have create=
d all
> > -        * the device links it needs to or make new device links as it =
needs
> > -        * them. So, fw_devlink no longer needs to create device links =
to any
> > -        * of the device's suppliers.
> > -        *
> > -        * Also, if a child firmware node of this bound device is not a=
dded as a
> > -        * device by now, assume it is never going to be added. Make th=
is bound
> > -        * device the fallback supplier to the dangling consumers of th=
e child
> > -        * firmware node because this bound device is probably implemen=
ting the
> > -        * child firmware node functionality and we don't want the dang=
ling
> > -        * consumers to defer probe indefinitely waiting for a device f=
or the
> > -        * child firmware node.
> > -        */
> > -       if (dev->fwnode && dev->fwnode->dev =3D=3D dev) {
> > -               fwnode_links_purge_suppliers(dev->fwnode);
> > -               fw_devlink_pickup_dangling_consumers(dev);
> > -       }
> > -       device_remove_file(dev, &dev_attr_waiting_for_supplier);
> > -
> > -       device_links_write_lock();
> > +       struct device_link *link;
> > +       bool class_device =3D device_links_track_class(dev);
> >
> >         list_for_each_entry(link, &dev->links.consumers, s_node) {
> >                 if (!device_link_test(link, DL_FLAG_MANAGED))
> > @@ -1409,16 +1409,35 @@ void device_links_driver_bound(struct device *d=
ev)
> >                         continue;
> >
> >                 WARN_ON(link->status !=3D DL_STATE_DORMANT);
> > -               WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
> > +               /*
> > +                * A class interface can add a link from an already-bou=
nd consumer
> > +                * while the class supplier is being registered.  Likew=
ise, a class
> > +                * consumer has no driver probe to retry when a late su=
pplier binds.
> > +                * Those consumers are already functional, so activate =
their links.
> > +                */
> > +               if ((class_device ||
> > +                    device_links_track_class(link->consumer)) &&
> > +                   link->consumer->links.status =3D=3D DL_DEV_DRIVER_B=
OUND) {
> > +                       WRITE_ONCE(link->status, DL_STATE_ACTIVE);
> > +               } else {
> > +                       WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
> >
> > -               if (device_link_test(link, DL_FLAG_AUTOPROBE_CONSUMER))
> > -                       driver_deferred_probe_add(link->consumer);
> > +                       if (device_link_test(link, DL_FLAG_AUTOPROBE_CO=
NSUMER))
> > +                               driver_deferred_probe_add(link->consume=
r);
> > +               }
> >         }
> >
> >         if (defer_sync_state_count)
> >                 __device_links_supplier_defer_sync(dev);
> >         else
> > -               __device_links_queue_sync_state(dev, &sync_list);
> > +               __device_links_queue_sync_state(dev, sync_list);
> > +}
> > +
> > +static void __device_links_consumer_bound(struct device *dev,
> > +                                         struct list_head *sync_list)
> > +{
> > +       struct device_link *link, *ln;
> > +       bool class_device =3D device_links_track_class(dev);
> >
> >         list_for_each_entry_safe(link, ln, &dev->links.suppliers, c_nod=
e) {
> >                 struct device *supplier;
> > @@ -1431,13 +1450,13 @@ void device_links_driver_bound(struct device *d=
ev)
> >                         /*
> >                          * When DL_FLAG_SYNC_STATE_ONLY is set, it mean=
s no
> >                          * other DL_MANAGED_LINK_FLAGS have been set. S=
o, it's
> > -                        * save to drop the managed link completely.
> > +                        * safe to drop the managed link completely.
> >                          */
> >                         device_link_drop_managed(link);
> > -               } else if (dev_is_best_effort(dev) &&
> > +               } else if (!class_device && dev_is_best_effort(dev) &&
> >                            device_link_test(link, DL_FLAG_INFERRED) &&
> >                            link->status !=3D DL_STATE_CONSUMER_PROBE &&
> > -                          !dev_can_match(link->supplier)) {
> > +                          dev_is_unmatchable(link->supplier)) {
> >                         /*
> >                          * When dev_is_best_effort() is true, we ignore=
 device
> >                          * links to suppliers that don't have a driver.=
  If the
> > @@ -1446,9 +1465,17 @@ void device_links_driver_bound(struct device *de=
v)
> >                          * (consumer probed before supplier). So delete=
 it.
> >                          */
> >                         device_link_drop_managed(link);
> > -               } else {
> > +               } else if (!class_device) {
> >                         WARN_ON(link->status !=3D DL_STATE_CONSUMER_PRO=
BE);
> >                         WRITE_ONCE(link->status, DL_STATE_ACTIVE);
> > +               } else if (link->status =3D=3D DL_STATE_CONSUMER_PROBE =
||
> > +                          link->status =3D=3D DL_STATE_AVAILABLE) {
> > +                       WRITE_ONCE(link->status, DL_STATE_ACTIVE);
> > +               } else {
> > +                       WARN_ON(link->status !=3D DL_STATE_ACTIVE &&
> > +                               link->status !=3D DL_STATE_DORMANT &&
> > +                               link->status !=3D DL_STATE_SUPPLIER_UNB=
IND);
> > +                       continue;
> >                 }
> >
> >                 /*
> > @@ -1460,10 +1487,67 @@ void device_links_driver_bound(struct device *d=
ev)
> >                 if (defer_sync_state_count)
> >                         __device_links_supplier_defer_sync(supplier);
> >                 else
> > -                       __device_links_queue_sync_state(supplier, &sync=
_list);
> > +                       __device_links_queue_sync_state(supplier, sync_=
list);
> >         }
> >
> >         dev->links.status =3D DL_DEV_DRIVER_BOUND;
> > +}
> > +
> > +static void device_links_class_bound(struct device *dev)
> > +{
> > +       LIST_HEAD(sync_list);
> > +
> > +       device_remove_file(dev, &dev_attr_waiting_for_supplier);
> > +
> > +       device_links_write_lock();
> > +       __device_links_supplier_bound(dev, &sync_list);
> > +       __device_links_consumer_bound(dev, &sync_list);
> > +       device_links_write_unlock();
> > +
> > +       device_links_flush_sync_list(&sync_list, NULL);
> > +       driver_deferred_probe_trigger();
> > +       device_probe_end();
> > +}
> > +
> > +/**
> > + * device_links_driver_bound - Update device links after probing its d=
river.
> > + * @dev: Device to update the links for.
> > + *
> > + * The probe has been successful, so update links from this device to =
any
> > + * consumers by changing their status to "available".
> > + *
> > + * Also change the status of @dev's links to suppliers to "active".
> > + *
> > + * Links without the DL_FLAG_MANAGED flag set are ignored.
> > + */
> > +void device_links_driver_bound(struct device *dev)
> > +{
> > +       LIST_HEAD(sync_list);
> > +
> > +       /*
> > +        * If a device binds successfully, it's expected to have create=
d all
> > +        * the device links it needs to or make new device links as it =
needs
> > +        * them. So, fw_devlink no longer needs to create device links =
to any
> > +        * of the device's suppliers.
> > +        *
> > +        * Also, if a child firmware node of this bound device is not a=
dded as a
> > +        * device by now, assume it is never going to be added. Make th=
is bound
> > +        * device the fallback supplier to the dangling consumers of th=
e child
> > +        * firmware node because this bound device is probably implemen=
ting the
> > +        * child firmware node functionality and we don't want the dang=
ling
> > +        * consumers to defer probe indefinitely waiting for a device f=
or the
> > +        * child firmware node.
> > +        */
> > +       if (dev->fwnode && dev->fwnode->dev =3D=3D dev) {
> > +               fwnode_links_purge_suppliers(dev->fwnode);
> > +               fw_devlink_pickup_dangling_consumers(dev);
> > +       }
> > +
> > +       device_remove_file(dev, &dev_attr_waiting_for_supplier);
> > +
> > +       device_links_write_lock();
> > +       __device_links_supplier_bound(dev, &sync_list);
> > +       __device_links_consumer_bound(dev, &sync_list);
> >
> >         device_links_write_unlock();
> >
> > @@ -1548,17 +1632,7 @@ void device_links_no_driver(struct device *dev)
> >         device_links_write_unlock();
> >  }
> >
> > -/**
> > - * device_links_driver_cleanup - Update links after driver removal.
> > - * @dev: Device whose driver has just gone away.
> > - *
> > - * Update links to consumers for @dev by changing their status to "dor=
mant" and
> > - * invoke %__device_links_no_driver() to update links to suppliers for=
 it as
> > - * appropriate.
> > - *
> > - * Links without the DL_FLAG_MANAGED flag set are ignored.
> > - */
> > -void device_links_driver_cleanup(struct device *dev)
> > +static void device_links_cleanup(struct device *dev)
> >  {
> >         struct device_link *link, *ln;
> >
> > @@ -1568,7 +1642,8 @@ void device_links_driver_cleanup(struct device *d=
ev)
> >                 if (!device_link_test(link, DL_FLAG_MANAGED))
> >                         continue;
> >
> > -               WARN_ON(device_link_test(link, DL_FLAG_AUTOREMOVE_CONSU=
MER));
> > +               WARN_ON(device_link_test(link, DL_FLAG_AUTOREMOVE_CONSU=
MER) &&
> > +                       !device_links_track_class(link->consumer));
> >                 WARN_ON(link->status !=3D DL_STATE_SUPPLIER_UNBIND);
> >
> >                 /*
> > @@ -1589,6 +1664,21 @@ void device_links_driver_cleanup(struct device *=
dev)
> >         device_links_write_unlock();
> >  }
> >
> > +/**
> > + * device_links_driver_cleanup - Update links after driver removal.
> > + * @dev: Device whose driver has just gone away.
> > + *
> > + * Update links to consumers for @dev by changing their status to "dor=
mant" and
> > + * invoke %__device_links_no_driver() to update links to suppliers for=
 it as
> > + * appropriate.
> > + *
> > + * Links without the DL_FLAG_MANAGED flag set are ignored.
> > + */
> > +void device_links_driver_cleanup(struct device *dev)
> > +{
> > +       device_links_cleanup(dev);
> > +}
> > +
> >  /**
> >   * device_links_busy - Check if there are any busy links to consumers.
> >   * @dev: Device to check.
> > @@ -1599,7 +1689,9 @@ void device_links_driver_cleanup(struct device *d=
ev)
> >   * state to "supplier unbind" to prevent the consumer from being probe=
d
> >   * successfully going forward.
> >   *
> > - * Return 'false' if there are no probing or active consumers.
> > + * Sync-state-only links are moved to "supplier unbind" without making=
 the
> > + * supplier busy, since they do not require the consumer to be unbound=
.
> > + * Return 'false' if there are no other probing or active consumers.
> >   *
> >   * Links without the DL_FLAG_MANAGED flag set are ignored.
> >   */
> > @@ -1613,6 +1705,11 @@ bool device_links_busy(struct device *dev)
> >         list_for_each_entry(link, &dev->links.consumers, s_node) {
> >                 if (!device_link_test(link, DL_FLAG_MANAGED))
> >                         continue;
> > +               /* Sync-state-only links do not require consumer unbind=
ing. */
> > +               if (device_link_test(link, DL_FLAG_SYNC_STATE_ONLY)) {
> > +                       WRITE_ONCE(link->status, DL_STATE_SUPPLIER_UNBI=
ND);
> > +                       continue;
> > +               }
> >
> >                 if (link->status =3D=3D DL_STATE_CONSUMER_PROBE
> >                     || link->status =3D=3D DL_STATE_ACTIVE) {
> > @@ -1668,6 +1765,10 @@ void device_links_unbind_consumers(struct device=
 *dev)
> >                 if (status =3D=3D DL_STATE_ACTIVE) {
> >                         struct device *consumer =3D link->consumer;
> >
> > +                       /* Class consumers have no driver to release. *=
/
> > +                       if (device_links_track_class(consumer))
> > +                               continue;
> > +
> >                         get_device(consumer);
> >
> >                         device_links_write_unlock();
> > @@ -1826,7 +1927,7 @@ static int fw_devlink_no_driver(struct device *de=
v, void *data)
> >  {
> >         struct device_link *link =3D to_devlink(dev);
> >
> > -       if (!dev_can_match(link->supplier))
> > +       if (dev_is_unmatchable(link->supplier))
> >                 fw_devlink_relax_link(link);
> >
> >         return 0;
> > @@ -3704,6 +3805,7 @@ int device_add(struct device *dev)
> >         struct device *parent;
> >         struct kobject *kobj;
> >         struct class_interface *class_intf;
> > +       bool track_class_links =3D false;
> >         int error =3D -EINVAL;
> >         struct kobject *glue_dir =3D NULL;
> >
> > @@ -3737,6 +3839,10 @@ int device_add(struct device *dev)
> >         if (error)
> >                 goto name_error;
> >
> > +       track_class_links =3D device_links_track_class(dev);
> > +       if (track_class_links)
> > +               device_links_class_start(dev);
> > +
> >         pr_debug("device: '%s': %s\n", dev_name(dev), __func__);
> >
> >         parent =3D get_device(dev->parent);
> > @@ -3838,7 +3944,7 @@ int device_add(struct device *dev)
> >          * match with any driver, don't block its consumers from probin=
g in
> >          * case the consumer device is able to operate without this sup=
plier.
> >          */
> > -       if (dev->fwnode && fw_devlink_drv_reg_done && !dev_can_match(de=
v))
> > +       if (dev->fwnode && fw_devlink_drv_reg_done && dev_is_unmatchabl=
e(dev))
> >                 fw_devlink_unblock_consumers(dev);
> >
> >         if (parent)
> > @@ -3858,6 +3964,8 @@ int device_add(struct device *dev)
> >                 mutex_unlock(&sp->mutex);
> >                 subsys_put(sp);
> >         }
> > +       if (track_class_links)
> > +               device_links_class_bound(dev);
> >  done:
> >         put_device(dev);
> >         return error;
> > @@ -3886,6 +3994,10 @@ int device_add(struct device *dev)
> >  parent_error:
> >         put_device(parent);
> >  name_error:
> > +       if (track_class_links) {
> > +               device_links_no_driver(dev);
> > +               device_probe_end();
> > +       }
> >         kfree(dev->p);
> >         dev->p =3D NULL;
> >         goto done;
> > @@ -3980,9 +4092,17 @@ void device_del(struct device *dev)
> >         struct device *parent =3D dev->parent;
> >         struct kobject *glue_dir =3D NULL;
> >         struct class_interface *class_intf;
> > +       bool track_class_links =3D device_links_track_class(dev);
> >         unsigned int noio_flag;
> >
> >         device_lock(dev);
> > +       if (track_class_links) {
> > +               while (device_links_busy(dev)) {
> > +                       device_unlock(dev);
> > +                       device_links_unbind_consumers(dev);
> > +                       device_lock(dev);
> > +               }
> > +       }
> >         kill_device(dev);
> >         device_unlock(dev);
> >
> > @@ -4024,6 +4144,8 @@ void device_del(struct device *dev)
> >         device_pm_remove(dev);
> >         driver_deferred_probe_del(dev);
> >         device_platform_notify_remove(dev);
> > +       if (track_class_links)
> > +               device_links_cleanup(dev);
> >         device_links_purge(dev);
> >
> >         /*
> > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > index 60c005223844..61288fcceb5b 100644
> > --- a/drivers/base/dd.c
> > +++ b/drivers/base/dd.c
> > @@ -555,9 +555,21 @@ int device_bind_driver(struct device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(device_bind_driver);
> >
> > +/* Driver probes and driverless class-device registrations in progress=
. */
> >  static atomic_t probe_count =3D ATOMIC_INIT(0);
> >  static DECLARE_WAIT_QUEUE_HEAD(probe_waitqueue);
> >
> > +void device_probe_begin(void)
> > +{
> > +       atomic_inc(&probe_count);
> > +}
> > +
> > +void device_probe_end(void)
> > +{
> > +       atomic_dec(&probe_count);
> > +       wake_up_all(&probe_waitqueue);
> > +}
> > +
> >  static ssize_t state_synced_store(struct device *dev,
> >                                   struct device_attribute *attr,
> >                                   const char *buf, size_t count)
> > @@ -797,7 +809,7 @@ static int really_probe_debug(struct device *dev, c=
onst struct device_driver *dr
> >
> >  /**
> >   * driver_probe_done
> > - * Determine if the probe sequence is finished or not.
> > + * Determine if the probe and class-device registration sequence is fi=
nished.
> >   *
> >   * Should somehow figure out how to use a semaphore, not an atomic var=
iable...
> >   */
> > @@ -811,7 +823,7 @@ bool __init driver_probe_done(void)
> >
> >  /**
> >   * wait_for_device_probe
> > - * Wait for device probing to be completed.
> > + * Wait for device probing and driverless class registration to be com=
pleted.
> >   */
> >  void wait_for_device_probe(void)
> >  {
> > @@ -894,7 +906,7 @@ static int driver_probe_device(const struct device_=
driver *drv, struct device *d
> >         int trigger_count =3D atomic_read(&deferred_trigger_count);
> >         int ret;
> >
> > -       atomic_inc(&probe_count);
> > +       device_probe_begin();
> >         ret =3D __driver_probe_device(drv, dev);
> >         if (ret =3D=3D -EPROBE_DEFER || ret =3D=3D EPROBE_DEFER) {
> >                 driver_deferred_probe_add(dev);
> > @@ -906,8 +918,7 @@ static int driver_probe_device(const struct device_=
driver *drv, struct device *d
> >                     !defer_all_probes)
> >                         driver_deferred_probe_trigger();
> >         }
> > -       atomic_dec(&probe_count);
> > -       wake_up_all(&probe_waitqueue);
> > +       device_probe_end();
> >         return ret;
> >  }
> >
> > diff --git a/drivers/base/test/Makefile b/drivers/base/test/Makefile
> > index d871a71dbbaa..c33c615eaabf 100644
> > --- a/drivers/base/test/Makefile
> > +++ b/drivers/base/test/Makefile
> > @@ -3,6 +3,7 @@ obj-$(CONFIG_TEST_ASYNC_DRIVER_PROBE)   +=3D test_async=
_driver_probe.o
> >
> >  obj-$(CONFIG_DM_KUNIT_TEST)    +=3D root-device-test.o
> >  obj-$(CONFIG_DM_KUNIT_TEST)    +=3D platform-device-test.o
> > +obj-$(CONFIG_DM_KUNIT_TEST)    +=3D device-link-class-test.o
> >  obj-$(CONFIG_DM_KUNIT_TEST)    +=3D fwnode-link-test.o
> >
> >  obj-$(CONFIG_DRIVER_PE_KUNIT_TEST) +=3D property-entry-test.o
> > diff --git a/drivers/base/test/device-link-class-test.c b/drivers/base/=
test/device-link-class-test.c
> > new file mode 100644
> > index 000000000000..7d52efb55aa5
> > --- /dev/null
> > +++ b/drivers/base/test/device-link-class-test.c
> > @@ -0,0 +1,479 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <kunit/platform_device.h>
> > +#include <kunit/resource.h>
> > +#include <kunit/test.h>
> > +
> > +#include <linux/completion.h>
> > +#include <linux/device.h>
> > +#include <linux/device/driver.h>
> > +#include <linux/fwnode.h>
> > +#include <linux/jiffies.h>
> > +#include <linux/kernfs.h>
> > +#include <linux/kthread.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/sched/task.h>
> > +#include <linux/slab.h>
> > +#include <linux/sysfs.h>
> > +
> > +#define TEST_CLASS_NAME                "device-link-test"
> > +#define TEST_DRIVER_NAME       "device-link-test-consumer"
> > +
> > +enum test_class_action {
> > +       TEST_CLASS_NONE,
> > +       TEST_CLASS_SUPPLIER,
> > +       TEST_CLASS_SYNC_CONSUMER,
> > +       TEST_CLASS_OBSERVE,
> > +       TEST_CLASS_WAIT,
> > +       TEST_CLASS_UNBIND_RACE,
> > +};
> > +
> > +struct device_link_class_context {
> > +       enum test_class_action action;
> > +       struct device *endpoint;
> > +       struct device_link *link;
> > +       struct completion waiter_started;
> > +       struct completion waiter_done;
> > +       struct task_struct *waiter;
> > +       struct completion unbind_started;
> > +       struct completion unbind_done;
> > +       struct task_struct *unbinder;
> > +       bool waiter_completed_during_add;
> > +       bool unbind_completed_during_add;
> > +       bool waiting_for_supplier_seen;
> > +};
> > +
> > +struct test_class_device {
> > +       struct device dev;
> > +       struct fwnode_handle fwnode;
> > +       struct fwnode_handle missing_supplier;
> > +       bool added;
> > +};
> > +
> > +static struct class *test_class;
> > +static struct device_link_class_context *test_context;
> > +static atomic_t remove_count;
> > +static atomic_t sync_count;
> > +
> > +static int test_driver_probe(struct platform_device *pdev)
> > +{
> > +       return 0;
> > +}
> > +
> > +static void test_driver_remove(struct platform_device *pdev)
> > +{
> > +       atomic_inc(&remove_count);
> > +}
> > +
> > +static void test_driver_sync_state(struct device *dev)
> > +{
> > +       atomic_inc(&sync_count);
> > +}
> > +
> > +static struct platform_driver test_driver =3D {
> > +       .probe =3D test_driver_probe,
> > +       .remove =3D test_driver_remove,
> > +       .driver =3D {
> > +               .name =3D TEST_DRIVER_NAME,
> > +               .sync_state =3D test_driver_sync_state,
> > +       },
> > +};
> > +
> > +static bool test_has_waiting_for_supplier(struct device *dev)
> > +{
> > +       struct kernfs_node *kn;
> > +
> > +       kn =3D sysfs_get_dirent(dev->kobj.sd, "waiting_for_supplier");
> > +       if (kn)
> > +               kernfs_put(kn);
> > +
> > +       return !!kn;
> > +}
> > +
> > +static int test_wait_for_probe(void *data)
> > +{
> > +       struct device_link_class_context *context =3D data;
> > +
> > +       complete(&context->waiter_started);
> > +       wait_for_device_probe();
> > +       complete(&context->waiter_done);
> > +
> > +       return 0;
> > +}
> > +
> > +static int test_unbind_supplier(void *data)
> > +{
> > +       struct device_link_class_context *context =3D data;
> > +
> > +       complete(&context->unbind_started);
> > +       device_release_driver(context->endpoint);
> > +       complete(&context->unbind_done);
> > +
> > +       return 0;
> > +}
> > +
> > +static int test_class_add(struct device *dev)
> > +{
> > +       struct device_link_class_context *context =3D test_context;
> > +
> > +       if (!context)
> > +               return 0;
> > +
> > +       switch (context->action) {
> > +       case TEST_CLASS_SUPPLIER:
> > +               context->link =3D device_link_add(context->endpoint, de=
v,
> > +                                               DL_FLAG_INFERRED |
> > +                                               DL_FLAG_AUTOPROBE_CONSU=
MER);
> > +               return context->link ? 0 : -ENOMEM;
> > +       case TEST_CLASS_SYNC_CONSUMER:
> > +               context->link =3D device_link_add(dev, context->endpoin=
t,
> > +                                               DL_FLAG_INFERRED |
> > +                                               DL_FLAG_SYNC_STATE_ONLY=
);
> > +               return context->link ? 0 : -ENOMEM;
> > +       case TEST_CLASS_OBSERVE:
> > +               context->waiting_for_supplier_seen =3D
> > +                       test_has_waiting_for_supplier(dev);
> > +               return 0;
> > +       case TEST_CLASS_WAIT:
> > +               context->waiter =3D kthread_create(test_wait_for_probe,=
 context,
> > +                                                "device-link-wait");
> > +               if (IS_ERR(context->waiter))
> > +                       return PTR_ERR(context->waiter);
> > +               get_task_struct(context->waiter);
> > +               wake_up_process(context->waiter);
> > +               wait_for_completion(&context->waiter_started);
> > +               context->waiter_completed_during_add =3D
> > +                       wait_for_completion_timeout(&context->waiter_do=
ne,
> > +                                                   msecs_to_jiffies(50=
));
> > +               return 0;
> > +       case TEST_CLASS_UNBIND_RACE:
> > +               context->link =3D device_link_add(dev, context->endpoin=
t, 0);
> > +               if (!context->link)
> > +                       return -ENOMEM;
> > +               context->unbinder =3D kthread_create(test_unbind_suppli=
er, context,
> > +                                                  "device-link-unbind"=
);
> > +               if (IS_ERR(context->unbinder))
> > +                       return PTR_ERR(context->unbinder);
> > +               get_task_struct(context->unbinder);
> > +               wake_up_process(context->unbinder);
> > +               wait_for_completion(&context->unbind_started);
> > +               context->unbind_completed_during_add =3D
> > +                       wait_for_completion_timeout(&context->unbind_do=
ne,
> > +                                                   msecs_to_jiffies(50=
));
> > +               return 0;
> > +       case TEST_CLASS_NONE:
> > +               return 0;
> > +       }
> > +
> > +       return -EINVAL;
> > +}
> > +
> > +static struct class_interface test_class_interface =3D {
> > +       .add_dev =3D test_class_add,
> > +};
> > +
> > +static void test_unregister_device(void *data)
> > +{
> > +       device_unregister(data);
> > +}
> > +
> > +static void test_resume_sync_state(void *data)
> > +{
> > +       device_links_supplier_sync_state_resume();
> > +}
> > +
> > +static struct platform_device *
> > +test_register_platform_device(struct kunit *test)
> > +{
> > +       struct platform_device_info info =3D {
> > +               .name =3D TEST_DRIVER_NAME,
> > +               .id =3D PLATFORM_DEVID_AUTO,
> > +       };
> > +       struct platform_device *pdev;
> > +
> > +       pdev =3D kunit_platform_device_register_full(test, &info);
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> > +       KUNIT_ASSERT_EQ(test, pdev->dev.links.status, DL_DEV_DRIVER_BOU=
ND);
> > +
> > +       return pdev;
> > +}
> > +
> > +static void test_class_device_release(struct device *dev)
> > +{
> > +       struct test_class_device *tdev =3D
> > +               container_of(dev, struct test_class_device, dev);
> > +
> > +       fwnode_links_purge(&tdev->fwnode);
> > +       fwnode_links_purge(&tdev->missing_supplier);
> > +       kfree(tdev);
> > +}
> > +
> > +static void test_class_device_cleanup(void *data)
> > +{
> > +       struct test_class_device *tdev =3D data;
> > +
> > +       if (tdev->added)
> > +               device_unregister(&tdev->dev);
> > +       else
> > +               put_device(&tdev->dev);
> > +}
> > +
> > +static struct test_class_device *
> > +test_class_device_alloc(struct kunit *test, const char *name)
> > +{
> > +       struct test_class_device *tdev;
> > +       int ret;
> > +
> > +       tdev =3D kzalloc_obj(*tdev);
> > +       KUNIT_ASSERT_NOT_NULL(test, tdev);
> > +
> > +       device_initialize(&tdev->dev);
> > +       fwnode_init(&tdev->fwnode, NULL);
> > +       fwnode_init(&tdev->missing_supplier, NULL);
> > +       tdev->dev.class =3D test_class;
> > +       tdev->dev.release =3D test_class_device_release;
> > +       device_set_node(&tdev->dev, &tdev->fwnode);
> > +       ret =3D dev_set_name(&tdev->dev, "%s", name);
> > +       if (ret) {
> > +               put_device(&tdev->dev);
> > +               KUNIT_FAIL(test, "failed to name class device: %d", ret=
);
> > +               return NULL;
> > +       }
> > +
> > +       ret =3D kunit_add_action_or_reset(test, test_class_device_clean=
up, tdev);
> > +       KUNIT_ASSERT_EQ(test, ret, 0);
> > +
> > +       return tdev;
> > +}
> > +
> > +static void device_link_class_supplier_test(struct kunit *test)
> > +{
> > +       struct device_link_class_context *context =3D test->priv;
> > +       struct platform_device *consumer;
> > +       struct device *supplier;
> > +       int ret;
> > +
> > +       consumer =3D test_register_platform_device(test);
> > +       context->action =3D TEST_CLASS_SUPPLIER;
> > +       context->endpoint =3D &consumer->dev;
> > +
> > +       supplier =3D device_create(test_class, NULL, 0, NULL,
> > +                                TEST_CLASS_NAME "-supplier");
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, supplier);
> > +       ret =3D kunit_add_action_or_reset(test, test_unregister_device,=
 supplier);
> > +       KUNIT_ASSERT_EQ(test, ret, 0);
> > +
> > +       KUNIT_ASSERT_NOT_NULL(test, context->link);
> > +       KUNIT_EXPECT_EQ(test, supplier->links.status, DL_DEV_DRIVER_BOU=
ND);
> > +       KUNIT_EXPECT_EQ(test, READ_ONCE(context->link->status), DL_STAT=
E_ACTIVE);
> > +       KUNIT_EXPECT_TRUE(test, device_link_test(context->link,
> > +                                                DL_FLAG_AUTOPROBE_CONS=
UMER));
> > +       KUNIT_EXPECT_FALSE(test, device_link_test(context->link,
> > +                                                 DL_FLAG_SYNC_STATE_ON=
LY));
> > +
> > +       kunit_release_action(test, test_unregister_device, supplier);
> > +       device_link_wait_removal();
> > +
> > +       KUNIT_EXPECT_EQ(test, atomic_read(&remove_count), 1);
> > +       KUNIT_EXPECT_EQ(test, consumer->dev.links.status, DL_DEV_NO_DRI=
VER);
> > +}
> > +
> > +static void device_link_class_consumer_sync_test(struct kunit *test)
> > +{
> > +       struct device_link_class_context *context =3D test->priv;
> > +       struct platform_device *supplier;
> > +       struct device *consumer;
> > +       int ret;
> > +
> > +       device_links_supplier_sync_state_pause();
> > +       ret =3D kunit_add_action_or_reset(test, test_resume_sync_state,=
 NULL);
> > +       KUNIT_ASSERT_EQ(test, ret, 0);
> > +
> > +       supplier =3D test_register_platform_device(test);
> > +       context->action =3D TEST_CLASS_SYNC_CONSUMER;
> > +       context->endpoint =3D &supplier->dev;
> > +
> > +       consumer =3D device_create(test_class, NULL, 0, NULL,
> > +                                TEST_CLASS_NAME "-consumer");
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, consumer);
> > +       ret =3D kunit_add_action_or_reset(test, test_unregister_device,=
 consumer);
> > +       KUNIT_ASSERT_EQ(test, ret, 0);
> > +
> > +       KUNIT_ASSERT_NOT_NULL(test, context->link);
> > +       KUNIT_EXPECT_EQ(test, consumer->links.status, DL_DEV_DRIVER_BOU=
ND);
> > +       KUNIT_EXPECT_TRUE(test, list_empty(&consumer->links.suppliers))=
;
> > +       kunit_release_action(test, test_resume_sync_state, NULL);
> > +       KUNIT_EXPECT_EQ(test, atomic_read(&sync_count), 1);
> > +}
> > +
> > +static void device_link_class_existing_consumer_link_test(struct kunit=
 *test)
> > +{
> > +       struct device_link_class_context *context =3D test->priv;
> > +       struct test_class_device *consumer;
> > +       struct platform_device *supplier;
> > +       struct device_link *link;
> > +       int ret;
> > +
> > +       supplier =3D test_register_platform_device(test);
> > +       consumer =3D test_class_device_alloc(test,
> > +                                          TEST_CLASS_NAME "-existing-l=
ink");
> > +       KUNIT_ASSERT_NOT_NULL(test, consumer);
> > +
> > +       link =3D device_link_add(&consumer->dev, &supplier->dev,
> > +                              DL_FLAG_AUTOREMOVE_CONSUMER);
> > +       KUNIT_ASSERT_NOT_NULL(test, link);
> > +       KUNIT_ASSERT_EQ(test, READ_ONCE(link->status), DL_STATE_AVAILAB=
LE);
> > +       ret =3D fwnode_link_add(&consumer->fwnode,
> > +                             &consumer->missing_supplier, 0);
> > +       KUNIT_ASSERT_EQ(test, ret, 0);
> > +
> > +       context->action =3D TEST_CLASS_OBSERVE;
> > +       ret =3D device_add(&consumer->dev);
> > +       KUNIT_ASSERT_EQ(test, ret, 0);
> > +       consumer->added =3D true;
> > +
> > +       KUNIT_EXPECT_EQ(test, consumer->dev.links.status, DL_DEV_DRIVER=
_BOUND);
> > +       KUNIT_EXPECT_EQ(test, READ_ONCE(link->status), DL_STATE_ACTIVE)=
;
> > +       KUNIT_EXPECT_TRUE(test, context->waiting_for_supplier_seen);
> > +       KUNIT_EXPECT_FALSE(test, test_has_waiting_for_supplier(&consume=
r->dev));
> > +}
> > +
> > +static void device_link_class_registration_wait_test(struct kunit *tes=
t)
> > +{
> > +       struct device_link_class_context *context =3D test->priv;
> > +       struct device *dev;
> > +       unsigned long timeout;
> > +       int ret;
> > +
> > +       wait_for_device_probe();
> > +       context->action =3D TEST_CLASS_WAIT;
> > +       dev =3D device_create(test_class, NULL, 0, NULL,
> > +                           TEST_CLASS_NAME "-wait");
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
> > +       ret =3D kunit_add_action_or_reset(test, test_unregister_device,=
 dev);
> > +       KUNIT_ASSERT_EQ(test, ret, 0);
> > +
> > +       KUNIT_EXPECT_FALSE(test, context->waiter_completed_during_add);
> > +       timeout =3D wait_for_completion_timeout(&context->waiter_done,
> > +                                             msecs_to_jiffies(1000));
> > +       KUNIT_EXPECT_GT(test, timeout, 0UL);
> > +}
> > +
> > +static void device_link_class_supplier_unbind_race_test(struct kunit *=
test)
> > +{
> > +       struct device_link_class_context *context =3D test->priv;
> > +       struct platform_device *supplier;
> > +       struct device *consumer;
> > +       unsigned long timeout;
> > +       int ret;
> > +
> > +       supplier =3D test_register_platform_device(test);
> > +       context->action =3D TEST_CLASS_UNBIND_RACE;
> > +       context->endpoint =3D &supplier->dev;
> > +       consumer =3D device_create(test_class, NULL, 0, NULL,
> > +                                TEST_CLASS_NAME "-unbind-race");
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, consumer);
> > +       ret =3D kunit_add_action_or_reset(test, test_unregister_device,=
 consumer);
> > +       KUNIT_ASSERT_EQ(test, ret, 0);
> > +
> > +       KUNIT_ASSERT_NOT_NULL(test, context->link);
> > +       KUNIT_EXPECT_FALSE(test, context->unbind_completed_during_add);
> > +       timeout =3D wait_for_completion_timeout(&context->unbind_done,
> > +                                             msecs_to_jiffies(1000));
> > +       KUNIT_EXPECT_GT(test, timeout, 0UL);
> > +       KUNIT_EXPECT_EQ(test, atomic_read(&remove_count), 1);
> > +       KUNIT_EXPECT_EQ(test, supplier->dev.links.status, DL_DEV_NO_DRI=
VER);
> > +}
> > +
> > +static int device_link_class_test_init(struct kunit *test)
> > +{
> > +       struct device_link_class_context *context;
> > +
> > +       context =3D kunit_kzalloc(test, sizeof(*context), GFP_KERNEL);
> > +       if (!context)
> > +               return -ENOMEM;
> > +
> > +       init_completion(&context->waiter_started);
> > +       init_completion(&context->waiter_done);
> > +       init_completion(&context->unbind_started);
> > +       init_completion(&context->unbind_done);
> > +       test->priv =3D context;
> > +       test_context =3D context;
> > +       atomic_set(&remove_count, 0);
> > +       atomic_set(&sync_count, 0);
> > +
> > +       return 0;
> > +}
> > +
> > +static void device_link_class_test_exit(struct kunit *test)
> > +{
> > +       struct device_link_class_context *context =3D test->priv;
> > +
> > +       if (context->waiter && !IS_ERR(context->waiter)) {
> > +               kthread_stop(context->waiter);
> > +               put_task_struct(context->waiter);
> > +       }
> > +       if (context->unbinder && !IS_ERR(context->unbinder)) {
> > +               kthread_stop(context->unbinder);
> > +               put_task_struct(context->unbinder);
> > +       }
> > +       test_context =3D NULL;
> > +}
> > +
> > +static int device_link_class_suite_init(struct kunit_suite *suite)
> > +{
> > +       int ret;
> > +
> > +       test_class =3D class_create(TEST_CLASS_NAME);
> > +       if (IS_ERR(test_class))
> > +               return PTR_ERR(test_class);
> > +
> > +       ret =3D platform_driver_register(&test_driver);
> > +       if (ret)
> > +               goto destroy_class;
> > +
> > +       test_class_interface.class =3D test_class;
> > +       ret =3D class_interface_register(&test_class_interface);
> > +       if (ret)
> > +               goto unregister_driver;
> > +
> > +       return 0;
> > +
> > +unregister_driver:
> > +       platform_driver_unregister(&test_driver);
> > +destroy_class:
> > +       class_destroy(test_class);
> > +
> > +       return ret;
> > +}
> > +
> > +static void device_link_class_suite_exit(struct kunit_suite *suite)
> > +{
> > +       class_interface_unregister(&test_class_interface);
> > +       platform_driver_unregister(&test_driver);
> > +       class_destroy(test_class);
> > +       device_link_wait_removal();
> > +}
> > +
> > +static struct kunit_case device_link_class_test_cases[] =3D {
> > +       KUNIT_CASE(device_link_class_supplier_test),
> > +       KUNIT_CASE(device_link_class_consumer_sync_test),
> > +       KUNIT_CASE(device_link_class_existing_consumer_link_test),
> > +       KUNIT_CASE(device_link_class_registration_wait_test),
> > +       KUNIT_CASE(device_link_class_supplier_unbind_race_test),
> > +       {}
> > +};
> > +
> > +static struct kunit_suite device_link_class_test_suite =3D {
> > +       .name =3D "device-link-class",
> > +       .suite_init =3D device_link_class_suite_init,
> > +       .suite_exit =3D device_link_class_suite_exit,
> > +       .init =3D device_link_class_test_init,
> > +       .exit =3D device_link_class_test_exit,
> > +       .test_cases =3D device_link_class_test_cases,
> > +};
> > +
> > +kunit_test_suite(device_link_class_test_suite);
> > +
> > +MODULE_DESCRIPTION("KUnit tests for class device links");
> > +MODULE_LICENSE("GPL");
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index aee79fd6b32b..3783744df86e 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -446,11 +446,16 @@ enum device_link_state {
> >  #define DL_FLAG_CYCLE                  BIT(9)
> >
> >  /**
> > - * enum dl_dev_state - Device driver presence tracking information.
> > + * enum dl_dev_state - Device availability tracking information.
> >   * @DL_DEV_NO_DRIVER: There is no driver attached to the device.
> >   * @DL_DEV_PROBING: A driver is probing.
> >   * @DL_DEV_DRIVER_BOUND: The driver has been bound to the device.
> >   * @DL_DEV_UNBINDING: The driver is unbinding from the device.
> > + *
> > + * Class devices which are not on a bus use the same states for their
> > + * registration lifecycle.  In that case, PROBING and DRIVER_BOUND mea=
n that
> > + * device_add() is in progress or has completed, respectively, and UNB=
INDING
> > + * means that device_del() is in progress.
> >   */
> >  enum dl_dev_state {
> >         DL_DEV_NO_DRIVER =3D 0,
> > @@ -480,7 +485,7 @@ enum device_removable {
> >   * @suppliers: List of links to supplier devices.
> >   * @consumers: List of links to consumer devices.
> >   * @defer_sync: Hook to global list of devices that have deferred sync=
_state.
> > - * @status: Driver status information.
> > + * @status: Driver or class-device availability status.
> >   */
> >  struct dev_links_info {
> >         struct list_head suppliers;
> >
> > --
> > 2.53.0
> >
