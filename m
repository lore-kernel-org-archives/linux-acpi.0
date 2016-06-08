From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/3] ACPICA: Events: Introduce acpi_block_gpe()/acpi_unblock_gpe()/acpi_control_gpe_handling()
 to allow administrative GPE enabling/disabling
Date: Wed, 8 Jun 2016 22:17:33 +0200
Message-ID: <CAJZ5v0iaLoj5eJfbTfRAeQOPtSHBphRdxKt4puep79cy9HXbmA@mail.gmail.com>
References: <cover.1463389639.git.lv.zheng@intel.com> <216c54dbfd2be7ab949cd16afffb84c45900f1d9.1463389639.git.lv.zheng@intel.com>
 <1585140.3ZMjLZu0YQ@vostro.rjw.lan> <1AE640813FDE7649BE1B193DEA596E883BBC884D@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BBC884D@SHSMSX101.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 8, 2016 at 9:49 AM, Zheng, Lv <lv.zheng@intel.com> wrote:
> Hi,
>
>> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
>> Subject: Re: [PATCH 1/3] ACPICA: Events: Introduce
>> acpi_block_gpe()/acpi_unblock_gpe()/acpi_control_gpe_handling() to
>> allow administrative GPE enabling/disabling
>>
>> On Monday, May 16, 2016 05:11:11 PM Lv Zheng wrote:
>> > There is a facility in Linux, developers can manage GPE enabling/disabling
>> > through /sys/firmware/acpi/interrupts/gpexx. This is mainly for
>> debugging
>> > purposes. Many users expect to use this facility to implement quirks to
>> > disable specific GPEs when there is a gap in Linux causing GPE flood.
>> > This is not working correctly because currently this facility invokes
>> > enabling/disabling counting based GPE driver APIs:
>> >  acpi_enable_gpe()/acpi_disable_gpe()
>> > and the GPE drivers can still affect the count to mess up the GPE
>> > management purposes.
>> >
>> > This patch introduces acpi_block_gpe()/acpi_unblock_gpe() to be used in
>> such
>> > situation instead of acpi_enable_gpe()/acpi_disable_gpe().
>>
>> Up to this point, I agree.
>>
>> > The idea to implement this is to replace the GPE register EN bit with the
>> > managed value, block EN set/clear operations but record the operation
>> > results in blocked_enabled, so that after the managed state is removed,
>> > restore the saved blocked_enabled back to the GPE register EN bit.
>>
>> Unfortunately, I don't really follow the above paragraph, so chances are
>> that
>> whoever is not familiar with the code will not be able to follow it either.
> [Lv Zheng]
> I see.
> I should stop talking this using "managed".
> It is better to use "masked".
> As this facility is actually trying to implement the kind of the facility that can be seen in many other IRQ chips - the IRQ MASK bit.

This is a somewhat simplified special case of it, though.

>> > Now OSPMs should be able to use this facility to generate quirks. ACPICA
>> > BZ 1102.
>> >
>> > This facility can also be used by the administrator to control the GPE
>> > handling mode during the runtime when the driver is capable of handling
>> the
>> > GPE in both the interrupt mode and the polling mode (for example, the
>> Linux
>> > EC driver). acpi_control_gpe_handling() is offered for this purpose. Lv
>> Zheng.
>>
>> That is too much.  The patch should focus on the block/unblock
>> functionality.
>> Anything beyond that should be added later IMO.
> [Lv Zheng]
> OK.
> So after examining all of your comments.
> I think what I need to improve is eliminating this feature.
> That should be able to make the code simpler and thus easier for the others to follow.

Sounds good!
