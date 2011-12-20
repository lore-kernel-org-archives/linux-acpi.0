From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [linux-pm] [RFC PATCH 1/2] thermal: Add a new trip type to use
 cooling device instance number
Date: Tue, 20 Dec 2011 13:37:22 +0100
Message-ID: <CAKfTPtCVtWfdUpW=Up6eWTsceBCfER5NcvjF1KRTNcqys2YArQ@mail.gmail.com>
References: <1323789196-4942-1-git-send-email-amit.kachhap@linaro.org>
	<1323789196-4942-2-git-send-email-amit.kachhap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:61342 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920Ab1LTMhX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Dec 2011 07:37:23 -0500
In-Reply-To: <1323789196-4942-2-git-send-email-amit.kachhap@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Amit Daniel Kachhap <amit.kachhap@linaro.org>
Cc: linux-pm@lists.linux-foundation.org, linaro-dev@lists.linaro.org, patches@linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Hi Amit,

I'm not sure that using the trip index for setting the state of a
cooling device is a generic solution because you are adding a
dependency between the trip index and the cooling device state that
might be difficult to handle. This dependency implies that a cooling
device like cpufreq_cooling_device must be registered in the 1st trips
of a thermal_zone which is not possible when we want to register 2
cpufreq_cooling_devices in the same thermal_zone.
You should only rely on the current and last temperatures to detect if
a trip_temp has been crossed and you should increase or decrease the
current state of the cooling device accordingly.

something like below should work with cpufreq_cooling_device and will
not add any constraint on the trip index. The state of a cooling
device is increased/decreased once for each trip

+		case THERMAL_TRIP_STATE_ACTIVE:
+			list_for_each_entry(instance, &tz->cooling_devices,
+					    node) {
+				if (instance->trip !=3D count)
+					continue;
+
+				cdev =3D instance->cdev;
+
+				if ((temp >=3D trip_temp)
+					&& (trip_temp > tz->last_temperature)) {
+					cdev->ops->get_max_state(cdev,
+							&max_state);
+					cdev->ops->get_cur_state(cdev,
+							&current_state);
+					if (++current_state <=3D max_state)
+						cdev->ops->set_cur_state(cdev,
+								current_state);
+				}
+				else if ((temp < trip_temp)
+					&& (trip_temp <=3D tz->last_temperature)) {
+					cdev->ops->get_cur_state(cdev,
+							&current_state);
+					if (current_state > 0)
+						cdev->ops->set_cur_state(cdev,
+								--current_state);
+			}
+			break;

Regards,
Vincent

On 13 December 2011 16:13, Amit Daniel Kachhap <amit.kachhap@linaro.org=
> wrote:
> This patch adds a new trip type THERMAL_TRIP_STATE_ACTIVE. This
> trip behaves same as THERMAL_TRIP_ACTIVE but also passes the cooling
> device instance number. This helps the cooling device registered as
> different instances to perform appropriate cooling action decision in
> the set_cur_state call back function.
>
> Also since the trip temperature's are in ascending order so some logi=
c
> is put in place to skip the un-necessary checks.
>
> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
> ---
> =A0Documentation/thermal/sysfs-api.txt | =A0 =A04 ++--
> =A0drivers/thermal/thermal_sys.c =A0 =A0 =A0 | =A0 27 +++++++++++++++=
+++++++++++-
> =A0include/linux/thermal.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A03 files changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/ther=
mal/sysfs-api.txt
> index b61e46f..5c1d44e 100644
> --- a/Documentation/thermal/sysfs-api.txt
> +++ b/Documentation/thermal/sysfs-api.txt
> @@ -184,8 +184,8 @@ trip_point_[0-*]_temp
>
> =A0trip_point_[0-*]_type
> =A0 =A0 =A0 =A0Strings which indicate the type of the trip point.
> - =A0 =A0 =A0 E.g. it can be one of critical, hot, passive, active[0-=
*] for ACPI
> - =A0 =A0 =A0 thermal zone.
> + =A0 =A0 =A0 E.g. it can be one of critical, hot, passive, active[0-=
1],
> + =A0 =A0 =A0 state-active[0-*] for ACPI thermal zone.
> =A0 =A0 =A0 =A0RO, Optional
>
> =A0cdev[0-*]
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_=
sys.c
> index dd9a574..72b1ab3 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -192,6 +192,8 @@ trip_point_type_show(struct device *dev, struct d=
evice_attribute *attr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return sprintf(buf, "passive\n");
> =A0 =A0 =A0 =A0case THERMAL_TRIP_ACTIVE:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return sprintf(buf, "active\n");
> + =A0 =A0 =A0 case THERMAL_TRIP_STATE_ACTIVE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "state-active\n");
> =A0 =A0 =A0 =A0default:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return sprintf(buf, "unknown\n");
> =A0 =A0 =A0 =A0}
> @@ -1035,7 +1037,7 @@ EXPORT_SYMBOL(thermal_cooling_device_unregister=
);
> =A0void thermal_zone_device_update(struct thermal_zone_device *tz)
> =A0{
> =A0 =A0 =A0 =A0int count, ret =3D 0;
> - =A0 =A0 =A0 long temp, trip_temp;
> + =A0 =A0 =A0 long temp, trip_temp, max_state, last_trip_change =3D 0=
;
> =A0 =A0 =A0 =A0enum thermal_trip_type trip_type;
> =A0 =A0 =A0 =A0struct thermal_cooling_device_instance *instance;
> =A0 =A0 =A0 =A0struct thermal_cooling_device *cdev;
> @@ -1086,6 +1088,29 @@ void thermal_zone_device_update(struct thermal=
_zone_device *tz)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0cdev->ops->set_cur_state(cdev, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case THERMAL_TRIP_STATE_ACTIVE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_for_each_entry(ins=
tance, &tz->cooling_devices,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ins=
tance->trip !=3D count)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 continue;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (tem=
p <=3D last_trip_change)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 continue;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cdev =3D=
 instance->cdev;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cdev->o=
ps->get_max_state(cdev, &max_state);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((te=
mp >=3D trip_temp) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 ((count + 1) <=3D max_state))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 cdev->ops->set_cur_state(cdev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count + 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if=
 ((temp < trip_temp) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (count <=3D max_state))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 cdev->ops->set_cur_state(cdev, count);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 last_tr=
ip_change =3D trip_temp;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case THERMAL_TRIP_PASSIVE:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (temp >=3D trip_tem=
p || tz->passive)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0therma=
l_zone_device_passive(tz, temp,
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 47b4a27..d7d0a27 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -42,6 +42,7 @@ enum thermal_trip_type {
> =A0 =A0 =A0 =A0THERMAL_TRIP_PASSIVE,
> =A0 =A0 =A0 =A0THERMAL_TRIP_HOT,
> =A0 =A0 =A0 =A0THERMAL_TRIP_CRITICAL,
> + =A0 =A0 =A0 THERMAL_TRIP_STATE_ACTIVE,
> =A0};
>
> =A0struct thermal_zone_device_ops {
> --
> 1.7.1
>
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-pm
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
