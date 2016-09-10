From: Borislav Petkov <bp@alien8.de>
Subject: Re: 584c5c422f6c ("x86/ioapic: Support hot-removal of IOAPICs
 present during boot")
Date: Sat, 10 Sep 2016 16:30:31 +0200
Message-ID: <20160910143031.5s4psayo4wqrmpt2@pd.tnic>
References: <20160910112744.4a6inn5bnjxsseak@pd.tnic>
 <1473513090-30218-1-git-send-email-rui.y.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:33563 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753252AbcIJOhh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 10 Sep 2016 10:37:37 -0400
Content-Disposition: inline
In-Reply-To: <1473513090-30218-1-git-send-email-rui.y.wang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rui Wang <rui.y.wang@intel.com>
Cc: bhelgaas@google.com, torvalds@linux-foundation.org, peterz@infradead.org, tglx@linutronix.de, helgaas@kernel.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, rjw@rjwysocki.net, tony.luck@intel.com, mingo@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org

On Sat, Sep 10, 2016 at 09:11:30PM +0800, Rui Wang wrote:
> Thanks for the analysis. Looks like acpi_gbl_root_node == 0. It is

Is ACPI_HANDLE(root_bus->bridge) == ACPI_ROOT_OBJECT?

Because this is what the code does but I can't see it from the code that
the handle is of type ACPI_ROOT_OBJECT...

> initialized earlier than where we call acpi_ioapic_add().
> start_kernel()
> 	->acpi_early_init()
> 		->acpi_initialize_subsystem()
> 			 ->acpi_ns_root_initialize()
> 				-> acpi_gbl_root_node = ...
> 
> 
> But acpi_gbl_root_node can be 0 if acpi_disabled == 1.
> Do you somehow have acpi turned off (!CONFIG_ACPI or booting with acpi=off)?

Nope.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
