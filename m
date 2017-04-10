From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [RFC] Fix shared irq trigger-flags conflict when old irqaction
 uses IRQF_TRIGGER_NONE
Date: Mon, 10 Apr 2017 13:04:18 +0200
Message-ID: <1117548f-9b5a-111c-6657-79a6c30179de@redhat.com>
References: <20170409195918.20864-1-hdegoede@redhat.com>
 <8e5511ce-601b-bde9-cdd3-c901ffc3d53d@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8e5511ce-601b-bde9-cdd3-c901ffc3d53d@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-acpi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

HI,

On 10-04-17 12:13, Marc Zyngier wrote:
> Hi Hans,
>
> On 09/04/17 20:59, Hans de Goede wrote:
>> While writing a driver for the INT0002 ACPI device found on Intel
>> Bay and Cherry Trail devices I hit the following error:
>>
>> "genirq: Flags mismatch irq 9. 00000084 (INT0002) vs. 00000080 (acpi)"
>>
>> This is caused by drivers/acpi/osl.c first doing:
>>
>> request_irq(irq, acpi_irq, IRQF_SHARED, "acpi", acpi_irq)
>>
>> While the irqdata for the irq contains no trigger flags, resulting
>> in an irqaction with IRQF_TRIGGER_NONE.
>>
>> And then the INT0002 driver I'm working on calling platform_get_irq
>> which does: irqd_set_trigger_type(irqd, r->flags & IORESOURCE_BITS);
>>
>> And then request_irq(irq, ..., IRQF_SHARED, ...) on the irq returned
>> by platform_get_irq causes the error quoted above.
>>
>> Arguably the genirq code should not hit the shared irq trigger-flags
>> mismatch code if the old irqaction has IRQF_TRIGGER_NONE as flags.
>>
>> This patch is an attempt at fixing this, but I'm not sure it is the
>> right fix, hence it RFC status.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  kernel/irq/manage.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
>> index a4afe5c..24e5eef 100644
>> --- a/kernel/irq/manage.c
>> +++ b/kernel/irq/manage.c
>> @@ -1212,8 +1212,13 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
>>  		 * set the trigger type must match. Also all must
>>  		 * agree on ONESHOT.
>>  		 */
>> +		unsigned int old_msk = old->flags & IRQF_TRIGGER_MASK;
>> +
>> +		if (!old_msk)
>> +			old_msk = irqd_get_trigger_type(&desc->irq_data);
>> +
>>  		if (!((old->flags & new->flags) & IRQF_SHARED) ||
>> -		    ((old->flags ^ new->flags) & IRQF_TRIGGER_MASK) ||
>> +		    ((old_msk ^ new->flags) & IRQF_TRIGGER_MASK) ||
>>  		    ((old->flags ^ new->flags) & IRQF_ONESHOT))
>>  			goto mismatch;
>>
>>
>
> I'm afraid you're just papering over the issue here, as you leave the
> "old" descriptor in an inconsistent state w.r.t. the "new" descriptor.
>
> My view is that the old irq_desc should be "upgraded" to the new trigger
> configuration, because they are sharing a line and must have compatible
> behaviours.

There is no old irq_desc only an old ircaction, but yes that can easily
be updated to reflect the mask from the irq_data, or maybe we should not use
the oldaction for the trigger_mask bits at all and instead use
the trigger_mask from the irq_data as done in:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/kernel/irq/manage.c?id=7ee7e87dfb158e79019ea1d5ea1b0e6f2bc93ee4

For a different code path ? Thomas?

> NONE is effectively a wildcard, and the second interrupt
> request should turn this wildcard into the real thing.
 >
> The opposite case also exists (request a LEVEL interrupt first, then a
> NONE), and should be resolved the same way (NONE becomes LEVEL).

The 2nd order of requesting irqs will already work because of:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/kernel/irq/manage.c?id=4b357daed698c95d6b5eacc1c3c4afa206071ba2

Where the new_action trigger_mask gets filled with the triger_mask
from the irq_data, which is a further hint that looking at
irqd_get_trigger_type(&desc->irq_data) rather then at
(old->flags IRQF_TRIGGER_MASK) is probably the right fix.

Note btw that 4b357daed698 is (part of) what is breaking things for
my use-case, I request the irq with IRQF_TRIGGER_NONE but
4b357daed698 modifies that before comparing the new trigger flags
to the old.

Regards,

Hans
