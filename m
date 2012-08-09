From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH V4 01/13] Thermal: Introduce multiple cooling states
 support
Date: Thu, 09 Aug 2012 08:58:22 +0800
Message-ID: <1344473902.1682.645.camel@rui.sh.intel.com>
References: <1343292083-2047-1-git-send-email-rui.zhang@intel.com>
	 <1343292083-2047-2-git-send-email-rui.zhang@intel.com>
	 <CAGF5oy9XhLt9VG6BDiPr7_0oMzFjwVMPB+Qt=P7=nHa1-dMHUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:35783 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758675Ab2HIA5R (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Aug 2012 20:57:17 -0400
In-Reply-To: <CAGF5oy9XhLt9VG6BDiPr7_0oMzFjwVMPB+Qt=P7=nHa1-dMHUg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Valentin, Eduardo" <eduardo.valentin@ti.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On =E4=B8=89, 2012-08-08 at 15:02 +0300, Valentin, Eduardo wrote:
> Hello Rui,
>=20
> On Thu, Jul 26, 2012 at 11:41 AM, Zhang Rui <rui.zhang@intel.com> wro=
te:
> > This is because general active cooling devices, like fans,
> > may have multiple speeds, which can be mapped to different cooling =
states.
> >
> > Reviewed-by: Rafael J. Wysocki <rjw@sisk.pl>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>=20
> Reviewed-by: Eduardo Valentin <eduardo.valentin@ti.com>
>=20
thanks!

-rui
> > ---
> >  drivers/thermal/thermal_sys.c |   12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/therma=
l_sys.c
> > index 2d7a9fe..05f42cd 100644
> > --- a/drivers/thermal/thermal_sys.c
> > +++ b/drivers/thermal/thermal_sys.c
> > @@ -1059,6 +1059,7 @@ void thermal_zone_device_update(struct therma=
l_zone_device *tz)
> >         enum thermal_trip_type trip_type;
> >         struct thermal_cooling_device_instance *instance;
> >         struct thermal_cooling_device *cdev;
> > +       unsigned long cur_state, max_state;
> >
> >         mutex_lock(&tz->lock);
> >
> > @@ -1098,10 +1099,17 @@ void thermal_zone_device_update(struct ther=
mal_zone_device *tz)
> >
> >                                 cdev =3D instance->cdev;
> >
> > +                               cdev->ops->get_cur_state(cdev, &cur=
_state);
> > +                               cdev->ops->get_max_state(cdev, &max=
_state);
> > +
> >                                 if (temp >=3D trip_temp)
> > -                                       cdev->ops->set_cur_state(cd=
ev, 1);
> > +                                       cur_state =3D cur_state < m=
ax_state ?
> > +                                               (cur_state + 1) : m=
ax_state;
> >                                 else
> > -                                       cdev->ops->set_cur_state(cd=
ev, 0);
> > +                                       cur_state =3D cur_state > 0=
 ?
> > +                                               (cur_state - 1) : 0=
;
> > +
> > +                               cdev->ops->set_cur_state(cdev, cur_=
state);
> >                         }
> >                         break;
> >                 case THERMAL_TRIP_PASSIVE:
> > --
> > 1.7.9.5
> >
>=20
>=20
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
