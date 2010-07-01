From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 4/4 V2] ACPI: introduce module parameter acpi.aml_debug
Date: Thu, 01 Jul 2010 13:37:49 +0800
Message-ID: <1277962669.4537.288.camel@rzhang1-desktop>
References: <1276328790.19052.17845.camel@rzhang1-desktop>
	 <alpine.LFD.2.00.1006212307400.26824@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:55537 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753592Ab0GAFgj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 Jul 2010 01:36:39 -0400
In-Reply-To: <alpine.LFD.2.00.1006212307400.26824@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

On Tue, 2010-06-22 at 11:09 +0800, Len Brown wrote:
> >  
> > +static int param_set_aml_debug(const char *val, struct kernel_param *kp)
> > +{
> > +	if (!strncmp(val, "1\n", 2))
> > +		acpi_gbl_enable_aml_debug_object = 1;
> > +	else if (!strncmp(val, "0\n", 2))
> > +		acpi_gbl_enable_aml_debug_object = 0;
> > +	else
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +static int param_get_aml_debug(char *buffer, struct kernel_param *kp)
> > +{
> > +	if (acpi_gbl_enable_aml_debug_object)
> > +		return sprintf(buffer, "1");
> > +	else
> > +		return sprintf(buffer, "0");
> > +}
> > +
> > +module_param_call(aml_debug, param_set_aml_debug, param_get_aml_debug, NULL, 0644);
> 
> lets do this with a simple module_param instead.
> We can change the type of acpi_gbl_enable_aml_debug_object from u8
> if we need to diverge from acpica.  Maybe we can use a #define
what do you mean by "use a #define"?

> in aclinux.h to change it to a more friendly modparam,
> such as aml_debug_object?

hwo about the patch attached below.


Introduce module parameter acpi.aml_debug_output.

With acpi.aml_debug_output set, we can get AML debug object output
(Store (AAA, Debug)), even with CONFIG_ACPI_DEBUG cleared.

Together with the runtime custom method mechanism,
we can debug AML code problems without rebuilding the kernel.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 Documentation/acpi/method-customizing.txt |    2 ++
 drivers/acpi/acpica/acglobal.h            |    2 +-
 drivers/acpi/debugfs.c                    |    3 +++
 include/acpi/acpixf.h                     |    2 +-
 4 files changed, 7 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/acpi/debugfs.c
===================================================================
--- linux-2.6.orig/drivers/acpi/debugfs.c
+++ linux-2.6/drivers/acpi/debugfs.c
@@ -9,6 +9,9 @@
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
 ACPI_MODULE_NAME("debugfs");
 
+module_param_named(aml_debug_output, acpi_gbl_enable_aml_debug_object, bool, 0644);
+MODULE_PARM_DESC(aml_debug_output, "To enable/disable the ACPI Debug Object output.");
+
 /* --------------------------------------------------------------------------
 				DebugFS Interface
    -------------------------------------------------------------------------- */
Index: linux-2.6/Documentation/acpi/method-customizing.txt
===================================================================
--- linux-2.6.orig/Documentation/acpi/method-customizing.txt
+++ linux-2.6/Documentation/acpi/method-customizing.txt
@@ -19,6 +19,8 @@ Note: Only ACPI METHOD can be overridden
       "Device", "OperationRegion", are not recognized.
 Note: The same ACPI control method can be overridden for many times,
       and it's always the latest one that used by Linux/kernel.
+Note: To get the ACPI debug object output (Store (AAAA, Debug)),
+      please run "echo 1 > /sys/module/acpi/parameters/aml_debug_output".
 
 1. override an existing method
    a) get the ACPI table via ACPI sysfs I/F. e.g. to get the DSDT,
Index: linux-2.6/drivers/acpi/acpica/acglobal.h
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/acglobal.h
+++ linux-2.6/drivers/acpi/acpica/acglobal.h
@@ -115,7 +115,7 @@ u8 ACPI_INIT_GLOBAL(acpi_gbl_use_default
 /*
  * Optionally enable output from the AML Debug Object.
  */
-u8 ACPI_INIT_GLOBAL(acpi_gbl_enable_aml_debug_object, FALSE);
+u32 ACPI_INIT_GLOBAL(acpi_gbl_enable_aml_debug_object, FALSE);
 
 /*
  * Optionally copy the entire DSDT to local memory (instead of simply
Index: linux-2.6/include/acpi/acpixf.h
===================================================================
--- linux-2.6.orig/include/acpi/acpixf.h
+++ linux-2.6/include/acpi/acpixf.h
@@ -67,7 +67,7 @@ extern u8 acpi_gbl_leave_wake_gpes_disab
 extern u8 acpi_gbl_use_default_register_widths;
 extern acpi_name acpi_gbl_trace_method_name;
 extern u32 acpi_gbl_trace_flags;
-extern u8 acpi_gbl_enable_aml_debug_object;
+extern u32 acpi_gbl_enable_aml_debug_object;
 extern u8 acpi_gbl_copy_dsdt_locally;
 extern u8 acpi_gbl_truncate_io_addresses;
 


