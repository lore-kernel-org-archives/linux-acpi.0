From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [PATCH] ACPI: battery: register power_supply subdevice even when
	battery not present
Date: Fri, 11 Sep 2009 15:16:22 +0100
Message-ID: <9b2b86520909110716o7f426eaeya4e14570b3b0b0a5@mail.gmail.com>
References: <9b2b86520909110528g21fec703v1afc75e699c44284@mail.gmail.com>
	 <20090911131022.GA3803@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:47036 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857AbZIKOQV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Sep 2009 10:16:21 -0400
Received: by bwz19 with SMTP id 19so807503bwz.37
        for <linux-acpi@vger.kernel.org>; Fri, 11 Sep 2009 07:16:23 -0700 (PDT)
In-Reply-To: <20090911131022.GA3803@oksana.dev.rtsoft.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: avorontsov@ru.mvista.com
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Anton Vorontsov <cbou@mail.ru>, David Woodhouse <dwmw2@infradead.org>, linux acpi <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>

On 9/11/09, Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> On Fri, Sep 11, 2009 at 01:28:42PM +0100, Alan Jenkins wrote:
>> [CC power_supply maintainers]
>>
>> I tried to fix the ACPI battery driver so it created a power supply
>> device even if the battery is not present.  All the other battery
>> drivers do this.  It would let e.g. gnome-power-manager to detect the
>> presence of a battery bay, and allow configuration of battery
>> behaviour even when the battery has been removed.
>
> This was discussed several times already.
>
> http://lkml.org/lkml/2009/4/27/314
> http://lkml.org/lkml/2007/10/27/170
>
>> Unfortunately this is not as easy as I thought.
>
> And not possible for certain batteries.
>
> [...]
>> I can think of some more complex ways to do this
>>
>> 1) Destroy and recreate the battery device on hotplug.
>> 2) Modify the generic power supply class to allow changing the set of
>> attribute.
>> 3) Restructure the interface to provide a "battery bay" device as a
>> parent.
>>
>> 1) and 2) are hacks.  1) could at least cause annoyingly spurious UI
>> events.  2) sounds like a bad idea, but existing userspace _might_
>> handle it because it already happens at registration time.  (Power
>> supply attributes aren't available on the initial ADD uevent; they are
>> added in a follow-up CHANGE uevent).
>>
>> 3) could be backwards compatible and relatively straightforward.  The
>> "battery bay" could be a new type of power supply device, with no
>> attributes of its own.
>
> Yes, that would be nice. There could be some attributes though,
> I can think of a temperature sensor (measures ambient/bay
> temperature), a battery presence/lock sensor etc.
>
> IIRC, battery bay in iPaq hx4700 devices can report if a battery is
> locked (that's all it can do, but still useful).
>
>> It could be created automatically for non-acpi batteries.
>
> Why? If there is no bay, we don't need any device for it.

I thought it would be easier for userspace... but actually there's no
point since programs will still have to handle older kernels.

Ok, I'll write 3) and see what happens.

Alan
