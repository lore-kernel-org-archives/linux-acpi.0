From: "Ash Milsted" <thatistosayiseenem@gawab.com>
Subject: Re: 2.6.24-rc1 acpi battery driver -> sysfs interface does not update correctly
Date: Sun, 28 Oct 2007 13:06:51 +0100
Message-ID: <3e7b9f4b0710280506g18b9ec61h8cadc491877dd533@mail.gmail.com>
References: <3e7b9f4b0710241114u73ad1d4bl34070b4fd2b18d63@mail.gmail.com>
	 <471FABF5.1030406@gmail.com>
	 <3e7b9f4b0710241417i7f0edeel6d11b8a3e4048243@mail.gmail.com>
	 <471FBDF5.7000906@gmail.com>
	 <3e7b9f4b0710241528j403e2ecboc29e03438034349a@mail.gmail.com>
	 <3e7b9f4b0710241537i1d3db590u2220900e30ae0d1b@mail.gmail.com>
	 <472008C5.8030906@gmail.com>
	 <3e7b9f4b0710250231p2e562989s97033ee50d2e5ec2@mail.gmail.com>
	 <3e7b9f4b0710270952r3e7ff889qe628cf9ff0c8361e@mail.gmail.com>
	 <472373E9.3040207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.237]:57017 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbXJ1MGw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 28 Oct 2007 08:06:52 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1412100wxd
        for <linux-acpi@vger.kernel.org>; Sun, 28 Oct 2007 05:06:51 -0700 (PDT)
In-Reply-To: <472373E9.3040207@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: linux-acpi@vger.kernel.org

On 27/10/2007, Alexey Starikovskiy <aystarik@gmail.com> wrote:
> Ash Milsted wrote:
> > Hi again,
> > I just thought I'd say that this is still occuring with the current
> > linux-acpi-2.6 git tree on top of Linus' latest.. I don't get
> > (dis)charge uevents and, oddly, the sysfs charge_now value is
> As I remember, you did not found uevents in 2.6.23 as well?

Yeah, no uevents for (dis)charges or (un)plugs in 2.6.23.

> > initially wrong on boot-up. For some reason it gives a value of about
> > half the full charge of the battery (no matter what the true value is)
> > until I read it a couple of times, at which point it corrects itself.

Reading the sysfs value is, it turns out, not necessary to trigger
this single update (which also sends a change uevent). I guess this is
just the battery driver grabbing the initial value - after that there
are no more change uevents.

> > I attach a few extra details, in case they help.
> your acpidump output might be usefull at this point.

Attached.

> >
> > cat /sys/class/power_supply/BAT1/uevent
> > POWER_SUPPLY_NAME=BAT1
> > POWER_SUPPLY_TYPE=Battery
> > POWER_SUPPLY_STATUS=Charging
> > POWER_SUPPLY_PRESENT=1
> > POWER_SUPPLY_TECHNOLOGY=Unknown
> > POWER_SUPPLY_VOLTAGE_MIN_DESIGN=14800000
> > POWER_SUPPLY_VOLTAGE_NOW=14800000
> > POWER_SUPPLY_CURRENT_NOW=0
> > POWER_SUPPLY_CHARGE_FULL_DESIGN=4000000
> > POWER_SUPPLY_CHARGE_FULL=4000000
> > POWER_SUPPLY_CHARGE_NOW=1960000
> > POWER_SUPPLY_MODEL_NAME=PABAS005
> > POWER_SUPPLY_MANUFACTURER=TOSHIBA
> >
> > One odd thing about this is the TECHNOLOGY field - with the procfs
> > interface it is reported as lion, not "Unknown". As before, if I any
> > other info would help, just ask.
> I check against "LION" (strcasecmp), so lion should be recognized.
> Please take a look on dmesg with attached patch

Turns out that the string was "Li-Ion", not "lion".
...ACPI: unmatched technology 'Li-Ion'
I guess, chemically speaking, it's more precise :)

> Thanks,
> Alex.

No problem. One other thing - I just saw this is my dmesg...
Oct 28 13:41:49 tuktuk omnibook: Driver version 2.20070211-trunk.
Oct 28 13:41:49 tuktuk omnibook: Toshiba Satellite 1110 detected.
Oct 28 13:41:49 tuktuk omnibook: LCD backlight turn off at console
blanking is enabled.
Oct 28 13:41:49 tuktuk omnibook: Enabling all hotkeys.
Oct 28 13:41:49 tuktuk ACPI: EC: non-query interrupt received,
switching to interrupt mode

ACPI switched to interrupt mode only after the (out-of-tree) omnibook
driver loads. Will test without this module, however I know it was not
loaded when I tested 2.6.23.

Ash
