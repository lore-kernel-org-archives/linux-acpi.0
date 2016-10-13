From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V2 1/3] Revert "ACPI, PCI,
 IRQ: reduce static IRQ array size to 16"
Date: Thu, 13 Oct 2016 16:16:28 -0400
Message-ID: <469134d3-3950-0d89-2599-64f917f09781@codeaurora.org>
References: <1475615720-31047-1-git-send-email-okaya@codeaurora.org>
 <1475615720-31047-2-git-send-email-okaya@codeaurora.org>
 <20161012221357.GB15116@localhost>
 <09f93442-89c8-7b2c-467d-d29b857739ff@codeaurora.org>
 <20161013181535.GB21529@localhost>
 <498097a5-f75c-d2dd-f134-148b3fb8e1ed@codeaurora.org>
 <20161013200238.GE21529@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161013200238.GE21529@localhost>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux@rainbow-software.org, ravikanth.nalla@hpe.com, jcm@redhat.com, timur@codeaurora.org, agross@codeaurora.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, alex.williamson@redhat.com, cov@codeaurora.org, linux-pci@vger.kernel.org, bhelgaas@google.com, wim@djo.tudelft.nl, linux-arm-msm@vger.kernel.org, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 10/13/2016 4:02 PM, Bjorn Helgaas wrote:
> On Thu, Oct 13, 2016 at 03:36:11PM -0400, Sinan Kaya wrote:
>> On 10/13/2016 2:15 PM, Bjorn Helgaas wrote:
>>> It seems like the problem is that we removed acpi_penalize_sci_irq(),
>>> which told us the polarity and trigger mode.  We tried to get that
>>> information via irq_get_trigger_type(), but that didn't work in this
>>> case because we use the acpi_irq_get_penalty() path before the SCI is
>>> registered.
>>>
>>> It makes sense to me to add acpi_penalize_sci_irq() back in, which is
>>> what patch [3/3] does.
>>>
>>> I don't understand how *this* patch, which basically just increases
>>> the penalty array size from 16 to 256, helps fix the problem.  It
>>> seems like this patch should only matter if the SCI were some IRQ
>>> between 16 and 255.
>>
>>
>> I see your point. The original code supported 256 interrupts. 
>>
>> The machine where we had the problem had an SCI interrupt of 11. So,
>> this patch does not necessarily fix anything for this machine alone.
>> However, to be safe; I wanted to go back to the old behavior to fix
>> the SCI issue for all existing platforms.
> 
> I saw a previous email that said the SCI interrupt could not be
> greater than 256, but I don't know where that restriction is.  I'm
> pretty sure the FADT field is 2 bytes, which would mean it could be up
> to 65535.
> 
> To fix this problem, I think we only need to fix the penalty for the
> SCI interrupt.  It seems better to add a single "sci_penalty"
> variable, set it to PIRQ_PENALTY_PCI_USING if it's level/low or
> PIRQ_PENALTY_ISA_ALWAYS otherwise, and add "sci_penalty" in when
> appropriate.  That should fix it for *any* SCI IRQ, not just those
> less than 256, and we don't have to add these extra penalty table
> entries that are all unused (except possibly for one entry if we have
> an SCI in the 16-255 range).
> 
> Something like this:
> 
>   static int sci_irq, sci_penalty;
> 
>   void acpi_penalize_sci_irq(int irq, int trigger, int polarity)
>   {
>     sci = irq;
>     if (trigger == ACPI_MADT_TRIGGER_LEVEL &&
>         polarity == ACPI_MADT_POLARITY_ACTIVE_LOW)
>       sci_penalty = PIRQ_PENALTY_PCI_USING;
>     else
>       sci_penalty = PIRQ_PENALTY_ISA_ALWAYS;
>   }
> 
>   static int acpi_irq_get_penalty(int irq)
>   {
>     int penalty = 0;
> 
>     if (irq == sci_irq)
>       penalty += sci_penalty;
>     ...
>   }
> 
> One could argue that ACPI devices can use IRQs above 15, and we should
> handle penalties for them, too.  But the table is the wrong mechanism
> for that, because it handles penalties for IRQs < 256, but IRQs above
> that would mysteriously be handled differently.
> 
> Bjorn
> 

I agree this is a better approach. I think my math was wrong when figuring
out what a max SCI interrupt could be.



-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
