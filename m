From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 2/3] acpi: dptf_power: Add DPTF power participant
Date: Fri, 24 Jun 2016 02:26:39 +0200
Message-ID: <CAJZ5v0ithpoZfHJQwfyLdrsLyU1-M8psrJz12eaOTR9ffCTPOQ@mail.gmail.com>
References: <1466718134-29921-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1466718134-29921-3-git-send-email-srinivas.pandruvada@linux.intel.com>
 <CAJZ5v0hRVDMgsBzEMufwHurA8aRBmd7p_MvnMg1cdNYgDrPDaA@mail.gmail.com> <1466723970.8970.69.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34808 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbcFXA0l (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Jun 2016 20:26:41 -0400
Received: by mail-wm0-f65.google.com with SMTP id 187so980607wmz.1
        for <linux-acpi@vger.kernel.org>; Thu, 23 Jun 2016 17:26:41 -0700 (PDT)
In-Reply-To: <1466723970.8970.69.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Fri, Jun 24, 2016 at 1:19 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Fri, 2016-06-24 at 00:31 +0200, Rafael J. Wysocki wrote:
>> On Thu, Jun 23, 2016 at 11:42 PM, Srinivas Pandruvada
>> <srinivas.pandruvada@linux.intel.com> wrote:
>> >
>> > This driver adds support for Dynamic Platform and Thermal Framework
>> > (DPTF) Platform Power Participant device support.
>> > This participant is responsible for exposing platform telemetry
>> > such as
>> > platform Power, battery Information such as state of Charge,
>> > estimated
>> > maximum sustainable power (PMax), SMART battery spec information.
>> >
>> > This driver is implemented as a platform driver for INT3407 and
>> > presented
>> > as power_supply device. Since this has common features with the
>> > ACPI
>> > battery, existing interface provide by battery_common driver are
>> > reused
>> > to present as a battery power supply device.
>> >
>> > When both CONFIG_ACPI_BATTERY and CONFIG_DPTF_POWER are defined and
>> > platform has support for INT3407, then dptf power registration is
>> > delayed for 100ms. In 100 ms, if there is no ACPI battery is
>> > registered
>> > then dptf power will be registered. Since both can be modules and
>> > battery driver loads in async thread, there can be race even if we
>> > specify loading order for initialization.
>>
>> First, does the waiting actually help, though?
>
> Yes, if the acpi_battery registered then
> if (!battery_registered) will be false.
>

Ah, so [1/3] adds battery_registered while moving code around and the
changelog in there doesn't mention that.  It is added there, but not
really used, only set and reset.

I wouldn't do it that way.  Just add it in a separate patch or in
[2/3] itself, because it is the real user of it.

Also this is racy to my eyes, because acpi_battery can register after
you've checked battery_registered in dptf_power_init_work_fn() and
before calling dptf_power_init().  It actually can register just fine
at any time after that AFAICS.

>>
>> Second, to my eyes, even if acpi_battery load first, the dptf_power
>> thing will still bind to the same device, but via the platform bus
>> instead of the ACPI bus type.  I don't see anything preventing that
>> from happening in the patch, but maybe I missed something?
>>
> The INT3407 object also has battery _BST and _BIX, so driver will bind
> to this device not with PNP0C0A battery device. Either of them should
> be able to register and provide battery information. But the names are
> different (BAT vs TPWR on my platform)
> The check if (!battery_registered) will fail, so dptf_power will not
> register. So we will not see two batteries registered with power supply
> class (and hence no two batteries in desktop UI).

Ah OK.  I thought that the DPTF device had a _CID("PNP0C0A").  If
that's not the case, then the battery driver will not bind to it, so I
misunderstood the problem you wanted to address.

I think what you need is that if acpi_battery is bound to at least one
device, you don't want to bind dptf_power to anything.  Conversely, if
dptf_power has been bound to at least one device, you don't want to
bind acpi_battery to anything.

That may be achieved with a lock and two counters, one (A) incremented
only by acpi_battery and the other (B) incremented only by dptf_power
and such that you can't increment A if B is different from 0 and you
can't increment B if A is different from 0.  Of course, each driver
would need to specify which counter it wants to use (A or B), so that
would take an additional argument to acpi_battery_common_add() and an
additional field in struct acpi_battery (for the remove operation).

With that, I think it should only be possible to build both
acpi_battery and dptf_power if they are both modules.  IOW, DPTF_POWER
should depend on (!ACPI_BATTERY || ACPI_BATTERY=m) or similar.  And if
they are both modules, let user space manage that.

And the waiting itself doesn't add any value then IMO.

Thanks,
Rafael
