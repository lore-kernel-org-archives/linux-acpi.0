From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RFC] Shutdown on thermal HOT event if no userspace tool
 registered being able to do S4
Date: Tue, 30 Mar 2010 21:14:36 -0300
Message-ID: <20100331001436.GA9925@khazad-dum.debian.net>
References: <201003301123.10711.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:32899 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932467Ab0CaAOk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Mar 2010 20:14:40 -0400
Content-Disposition: inline
In-Reply-To: <201003301123.10711.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org, Joey Lee <jlee@novell.com>, Holger Macht <hmacht@suse.de>, Zhang Rui <rui.zhang@intel.com>, Rafael Wysocki <rwysocki@suse.de>

On Tue, 30 Mar 2010, Thomas Renninger wrote:
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
>   - Reliably power off the system (shutdown if S4 did not succeed)
>   - ...
> 
> Comments?

ThinkPads have specific alarms that would benefit from a generic interface
to report the above stuff to userspace, and to kick a S3/S4/S5 transition if
userspace fails to do something about it.

These are:

1. Emergency Thermal alarms (Lenovo tells me we should enter S3 or S4)
   - Battery alarm (very dangerous, risk of Lithium fire)
   - Sensor alarm (less dangerous, risk of permanent hardware damage)

2. Wakeup from S3 because the battery is nearly empty (enter S4 or S5)
   - Pretty much guarantees the user is !@#$#@ if we don't act on it,
     since it will cause a mess even on a hibernate-to-S3 setup
     if the user didn't tell the BIOS he does "RediSafe"...

It would be nice to have flags to tell userspace if we want any sleep, or if
we need S4/S5.

It would also be nice to have a generic way to deliver these alarms,
thinkpads have pre-alarms that should be used to notify the user before
things get too dire...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
