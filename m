From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [patch update] Re: [linux-pm] Run-time PM idea (was: Re:
	[RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Thu, 11 Jun 2009 14:18:46 +0900
Message-ID: <aec7e5c30906102218j2f8f38dbt5d05a3928ca46c15@mail.gmail.com>
References: <Pine.LNX.4.44L0.0906082233490.19072-100000@netrider.rowland.org>
	 <200906100057.04473.rjw@sisk.pl> <200906101029.27529.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:2200 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432AbZFKFSo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Jun 2009 01:18:44 -0400
In-Reply-To: <200906101029.27529.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oliver@neukum.org>, linux-pm@lists.linux-foundation.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Hi Rafael,

On Wed, Jun 10, 2009 at 5:29 PM, Rafael J. Wysocki<rjw@sisk.pl> wrote:
>> I tried to address your comments and the Oliver's comments too in th=
e new
>> version of the patch below. =A0Please have a look and tell me what y=
ou think.
>
> Argh, I forgot about some important things.
>
> First, there are devices with no parent (actually, it would be much e=
asier if
> they had a default dummy parent, but that's a separate issue).
>
> Second, the parent has to be taken into account in the asynchronous r=
esume
> path too (which BTW is more complicated).
>
> Finally, I decided to follow the Oliver's suggestion that some error =
codes returned
> by ->autosuspend() and ->autoresume() may be regarded as "go back to =
the
> previous state" information. =A0I chose to use -EAGAIN and -EBUSY for=
 this
> purpose.
>
> Updated patch follows, sorry for the confusion.

Thanks for your work on this. I think the patch looks very good in
general so I will not comment on the code itself. I do however have a
few high level questions:

Q1) Regarding pm_request_suspend(), would it be possible to get a
synchronous version or to make use of the completion somehow?

Q2) As pm_request_suspend() works today, the device is marked as
RPM_IDLE and the delayed work is queued up. There is no real decision
making going on except the time out. I'd like to let the bus code
decide when to autosuspend a buch of devices. Maybe the idle handling
should be broken out into a pm_request_idle() and pm_request_suspend()
can be modified to synchronously suspend devices marked with
pm_request_idle()?

Q3) Have you thought about how device drivers can inform the Runtime
PM that the device are idle and that they need the hardware to be
woken up? I'd like something similar to my "[PATCH 02/04] Driver Core:
Add idle and wakeup functions" patch but maybe not specific to
platform devices. We talked about adding some hooks to the bus_type
for this. Any ideas?

This is how I'm thinking of integrating your Runtime PM code with our
SuperH platform devices:

Device Idle Handling:

1) Device drivers call pm_device_idle() (See Q3) which invokes arch
specific platform bus code in the case of our SoC platform devices.
This bus code marks the device as idle using pm_request_idle(). (See
Q2). At this point light weight power management like clock stopping
may be performed as well.

2) The arch specific bus code knows how the platform devices are
grouped together (thanks to the data area in "[PATCH] Driver Core: Add
platform device arch data V3"), and when all devices in one power
domain are marked as idle the bus code calls the synchronous
pm_request_suspend() (no delay).

3) When all devices in the power domain are suspended the bus code can
turn off the power. The reason why I'd like to only autosuspend when
all devices are idle is simply that we don't get any power savings
from the per device autosuspend() callbacks, only from turning off
power to the entire per-domain. So bindly autosuspending and
autoresuming devices is just pure overhead unless we know we can do it
for all devices in the domain.

4) Over time when the code in 2) should be extended to handle latencies=
=2E

Device Wakeup Handling:

1) Device drivers call pm_device_wakeup() (See Q3). This invokes arch
specific bus code for our SoC platform devices. The bus code enables
clocks if needed and also calls pm_resume_sync().

2) After the call to pm_resume_sync() the pm_device_wakeup() call
returns and the device driver can access the hardware as usual.

That's it! Far from perfect but maybe a good start at least.

I have seen quite a few patches from you lately, nice work. To make
tracking of the Runtime PM patches easier, can you pleae consider
including the version of the patch in the subject when you post new
versions?

Thanks!

/ magnus
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
