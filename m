From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH 2.6.28-rc6] ACPICA: don't cond_resched() when
	irqs_disabled()
Date: Fri, 19 Dec 2008 19:01:45 +0800
Message-ID: <20081219110145.GA14076@localhost>
References: <20081126135508.GA1891@localhost> <alpine.LFD.2.00.0812190016120.6312@localhost.localdomain> <1229670120.3990.11.camel@yakui_zhao.sh.intel.com> <alpine.LFD.2.00.0812190326000.6312@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:18048 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753357AbYLSMFV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Dec 2008 07:05:21 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0812190326000.6312@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Zhao, Yakui" <yakui.zhao@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>

Hi Len,

FYI: this patch from Lin Ming will generate the following messages:

on closing lid =>                                                                                                                
                                                                                                                                 
[ 8993.764829] irq status before SMI: enable                                                                                     
[ 8993.768028] irq status after SMI: disable, value: 0xF3                                                                        
                                                                                                                                     
on opening lid =>                                                                                                                    
                                                                                                                                     
[ 8987.590636] irq status before SMI: enable                                                                                         
[ 8987.669829] irq status after SMI: enable, value: 0xF3                                                                             

---
 drivers/acpi/executer/exregion.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- linux-2.6.orig/drivers/acpi/executer/exregion.c
+++ linux-2.6/drivers/acpi/executer/exregion.c
@@ -300,8 +300,20 @@ acpi_ex_system_io_space_handler(u32 func
 
 	case ACPI_WRITE:
 
+		if (address == 0xB2) {
+			printk("irq status before SMI: %s\n",
+				irqs_disabled() ? "disable" : "enable");
+		}
+
 		status = acpi_os_write_port((acpi_io_address) address,
 					    (u32) * value, bit_width);
+
+		if (address == 0xB2) {
+			printk("irq status after SMI: %s, value: 0x%X\n",
+				irqs_disabled() ? "disable" : "enable",
+				(u32) *value);
+		}
+
 		break;
 
 	default:

We are now exploring how the Windows execution path manages to avoid this bug.

Thanks,
Fengguang

On Fri, Dec 19, 2008 at 10:38:18AM +0200, Len Brown wrote:
> >     The issue on Fengguang's laptop is different with that on the box of
> > T61.  On Fengguang's laptop after evaluating one ACPI object(GPE
> > _L18object), the irq is disabled mystically. After some investigations
> > we find that it is caused by SMI(The SMI will be triggered while
> > evaluating the ACPI object. And this issue is also related with Video). 
> 
> Interesting.
> I hadn't realized you root-caused that failure.
> This is good to know, but the fact that SMM can
> leave interrupts disabled is frightening.
> 
> If the BIOS SMM on that box disables interrupts when
> random AML is run, then it is going to run into
> all kinds of other problems in addition to this one...
> 
> Hopefully the BIOS bugs is fixed by a BIOS update...
> 
> >     If the boot option of "noapic" is added on the box of bug12252, the
> > irq_router_resume will be called, in which the _CRS/_SRS object will be
> > evaluated. But unfortunately the irq is disabled when irq_router_resume
> > is called. 
> 
> Right.  I forced the T61 to run into this problem by forcing
> it to use PIC mode and suspending -- for it doesn't use the links
> in IOAPIC mode.  Many other systems do use the links in default
> mode, however, so I'm surprised that we had not heard more about
> this failure.
> 
> Now that I search for acpi_ps_complete_op() on kerneloops.org,
> I see that just a few people have run into it.
> 
> thanks,
> -- Len Brown, Intel Open Source Technology Center> 
