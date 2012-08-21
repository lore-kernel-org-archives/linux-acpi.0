From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH V4 05/13] Thermal: Remove tc1/tc2 in generic thermal
 layer.
Date: Tue, 21 Aug 2012 08:49:42 +0800
Message-ID: <1345510182.1682.927.camel@rui.sh.intel.com>
References: <1343292083-2047-1-git-send-email-rui.zhang@intel.com>
	 <1343292083-2047-6-git-send-email-rui.zhang@intel.com>
	 <CAGF5oy9DMdCFL41dGD8CBq_+VT_dTtsTrVjdTphmmxFdNr2j9g@mail.gmail.com>
	 <1344473874.1682.644.camel@rui.sh.intel.com>
	 <CAGF5oy9By=A6az=n7-AfPX_57HLzj3J0YXbFenKQXMvG2HcmYQ@mail.gmail.com>
	 <20120820121842.GA9833@besouro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:33808 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752744Ab2HUAsm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Aug 2012 20:48:42 -0400
In-Reply-To: <20120820121842.GA9833@besouro>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: eduardo.valentin@ti.com
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On =E4=B8=80, 2012-08-20 at 15:18 +0300, Eduardo Valentin wrote:
> Hello,
>=20
> On Thu, Aug 09, 2012 at 06:10:04PM +0300, Valentin, Eduardo wrote:
> >=20
> > (resending the mail so that it reaches the mailing lists)
> >=20
> > Nice, I checked your tree and this patch is fine for me. Next time =
you
> > send it out, you may want to add my reviewed-by:
>=20
> Except that in your tree it is still introducing compilation issues u=
nder omap-thermal-common.c
>=20
why, I think I have fixed that already.
would you please send an incremental patch so that I can apply it?

thanks,
rui
> >=20
> > Reviewed-by: Eduardo Valentin <eduardo.valentin@ti.com>
>=20
> So, apart from the above comment, this patch is still fine for me.
>=20
> >=20
> >=20
> > >
> > > thanks,
> > > rui
> > > > Apart from the compilation issues and the needed patch refresh,=
 I am
