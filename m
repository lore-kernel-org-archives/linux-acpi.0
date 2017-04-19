From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ACPI: avoid maybe-uninitialized warning
Date: Wed, 19 Apr 2017 19:47:04 +0200
Message-ID: <20170419174720.4110126-1-arnd@arndb.de>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Paul Menzel <pmenzel@molgen.mpg.de>, Josh Poimboeuf <jpoimboe@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, All applicable <stable@vger.kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

gcc -O2 cannot always prove that the loop in acpi_power_get_inferred_state
is enterered at least once, so it assumes that cur_state might not get
initialized:

drivers/acpi/power.c: In function 'acpi_power_get_inferred_state':
drivers/acpi/power.c:222:9: error: 'cur_state' may be used uninitialized in this function [-Werror=maybe-uninitialized]

This sets the variable to zero at the start of the loop, to ensure that
there is well-defined behavior even for an empty list. This gets rid of
the warning.

The warning first showed up when the -Os flag got removed in a bug fix
patch in linux-4.11-rc5.

I would suggest merging this addon patch on top of that bug fix to avoid
introducing a new warning in the stable kernels.

Fixes: 61b79e16c68d ("ACPI: Fix incompatibility with mcount-based function graph tracing")
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/acpi/power.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index fcd4ce6f78d5..1c2b846c5776 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -200,6 +200,7 @@ static int acpi_power_get_list_state(struct list_head *list, int *state)
 		return -EINVAL;
 
 	/* The state of the list is 'on' IFF all resources are 'on'. */
+	cur_state = 0;
 	list_for_each_entry(entry, list, node) {
 		struct acpi_power_resource *resource = entry->resource;
 		acpi_handle handle = resource->device.handle;
-- 
2.9.0
