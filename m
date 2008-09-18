From: Len Brown <lenb@hera.kernel.org>
Subject: Re:  /proc/acpi/ removal plan
Date: Thu, 18 Sep 2008 16:33:01 GMT
Message-ID: <200809181633.m8IGX1s7019188@hera.kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48306 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753452AbYIRQdH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 18 Sep 2008 12:33:07 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-acpi@vger.kernel.org, rjw@sisk.pl, rui.zhang@intel.com

> processor throttling state I/F
> As processor T-state is used for thermal control only,
> processor t-state is mapped to a cooling_device's cooling_state
> in the generic thermal driver, combined with the processor's p-state.

> # ls -l /sys/class/thermal/cooling_device0/

When I scribble into cur_state
I do not see anything reflected in
/proc/acpi/processor/*/throttling

Also, max_state is 10, when surely my processor
has only 8 T-states.

If user-space can not provoke processor T-states via this I/F,
then those using the old /proc I/F will flag it as a regression
when it goes away.  (even if few should ever need it)

> wakeup control,
> /sys/devices/.../wakeup should be in the todo list. :)

I thought that Rafael said the wakeup file
in the device tree was working now -- at least
for PCI devices, no?

I think the biggest problem with sysfs wakeup is that every
device in the tree gets a wakeup file, even if it
has no wakeup capability...

> oops, I forget to add the dynamic tables... will do it soon, :)
That would be good.
For when we have dynamic tables, we'll be able to enhance
acpidump to collect them and we'll not have to do this manually
like we've been doing.

>  button sys I/F can be found at /sys/class/input/.
> e.g.
> # cat /sys/class/input/input*/device/hid 
> LNXPWRBN
> PNP0C0C

The /proc files for power and sleep buttons simply
told us what kind of button they were, just info, not API.

The functional one is PNP0C0D, the lid switch.
It is also reflected in /sys/class/input, but I don't
see a way to find from /sys the open/closed state
like we have in /proc.  (I ran into this when I tried
to delete the button /proc I/F some time ago).


re: ec and power_resource, I agree, they can go.

thanks,
-Len



