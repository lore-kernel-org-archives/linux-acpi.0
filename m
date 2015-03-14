From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v10 16/21] irqchip: Add GICv2 specific ACPI boot support
Date: Sat, 14 Mar 2015 08:47:49 +0000
Message-ID: <CACxGe6uN_1_y+tSwkUdYZdbsURibR+es-oGab0JefsnFehJw_g@mail.gmail.com>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
 <1426077587-1561-17-git-send-email-hanjun.guo@linaro.org> <CACxGe6uWwts6X=Yc2ioBdQizXkF1_YgoNNOsREWirk2MFBVDHg@mail.gmail.com>
 <20150311231141.GG21998@io.lakedaemon.net> <5500EFFF.2070807@huawei.com>
 <20150312051245.GI21998@io.lakedaemon.net> <550140ED.3080808@huawei.com> <20150313171526.GL21998@io.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:35612 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194AbbCNIsM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 14 Mar 2015 04:48:12 -0400
Received: by ieclw3 with SMTP id lw3so137297007iec.2
        for <linux-acpi@vger.kernel.org>; Sat, 14 Mar 2015 01:48:11 -0700 (PDT)
In-Reply-To: <20150313171526.GL21998@io.lakedaemon.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Hanjun Guo <guohanjun@huawei.com>, Mark Rutland <mark.rutland@arm.com>, linaro-acpi <linaro-acpi@lists.linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Timur Tabi <timur@codeaurora.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Robert Richter <rric@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Graeme Gregory <graeme.gregory@linaro.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hanjun Guo <hanjun.guo@linaro.org>

On Fri, Mar 13, 2015 at 5:15 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> Hanjun, Catalin,
>
> On Thu, Mar 12, 2015 at 03:31:57PM +0800, Hanjun Guo wrote:
>> On 2015/3/12 13:12, Jason Cooper wrote:
>> > On Thu, Mar 12, 2015 at 09:46:39AM +0800, Hanjun Guo wrote:
>> >> On 2015/3/12 7:11, Jason Cooper wrote:
>> >>> Hey Grant,
>> >>>
>> >>> On Wed, Mar 11, 2015 at 06:04:50PM +0000, Grant Likely wrote:
>> >>>> On 11 Mar 2015 12:42, "Hanjun Guo" <hanjun.guo@linaro.org> wrote:
>> [...]
>> >>>>> diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
>> >>>>> index 0fe2f71..afd1af3 100644
>> >>>>> --- a/drivers/irqchip/irqchip.c
>> >>>>> +++ b/drivers/irqchip/irqchip.c
>> >>>>> @@ -8,6 +8,7 @@
>> >>>>>   * warranty of any kind, whether express or implied.
>> >>>>>   */
>> >>>>>
>> >>>>> +#include <linux/acpi_irq.h>
>> >>>>>  #include <linux/init.h>
>> >>>>>  #include <linux/of_irq.h>
>> >>>>>  #include <linux/irqchip.h>
>> >>>>> @@ -26,4 +27,6 @@ extern struct of_device_id __irqchip_of_table[];
>> >>>>>  void __init irqchip_init(void)
>> >>>>>  {
>> >>>>>         of_irq_init(__irqchip_of_table);
>> >>>>> +
>> >>>>> +       acpi_irq_init();
>> >>>>>  }
>> >>> Is this in line with Olof's idea that providing a dtb would override ACPI?
>> >> Yes, it will. Since ACPI is default OFF (disabled), if a dtb provided, and no acpi=force
>> >> passed in the early command line, dtb will be used as system configuration for
>> >> boot (dtb is always the prior one for now) [1]. In acpi_gic_init() which called by
>> >> acpi_irq_init(), it will return immediately if acpi disabled, so it will not parse
>> >> any ACPI table for device configuration.
>> > Ok, that matches my recollection.  Thanks for refreshing my memory.  I'll apply
>> > this on a topic branch for irqchip/gic when I return from travel.  Most likely
>> > Friday or over the weekend.
>>
>> Thank you very much! But this patch can't be applied without previous ones in this
>> patch set, how about you ack this patch and Catalin takes it via ARM64 tree? I'm
>> not sure for this, it depends on your decision.
>
> Is this a build dependency or a boot dependency?  I only received this patch in
> the series and I apologize, I'm a bit swamped atm.  Catalin, would an immutable
> irqchip/gic topic branch with this in it work for you?

Jason,

For a series like this I strongly recommend you provide an ack and let
the whole series go in via a single branch. Trying to split it up only
to reassemble it again creates more work for everyone. There is also
very little likelyhood that this will create a complex conflict with
your tree.

g.
