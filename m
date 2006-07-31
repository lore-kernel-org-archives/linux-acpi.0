From: "Shem Multinymous" <multinymous@gmail.com>
Subject: Re: Generic battery interface
Date: Tue, 1 Aug 2006 01:34:30 +0300
Message-ID: <41840b750607311534n31e45ca4xbbf98bf4c8085cea@mail.gmail.com>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
	 <20060727232427.GA4907@suse.cz>
	 <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com>
	 <20060728074202.GA4757@suse.cz>
	 <41840b750607280814x50db03erb30d833802ae983e@mail.gmail.com>
	 <20060728202359.GB5313@suse.cz>
	 <41840b750607281548h5ee2219eka1de6745b692c092@mail.gmail.com>
	 <41840b750607291406p2f843054rc89fa1c3c467688d@mail.gmail.com>
	 <41840b750607301137t1e10fe88o3a1c73e7a4b4bf44@mail.gmail.com>
	 <20060731233536.92b39035.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:55615 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030358AbWGaWec (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 31 Jul 2006 18:34:32 -0400
Received: by ug-out-1314.google.com with SMTP id m3so1017343ugc
        for <linux-acpi@vger.kernel.org>; Mon, 31 Jul 2006 15:34:30 -0700 (PDT)
In-Reply-To: <20060731233536.92b39035.khali@linux-fr.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>, Matthew Garrett <mjg59@srcf.ucam.org>, kernel list <linux-kernel@vger.kernel.org>, linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@debian.org>, Mark Underwood <basicmark@yahoo.com>, Greg KH <greg@kroah.com>

Hi Jean,

On 8/1/06, Jean Delvare <khali@linux-fr.org> wrote:
> Disclaimer: I have no idea how the input interface works currently. And
> I don't know what problem you are trying to solve. I just thought my
> hwmon-oriented comments might help.

Your comments are highly relevant! Almost everything said in this
thread, apart from "where should we put battery readouts", is
applicable to hwmon.

The problem we're trying to solve is minimizing system load and timer
interrupts caused by apps that track kernel-issued readouts (e.g.,
hwmon's), without the application making unnecessary assumptions about
the driver or vice versa.


> > 1. A new ioctl DELAYED_UPDATE, with parameters min_wait and
> >    min_fresh, meaning: "I want an a fresh readout. If I poll() this FD
> >    with POLLIN then send an input-ready event at time is T+min_wait, or
> >    when you have a readout that was received from the hardware at  time
> >    T+min_fresh, whichever is *later*. Likewise if I select()".
> >    Here T is the time of the ioctl call and min_wait>=min_fresh.
>
> "A or B, whichever is later", effectively means "A and B". Or am I
> missing something?

The equivlent phrasing using "and" is s follows:

"as soon as the current time is at least T+min_wait *and* you have a
readout that was received from the hardware at  time at least
T+min_fresh."


> I fail to see the difference between min_wait and min_fresh.

Here's an example illustrating all parameters.

Suppose the app does a DELAYED_UPDATE with min_wait=700 and
min_fresh=1000 at time T, and then poll()s with a timeout of 9999.

At time T+600 the driver receives update events (yeah, it' that kind
of driver). If this is all that happens, the app will remain blocked
for 9999ms -- the requirement for a readout fresher than T+700 is
never fulfilled.

If the driver get a second event at time T+800, the app will be
unblocked at time T+1000. If, instead, the driver gets the second
event at time T+1200, the app will be unblocked immediately.


> The hwmon interface (sysfs now, procfs before) has been returning
> cached values by defaut for years. Changing this at this point might be
> confusing.

Yes. All those should be told to use O_NONBLOCK, or be delayed by one
readout cycle whenever they poll an attribute. How serious is this?

The essential problem is that we don't want drivers to query the
hardware and cause timer interrups when nobody's listening, so cached
values can get arbitrarily stale. Thus, an out-of-the-blue read by a
*must* wait for a refresh (i.e., hardware query). I don't see a
non-kludgy way out of it.


> I don't see much benefit in waiting for updated values
> compared to reading them from the cache. The driver knows better how
> frequently it can read from the chip.

Yes, but the driver doesn't know how frequently apps *need* it to read
from the chip.

Take the hdaps driver, for example. The hardware can provide fresh
readouts at a rate of 500Hz. Some apps (e.g., hdapsd) actually need a
high poll rate. Others (e.g., joystick emulation and hdaps-gl) work
nicely with 20Hz. And the tp-theft app will be useful even with 1Hz,
and may change its poll rate depending on circumstances. So, what is
the driver supposed to do?

In my proposal, the the driver and all app (implicitly) negotiate a
poll rate which makes sense for all parties involved.


> And no hardware monitoring chip I
> know of can tell when the monitored value has changed - you have to read
> the chip registers to know.

Yes, this may not be relevant for traditional hwmon chips, but we're
trying to handle event-based data sources too. You might get an ACPI
event on temperature change, or a "critical temperature" interrupt
(which flips a boolean sysfs attr) , etc. I can't think of a really
convincing example, but we certainly want an interface that will
support such drivers transparently to userspace.


> > To illustrate, here's an example of a proper polling loop (sans error
> > checking). This app wants to refresh its display when the data has
> > changed, but not more often than once per second. It wants the
> > readouts to be reasonly spaced: they should be obtained at least 700ms
> > apart. And it needs to update its GUI every 3 seconds regardless of
> > readouts.
>
> I don't see the point in the 700ms rule. If you don't want new data
> more often than once per second, the readouts will be spaced by one
> second, which implies > 700ms already.

Only on average. If you use min_wait=1000 and min_fresh=0, you might
be seeing cached readouts that were obtained at times
999,1001,2999,3001,4999,5001,...
which is probably not what you want.


> No seek(fd, ..., 0) here? sysfs files are supposed to be simple text
> files, aren't they?

Yes, for sysfs there's a seek(fd, ..., 0). There isn't one if you use
the input infrastructure's approach, where read()s return a stream of
event records.

  Shem
