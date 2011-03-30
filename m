From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/3] acpi: Cleanup custom_method debug stuff
Date: Wed, 30 Mar 2011 11:06:08 +0200
Message-ID: <201103301106.08827.trenn@suse.de>
References: <1301401990-35469-1-git-send-email-trenn@suse.de> <1301401990-35469-3-git-send-email-trenn@suse.de> <1301449065.31460.75.camel@rui>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:50537 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753672Ab1C3JGL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Mar 2011 05:06:11 -0400
In-Reply-To: <1301449065.31460.75.camel@rui>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wednesday, March 30, 2011 03:37:45 AM Zhang Rui wrote:
> On Tue, 2011-03-29 at 20:33 +0800, Thomas Renninger wrote:
> > - Revert param aml_debug_output, it's not used.
> 
> NAK.
> 
> void
> acpi_ex_do_debug_object(union acpi_operand_object *source_desc,
>                         u32 level, u32 index)
> {
> 	...
>         if (!acpi_gbl_enable_aml_debug_object &&
>             !(acpi_dbg_level & ACPI_LV_DEBUG_OBJECT)) {
>                 return_VOID;
>         }
> 	...
> }
> 
> Users can set acpi_gbl_enable_aml_debug_object via module parameter
> aml_bug_output, thus enable the ACPI Debug output at runtime.
Ah yes, I've overseen this one.
What is the advantage of:
/sys/module/acpi/parameters/aml_debug_output
over:
/sys/module/acpi/parameters/{debug_level,debug_layer}
?

The first is also available even if CONFIG_ACPI_DEBUG
is not defined at all?

Yep, this is rather useful. I still would move the param into:
drivers/acpi/sysfs.c
if I touch this now anyway, where all the other
/sys tunables are flying around:
grep \/sys drivers/acpi/sysfs.c
 * /sys/modules/acpi/parameters/debug_layer
 * /sys/modules/acpi/parameters/debug_level
 * /sys/modules/acpi/parameters/trace_method_name
 * /sys/modules/acpi/parameters/trace_state
 * /sys/modules/acpi/parameters/trace_debug_layer
 * /sys/modules/acpi/parameters/trace_debug_level
/* /sys/module/acpi/parameters/acpica_version */
 * /sys/firmware/acpi/tables/
 * /sys/firmware/acpi/tables/dynamic/
 * /sys/firmware/acpi/interrupts/

...if that's fine with you.

   Thomas
