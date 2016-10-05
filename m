From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Wed, 5 Oct 2016 22:33:47 +0200
Message-ID: <CAJZ5v0jNSEQ6Uk4T-19jA=RV9pmRzojB4FBd=SFAo6VOj-SLLg@mail.gmail.com>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
 <20161005092215.GA20248@red-moon> <20161005114129.GI1765@lahna.fi.intel.com>
 <20161005150641.GA22282@red-moon> <20161005153229.GO1765@lahna.fi.intel.com> <20161005161800.GA22433@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33827 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752140AbcJEUdu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Oct 2016 16:33:50 -0400
Received: by mail-wm0-f66.google.com with SMTP id b201so387017wmb.1
        for <linux-acpi@vger.kernel.org>; Wed, 05 Oct 2016 13:33:49 -0700 (PDT)
In-Reply-To: <20161005161800.GA22433@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>

On Wed, Oct 5, 2016 at 6:18 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Wed, Oct 05, 2016 at 06:32:29PM +0300, Mika Westerberg wrote:
>
> [...]
>
>> > FWIW I had a quick look at dts bindings with "compatible = nokia,smia"
>> > and related kernel driver.
>> >
>> > Those nodes require properties like clocks and power supplies, it
>> > seems to me that there are already ACPI PM methods to control those
>> > properties and therefore they should not be handled with PRP0001,
>> > I am happy to be corrected if I am wrong.
>>
>> Clocks and power supplies should be handled as native ACPI
>> PowerResources. We are not trying to represent those here.
>>
>> > When you start matching whole subsystem through PRP0001 and related
>> > compatible strings you can end up in a situation where DT and ACPI
>> > FW handling clash and that's why we were opposed to mixing them from
>> > the beginning, in ARM world if we need a DT we boot with a devicetree.
>> >
>> > If PRP0001 is used for leaf-nodes drivers properties it may work,
>> > everything else, frankly, is a bit of a gamble you are taking.
>>
>> The hardware we are describing is exactly the same, only thing that
>> changes is the firmware interface. So if there is a hardware property
>> that cannot be discovered automatically it needs to be provided by the
>> firmware, like ACPI.
>
> We certainly agree that HW is the same and that the firmware interfaces
> differ, that's why mixing them is not exactly ideal.
>
>> If it happens that the property already has an existing DT binding, why
>> do you think it is gambling to use it instead of inventing the same with
>> annother name for ACPI?
>
> Do not spin the argument. I am telling you that what I am worried
> about is mixing the interfaces because that might trigger kernel
> control paths clashing while controlling HW (DT native vs ACPI control
> methods).

That would have been possible, had the *kernel* supported _DSD
properties that could have conflict with native ACPI stuff at the
framework level.  Yet, it doesn't and there are no plans to add any
support like that to it I'm aware of.

So far, we have been careful enough to avoid supporting any _DSD
properties that may potentially conflict with ACPI-defined HW control,
this way or another, and as long as we continue to do that, all should
be fine.  So the way to go, to me, is not to reject support for any
kind of generic _DSD properties that follow DT bindings, but to look
at every case carefully and see if they conflict with ACPI-defined HW
control in any way.  If they don't, I see no reason for not supporting
them.

> I am pretty sure this won't happen, still, if you do not mind
> please post this series (and drivers actually making use of it) to a
> wider audience (which includes devicetree and ARM mailing list) and we
> will restart the discussion from there.

I think that the target subsystem (V4L in this particular case) should
be notified of this in the first place as they are the user of the
bindings in question.

Thanks,
Rafael
