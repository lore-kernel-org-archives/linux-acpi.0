From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH V4 13/13] Thermal: Introduce locking for
 cdev.thermal_instances list.
Date: Tue, 21 Aug 2012 08:01:21 +0300
Message-ID: <20120821050121.GT9833@besouro>
References: <1343292083-2047-1-git-send-email-rui.zhang@intel.com>
 <1343292083-2047-14-git-send-email-rui.zhang@intel.com>
 <20120820154518.GB9833@besouro>
 <1345510407.1682.930.camel@rui.sh.intel.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:36734 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750902Ab2HUFBb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Aug 2012 01:01:31 -0400
Received: by weyu54 with SMTP id u54so5546443wey.17
        for <linux-acpi@vger.kernel.org>; Mon, 20 Aug 2012 22:01:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1345510407.1682.930.camel@rui.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: eduardo.valentin@ti.com, "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

Hello,

On Tue, Aug 21, 2012 at 08:53:27AM +0800, Zhang Rui wrote:
> On =E4=B8=80, 2012-08-20 at 18:45 +0300, Eduardo Valentin wrote:
> > Hello Rui,
> >=20
> > On Thu, Jul 26, 2012 at 04:41:23PM +0800, Zhang Rui wrote:
> > > we need to go over all the thermal_instance list of a cooling dev=
ice
> > > to decide which cooling state to put the cooling device to.
> > >=20
> > > But at this time, as a cooling device may be referenced in multip=
le
> > > thermal zones, we need to lock the list first in case
> > > another thermal zone is updating this cooling device.
> > >=20
> > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> >=20
> > Reviewed-by: Eduardo Valentin <eduardo.valentin@ti.com>
> >=20
> > A minor comment bellow.
> >=20
> > > ---
> > >  drivers/thermal/thermal_sys.c |    8 ++++++++
> > >  include/linux/thermal.h       |    1 +
> > >  2 files changed, 9 insertions(+)
> > >=20
> > > diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/ther=
mal_sys.c
> > > index 7f3a891..356a59d 100644
> > > --- a/drivers/thermal/thermal_sys.c
> > > +++ b/drivers/thermal/thermal_sys.c
> > > @@ -799,6 +799,7 @@ int thermal_zone_bind_cooling_device(struct t=
hermal_zone_device *tz,
> > >  		goto remove_symbol_link;
> > > =20
> > >  	mutex_lock(&tz->lock);
> > > +	mutex_lock(&cdev->lock);
> >=20
> > Why do you need to lock while going through the tz thermal_instance=
s?
> >=20
> > >  	list_for_each_entry(pos, &tz->thermal_instances, tz_node)
> > >  	    if (pos->tz =3D=3D tz && pos->trip =3D=3D trip && pos->cdev=
 =3D=3D cdev) {
> > >  		result =3D -EEXIST;
> > > @@ -808,6 +809,7 @@ int thermal_zone_bind_cooling_device(struct t=
hermal_zone_device *tz,
> > >  		list_add_tail(&dev->tz_node, &tz->thermal_instances);
> > >  		list_add_tail(&dev->cdev_node, &cdev->thermal_instances);
> >=20
> > Locking the above operation should be enough, no?
> >=20
> we need to add this thermal_instance to the cooling device
> thermal_instance list.
> say, what if another thermal zone that references this cooling device=
 is
> being unregistered at the same time?

Well yes, that part I got it. But do you need to lock the cdev->lock
while doing the search under tz->thermal_instances?

I believe you need to lock it only while adding it to cdev->thermal_ins=
tances.
That would cover the situation you are talking about.

>=20
> thanks,
> rui
>=20
> > >  	}
> > > +	mutex_unlock(&cdev->lock);
> > >  	mutex_unlock(&tz->lock);
> > > =20
> > >  	if (!result)
> > > @@ -840,14 +842,17 @@ int thermal_zone_unbind_cooling_device(stru=
ct thermal_zone_device *tz,
> > >  	struct thermal_instance *pos, *next;
> > > =20
> > >  	mutex_lock(&tz->lock);
> > > +	mutex_lock(&cdev->lock);
> > >  	list_for_each_entry_safe(pos, next, &tz->thermal_instances, tz_=
node) {
> > >  		if (pos->tz =3D=3D tz && pos->trip =3D=3D trip && pos->cdev =3D=
=3D cdev) {
> > >  			list_del(&pos->tz_node);
> > >  			list_del(&pos->cdev_node);
> > > +			mutex_unlock(&cdev->lock);
> > >  			mutex_unlock(&tz->lock);
> > >  			goto unbind;
> > >  		}
> > >  	}
> > > +	mutex_unlock(&cdev->lock);
> > >  	mutex_unlock(&tz->lock);
> > > =20
> > >  	return -ENODEV;
> > > @@ -913,6 +918,7 @@ thermal_cooling_device_register(char *type, v=
oid *devdata,
> > >  	}
> > > =20
> > >  	strcpy(cdev->type, type);
> > > +	mutex_init(&cdev->lock);
> > >  	INIT_LIST_HEAD(&cdev->thermal_instances);
> > >  	cdev->ops =3D ops;
> > >  	cdev->updated =3D true;
> > > @@ -1016,6 +1022,7 @@ static void thermal_cdev_do_update(struct t=
hermal_cooling_device *cdev)
> > >  	if (cdev->updated)
> > >  		return;
> > > =20
> > > +	mutex_lock(&cdev->lock);
> > >  	/* Make sure cdev enters the deepest cooling state */
> > >  	list_for_each_entry(instance, &cdev->thermal_instances, cdev_no=
de) {
> > >  		if (instance->target =3D=3D THERMAL_NO_TARGET)
> > > @@ -1023,6 +1030,7 @@ static void thermal_cdev_do_update(struct t=
hermal_cooling_device *cdev)
> > >  		if (instance->target > target)
> > >  			target =3D instance->target;
> > >  	}
> > > +	mutex_unlock(&cdev->lock);
> > >  	cdev->ops->set_cur_state(cdev, target);
> > >  	cdev->updated =3D true;
> > >  }
> > > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > > index 06fd04d..d02d06d 100644
> > > --- a/include/linux/thermal.h
> > > +++ b/include/linux/thermal.h
> > > @@ -95,6 +95,7 @@ struct thermal_cooling_device {
> > >  	void *devdata;
> > >  	const struct thermal_cooling_device_ops *ops;
> > >  	bool updated; /* true if the cooling device does not need updat=
e */
> > > +	struct mutex lock; /* protect thermal_instances list */
> > >  	struct list_head thermal_instances;
> > >  	struct list_head node;
> > >  };
> > > --=20
> > > 1.7.9.5
> > >=20
>=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
