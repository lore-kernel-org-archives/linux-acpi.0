From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: bug report: ACPI Error: [RAMB] Namespace lookup failure,
 AE_NOT_FOUND (20110112/psargs-359)
Date: Mon, 19 Sep 2011 15:04:00 +0800
Message-ID: <1316415840.3634.13.camel@minggr>
References: <CACAe89zvHM7Dz4X1_aTjFt6JpLSJOTWn6HdhyUHCM81+=0Uv=w@mail.gmail.com>
	 <CAF1ivSa45AFa5bVWx32qCVNUCfAoEk4ZNSjmy3B1E47kE9VvWQ@mail.gmail.com>
	 <CACAe89zS5zckGc-2CMcO+QW5tZyXpDq4mvUHNUc8T4WZYMPF6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39300 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751054Ab1ISHED (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Sep 2011 03:04:03 -0400
In-Reply-To: <CACAe89zS5zckGc-2CMcO+QW5tZyXpDq4mvUHNUc8T4WZYMPF6A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jim Green <student.northwestern@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

On Mon, 2011-09-19 at 10:12 +0800, Jim Green wrote:
> On 19 September 2011 00:23, Lin Ming <ming.m.lin@intel.com> wrote:
> > On Mon, Sep 19, 2011 at 1:18 AM, Jim Green
> > <student.northwestern@gmail.com> wrote:
> >> Hello:
> >>
> >> I am running 2.6.38.8-4 kernel on p8p67 deluxe motherboard(bios
> >> version 1702, latest stable)
> >>
> >> 2357 Sep 18 13:05:07 localhost kernel: [    1.045727] ACPI: EC: Look
> >> up EC in DSDT
> >> 2358 Sep 18 13:05:07 localhost kernel: [    1.046535] ACPI: Executed 1
> >> blocks of module-level executable AML code
> >> 2359 Sep 18 13:05:07 localhost kernel: [    1.049876] ACPI Error:
> >> [RAMB] Namespace lookup failure, AE_NOT_FOUND (20110112/psargs-359)
> >> 2360 Sep 18 13:05:07 localhost kernel: [    1.049880] ACPI Exception:
> >> AE_NOT_FOUND, Could not execute arguments for [RAMW] (Region)
> >> (20110112/         nsinit-349)
> >> 2361 Sep 18 13:05:07 localhost kernel: [    1.050347] ACPI: SSDT
> >> 00000000df5d4818 0079C (v01    AMI      IST 00000001 MSFT 03000001)
> >> 2362 Sep 18 13:05:07 localhost kernel: [    1.050805] ACPI: Dynamic
> >> OEM Table Load:
> >> 2363 Sep 18 13:05:07 localhost kernel: [    1.050807] ACPI: SSDT
> >>    (null) 0079C (v01    AMI      IST 00000001 MSFT 03000001)
> >> 2364 Sep 18 13:05:07 localhost kernel: [    1.050883] ACPI: SSDT
> >> 00000000df5dba18 0021C (v01    AMI      CST 00000001 MSFT 03000001)
> >> 2365 Sep 18 13:05:07 localhost kernel: [    1.051168] ACPI: Dynamic
> >> OEM Table Load:
> >> 2366 Sep 18 13:05:07 localhost kernel: [    1.051169] ACPI: SSDT
> >>    (null) 0021C (v01    AMI      CST 00000001 MSFT 03000001)
> >> 2367 Sep 18 13:05:07 localhost kernel: [    1.052510] ACPI: Interpreter enabled
> >> 2368 Sep 18 13:05:07 localhost kernel: [    1.052512] ACPI: (supports
> >> S0 S1 S3 S4 S5)
> >> 2369 Sep 18 13:05:07 localhost kernel: [    1.052530] ACPI: Using
> >> IOAPIC for interrupt routing
> >>
> >> Could anyone help how to fix this error?.. is this bug fixed in some
> >> later kernel versions?
> >
> > Could you attach the acpidump output?
> 
> Hi!
> 
> Pls see attached, THanks!

Hi, please try below patch on 2.6.38.* kernel.

(Note, this patch can't be applied on top of latest 3.1-rc kernel,
because dsopcode.c file was renamed).

>From 5eeaba8a77213dc9ce777a69fd178468253ef578 Mon Sep 17 00:00:00 2001
From: Lin Ming <ming.m.lin@intel.com>
Date: Mon, 19 Sep 2011 14:36:42 +0800
Subject: [PATCH] ACPICA: Save scope node to resolve region argument

    Scope (_SB)
    {
        Name (RAMB, 0xDF5A1018)
        OperationRegion (\RAMW, SystemMemory, RAMB, 0x00010000)
    }

For above ASL code, we need to save scope node(\_SB) to lookup
the argument node(\_SB.RAMB).

Reported-by: Jim Green <student.northwestern@gmail.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/acobject.h |    1 +
 drivers/acpi/acpica/dsopcode.c |    2 +-
 drivers/acpi/acpica/excreate.c |    6 ++++++
 3 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index 1055769..6d276c2 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -358,6 +358,7 @@ typedef enum {
  */
 struct acpi_object_extra {
 	ACPI_OBJECT_COMMON_HEADER struct acpi_namespace_node *method_REG;	/* _REG method for this region (if any) */
+	struct acpi_namespace_node *scope_node;
 	void *region_context;	/* Region-specific data */
 	u8 *aml_start;
 	u32 aml_length;
diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
index bbecf29..7ba0335 100644
--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -394,7 +394,7 @@ acpi_status acpi_ds_get_region_arguments(union acpi_operand_object *obj_desc)
 
 	/* Execute the argument AML */
 
-	status = acpi_ds_execute_arguments(node, node->parent,
+	status = acpi_ds_execute_arguments(node, extra_desc->extra.scope_node,
 					   extra_desc->extra.aml_length,
 					   extra_desc->extra.aml_start);
 	if (ACPI_FAILURE(status)) {
diff --git a/drivers/acpi/acpica/excreate.c b/drivers/acpi/acpica/excreate.c
index e7b372d..df6ef00 100644
--- a/drivers/acpi/acpica/excreate.c
+++ b/drivers/acpi/acpica/excreate.c
@@ -329,6 +329,12 @@ acpi_ex_create_region(u8 * aml_start,
 	region_obj2 = obj_desc->common.next_object;
 	region_obj2->extra.aml_start = aml_start;
 	region_obj2->extra.aml_length = aml_length;
+	if (walk_state->scope_info) {
+		region_obj2->extra.scope_node =
+		    walk_state->scope_info->scope.node;
+	} else {
+		region_obj2->extra.scope_node = node;
+	}
 
 	/* Init the region from the operands */
 
-- 
1.7.2.5



