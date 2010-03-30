From: Thomas Renninger <trenn@suse.de>
Subject: [RFC] Shutdown on thermal HOT event if no userspace tool registered being able to do S4
Date: Tue, 30 Mar 2010 10:23:10 +0100
Message-ID: <201003301123.10711.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60924 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755964Ab0C3JXM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Mar 2010 05:23:12 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Joey Lee <jlee@novell.com>, Holger Macht <hmacht@suse.de>, Zhang Rui <rui.zhang@intel.com>, Rafael Wysocki <rwysocki@suse.de>

Hi,

this is related to:
commit fa80945269f312bc609e8384302f58b03c916e12
    ACPI thermal: Don't invalidate thermal zone if critical trip point is bad
and
commit 8b7ef6d8f16274da42344cd50746ddb1c93c25ea
    ACPI thermal: Check for thermal zone requirement

There the critical trip point is replaced with the hot trip
point if latest Windows OS is detected (Vista also? I think yes,
but need to double check).

This seem to get more common and it looks like Windows suggests
to use hot trip points for thermal emergency shutdowns (S4).
It looks like the default Windows thermal emergency power off is
S4. Thus the hot trip point is used and the critical trip point
is of no use anymore (and often gets replaced or is invalid).

As thermal emergency shut down is something urgent there is this
direct call /sbin/poweroff in orderly_poweroff(true) compare with
kernel/sys.c and drivers/thermal/thermal_sys.c
This won't work in above cases when BIOS writers assume the machine
is shut down with _HOT already and do not provide _CRT anymore.

My idea is to also shutdown the system on _HOT by default,
the same way as done if _CRT is exceeded as long as no userspace
explicitly set a sysfs (only one file set by thermal_sys.c somewhere
in /sys?).
Background is that S4 needs some setup (e.g. swap) or userspace hooks
to make sure S4 succeeds and everything (network, whatever...) is set
up correctly afterwards.

Requirement for the userspace tool setting the "do not shutdown if a
hot thermal event happened" would be:
  - Fetch the thermal hot event
  - Reliably power off the system (shutdown if S4 did not succeed)
  - ...

Comments?
What userspace tools are candidates to implement this if this
makes sense?

Thanks,

      Thomas
