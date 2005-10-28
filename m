From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 9/9] acpi: cleanup u32 flags in spin_lock calls
Date: Fri, 28 Oct 2005 14:59:54 -0700
Message-ID: <200510282159.j9SLxa5X021628@shell0.pdx.osdl.net>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


From: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>

There are some places in ACPI that save flags as a u32 instead of a
unsigned long.  This is done indirectly by calling acpi_os_acquire_lock,
which uses unsigned long, but the flags returned are saved in the acpi code
as a u32.

Since today's archs that use acpi, only care about the LS 32 bits of the
word, this is not really an issue.  But if there is an arch in the future
that changes that assumption, or (as RT does) some internal change in the
kernel that looks at the MSB of flags on a restore, this will be broken for
64 bit machines.

This patch is just to make the ACPI code "clean".  That is, to use the
proper type for flags.

Signed-off-by: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 drivers/acpi/events/evgpe.c    |    2 +-
 drivers/acpi/events/evgpeblk.c |   10 +++++-----
 drivers/acpi/events/evxface.c  |    4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff -puN drivers/acpi/events/evgpeblk.c~acpi-cleanup-u32-flags-in-spin_lock-calls drivers/acpi/events/evgpeblk.c
--- 25/drivers/acpi/events/evgpeblk.c~acpi-cleanup-u32-flags-in-spin_lock-calls	Fri Oct 28 14:59:14 2005
+++ 25-akpm/drivers/acpi/events/evgpeblk.c	Fri Oct 28 14:59:14 2005
@@ -136,7 +136,7 @@ acpi_status acpi_ev_walk_gpe_list(ACPI_G
 	struct acpi_gpe_block_info *gpe_block;
 	struct acpi_gpe_xrupt_info *gpe_xrupt_info;
 	acpi_status status = AE_OK;
-	u32 flags;
+	unsigned long flags;
 
 	ACPI_FUNCTION_TRACE("ev_walk_gpe_list");
 
@@ -479,7 +479,7 @@ static struct acpi_gpe_xrupt_info *acpi_
 	struct acpi_gpe_xrupt_info *next_gpe_xrupt;
 	struct acpi_gpe_xrupt_info *gpe_xrupt;
 	acpi_status status;
-	u32 flags;
+	unsigned long flags;
 
 	ACPI_FUNCTION_TRACE("ev_get_gpe_xrupt_block");
 
@@ -553,7 +553,7 @@ static acpi_status
 acpi_ev_delete_gpe_xrupt(struct acpi_gpe_xrupt_info *gpe_xrupt)
 {
 	acpi_status status;
-	u32 flags;
+	unsigned long flags;
 
 	ACPI_FUNCTION_TRACE("ev_delete_gpe_xrupt");
 
@@ -610,7 +610,7 @@ acpi_ev_install_gpe_block(struct acpi_gp
 	struct acpi_gpe_block_info *next_gpe_block;
 	struct acpi_gpe_xrupt_info *gpe_xrupt_block;
 	acpi_status status;
-	u32 flags;
+	unsigned long flags;
 
 	ACPI_FUNCTION_TRACE("ev_install_gpe_block");
 
@@ -663,7 +663,7 @@ acpi_ev_install_gpe_block(struct acpi_gp
 acpi_status acpi_ev_delete_gpe_block(struct acpi_gpe_block_info *gpe_block)
 {
 	acpi_status status;
-	u32 flags;
+	unsigned long flags;
 
 	ACPI_FUNCTION_TRACE("ev_install_gpe_block");
 
diff -puN drivers/acpi/events/evgpe.c~acpi-cleanup-u32-flags-in-spin_lock-calls drivers/acpi/events/evgpe.c
--- 25/drivers/acpi/events/evgpe.c~acpi-cleanup-u32-flags-in-spin_lock-calls	Fri Oct 28 14:59:14 2005
+++ 25-akpm/drivers/acpi/events/evgpe.c	Fri Oct 28 14:59:14 2005
@@ -377,7 +377,7 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_x
 	struct acpi_gpe_register_info *gpe_register_info;
 	u32 status_reg;
 	u32 enable_reg;
-	u32 flags;
+	unsigned long flags;
 	acpi_status status;
 	struct acpi_gpe_block_info *gpe_block;
 	acpi_native_uint i;
diff -puN drivers/acpi/events/evxface.c~acpi-cleanup-u32-flags-in-spin_lock-calls drivers/acpi/events/evxface.c
--- 25/drivers/acpi/events/evxface.c~acpi-cleanup-u32-flags-in-spin_lock-calls	Fri Oct 28 14:59:14 2005
+++ 25-akpm/drivers/acpi/events/evxface.c	Fri Oct 28 14:59:14 2005
@@ -562,7 +562,7 @@ acpi_install_gpe_handler(acpi_handle gpe
 	struct acpi_gpe_event_info *gpe_event_info;
 	struct acpi_handler_info *handler;
 	acpi_status status;
-	u32 flags;
+	unsigned long flags;
 
 	ACPI_FUNCTION_TRACE("acpi_install_gpe_handler");
 
@@ -653,7 +653,7 @@ acpi_remove_gpe_handler(acpi_handle gpe_
 	struct acpi_gpe_event_info *gpe_event_info;
 	struct acpi_handler_info *handler;
 	acpi_status status;
-	u32 flags;
+	unsigned long flags;
 
 	ACPI_FUNCTION_TRACE("acpi_remove_gpe_handler");
 
_


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
