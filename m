From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v2 3/3] ACPI / button: Send "open" state after boot/resume
Date: Tue, 31 May 2016 16:47:20 +0200
Message-ID: <CAN+gG=Fzx0K6O4K9GRAjCe9Bg8-iGQhsYAiOdBZRpwoGeafRuw@mail.gmail.com>
References: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com>
	<cover.1464332745.git.lv.zheng@intel.com>
	<4472be3d63af1b56c2f0f7cfbccd73538dc36252.1464332745.git.lv.zheng@intel.com>
	<CAN+gG=EaTOSbkx82HCYwLOtR9b_6291obNnpokJ2PhOXD8bWHw@mail.gmail.com>
	<1AE640813FDE7649BE1B193DEA596E883BBB5C64@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:36858 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753686AbcEaOrW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 31 May 2016 10:47:22 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BBB5C64@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Bastien Nocera:" <hadess@hadess.net>, "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>

Hi Lv,

On Tue, May 31, 2016 at 4:55 AM, Zheng, Lv <lv.zheng@intel.com> wrote:
> Hi,
>
>> From: Benjamin Tissoires [mailto:benjamin.tissoires@gmail.com]
>> Subject: Re: [PATCH v2 3/3] ACPI / button: Send "open" state after
>> boot/resume
>>
>> On Fri, May 27, 2016 at 9:16 AM, Lv Zheng <lv.zheng@intel.com> wrote:
[snipped
]>> As Valdis replied on 0/3, I don't think this is a good solution (even
>> temporary). Linux should not assume the current state of a input
>> device, and sending unconditionally 1 here is wrong. If the device is
>> on a docking station, you will wake up the wrong monitor and screw the
>> user session (and this will be a regression).
> [Lv Zheng]
> We are doing the test to see how this behaves on several different platforms.
>
>>
>> How about we simply send the current LID state stored in the ACPI?
>> something like calling acpi_lid_send_state() directly?
> [Lv Zheng]
> This is what we are going to eliminate in [PATCH 01].
> We have several real bugs related to sending a wrong state to the userspace.
> Userspace will suspend right after resume because of the 'close' state.

On the other hand, you are trying to remove 23de5d9ef2a4bbc4f733f, a
patch that has been around for 9 years and we only start seeing
devices where this logic is not working...

I am not saying your approach is wrong, I am just saying that instead
of a plain revert, we should probably be more conservative and add a
quirk for those buggy machines. Ideally, we should try to understand
why there is such an issue that Windows doesn't have (the solution
might just be that given Windows doesn't care, we are screwed).

BTW, on the Surface 3, there is a WMI
(f7cc25ec-d20b-404c-8903-0ed4359c18ae -> WQHE) which returns the
actual value of the LID, without using PNP0C0D at all. I have a
feeling that Windows might use it when it is in trouble or in an
unsure state. I couldn't find this WMI on the 2 other systems so that
may also be just a one shot for the Surface 3.

[snipped]
> [Lv Zheng]
> The understanding here is incorrect.
> We have 3 bogus devices.
> 1 of them is surface 3 which is a hardware reduced platform.
> The others are all traditional platforms.
>
> =====
> The facts are:
>
> Both the platforms return cached lid state from _LID.
> The cached value will be updated by lid irq (via GPIO IRQ, GPE, or EC event).
> AML tables will send lid notification in the irq handler.
>
> Some AML tables will update the cached value in _WAK (I'll describe why it is necessary below).
> But updating the cached value in _WAK is not guaranteed by all AML tables.
>
> For the 'close' state irq, all tables will send lid close notification.
> For the 'open' state irq, it seems there are tables never sending lid open notification (sounds like Windows do not care about lid open).
> =====
>
> Surface 3 is entirely a different case.
> It is a runtime idle system and hardware reduced.
> On that kind of system, lid open is handled by OS not by BIOS.
> Surface 3 is exactly the platform that doesn't send lid open notification.
> I guess the AML is intentionally written in this way to be compliant to the traditional platforms.
>
> While on the traditional platforms:
> When lid is opened, BIOS handles the lid irq and wakes the system from the FACS waking vector.
> So it is likely that there is no lid open irq after the system is resumed.
> BIOS may forget to update the cached lid value in the _WAK or some other control methods that could be executed after resuming.
> Then if we send _LID result to the user space, the cached value could apparently be 'close'.
>
> That explains why there is no "lid open" configuration in the "Windows Device Manager".
>
>>
>> I propose as a workaround to enable a kthread that will monitor the
>> lid state and update the correct value to userspace (5 sec of polling
>> time should be enough given that systemd checks every 20 sec).
>> We should probably have this workaround only for a set of known
>> devices, as it might just be temporary for those until the actual
>> underlying problem is fixed (wrong DSDT in the Surface 3 case that
>> doesn't notify at all, issue in the EC for the Surface Pro 1 and the
>> Samsung N210).
> [Lv Zheng]
> That cannot help to solve the issue/gap.
>
> The problem is Linux userspace has a facility re-checking lid state when lid state is "close".
> If it failed to update the lid state to "open" for a timeout period, it would suspend the platform.
>
> We actually are recommending Linus userspace to introduce a new lid handling mode to only handle "lid close" event and ignore "lid open" event.
> During the period this is not changed from the userspace, we have to send "open" after resume/boot in order not to trigger the timeout mechanism.
>

I hear your points and I couldn't agree more that the only solution
for us is (sadly) to mimic Windows.

I am just disagreeing on the method used here: I'd rather have a
fallback mechanism where the lid is not sent to "one" at each boot
resume because this will mess us people using docking stations. The
problem is that Red Hat has a lot of them, and I foresee a lot of
complains to me if this is merged in its current state.

We could have a parameter (say "send_lid_open_on_resume" or
"use_bios_lid_value") in acpi/button.c which would allow people to
choose if they want the "new" behavior or the old one. And we could
also add some DMI matching for the messed up laptops/tablets where we
force one or the other quirk. When we agree that user space now
behaves gently with us, we could then remove entirely the quirk and
the dmi matching.

How does that sound?

Also, on the topic of the .notify not being sent by some BIOS, I have
seen something similar on the surface 3.

The ASL for the LID status change is the following:
---
            Method (_E4C, 0, Serialized)  // _Exx: Edge-Triggered GPE
            {
                If ((HELD == One))
                {
                    ^^LID.LIDB = One
                }
                Else
                {
                    ^^LID.LIDB = Zero
                    Notify (LID, 0x80) // Status Change
                }

                Notify (^^PCI0.SPI1.NTRG, One) // Device Check
            }
---

I noticed I received the hotplug event on the touchscreen when the LID
state changed, and tried to initiate the notify on the LID acpi device
from within the touchscreen driver.
This works well, except that from time to time, on resume, I don't
even receive the hotplug notification. It is as if the notification is
lost while I receive it 80% of the time.

This might be completely unrelated, but I think it is worth mentioning
because there might be a common root at the state not being updated
correctly.

Cheers, and sorry for being annoying :)
Benjamin
