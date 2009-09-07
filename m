From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: RFC: Light sensors, unifying current options?
Date: Mon, 7 Sep 2009 10:10:09 +0200
Message-ID: <71cd59b00909070110o85030f9vd84850b781d587a5@mail.gmail.com>
References: <4A9FC9D7.20000@cam.ac.uk> <1252308744.3483.414.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:58833 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbZIGIKI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Sep 2009 04:10:08 -0400
In-Reply-To: <1252308744.3483.414.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, LKML <linux-kernel@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, "alan@linux.intel.com" <alan@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>, "Cory T. Tusar" <ctusar@videon-central.com>, "Trisal, Kalhan" <kalhan.trisal@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Mon, Sep 7, 2009 at 9:32 AM, Zhang Rui<rui.zhang@intel.com> wrote:
> Hi, Jonathan,
>
> On Thu, 2009-09-03 at 21:51 +0800, Jonathan Cameron wrote:
>> Dear All,
>>
>> This thread is a follow up to (amongst others)
>>
>> [lm-sensors] Ambient Light sensor for Intersil-ISL29020 device
>>
>> Currently there are a number of light sensor drivers either in the
>> mainline kernel, posted to various mailing lists or sitting in vario=
us
>> testing trees.
>>
>> For example.
>>
>> Intersil ISL29020
>> http://www.intersil.com/products/deviceinfo.asp?pn=3DISL29020 driver
>> posted by Kalan Trisal to lm-sensors (as hwmon device rejected for
>> being out of subsystem scope)
>> http://lists.lm-sensors.org/pipermail/lm-sensors/2009-September/0265=
75.html
>>
>> ALS_sysfs class and als_acpi driver (V6 posted to lkml earlier this =
week).
>> http://lkml.org/lkml/2009/9/1/38
>>
>> TSL2561 under the industrial I/O Framework. (in Greg KH's tree, will
>> being in staging after merge window - there due to lack of review
>> more than any known problems.)
>> http://www.farnell.com/datasheets/49661.pdf
>> http://lkml.org/lkml/2009/7/2/189
>>
>> TSL2550 under i2c/chips/ which as a location is going away.
>> http://www.farnell.com/datasheets/48715.pdf
>>
>> (any others people know of?)

asus-laptop have one, it exports power switch and sensitivity.
Josh Green did the patch, not me, and I don't have the hardware, so I
don't know exactly how sensitivy works.

>> Two big questions:
>>
>> * Are there sufficient shared characteristics between these devices =
to
>> all for a unified framework? (would certainly be nice!)
>>
>> * What applications are they used for? This will drive the question
>> of what functionality is desirable. (particularly do we need an even=
t
>> infrastructure or not).
>>
>> To sumarize the functionality currently provided by the above driver=
s
>> (or that should probably be added)
>>
>> ISL29020:
>> * sensing_range
>> * lux_level
>> * power state (should probably move over to the new power management
>> =C2=A0 framework)
>>
>> ALS:
>> * illuminance (equivalent of lux_level)
>> * adjustment (I don't follow the purpose of this, but then I don't k=
now
>> anything about how this is being used!)
>>
> adjustment is a percentage value used by userspace to adjust the disp=
lay
> backlight.
>
> According to the ACPI spec, ACPI ALS device has "ambient light
> illuminance to display luminance" mappings that can be used by an OS =
to
> calibrate its ambient light policy for a given sensor configuration. =
The
> OS can use this information to extrapolate an ALS response curve. i.e=
=2E
> ACPI ALS knows what to do when ambient light illuminance changes, but=
 it
> won't change the backlight. Instead, it exports this info to user spa=
ce
> via the "adjustment" attribute.
> user space applications can get this value and change the display
> brightness via the backlight sysfs I/F.
>
> IMO, the ALS device should do the following work:
> 1. catch the ambient light illuminance change.
> 2. tell the userspace what to do with this change.
> isn't this true for the other ALS devices in this thread?
>
>> TSL2561
>> * infrared (raw value)
>> * broad spectrum (raw value)
>> (I'm of the view any derived values should probably be done in users=
pace)
>> This one is under IIO at the moment for two reasons.
>> 1) I hit the same issue of no suitable subsystem, but for a much lar=
ger
>> class of sensor devices. Light sensors are just one example (that's =
not
>> to say I mind hiving this lot off to a system of their own).
>> 2) To provide an event interface (which I haven't yet done)
>> Driver should also include:
>> * integration time
>> * gain control
>>
>> TSL2550
>> * power state
>> * operating mode
>> * lux (actually calculated from two separate readings as
>> per the tsl2561 but the are not available to userspace)
>>
>> Applications:
>>
>> 1) Backlight intensity type apps (guessing that covers most people)
>> 2) Environmental monitoring apps (the crossbow imb400 imote2 daughte=
r
>> board I'm using doesn't have any screen or other direct interface, i=
ts
>> simply a lightweight sensor platform).
>> 3) High speed apps (all current sensors are pretty slow so this isn'=
t
>> yet relevant).
>>
>> My personal feelings is that the IIO is overkill for these types
>> of sensors (slow update rate, tsl2550 takes 400ms, tsl2561 12-400ms)
>> unless we want the event handling infrastructure. I'm inclined to
>> say it is unecessary given the same result could be obtained by
>> polling only a few times a second.
>>
> agree.
> this is not a problem to ACPI ALS device.
> ACPI sends a notification to the ACPI ALS device when illuminance is
> changed.
>
>> My comments on ALS may be wrong or misleading as they are based on a
>> brief read of the code (please correct me!) =C2=A0A lot of the
>> infrastructure is only necessary if we have in kernel users
>> =C2=A0(and at
>> the moment the functionality doesn't appear to be there for any such
>> users to acquire access to these sensors in the first place. =C2=A0F=
or
>> example, the approach used by hwmon of letting drivers define their
>> own attributes seems to me to be more easily extendable than ALS' us=
e
>> of an ops structure.
>
> =EF=BB=BFI agree that the ops structure is unnecessary.
> To make the als_sys class more generic, we just need to
> 1. defines the generic attributes that the native ALS driver must
> follow.
> 2. registers an als device in the als_sys class.
> and the native driver should be responsible for the sysfs attributes.
>
> Because my approach is made by reading the ACPI spec, I'm not sure wh=
at
> should be done in the native driver and what should be done in the
> generic driver at the beginning.
>
> thanks for pointing this out.
>
>> =C2=A0For example, I'm not convinced it makes sense for
>> drivers to have to have a get_adjustment attribute or indeed even
>> necessarily have a direct illuminance attribute (deriving the releva=
nt
>> value may be a case of userspace combining several associated
>> readings).
>
> what these associated readings are?
> I think we can define some optional attributes besides the required
> attributes.
> but we should make clear what is necessary for an ALS device, and wha=
t
> optional features it may support.
>
> thanks,
> rui
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>



--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
