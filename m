From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPICA: Add hard limit to while loop
Date: Thu, 9 Oct 2008 05:28:41 -0700
Message-ID: <4911F71203A09E4D9981D27F9D830858031230D4@orsmsx503.amr.corp.intel.com>
References: <20081009103539.1238.81357.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48253 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755139AbYJIMaU convert rfc822-to-8bit (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Thu, 9 Oct 2008 08:30:20 -0400
In-Reply-To: <20081009103539.1238.81357.stgit@thinkpad>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>, LenBrown <lenb@kernel.org>
Cc: "Linux-acpi@vger.kernel.org" <Linux-acpi@vger.kernel.org>

This sounds like a good idea.

I would probably add a new exception code so that it is clear exactly why the method was aborted, and make the maximum loop count a configuration constant.

Bob


-----Original Message-----
From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Alexey Starikovskiy
Sent: Thursday, October 09, 2008 3:36 AM
To: LenBrown
Cc: Linux-acpi@vger.kernel.org
Subject: [PATCH] ACPICA: Add hard limit to while loop

We need to prevent infinite loops and lockups

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/dispatcher/dsopcode.c |    9 +++++++--
 include/acpi/acstruct.h            |    1 +
 2 files changed, 8 insertions(+), 2 deletions(-)


diff --git a/drivers/acpi/dispatcher/dsopcode.c b/drivers/acpi/dispatcher/dsopcode.c
index 6a81c44..e2a3535 100644
--- a/drivers/acpi/dispatcher/dsopcode.c
+++ b/drivers/acpi/dispatcher/dsopcode.c
@@ -1246,8 +1246,13 @@ acpi_ds_exec_end_control_op(struct acpi_walk_state * walk_state,
                if (walk_state->control_state->common.value) {

                        /* Predicate was true, go back and evaluate it again! */
-
-                       status = AE_CTRL_PENDING;
+                       /* Use hard limit to prevent infinite loops and lockups */
+                       if (++walk_state->cycle_count > 0xFFFF) {
+                               status = AE_LIMIT;
+                               ACPI_ERROR ((AE_INFO, "Infinite loop detected"));
+                       } else {
+                               status = AE_CTRL_PENDING;
+                       }
                }

                ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
diff --git a/include/acpi/acstruct.h b/include/acpi/acstruct.h
index 7980a26..fb4405e 100644
--- a/include/acpi/acstruct.h
+++ b/include/acpi/acstruct.h
@@ -94,6 +94,7 @@ struct acpi_walk_state {
        u32 method_breakpoint;  /* For single stepping */
        u32 user_breakpoint;    /* User AML breakpoint */
        u32 parse_flags;
+       u32 cycle_count;        /* While loop cycle count */

        struct acpi_parse_state parser_state;   /* Current state of parser */
        u32 prev_arg_types;

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
