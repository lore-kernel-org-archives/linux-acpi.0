From: "John H." <mistamaila-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Acpi4asus-user] Asus S5000: Problems with Suspend-to-RAM
Date: Sat, 14 Jan 2006 19:08:06 -0600
Message-ID: <5b9417770601141708i34e0013fn7ac8b2a9346eb313@mail.gmail.com>
References: <200601142257.46188.jani-matti.hatinen@iki.fi>
	 <20060114230647.GA12613@hell.org.pl>
	 <5b9417770601141528h77410d57g9c9b6dbcbb2df72f@mail.gmail.com>
	 <5b9417770601141607l6912c3f3wb160c29142b216e4@mail.gmail.com>
	 <20060115010337.GA6244@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20060115010337.GA6244-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Content-Disposition: inline
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: =?ISO-8859-1?Q?Jani-Matti_H=E4tinen?= <jani-matti.hatinen-X3B1VOXEql0@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

i was wondering if this would be related to the fact that i cannot use
keys with things like syslinux unless i disable "auto detect"

i've also had to boot with
nolapic pci=noacpi

What exactly would i be looking for on those lists?

as far as video goes, i have  radeon on this laptop, and i was using
this script, which should be doing what video.txt requires, right?

#!/bin/sh

# if launched through a lid event and lid is open, do nothing
#echo "$1" | grep "button/lid" && grep -q open
/proc/acpi/button/lid/LID/state && exit 0

# remove USB 1.1 driver
rmmod ohci_hcd

# sync filesystem and clock
sync
/sbin/hwclock --systohc

# switch to console
FGCONSOLE=`fgconsole`
chvt 6
/usr/sbin/radeontool light off

# go to sleep
sleep 5
echo -n "mem" > /sys/power/state

# readjust the clock (it might be off a bit after suspend)
/sbin/hwclock --adjust
/sbin/hwclock --hctosys

# reload USB 1.1 driver
modprobe ohci_hcd

# turn on the backlight and switch back to X
radeontool light on
chvt $FGCONSOLE




On 1/14/06, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org> wrote:
> [trimmed Cc:, it's no longer related to acpi4asus]
>
> Thus wrote John H.:
> > wow! i stopped acpid. and suspend didn't power off on resume from
> > hitting one of the mm keys!
> >
> > the only problem is, the motor and stuff seems to resume, and it seems
> > to try to read the cdrw drive again, and the various lights are on,
> > but
> >
> > 1. i cannot use any key, even caps lock does not turn on
>
> Search acpi-devel archives, I believe this was reported recently.
>
> > 2. i see nothing on the display
>
> Documentation/power/video.txt
> Best regards,
>
> --
> Karol 'sziwan' Kozimor
> sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
