From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RFC] Shutdown on thermal HOT event if no userspace tool
 registered being able to do S4
Date: Mon, 12 Apr 2010 10:38:14 +0800
Message-ID: <1271039894.7167.113.camel@rzhang1-desktop>
References: <201003301123.10711.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:42503 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752297Ab0DLChS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 11 Apr 2010 22:37:18 -0400
In-Reply-To: <201003301123.10711.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Joey Lee <jlee@novell.com>, Holger Macht <hmacht@suse.de>, Rafael Wysocki <rwysocki@suse.de>

On Tue, 2010-03-30 at 17:23 +0800, Thomas Renninger wrote:
> Hi,
> 
> this is related to:
> commit fa80945269f312bc609e8384302f58b03c916e12
>     ACPI thermal: Don't invalidate thermal zone if critical trip point is bad
> and
> commit 8b7ef6d8f16274da42344cd50746ddb1c93c25ea
>     ACPI thermal: Check for thermal zone requirement
> 
> There the critical trip point is replaced with the hot trip
> point if latest Windows OS is detected (Vista also? I think yes,
> but need to double check).
> 
> This seem to get more common and it looks like Windows suggests
> to use hot trip points for thermal emergency shutdowns (S4).
> It looks like the default Windows thermal emergency power off is
> S4. Thus the hot trip point is used and the critical trip point
> is of no use anymore (and often gets replaced or is invalid).
> 
> As thermal emergency shut down is something urgent there is this
> direct call /sbin/poweroff in orderly_poweroff(true) compare with
> kernel/sys.c and drivers/thermal/thermal_sys.c
> This won't work in above cases when BIOS writers assume the machine
> is shut down with _HOT already and do not provide _CRT anymore.
> 
> My idea is to also shutdown the system on _HOT by default,
> the same way as done if _CRT is exceeded as long as no userspace
> explicitly set a sysfs (only one file set by thermal_sys.c somewhere
> in /sys?).
> Background is that S4 needs some setup (e.g. swap) or userspace hooks
> to make sure S4 succeeds and everything (network, whatever...) is set
> up correctly afterwards.
> 
> Requirement for the userspace tool setting the "do not shutdown if a
> hot thermal event happened" would be:
>   - Fetch the thermal hot event

We need to introduce the notification mechanism, probably via netlink,
if we want to do this in the thermal sysfs driver.

>   - Reliably power off the system (shutdown if S4 did not succeed)
>   - ...
> 
Any then introduce another sysfs attribute for each trip point, say
"trippoint_x_mode".
kernel driver takes default actions when the threshold is reached when
it's set "kernel", and takes no action if it's set "user".
users can get the hot event via netlink and take any actions they want..

On the other hand, we can do this in ACPI thermal driver as well.
Because
1. netlink event has already been supported.
2. we can disable the kernel action of _HOT by module parameters, say
thermal.hot=on(default, s4 or shutdown in kernel)/off(no action, no
events)/ignore(no action, but still sends events to userspace).

thanks,
rui






we don't have any notification mechanism in the thermal sys driver
currently. 
So If we want to do this in the generic thermal driver, we need to
introduce the 



> Comments?
> What userspace tools are candidates to implement this if this
> makes sense?
> 
> Thanks,
> 
>       Thomas


