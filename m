From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Re: [lm-sensors] [PATCH 8/9] ACPI: thinkpad-acpi:
	use a separate	platform device for hwmon and name it
Date: Mon, 24 Sep 2007 23:39:58 -0300
Message-ID: <20070925023958.GA15111@khazad-dum.debian.net>
References: <1190557457539-git-send-email-hmh@hmh.eng.br>
	<11905574583315-git-send-email-hmh@hmh.eng.br>
	<20070924171128.19f91009@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20070924171128.19f91009-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, LM Sensors ML <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 24 Sep 2007, Jean Delvare wrote:
> On Sun, 23 Sep 2007 11:24:16 -0300, Henrique de Moraes Holschuh wrote:
> > Use a separate platform device to attach hwmon attributes and class, and
> > add a name attribute of "thinkpad_hwmon" to it.  To do it properly, we
> > also register a new platform driver ("thinkpad_hwmon").
> 
> The name attribute should really read "thinkpad" not "thinkpad_hwmon",
> otherwise "sensors" will present the chip as "thinkpad_hwmon-isa-0000",
> its section in /etc/sensors.conf will be named chip "thinkpad_hwmon-*",
> etc. That's pretty redundant and unaesthetic.

-isa- in platform drivers where there is not even a ISA bus in sight is also
very unaesthetic.

That said, I will change it to "thinkpad", but I still would rather have
thinkpad-platform from a cosmetic point of view, than thinkpad-isa-0001.

> > This makes thinkpad-acpi compatible with libsensors4 from lm-sensors, and
> > the platform driver and device split will make it much easier to separate
> > hwmon functionality into its own module later on.
> 
> I'm still not convinced that we want a separate device for this. If you

It is there for ease of breaking thinkpad-acpi into many modules.  It makes
life easier for me, and also it makes it pretty damn clear to userspace
app writers that they better use the proper ABI (libsensors4) or else.

> have a namespace issue, it's because the hwmon attributes are created
> directly in the device directory (for historical reasons) while they
> should be created in the hwmon class device directory. I'd rather work
> on fixing this now, than use a temporary workaround as you are
> proposing.

As I said, I have now another reason for the split.  The major mess of a
bunch of classes inside the device directory is annoying, but since you want
to fix that I wouldn't move the attributes to another device just for that
reason anymore.

> > Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
> > Cc: LM Sensors ML <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
> 
> It's pretty pointless to have a mailing list listed here, as the list
> itself can't ack nor nack your patch.

People in the list certainly can :-)  But if you'd rather I cc you directly,
I will change it.

> > -Sysfs device attributes are on the driver's sysfs attribute space,
> > -for 2.6.20 this is /sys/devices/platform/thinkpad_acpi/.
> > +Sysfs device attributes are on the thinkpad_acpi device sysfs attribute
> > +space, for 2.6.20 this is /sys/devices/platform/thinkpad_acpi/.
> 
> That's confusing. You keep mentioning version 2.6.20 when your patch
> will not make it into mainline before 2.6.24 at best.

I will update it.

> > -sysfs device attributes: (hwmon) fan_input, pwm1, pwm1_enable
> > +sysfs device attributes: (hwmon "thinkpad_hwmon") fan_input, pwm1,
> > +			  pwm1_enable
> 
> fan_input is not a valid attribute name, should be fan1_input.

Typo, the driver exports it as fan1_input.  Will fix, thanks for noticing
it.

> > +0x020000:	ABI fix: added a separate hwmon platform device and
> > +		driver, which must be located by name (thinkpad_hwmon)
> > +		and the hwmon class for lm_sensors4 compatibility.
> 
> There's no lm_sensors4. It's either lm-sensors 3, or libsensors4. (I
> know it's confusing, not my fault.)

Ok. Will fix.

> > -	tpacpi_hwmon = hwmon_device_register(&tpacpi_pdev->dev);
> > +	tpacpi_sensors_pdev = platform_device_register_simple(
> > +							IBM_HWMON_DRVR_NAME,
> > +							-1, NULL, 0);
> 
> As explained before, libsensors won't pick this device. You'd need to
> give it an id of 0 instead of -1. Hmm, I'll see if I can hack something
> in libsensors4 until that part of the code is reimplemented in a better
> way.

It really doesn't matter to me, as I used a new device.  I could change it
rather easily.  But since other platform drivers might not be in the same
position and it is more semanthically correct to have a device unique when
it IS unique...  IMHO it would be best to just keep it at -1, as you changed
libsensors4 to not care about it already.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
