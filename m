From: Rob Lee <rob.lee@linaro.org>
Subject: Re: [PATCH] ACPI-Thermal: Make Thermal trip points writeable
Date: Fri, 6 Apr 2012 08:01:37 -0500
Message-ID: <CAMXH7KGEUzfYJGCQYeCs1P71hT0bwkm0Z1gNCn0BDZu9DWKVaw@mail.gmail.com>
References: <1327681692-19299-1-git-send-email-durgadoss.r@intel.com>
	<1333605123-29172-1-git-send-email-amit.kachhap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:38344 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754823Ab2DFNBi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Apr 2012 09:01:38 -0400
Received: by obbtb18 with SMTP id tb18so3054412obb.19
        for <linux-acpi@vger.kernel.org>; Fri, 06 Apr 2012 06:01:38 -0700 (PDT)
In-Reply-To: <1333605123-29172-1-git-send-email-amit.kachhap@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Amit Daniel Kachhap <amit.kachhap@linaro.org>
Cc: durgadoss.r@intel.com, linux-acpi@vger.kernel.org, rui.zhang@intel.com, linaro-dev@lists.linaro.org, lenb@kernel.org

On Thu, Apr 5, 2012 at 12:52 AM, Amit Daniel Kachhap
<amit.kachhap@linaro.org> wrote:
> Hi Durgadoss,
>
> Instead of making all the trip-points of a thermal zone writeable we =
should
> only allow non-critical trip points to be writeable.
>
> Thanks,
> Amit Daniel
>

Agree, or even better, could the writeable attribute be made an
optional for any trip point?

Many SoCs now have built in thermal sensing and for cost reasons some
device makers may want to rely on the kernel thermal handling
capabilities as their primary thermal protection.  Allowing userspace
to modify the trip points may increase their risk/exposure to lawsuits
or other undesirable results in some cases.

Best Regards,
Rob