> > > > good with the patch. And thanks for pushing this forward.
> > > >
> > > > >  6 files changed, 11 insertions(+), 29 deletions(-)
> > > > >
> > > > > diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> > > > > index 0c49e42..0c755d2 100644
> > > > > --- a/drivers/acpi/thermal.c
> > > > > +++ b/drivers/acpi/thermal.c
> > > > > @@ -895,15 +895,12 @@ static int
> > > > > acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
> > > > >                 tz->thermal_zone =3D
> > > > >                         thermal_zone_device_register("acpitz"=
, trips,
> > > > > 0, tz,
> > > > >
> > > > > &acpi_thermal_zone_ops,
> > > > > -
> > > > > tz->trips.passive.tc1,
> > > > > -
> > > > > tz->trips.passive.tc2,
> > > > >
> > > > > tz->trips.passive.tsp*100,
> > > > >
> > > > > tz->polling_frequency*100);
> > > > >         else
> > > > >                 tz->thermal_zone =3D
> > > > >                         thermal_zone_device_register("acpitz"=
, trips,
> > > > > 0, tz,
> > > > > -
> > > > > &acpi_thermal_zone_ops,
> > > > > -                                                    0, 0, 0,
> > > > > +
> > > > > &acpi_thermal_zone_ops, 0,
> > > > >
> > > > > tz->polling_frequency*100);
> > > > >         if (IS_ERR(tz->thermal_zone))
> > > > >                 return -ENODEV;
> > > > > diff --git a/drivers/platform/x86/acerhdf.c
> > > > > b/drivers/platform/x86/acerhdf.c
> > > > > index a207466..84c5688 100644
> > > > > --- a/drivers/platform/x86/acerhdf.c
> > > > > +++ b/drivers/platform/x86/acerhdf.c
> > > > > @@ -662,7 +662,7 @@ static int acerhdf_register_thermal(void)
> > > > >                 return -EINVAL;
> > > > >
> > > > >         thz_dev =3D thermal_zone_device_register("acerhdf", 1=
, 0, NULL,
> > > > > -                                             &acerhdf_dev_op=
s, 0, 0,
> > > > > 0,
> > > > > +                                             &acerhdf_dev_op=
s, 0,
> > > > >                                               (kernelmode) ?
> > > > > interval*1000 : 0);
> > > > >         if (IS_ERR(thz_dev))
> > > > >                 return -EINVAL;
> > > > > diff --git a/drivers/platform/x86/intel_mid_thermal.c
> > > > > b/drivers/platform/x86/intel_mid_thermal.c
> > > > > index 2b2c212..6e309dd 100644
> > > > > --- a/drivers/platform/x86/intel_mid_thermal.c
> > > > > +++ b/drivers/platform/x86/intel_mid_thermal.c
> > > > > @@ -499,7 +499,7 @@ static int mid_thermal_probe(struct
> > > > > platform_device *pdev)
> > > > >                         goto err;
> > > > >                 }
> > > > >                 pinfo->tzd[i] =3D thermal_zone_device_registe=
r(name[i],
> > > > > -                               0, 0, td_info, &tzd_ops, 0, 0=
, 0, 0);
> > > > > +                               0, 0, td_info, &tzd_ops, 0, 0=
);
> > > > >                 if (IS_ERR(pinfo->tzd[i])) {
> > > > >                         kfree(td_info);
> > > > >                         ret =3D PTR_ERR(pinfo->tzd[i]);
> > > > > diff --git a/drivers/thermal/spear_thermal.c
> > > > > b/drivers/thermal/spear_thermal.c
> > > > > index 69a55d4..b55840a 100644
> > > > > --- a/drivers/thermal/spear_thermal.c
> > > > > +++ b/drivers/thermal/spear_thermal.c
> > > > > @@ -148,7 +148,7 @@ static int spear_thermal_probe(struct
> > > > > platform_device *pdev)
> > > > >         writel_relaxed(stdev->flags, stdev->thermal_base);
> > > > >
> > > > >         spear_thermal =3D thermal_zone_device_register("spear=
_thermal",
> > > > > 0, 0,
> > > > > -                               stdev, &ops, 0, 0, 0, 0);
> > > > > +                               stdev, &ops, 0, 0);
> > > > >         if (IS_ERR(spear_thermal)) {
> > > > >                 dev_err(&pdev->dev, "thermal zone device is N=
ULL\n");
> > > > >                 ret =3D PTR_ERR(spear_thermal);
> > > > > diff --git a/drivers/thermal/thermal_sys.c
> > > > > b/drivers/thermal/thermal_sys.c
> > > > > index 68c93d4..a70ed4c 100644
> > > > > --- a/drivers/thermal/thermal_sys.c
> > > > > +++ b/drivers/thermal/thermal_sys.c
> > > > > @@ -335,9 +335,6 @@ passive_store(struct device *dev, struct
> > > > > device_attribute *attr,
> > > > >                 tz->passive_delay =3D 0;
> > > > >         }
> > > > >
> > > > > -       tz->tc1 =3D 1;
> > > > > -       tz->tc2 =3D 1;
> > > > > -
> > > > >         tz->forced_passive =3D state;
> > > > >
> > > > >         thermal_zone_device_update(tz);
> > > > > @@ -718,13 +715,12 @@ static void
> > > > > thermal_zone_device_set_polling(struct thermal_zone_device *t=
z,
> > > > >  static void thermal_zone_device_passive(struct thermal_zone_=
device
> > > > > *tz,
> > > > >                                         int temp, int trip_te=
mp, int
> > > > > trip)
> > > > >  {
> > > > > -       int trend =3D 0;
> > > > > +       enum thermal_trend trend;
> > > > >         struct thermal_cooling_device_instance *instance;
> > > > >         struct thermal_cooling_device *cdev;
> > > > >         long state, max_state;
> > > > >
> > > > > -       if (!tz->ops->get_trend ||
> > > > > -           tz->ops->get_trend(tz, trip, (enum thermal_trend
> > > > > *)&trend)) {
> > > > > +       if (!tz->ops->get_trend || tz->ops->get_trend(tz, tri=
p,
> > > > > &trend)) {
> > > > >                 /*
> > > > >                  * compare the current temperature and previo=
us
> > > > > temperature
> > > > >                  * to get the thermal trend, if no special re=
quirement
> > > > > @@ -747,11 +743,8 @@ static void thermal_zone_device_passive(=
struct
> > > > > thermal_zone_device *tz,
> > > > >         if (temp >=3D trip_temp) {
> > > > >                 tz->passive =3D true;
> > > > >
> > > > > -               trend =3D (tz->tc1 * (temp - tz->last_tempera=
ture)) +
> > > > > -                       (tz->tc2 * (temp - trip_temp));
> > > > > -
> > > > >                 /* Heating up? */
> > > > > -               if (trend > 0) {
> > > > > +               if (trend =3D=3D THERMAL_TREND_RAISING) {
> > > > >                         list_for_each_entry(instance,
> > > > > &tz->cooling_devices,
> > > > >                                             node) {
> > > > >                                 if (instance->trip !=3D trip)
> > > > > @@ -762,7 +755,7 @@ static void thermal_zone_device_passive(s=
truct
> > > > > thermal_zone_device *tz,
> > > > >                                 if (state++ < max_state)
> > > > >                                         cdev->ops->set_cur_st=
ate(cdev,
> > > > > state);
> > > > >                         }
> > > > > -               } else if (trend < 0) { /* Cooling off? */
> > > > > +               } else if (trend =3D=3D THERMAL_TREND_DROPPIN=
G) { /*
> > > > > Cooling off? */
> > > > >                         list_for_each_entry(instance,
> > > > > &tz->cooling_devices,
> > > > >                                             node) {
> > > > >                                 if (instance->trip !=3D trip)
> > > > > @@ -1288,8 +1281,6 @@ static void remove_trip_attrs(struct
> > > > > thermal_zone_device *tz)
> > > > >   * @mask:      a bit string indicating the writeablility of =
trip
> > > > > points
> > > > >   * @devdata:   private device data
> > > > >   * @ops:       standard thermal zone device callbacks
> > > > > - * @tc1:       thermal coefficient 1 for passive calculation=
s
> > > > > - * @tc2:       thermal coefficient 2 for passive calculation=
s
> > > > >   * @passive_delay: number of milliseconds to wait between po=
lls when
> > > > >   *                performing passive cooling
> > > > >   * @polling_delay: number of milliseconds to wait between po=
lls when
> > > > > checking
> > > > > @@ -1297,13 +1288,12 @@ static void remove_trip_attrs(struct
> > > > > thermal_zone_device *tz)
> > > > >   *                driven systems)
> > > > >   *
> > > > >   * thermal_zone_device_unregister() must be called when the =
device is
> > > > > no
> > > > > - * longer needed. The passive cooling formula uses tc1 and t=
c2 as
> > > > > described in
> > > > > - * section 11.1.5.1 of the ACPI specification 3.0.
> > > > > + * longer needed. The passive cooling depends on the .get_tr=
end()
> > > > > return value.
> > > > >   */
> > > > >  struct thermal_zone_device *thermal_zone_device_register(cha=
r *type,
> > > > >         int trips, int mask, void *devdata,
> > > > >         const struct thermal_zone_device_ops *ops,
> > > > > -       int tc1, int tc2, int passive_delay, int polling_dela=
y)
> > > > > +       int passive_delay, int polling_delay)
> > > > >  {
> > > > >         struct thermal_zone_device *tz;
> > > > >         struct thermal_cooling_device *pos;
> > > > > @@ -1339,8 +1329,6 @@ struct thermal_zone_device
> > > > > *thermal_zone_device_register(char *type,
> > > > >         tz->device.class =3D &thermal_class;
> > > > >         tz->devdata =3D devdata;
> > > > >         tz->trips =3D trips;
> > > > > -       tz->tc1 =3D tc1;
> > > > > -       tz->tc2 =3D tc2;
> > > > >         tz->passive_delay =3D passive_delay;
> > > > >         tz->polling_delay =3D polling_delay;
> > > > >
> > > > > diff --git a/include/linux/thermal.h b/include/linux/thermal.=
h
> > > > > index a01e3e6..d18dcf6 100644
> > > > > --- a/include/linux/thermal.h
> > > > > +++ b/include/linux/thermal.h
> > > > > @@ -115,8 +115,6 @@ struct thermal_zone_device {
> > > > >         struct thermal_attr *trip_hyst_attrs;
> > > > >         void *devdata;
> > > > >         int trips;
> > > > > -       int tc1;
> > > > > -       int tc2;
> > > > >         int passive_delay;
> > > > >         int polling_delay;
> > > > >         int temperature;
> > > > > @@ -163,8 +161,7 @@ enum {
> > > > >  #define THERMAL_GENL_CMD_MAX (__THERMAL_GENL_CMD_MAX - 1)
> > > > >
> > > > >  struct thermal_zone_device *thermal_zone_device_register(cha=
r *, int,
> > > > > int,
> > > > > -               void *, const struct thermal_zone_device_ops =
*, int
> > > > > tc1,
> > > > > -               int tc2, int passive_freq, int polling_freq);
> > > > > +               void *, const struct thermal_zone_device_ops =
*, int,
> > > > > int);
> > > > >  void thermal_zone_device_unregister(struct thermal_zone_devi=
ce *);
> > > > >
> > > > >  int thermal_zone_bind_cooling_device(struct thermal_zone_dev=
ice *,
> > > > > int,
> > > > > --
> > > > > 1.7.9.5
> > > > >
> > > >
> > > >
> > > >
> > >
> > >
> >=20
> >=20
> >=20
> > --
> >=20
> > Eduardo Valentin


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
