From: Lin Ming <ming.m.lin@intel.com>
Subject: RE: [PATCH] ACPICA: Fix Scope() op in module level code
Date: Mon, 25 Oct 2010 08:29:21 +0800
Message-ID: <1287966561.6530.3229.camel@minggr.sh.intel.com>
References: <1287736022.6530.3216.camel@minggr.sh.intel.com>
	 <4911F71203A09E4D9981D27F9D830858BC1E4705@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:29173 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920Ab0JYAdF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 24 Oct 2010 20:33:05 -0400
In-Reply-To: <4911F71203A09E4D9981D27F9D830858BC1E4705@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: lenb <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "tony@awtrey.com" <tony@awtrey.com>, "john.floyd@environment.nsw.gov.au" <john.floyd@environment.nsw.gov.au>

On Sat, 2010-10-23 at 06:43 +0800, Moore, Robert wrote:
> However, the fix really affects any control method that attempts to use the Scope() operator, correct?

Correct, how about below changelog?

[PATCH] ACPICA: Fix Scope() op in control method

Some Panasonic Toughbooks create nodes in module level code.
Module level code is the executable AML code outside of control method,
but we implemented it as control method.
For example, below AML code creates a node \_SB.PCI0.GFX0.DD02.CUBL

       If (\_OSI ("Windows 2006"))
       {
           Scope (\_SB.PCI0.GFX0.DD02)
           {
               Name (CUBL, Ones)
               ...
           }
       }

Scope() op does not actually create a new object, it refers to an
existing object(\_SB.PCI0.GFX0.DD02 in above example). However, for
Scope(), we want to indeed open a new scope, so the child nodes(CUBL in
above example) can be created correctly under it.

https://bugzilla.kernel.org/show_bug.cgi?id=19462

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>


> 
> >-----Original Message-----
> >From: Lin, Ming M
> >Sent: Friday, October 22, 2010 1:27 AM
> >To: lenb
> >Cc: Moore, Robert; linux-acpi; tony@awtrey.com;
> >john.floyd@environment.nsw.gov.au
> >Subject: [PATCH] ACPICA: Fix Scope() op in module level code
> >
> >Len,
> >
> >Would you please include this patch in 2.6.37 merge?
> >
> >Thanks,
> >Lin Ming
> >---
> >
> >From: Bob Moore <robert.moore@intel.com>
> >
> >Some Panasonic Toughbooks create nodes in module level code.
> >Module level code is the executable AML code outside of control method,
> >for example, below AML code creates a node \_SB.PCI0.GFX0.DD02.CUBL
> >
> >        If (\_OSI ("Windows 2006"))
> >        {
> >            Scope (\_SB.PCI0.GFX0.DD02)
> >            {
> >                Name (CUBL, Ones)
> >                ...
> >            }
> >        }
> >
> >Scope() op does not actually create a new object, it refers to an
> >existing object(\_SB.PCI0.GFX0.DD02 in above example). However, for
> >Scope(), we want to indeed open a new scope, so the child nodes(CUBL in
> >above example) can be created correctly under it.
> >
> >https://bugzilla.kernel.org/show_bug.cgi?id=19462
> >
> >Signed-off-by: Bob Moore <robert.moore@intel.com>
> >Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> >---
> > drivers/acpi/acpica/dswexec.c |   19 +++++++++++++++++--
> > 1 files changed, 17 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c
> >index d555b37..6b0b5d0 100644
> >--- a/drivers/acpi/acpica/dswexec.c
> >+++ b/drivers/acpi/acpica/dswexec.c
> >@@ -300,10 +300,25 @@ acpi_ds_exec_begin_op(struct acpi_walk_state
> >*walk_state,
> > 			 * we must enter this object into the namespace.  The
> >created
> > 			 * object is temporary and will be deleted upon
> >completion of
> > 			 * the execution of this method.
> >+			 *
> >+			 * Note 10/2010: Except for the Scope() op. This opcode
> >does
> >+			 * not actually create a new object, it refers to an
> >existing
> >+			 * object. However, for Scope(), we want to indeed open a
> >+			 * new scope.
> > 			 */
> >-			status = acpi_ds_load2_begin_op(walk_state, NULL);
> >+			if (op->common.aml_opcode != AML_SCOPE_OP) {
> >+				status =
> >+				    acpi_ds_load2_begin_op(walk_state, NULL);
> >+			} else {
> >+				status =
> >+				    acpi_ds_scope_stack_push(op->named.node,
> >+							     op->named.node->
> >+							     type, walk_state);
> >+				if (ACPI_FAILURE(status)) {
> >+					return_ACPI_STATUS(status);
> >+				}
> >+			}
> > 		}
> >-
> > 		break;
> >
> > 	case AML_CLASS_EXECUTE:
> >
> 