>> -----Original Message-----
>> From: Durgadoss R <durgadoss.r@intel.com>
>> Sent: Friday, January 27, 2012 9:58 PM
>> To: linux-acpi@vger.kernel.org
>> Cc: lenb@kernel.org; rui.zhang@intel.com; durgadoss.r@intel.com
>> Subject: [PATCH] ACPI-Thermal: Make Thermal trip points writeable
>
>>Some of the thermal drivers using the Generic Thermal Framework
>>require (all/some) trip points to be writeable. This patch makes
>>the trip point temperatures writeable on a per-trip point basis,
>>and modifies the required function call in thermal.c. This patch
>>also updates the Documentation to reflect the new change.
>>
>>Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
>>---
>>v1
>>* patch1/2: Code for making trip points writeable
>>* patch2/2: Change the callee in thermal.c
>>v2
>>* Make both the changes in a single patch
>>* Update Documentation/thermal/sysfs-api.txt
>>---
>> Documentation/thermal/sysfs-api.txt | =A0 =A04 +-
>> drivers/acpi/thermal.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A04 +-
>> drivers/thermal/thermal_sys.c =A0 =A0 =A0 | =A0127 +++++++++++++++++=
+++++-------------
>> include/linux/thermal.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 10 ++-
>> 4 files changed, 91 insertions(+), 54 deletions(-)
>>
>>diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/ther=
mal/sysfs-api.txt
>>index b61e46f..cd1476c 100644
>>--- a/Documentation/thermal/sysfs-api.txt
>>+++ b/Documentation/thermal/sysfs-api.txt
>>@@ -32,7 +32,8 @@ temperature) and throttle appropriate devices.
>>
>> 1.1 thermal zone device interface
>> 1.1.1 struct thermal_zone_device *thermal_zone_device_register(char =
*name,
>>- =A0 =A0 =A0 =A0 =A0 =A0 =A0int trips, void *devdata, struct thermal=
_zone_device_ops *ops)
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0int trips, int flag, void *devdata,
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0struct thermal_zone_device_ops *ops)
>>
>> =A0 =A0 This interface function adds a new thermal zone device (sens=
or) to
>> =A0 =A0 /sys/class/thermal folder as thermal_zone[0-*]. It tries to =
bind all the
>>@@ -40,6 +41,7 @@ temperature) and throttle appropriate devices.
>>
>> =A0 =A0 name: the thermal zone name.
>> =A0 =A0 trips: the total number of trip points this thermal zone sup=
ports.
>>+ =A0 =A0flag: Bit string: If 'n'th bit is set, then trip point 'n' i=
s writeable.
>> =A0 =A0 devdata: device private data
>> =A0 =A0 ops: thermal zone device call-backs.
>> =A0 =A0 =A0 .bind: bind the thermal zone device with a thermal cooli=
ng device.
>>diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
>>index 48fbc64..1c3133e 100644
>>--- a/drivers/acpi/thermal.c
>>+++ b/drivers/acpi/thermal.c
>>@@ -845,7 +845,7 @@ static int acpi_thermal_register_thermal_zone(str=
uct acpi_thermal *tz)
>>
>> =A0 =A0 =A0 if (tz->trips.passive.flags.valid)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 tz->thermal_zone =3D
>>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0thermal_zone_device_regi=
ster("acpitz", trips, tz,
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0thermal_zone_device_regi=
ster("acpitz", trips, 0, tz,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&acpi_thermal_zone_ops,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tz->trips.passive.tc1,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tz->trips.passive.tc2,
>>@@ -853,7 +853,7 @@ static int acpi_thermal_register_thermal_zone(str=
uct acpi_thermal *tz)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tz->polling_frequency*100);
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 tz->thermal_zone =3D
>>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0thermal_zone_device_regi=
ster("acpitz", trips, tz,
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0thermal_zone_device_regi=
ster("acpitz", trips, 0, tz,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&acpi_thermal_zone_ops,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00, 0, 0,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tz->polling_frequency*100);
>>diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_=
sys.c
>>index dd9a574..3a4341e 100644
>>--- a/drivers/thermal/thermal_sys.c
>>+++ b/drivers/thermal/thermal_sys.c
>>@@ -220,6 +220,28 @@ trip_point_temp_show(struct device *dev, struct =
device_attribute *attr,
>> }
>>
>> static ssize_t
>>+trip_point_temp_store(struct device *dev, struct device_attribute *a=
ttr,
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *buf, size_t count)
>>+{
>>+ =A0 =A0 =A0struct thermal_zone_device *tz =3D to_thermal_zone(dev);
>>+ =A0 =A0 =A0int trip, ret;
>>+ =A0 =A0 =A0unsigned long temperature;
>>+
>>+ =A0 =A0 =A0if (!tz->ops->set_trip_temp)
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EPERM;
>>+
>>+ =A0 =A0 =A0if (!sscanf(attr->attr.name, "trip_point_%d_temp", &trip=
))
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>>+
>>+ =A0 =A0 =A0if (kstrtoul(buf, 10, &temperature))
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>>+
>>+ =A0 =A0 =A0ret =3D tz->ops->set_trip_temp(tz, trip, temperature);
>>+
>>+ =A0 =A0 =A0return ret ? ret : count;
>>+}
>>+
>>+static ssize_t
>> passive_store(struct device *dev, struct device_attribute *attr,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *buf, size_t count)
>> {
>>@@ -286,49 +308,6 @@ static DEVICE_ATTR(mode, 0644, mode_show, mode_s=
tore);
>> static DEVICE_ATTR(passive, S_IRUGO | S_IWUSR, passive_show, \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0passive_store);
>>
>>-static struct device_attribute trip_point_attrs[] =3D {
>>- =A0 =A0 =A0__ATTR(trip_point_0_type, 0444, trip_point_type_show, NU=
LL),
>>- =A0 =A0 =A0__ATTR(trip_point_0_temp, 0444, trip_point_temp_show, NU=
LL),
>>- =A0 =A0 =A0__ATTR(trip_point_1_type, 0444, trip_point_type_show, NU=
LL),
>>- =A0 =A0 =A0__ATTR(trip_point_1_temp, 0444, trip_point_temp_show, NU=
LL),
>>- =A0 =A0 =A0__ATTR(trip_point_2_type, 0444, trip_point_type_show, NU=
LL),
>>- =A0 =A0 =A0__ATTR(trip_point_2_temp, 0444, trip_point_temp_show, NU=
LL),
>>- =A0 =A0 =A0__ATTR(trip_point_3_type, 0444, trip_point_type_show, NU=
LL),
>>- =A0 =A0 =A0__ATTR(trip_point_3_temp, 0444, trip_point_temp_show, NU=
LL),
>>- =A0 =A0 =A0__ATTR(trip_point_4_type, 0444, trip_point_type_show, NU=
LL),
>>- =A0 =A0 =A0__ATTR(trip_point_4_temp, 0444, trip_point_temp_show, NU=
LL),
>>- =A0 =A0 =A0__ATTR(trip_point_5_type, 0444, trip_point_type_show, NU=
LL),
>>- =A0 =A0 =A0__ATTR(trip_point_5_temp, 0444, trip_point_temp_show, NU=
LL),
>>- =A0 =A0 =A0__ATTR(trip_point_6_type, 0444, trip_point_type_show, NU=
LL),
>>- =A0 =A0 =A0__ATTR(trip_point_6_temp, 0444, trip_point_temp_show, NU=
LL),
>>- =A0 =A0 =A0__ATTR(trip_point_7_type, 0444, trip_point_type_show, NU=
LL),
>>- =A0 =A0 =A0__ATTR(trip_point_7_temp, 0444, trip_point_temp_show, NU=
LL),
>>- =A0 =A0 =A0__ATTR(trip_point_8_type, 0444, trip_point_type_show, NU=
LL),
>>- =A0 =A0 =A0__ATTR(trip_point_8_temp, 0444, trip_point_temp_show, NU=
LL),
>>- =A0 =A0 =A0__ATTR(trip_point_9_type, 0444, trip_point_type_show, NU=
LL),
>>- =A0 =A0 =A0__ATTR(trip_point_9_temp, 0444, trip_point_temp_show, NU=
LL),
>>- =A0 =A0 =A0__ATTR(trip_point_10_type, 0444, trip_point_type_show, N=
ULL),
>>- =A0 =A0 =A0__ATTR(trip_point_10_temp, 0444, trip_point_temp_show, N=
ULL),
>>- =A0 =A0 =A0__ATTR(trip_point_11_type, 0444, trip_point_type_show, N=
ULL),
>>- =A0 =A0 =A0__ATTR(trip_point_11_temp, 0444, trip_point_temp_show, N=
ULL),
>>-};
>>-
>>-#define TRIP_POINT_ATTR_ADD(_dev, _index, result) =A0 =A0 \
>>-do { =A0 =A0\
>>- =A0 =A0 =A0result =3D device_create_file(_dev, =A0 =A0 =A0 \
>>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&trip_po=
int_attrs[_index * 2]); \
>>- =A0 =A0 =A0if (result) =A0 =A0 \
>>- =A0 =A0 =A0 =A0 =A0 =A0 =A0break; =A0\
>>- =A0 =A0 =A0result =3D device_create_file(_dev, =A0 =A0 =A0 \
>>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&trip_point_attrs[_index=
 * 2 + 1]); =A0 =A0 \
>>-} while (0)
>>-
>>-#define TRIP_POINT_ATTR_REMOVE(_dev, _index) =A0\
>>-do { =A0\
>>- =A0 =A0 =A0device_remove_file(_dev, &trip_point_attrs[_index * 2]);=
 =A0 =A0 =A0 =A0\
>>- =A0 =A0 =A0device_remove_file(_dev, &trip_point_attrs[_index * 2 + =
1]); =A0 =A0\
>>-} while (0)
>>-
>> /* sys I/F for cooling device */
>> #define to_cooling_device(_dev) =A0 =A0 =A0 \
>> =A0 =A0 =A0 container_of(_dev, struct thermal_cooling_device, device=
)
>>@@ -1112,9 +1091,54 @@ void thermal_zone_device_update(struct thermal=
_zone_device *tz)
>> EXPORT_SYMBOL(thermal_zone_device_update);
>>
>> /**
>>+ * create_trip_type_attr - creates a trip point type attribute
>>+ * @tz: =A0 =A0 =A0 =A0 =A0 =A0 =A0 the thermal zone device
>>+ * @indx: =A0 =A0 index into the trip_type_attrs array
>>+ */
>>+static int create_trip_type_attr(struct thermal_zone_device *tz, int=
 indx)
>>+{
>>+ =A0 =A0 =A0char attr_name[THERMAL_NAME_LENGTH];
>>+
>>+ =A0 =A0 =A0snprintf(attr_name, THERMAL_NAME_LENGTH, "trip_point_%d_=
type", indx);
>>+
>>+ =A0 =A0 =A0sysfs_attr_init(&tz->trip_type_attrs[indx].attr);
>>+ =A0 =A0 =A0tz->trip_type_attrs[indx].attr.name =3D attr_name;
>>+ =A0 =A0 =A0tz->trip_type_attrs[indx].attr.mode =3D S_IRUGO;
>>+ =A0 =A0 =A0tz->trip_type_attrs[indx].show =3D trip_point_type_show;
>>+
>>+ =A0 =A0 =A0return device_create_file(&tz->device, &tz->trip_type_at=
trs[indx]);
>>+}
>>+
>>+/**
>>+ * create_trip_temp_attr - creates a trip point temp attribute
>>+ * @tz: =A0 =A0 =A0 =A0 =A0 =A0 =A0 the thermal zone device
>>+ * @indx: =A0 =A0 index into the trip_type_attrs array
>>+ * @writeable: =A0 =A0 =A0 =A0A flag: If 1, 'this' trip point is wri=
teable; otherwise not
>>+ */
>>+static int create_trip_temp_attr(struct thermal_zone_device *tz,
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int indx=
, int writeable)
>>+{
>>+ =A0 =A0 =A0char attr_name[THERMAL_NAME_LENGTH];
>>+
>>+ =A0 =A0 =A0snprintf(attr_name, THERMAL_NAME_LENGTH, "trip_point_%d_=
temp", indx);
>>+
>>+ =A0 =A0 =A0sysfs_attr_init(&tz->trip_temp_attrs[indx].attr);
>>+ =A0 =A0 =A0tz->trip_temp_attrs[indx].attr.name =3D attr_name;
>>+ =A0 =A0 =A0tz->trip_temp_attrs[indx].attr.mode =3D S_IRUGO;
>>+ =A0 =A0 =A0tz->trip_temp_attrs[indx].show =3D trip_point_temp_show;
>>+ =A0 =A0 =A0if (writeable) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0tz->trip_temp_attrs[indx].attr.mode |=3D=
 S_IWUSR;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0tz->trip_temp_attrs[indx].store =3D trip=
_point_temp_store;
>>+ =A0 =A0 =A0}
>>+
>>+ =A0 =A0 =A0return device_create_file(&tz->device, &tz->trip_temp_at=
trs[indx]);
>>+}
>>+
>>+/**
>> =A0* thermal_zone_device_register - register a new thermal zone devi=
ce
>> =A0* @type: =A0 =A0 the thermal zone device type
>> =A0* @trips: =A0 =A0the number of trip points the thermal zone suppo=
rt
>>+ * @flag: =A0 =A0 a bit string indicating the writeablility of trip =
points
>> =A0* @devdata: =A0private device data
>> =A0* @ops: =A0 =A0 =A0standard thermal zone device callbacks
>> =A0* @tc1: =A0 =A0 =A0thermal coefficient 1 for passive calculations
>>@@ -1130,7 +1154,7 @@ EXPORT_SYMBOL(thermal_zone_device_update);
>> =A0* section 11.1.5.1 of the ACPI specification 3.0.
>> =A0*/
>> struct thermal_zone_device *thermal_zone_device_register(char *type,
>>- =A0 =A0 =A0int trips, void *devdata,
>>+ =A0 =A0 =A0int trips, int flag, void *devdata,
>> =A0 =A0 =A0 const struct thermal_zone_device_ops *ops,
>> =A0 =A0 =A0 int tc1, int tc2, int passive_delay, int polling_delay)
>> {
>>@@ -1199,9 +1223,15 @@ struct thermal_zone_device *thermal_zone_devic=
e_register(char *type,
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 for (count =3D 0; count < trips; count++) {
>>- =A0 =A0 =A0 =A0 =A0 =A0 =A0TRIP_POINT_ATTR_ADD(&tz->device, count, =
result);
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0result =3D create_trip_type_attr(tz, cou=
nt);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (result)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto unregister;
>>+
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0result =3D create_trip_temp_attr(tz, cou=
nt,
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0(flag & (1 << count)));
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0if (result)
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto unregister;
>>+
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 tz->ops->get_trip_type(tz, count, &trip_=
type);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (trip_type =3D=3D THERMAL_TRIP_PASSIV=
E)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 passive =3D 1;
>>@@ -1279,9 +1309,10 @@ void thermal_zone_device_unregister(struct the=
rmal_zone_device *tz)
>> =A0 =A0 =A0 if (tz->ops->get_mode)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_remove_file(&tz->device, &dev_att=
r_mode);
>>
>>- =A0 =A0 =A0for (count =3D 0; count < tz->trips; count++)
>>- =A0 =A0 =A0 =A0 =A0 =A0 =A0TRIP_POINT_ATTR_REMOVE(&tz->device, coun=
t);
>>-
>>+ =A0 =A0 =A0for (count =3D 0; count < tz->trips; count++) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0device_remove_file(&tz->device, &tz->tri=
p_type_attrs[count]);
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0device_remove_file(&tz->device, &tz->tri=
p_temp_attrs[count]);
>>+ =A0 =A0 =A0}
>> =A0 =A0 =A0 thermal_remove_hwmon_sysfs(tz);
>> =A0 =A0 =A0 release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
>> =A0 =A0 =A0 idr_destroy(&tz->idr);
>>diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>>index 47b4a27..4aa5a45 100644
>>--- a/include/linux/thermal.h
>>+++ b/include/linux/thermal.h
>>@@ -58,6 +58,8 @@ struct thermal_zone_device_ops {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum thermal_trip_type *);
>> =A0 =A0 =A0 int (*get_trip_temp) (struct thermal_zone_device *, int,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned lon=
g *);
>>+ =A0 =A0 =A0int (*set_trip_temp) (struct thermal_zone_device *, int,
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned lon=
g);
>> =A0 =A0 =A0 int (*get_crit_temp) (struct thermal_zone_device *, unsi=
gned long *);
>> =A0 =A0 =A0 int (*notify) (struct thermal_zone_device *, int,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enum thermal_trip_type);
>>@@ -89,6 +91,8 @@ struct thermal_zone_device {
>> =A0 =A0 =A0 int id;
>> =A0 =A0 =A0 char type[THERMAL_NAME_LENGTH];
>> =A0 =A0 =A0 struct device device;
>>+ =A0 =A0 =A0struct device_attribute trip_temp_attrs[THERMAL_MAX_TRIP=
S];
>>+ =A0 =A0 =A0struct device_attribute trip_type_attrs[THERMAL_MAX_TRIP=
S];
>> =A0 =A0 =A0 void *devdata;
>> =A0 =A0 =A0 int trips;
>> =A0 =A0 =A0 int tc1;
>>@@ -137,9 +141,9 @@ enum {
>> };
>> #define THERMAL_GENL_CMD_MAX (__THERMAL_GENL_CMD_MAX - 1)
>>
>>-struct thermal_zone_device *thermal_zone_device_register(char *, int=
, void *,
>>- =A0 =A0 =A0 =A0 =A0 =A0 =A0const struct thermal_zone_device_ops *, =
int tc1, int tc2,
>>- =A0 =A0 =A0 =A0 =A0 =A0 =A0int passive_freq, int polling_freq);
>>+struct thermal_zone_device *thermal_zone_device_register(char *, int=
, int,
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0void *, const struct thermal_zone_device=
_ops *, int tc1,
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0int tc2, int passive_freq, int polling_f=
req);
>> void thermal_zone_device_unregister(struct thermal_zone_device *);
>>
>> int thermal_zone_bind_cooling_device(struct thermal_zone_device *, i=
nt,
>>--
>>1.7.1
>>
>
> _______________________________________________
> linaro-dev mailing list
> linaro-dev@lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-dev
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
