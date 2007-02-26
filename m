From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Re: [lm-sensors] RFC: conversion of ibm-acpi to
	hwmon sysfs
Date: Mon, 26 Feb 2007 15:06:35 -0300
Message-ID: <20070226180635.GG2909@khazad-dum.debian.net>
References: <20070224182024.GA23865@khazad-dum.debian.net>
	<20070226172716.b2e956b7.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20070226172716.b2e956b7.khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 26 Feb 2007, Jean Delvare wrote:
> > However, some thinkpad thermal sensors are hotswappable (they're inside
> > battery packs, for example).  What is the recommended way to deal with that?
> > 
> > I was planning to return -ENXIO for sensors thare are currently unavailable,
> > and I could also try to make their sysfs attributes go away (and come back
> > again) when the driver detects such a change -- note that I don't get events
> > from the thinkpad firmware when a sensor gets disconnected or reconnected, I
> > need to poll them to know that).  Is that the recommended way to go about
> > it?  Or should I just leave all entries there and return -ENXIO on the
> > invalid ones (the firmware returns -128 for invalid sensors).
> 
> Had you been able to detect disconnections and reconnections as they
> happen, removing and creating the files on the file would have been
> nice. But as you can't do that, returning -ENXIO on disconnected
> sensors sounds sensible. I don't think any other driver does this at
> the moment though, so maybe libsensors will need to be updated to
> handle this behavior properly.

Ok. -ENXIO it is, that will be a lot easier on the code side too.

> > fan control is a bit more hard to map to the hwmon interface, as the
> > thinkpad firmware exports a higher level interface than your regular
> > thermal-and-fan-monitor chip (and it is far less documented and far more
> > buggy than regular chips :p):
> > 
> > Most thinkpads have a tachometer that returns data in RPM, and that gets
> > mapped to fan##_input.  The tachometer can get stale in fan control
> > disengaged mode (see below), how should I export that information to
> > userspace?  There is nothing in the standard hwmon sysfs for that, and it
> > *is* useful to userspace to know the last measured speed, so I don't want to
> > return -ENXIO or somesuch on fan##_input...   What do you guys suggest I do?
> > Add an ibm-acpi specific fan##_input_valid attribute that reads 0/1?  Or not
> > export that information in the first place?  Should I propose such an
> > attribute to the generic interface?
> 
> I'm surprised that the fan speed reading goes stale when a fan runs at
> max speed, it doesn't make much physical sense and it's quite the
> opposite of what happens usually: tachometers start failing when PWM
> modulation distorts the signal to much.

What can I say? Thinkpad firmware is weird. The EC simply stops updating the
tachometer registers when you tell it to go full-blast on the fans, that's
why we call it "disengaged" mode -- it disengages the control loop.  OTOH,
we got reports that some older ThinkPads (A30) do keep the tachometer
updated even while in full-blast mode
:p

> Either way, I do not think that knowing the last measured speed is that
> useful. Given that it may be completely unrelated with the current

It is, actually, because it lets one mess with the embedded controller and
completely override the fan control loop while not letting anyone else
notice (i.e. without disturbing fan monitor applets, etc).

Check http://thinkwiki.org/wiki/Embedded_Controller_Firmware and
http://thinkwiki.org/wiki/ACPI_fan_control_script if you are
curious about the whys for these weird things.

> value, I'd rather return -ENXIO or -ERETRY if there is a reasonable
> chance to get a valid reading soon after. If applications wants to

I will return the stale value or an error, then.  Not returning the stale
value actually requires that I implement some sort of back/white lists to
differentiate models which don't have the stale tachometer bug from those
that do... or I need to detect that the tachometer seems to be stuck.

-ERETRY doesn't make much sense, as the value will only be available when
disengaged mode is disabled, same goes for -EAGAIN.  -ENXIO seems to be the
best choice, as -ESTALE might confuse things, -EIO is for an real IO error,
etc.

> I don't want to see *_valid files being created, it doesn't add any
> value. Just try to read the data from the file, and check for errors.

Ok.

> > The thinkpad EC has three modes of fan operation: manual, where there are
> > seven fan speed levels (0=off, 1=slowest, 7=fastest) that map to different
> > speeds (usually fan stopped plus three different speeds, so it is not a 1:1
> > mapping).  auto, where it selects one of the levels by itself, and
> > disengaged, where it kicks the fan to its highest speed (which usually is
> > quite higher than level 7).  The levels are closed-loop-controlled, and
> > track a model-specific desired RPM value.  That allows for consistent
> > hardware behaviour with fans that are going old or are somewhat dirty.
> > 
> > I was thinking of using pwm##_enable to: force manual mode, level 0 (fan
> > off) when pwm##_enable is 0, force manual mode when it is 1, and force auto
> > mode when it is 2+.  I can query what mode the firmware is in, so reading
> > pwm##_enable is not a problem.
> 
> pwm#_enable = 0 means fan# at full speed, _not_ fan# stopped. Fan# stopped
> is pwm#_enable = 1 and pwm# = 0.

The hwmon sysfs interface documentation is not clear on that.  Turning PWM
off might lock the hardware into 0% duty or 100% duty depending on how it
was designed.

Anyway, I can map it to:
	pwm_enable = 0: disengaged mode on
		     1: manual mode on
		     2+: EC auto mode on (default)

no problem.

> > The level for manual mode would be set by pwm##: if it is 0, force level 0.
> > If it is between 1..90, I'd select one of the six non-stopped fan speed
> > levels.  If it is above 90, I'd select disengaged mode.
> 
> According to your description, the disengaged mode corresponds to
> pwm_enable = 0 (full speed), so I don't want it to be set automatically
> when the user writes a high value to pwm.

Ok. pwm = 0 in manual mode will stop fan, 1..255 will be mapped to 1..7 to
select the thinkpad fan level, which the EC itself will map to (usually)
three different speeds.

> Note that the "native" PWM scale is from 0 to 255, not 0 to 100 (I know
> it's somewhat confusing, but it's historical and makes drivers more
> simple.)

Thanks, I failed to notice that for some reason.

> You do not have to return the actual PWM value in automatic mode. Most
> chips don't report it and as a result most drivers don't. In automatic
> mode, pwm usually holds the value which would be set if manual mode was
> to be enabled. Only a few drivers report the current PWM value in
> automatic mode there.

Ok, thanks.

> > I was going to place all fan attributes in a sysfs group (subdirectory)
> > named "fan", and all thermal attributes in a sysfs group named "thermal". Is
> > that acceptable?
> 
> No, it's not, as it wouldn't be compatible with what all the other
> drivers do and what libsensors expects.

Very well.  No sysfs groups for fan or thermal.

BTW, ibm-acpi implements a "fan watchdog", to help fan-control userspace
applications.  It resets the fan to a safe "on" mode if nothing tries any
control operation on the fans in a given time period.

Is there any interest in trying for a fan-watchdog generic interface, or
should I just implement that in sysfs as I see fit for ibm-acpi?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
