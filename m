From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: What's part of the ABI (breaking eeepc-wmi)
Date: Tue, 8 Feb 2011 15:17:35 +0000
Message-ID: <AANLkTin5_jqEc3hxh02n7PU5C0BGXah=n_Bj9cN1Yar1@mail.gmail.com>
References: <AANLkTim5kG-pZRpj+6ckOvuk5ZSJ_O7zbwBnC4JNQPtS@mail.gmail.com>
	<20110208145301.GA12930@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62902 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645Ab1BHPRh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Feb 2011 10:17:37 -0500
In-Reply-To: <20110208145301.GA12930@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: platform-driver-x86@vger.kernel.org, linux acpi <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Tue, Feb 8, 2011 at 2:53 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Tue, Feb 08, 2011 at 08:51:27AM +0000, Corentin Chary wrote:
>
>> A first solution is to rename eeepc-wmi asus-wmi, and create an alias
>> to make eeepc-wmi work. Then this driver would handle asus-wmi and
>> eeepc-wmi platform drivers (it could also be splitted in 3
>> files/modules, common/notebook/eeepc).
>> But then, is it important to keep these strings ?
>> - hotplug string ("eeepc-wifi")
>> - rfkill names ("eeepc-xxxxx")
>> - input strings (.phys and .name)
>
> I think that, realistically, these changes should be fine but may break
> some user code. We don't have a good way of enforcing proper sysfs
> usage.

Unfortunatly, it would break udev (well.. only the touchpad key, which
probably never worked, does it really matters ?) ...

http://git.kernel.org/?p=linux/hotplug/udev.git;a=blobdiff;f=extras/keymap/95-keymap.rules;h=9059a8c41e4505f0d8088a90fc0c3a64fe8d5f2d;hp=053838d803d7142dd80fbca361ef65565c6189f2;hb=0d8b6be5f5238360d2d8e220d6da280f842c5358;hpb=e99cc72398d1d5057cc6d1e4c065799f8daaf29e

But your probably right for rfkill and hotplug slot name.

>> - led names ("eeepc::xxxxxx")
>
> But I don't think there's any other way of identifying LEDs, so this
> probably has to stay.

Yep .. but as this led probably never worked before the last patchset,
this is probably not the most important string to keep. And users
tends to use only the second part of the led name (*::touchpad,
*::kbd_backlight, etc...).

>> Any thoughts on that ?
>
> Seems less ugly than the alternatives!

Ok, I'll try to do something like that.

asus-wmi.ko - generic stuff
asus-nb-wmi.ko - used only on notebooks (bweark, asus-nb-wmi is an
horrible name :/)
eeepc-wmi.ko  - used only on eeepcs

And you'll be able to register only one asus_wmi_driver at a time,
since asus-wmi will have some static stuff in it (hotplug_slot_ops,
device_attribute, attribute, attribute_group, dev_pm_ops).

-- 
Corentin Chary
http://xf.iksaif.net
