From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/3] acpi: Cleanup custom_method debug stuff
Date: Thu, 31 Mar 2011 09:14:59 +0800
Message-ID: <1301534099.11482.40.camel@rui>
References: <1301401990-35469-1-git-send-email-trenn@suse.de>
	 <1301401990-35469-3-git-send-email-trenn@suse.de>
	 <1301449065.31460.75.camel@rui>  <201103301106.08827.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36404 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755440Ab1CaBQN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Mar 2011 21:16:13 -0400
In-Reply-To: <201103301106.08827.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, 2011-03-30 at 17:06 +0800, Thomas Renninger wrote:
> On Wednesday, March 30, 2011 03:37:45 AM Zhang Rui wrote:
> > On Tue, 2011-03-29 at 20:33 +0800, Thomas Renninger wrote:
> > > - Revert param aml_debug_output, it's not used.
> > 
> > NAK.
> > 
> > void
> > acpi_ex_do_debug_object(union acpi_operand_object *source_desc,
> >                         u32 level, u32 index)
> > {
> > 	...
> >         if (!acpi_gbl_enable_aml_debug_object &&
> >             !(acpi_dbg_level & ACPI_LV_DEBUG_OBJECT)) {
> >                 return_VOID;
> >         }
> > 	...
> > }
> > 
> > Users can set acpi_gbl_enable_aml_debug_object via module parameter
> > aml_bug_output, thus enable the ACPI Debug output at runtime.
> Ah yes, I've overseen this one.
> What is the advantage of:
> /sys/module/acpi/parameters/aml_debug_output
> over:
> /sys/module/acpi/parameters/{debug_level,debug_layer}
> ?
> 
> The first is also available even if CONFIG_ACPI_DEBUG
> is not defined at all?

right. Users can enable the ACPI Debug output w/o rebuilding the kernel.

> 
> Yep, this is rather useful. I still would move the param into:
> drivers/acpi/sysfs.c
> if I touch this now anyway, where all the other
> /sys tunables are flying around:
> grep \/sys drivers/acpi/sysfs.c
>  * /sys/modules/acpi/parameters/debug_layer
>  * /sys/modules/acpi/parameters/debug_level
>  * /sys/modules/acpi/parameters/trace_method_name
>  * /sys/modules/acpi/parameters/trace_state
>  * /sys/modules/acpi/parameters/trace_debug_layer
>  * /sys/modules/acpi/parameters/trace_debug_level
> /* /sys/module/acpi/parameters/acpica_version */
>  * /sys/firmware/acpi/tables/
>  * /sys/firmware/acpi/tables/dynamic/
>  * /sys/firmware/acpi/interrupts/
> 
> ...if that's fine with you.
> 
aml_debug_output is designed to be used together with the runtime
control method override. And this is why I put it in debugfs.c rather
than sysfs.c.
I have no strong objection to your proposal because I'm really not sure
which one is better. :p

thanks,
rui

>    Thomas


