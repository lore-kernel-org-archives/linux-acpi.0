From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] Fix shared irq trigger-flags conflict when old irqaction
 uses IRQF_TRIGGER_NONE
Date: Fri, 14 Apr 2017 11:34:27 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1704141129250.2327@nanos>
References: <20170409195918.20864-1-hdegoede@redhat.com> <8e5511ce-601b-bde9-cdd3-c901ffc3d53d@arm.com> <1117548f-9b5a-111c-6657-79a6c30179de@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:41418 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754397AbdDNJem (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Apr 2017 05:34:42 -0400
In-Reply-To: <1117548f-9b5a-111c-6657-79a6c30179de@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, linux-acpi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org

On Mon, 10 Apr 2017, Hans de Goede wrote:
> Where the new_action trigger_mask gets filled with the triger_mask
> from the irq_data, which is a further hint that looking at
> irqd_get_trigger_type(&desc->irq_data) rather then at
> (old->flags IRQF_TRIGGER_MASK) is probably the right fix.
> 
> Note btw that 4b357daed698 is (part of) what is breaking things for
> my use-case, I request the irq with IRQF_TRIGGER_NONE but
> 4b357daed698 modifies that before comparing the new trigger flags
> to the old.

The issue here is, that at the time of the first setup_irq() the trigger
type in irq_data is NONE. As a consequence the following is a NOOP:

     if (!new->trigger)
	new->flags |= get_type(irqdata);

Now the irq is started up for the first time and then the actual trigger
type gets established, but that's to late to fix up new->flags.

So yes, we should change the logic for the shared case to:

   if (old) {
      	    oldtype = get_type(irqdata);

	    if (oldtype != newtype)
	       	    goto mismatch;

That should cover all cases.

Thanks,

	tglx
