From: "Shem Multinymous" <multinymous@gmail.com>
Subject: Re: Generic battery interface
Date: Fri, 28 Jul 2006 03:27:00 +0300
Message-ID: <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
	 <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com>
	 <20060727232427.GA4907@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:51601 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750760AbWG1A1C (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Jul 2006 20:27:02 -0400
Received: by ug-out-1314.google.com with SMTP id m3so543562ugc
        for <linux-acpi@vger.kernel.org>; Thu, 27 Jul 2006 17:27:01 -0700 (PDT)
In-Reply-To: <20060727232427.GA4907@suse.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>, Matthew Garrett <mjg59@srcf.ucam.org>, kernel list <linux-kernel@vger.kernel.org>, linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org

Hi,

On 7/28/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > Battery polling is already used extensively, and its overhead is
> > completely negligible.
>
> You're joking, right? On quite a number of laptops, it takes quite a
> while to read the battery, spent in BIOS through SMI, polling the I2C
> bus while talking to the battery. The less often this is done, the
> better.

Yes, I know -- tp_smapi does that too. And it's still negligible,
usually a few microseconds.

Heck, the hdaps driver polls that same I2C bus 50 times per seconds
and still doesn't tickle the load average.


> > I'm yet to see any deployed userspace code
> > trying to query battery status more than once per second.
>
> The applets that were doing it (yes, up to 100 times per second)
> corrected their ways pretty quickly, because some machines became
> unusable with the applet enabled.

Exactly -- and they've been working merrily ever since.
And if you don't want to trust applet developers, cache the latest
reads and refresh them only if X jiffies have passed.


> You could, trivially, mirror the behavior of current applets: Not report
> the changes to the battery status more often than each N seconds, except
> for critical events.

You're taking a polling-based hardware, exposing it as an event-based
interface, and then and kludging it so that it behaves like polling
again...

So, in this scheme, how many lines of code does is the equivalent of
"cat /sys/devices/platform/smapi/BAT0/voltage"?


> > And you'll need to identify devices in a useful way, a problem that's
> > not yet solved even for input devices... You see where it's going.
>
> May you be more specific here? I'm not aware of any problems in this
> area. This may be my fault: What needs to be fixed there?

"Generic interface for accelerometers (AMS, HDAPS, ...)" on LKML, a
few weeks ago, about moving accelerator-based hard disk parking from
sysfs polling to the the input infrastructure. One unresolved issue
was how to find which input device happens to be the relevant
accelerometer.

  Shem
