From: "Shem Multinymous" <multinymous@gmail.com>
Subject: Re: Generic battery interface
Date: Sat, 29 Jul 2006 14:32:02 +0300
Message-ID: <41840b750607290432m6d302cdoae7f3eef869279d4@mail.gmail.com>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
	 <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com>
	 <20060727232427.GA4907@suse.cz>
	 <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com>
	 <20060728074202.GA4757@suse.cz>
	 <41840b750607280814x50db03erb30d833802ae983e@mail.gmail.com>
	 <20060728202359.GB5313@suse.cz>
	 <41840b750607281548h5ee2219eka1de6745b692c092@mail.gmail.com>
	 <20060729103613.GB7438@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:65518 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932607AbWG2LcE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 29 Jul 2006 07:32:04 -0400
Received: by ug-out-1314.google.com with SMTP id m3so103528ugc
        for <linux-acpi@vger.kernel.org>; Sat, 29 Jul 2006 04:32:02 -0700 (PDT)
In-Reply-To: <20060729103613.GB7438@suse.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>, Matthew Garrett <mjg59@srcf.ucam.org>, kernel list <linux-kernel@vger.kernel.org>, linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@debian.org>

On 7/29/06, Vojtech Pavlik <vojtech@suse.cz> wrote:

> I think we're hitting a fundamental problem with sysfs/hotplug/udev
> here. It was created to get fixed, non-changing names of devices in
> /dev, so that they'd be easy to enter into configuration files.
>
> Yet applications today want automatic discovery of devices and don't
> want to rely on udev getting the names right.
>
> We should make our minds up, and decide whether we want the 'devices are
> in /dev and applications just need to open the filename' or the 'an
> application will find the device itself' approach.

I think what people want from device choice is a reasonable default
plus a convenient way to override things. The former is handled nicely
by distributions' udev rules, while the latter is best done by
providing fixed paths. As an end-user, if I know my favorite joystick
is on a specific USB port (hence a specific syfs directory), then I
want to tell neverball "use that one" without setting up nasty udev
rules or playing major:minor matchup. Yes, that's bypassing the Proper
Udevian Way of Doing Things, but it's so much easier and Unix-like
that we really should make it possible (though not by default!).

Security issues aside (for a moment):
Is there any reason not to provide real device inodes on sysfs,
instead of just a textual /sys/foo/dev? And then, maybe udev should
symlink to those device files under /sys instead of creating its own?
This would tie the two systems together rather elegantly.


> This reminds me very much of the Joerg Schilling discussion (flamewar)
> of enumerating CD-burners. Most people on the kernel mailing list just
> wanted to enter the name of the device node on the cdrecord command
> line. Yet Joerg insisted that the application should do the discovery.

I think there's a lot more to *that* flamewar - such as unwavering
belief in generic scsi...


> > If you rattle your ThinkPad this badly, latency in Neverball is going
> > to be the least of your problems. :-)
>
> HDAPS, as explained above, doesn't have huge latency impact. The reason
> to have high update rates for input devices (mice nowadays run at 100 Hz
> refresh usually, gaming mice up to 1 kHz), is to not introduce
> additional delay to the user->computer->user closed control loop.
>
> The less delay, the better stability of the control loop and the better
> results in the game. The limiting factor is usually 3D rendering, but a
> 10 Hz joystick will still kill the experience by inducing a much larger
> delay.

Yes, I understand. I just pointed out that in the specific case of
system accelerometer readouts, either the readouts change very slowly
or your laptop is being rattled into an early death.


> Sort of a 'reverse select'.

Exactly.


  Shem
