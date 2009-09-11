From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [PATCH] ACPI: battery: register power_supply subdevice even when
	battery not present
Date: Fri, 11 Sep 2009 13:28:42 +0100
Message-ID: <9b2b86520909110528g21fec703v1afc75e699c44284@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:42413 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326AbZIKM2l (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Sep 2009 08:28:41 -0400
Received: by fxm17 with SMTP id 17so750571fxm.37
        for <linux-acpi@vger.kernel.org>; Fri, 11 Sep 2009 05:28:42 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Anton Vorontsov <cbou@mail.ru>, David Woodhouse <dwmw2@infradead.org>, linux acpi <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>

[CC power_supply maintainers]

I tried to fix the ACPI battery driver so it created a power supply
device even if the battery is not present.  All the other battery
drivers do this.  It would let e.g. gnome-power-manager to detect the
presence of a battery bay, and allow configuration of battery
behaviour even when the battery has been removed.

Unfortunately this is not as easy as I thought.  We would need to
either modify or work around the generic power supply class, so I
would like to ask your opinion on this.

On 9/11/09, Maxim Levitsky <maximlevitsky@gmail.com> wrote:
> Indeed, it works.
>
>
> Just one issue though, if I plug in the battery after system boot, it is
> detected a an 'energy battery' (energy_battery_props are used)
>
> ACPI seems to be ok:
...
> PBIF at offset 0 is set correctly to 1.

Your ACPI is fine - there's a fatal flaw in my patch.  It doesn't
evaluate _BIF until the battery is inserted.  At that point it is too
late to change the set of properties on the battery device, because
it's already been created.

The problem is that this power_unit value is allowed to change between
mW and mA when the battery is hotplugged.  And it looks like it does
on some machines, going from 0 to 1 when a battery is inserted.  So we
can't just read it at load time.

I can think of some more complex ways to do this

1) Destroy and recreate the battery device on hotplug.
2) Modify the generic power supply class to allow changing the set of attribute.
3) Restructure the interface to provide a "battery bay" device as a parent.

1) and 2) are hacks.  1) could at least cause annoyingly spurious UI
events.  2) sounds like a bad idea, but existing userspace _might_
handle it because it already happens at registration time.  (Power
supply attributes aren't available on the initial ADD uevent; they are
added in a follow-up CHANGE uevent).

3) could be backwards compatible and relatively straightforward.  The
"battery bay" could be a new type of power supply device, with no
attributes of its own.  It could be created automatically for non-acpi
batteries.  Userspace would have to be taught about it, but perhaps
this is a good time to do so since HAL is currently being replaced by
DevKit.

Alan
