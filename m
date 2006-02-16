From: Joshua Wise <joshua@joshuawise.com>
Subject: Thermal panic for systems with brain damaged ECs
Date: Thu, 16 Feb 2006 15:21:00 -0500 (EST)
Message-ID: <Pine.LNX.4.63.0602161506360.3502@dashnine>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from [205.138.198.144] ([205.138.198.144]:968 "EHLO dev.x-plane.com")
	by vger.kernel.org with ESMTP id S964899AbWBPUTs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Feb 2006 15:19:48 -0500
Received: from joshuawise.com (c-24-34-92-252.hsd1.ma.comcast.net [24.34.92.252])
	by dev.x-plane.com (Postfix) with ESMTP id C2A835AE8
	for <linux-acpi@vger.kernel.org>; Thu, 16 Feb 2006 14:19:26 -0600 (CST)
Received: from localhost (dashnine [127.0.0.1])
	by joshuawise.com (Postfix on joshuawise.com) with ESMTP id 9424320135
	for <linux-acpi@vger.kernel.org>; Thu, 16 Feb 2006 15:21:00 -0500 (EST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi all.

I have an HP TC1100 (tablet PC) that I've been pretty lucky with under Linux
in terms of component support. I have, however, been noticing a potentially
dangerous situation occurring, possibly due to a brain damaged EC, and
possibly due to my lack of acpid. Namely, when the system gets fatally hot,
it does not shut down.

I have previously had one tc1100 replaced under warranty for this (system
sitting in carrying case, unintentionally powered on for excessive periods
of time; system locked up and would not POST on powerup). Regardless of the
state in which software lies, the system should be able to automatically
shut down before it kills itself, although the EC doesn't seem to be doing
this for me.

So, I'm wondering if it's a good idea to have the thermal module provide an
option to automatically umount ro/sync/power down above a certain
temperature. I argue that this is not suitable for user space as it could
potentially damage the system, and therefore needs to act as reliably as
possible.

I notice that in thermal.c, poweroff is called, but this might not be
sufficient if the system is already starting to misbehave due to thermal
stress. It also seems that my DSDT has incorrect trip points (or the thermal
sensor does not properly read): S5 is listed as 80C, but the system was only
reading at 65C when the plastic case was too hot to touch. Does it make
sense to add a user-defineable hard poweroff point?

joshua
