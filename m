From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 4/9] acpi: cleanup u32 flags in spin_lock calls
Date: Thu, 05 Jan 2006 22:30:55 -0800
Message-ID: <200601060631.k066V8cU008132@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org
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

 drivers/acpi/events/evgpe.c     |    2 +-
 drivers/acpi/events/evgpeblk.c  |   10 +++++-----
 drivers/acpi/events/evxface.c   |    4 ++--
 include/acpi/platform/aclinux.h |    2 ++
 4 files changed, 10 insertions(+), 8 deletions(-)

diff -puN drivers/acpi/events/evgpeblk.c~acpi-cleanup-u32-flags-in-spin_lock-calls drivers/acpi/events/evgpeblk.c
--- devel/drivers/acpi/events/evgpeblk.c~acpi-cleanup-u32-flags-in-spin_lock-calls	2006-01-05 22:28:23.000000000 -0800
+++ devel-akpm/drivers/acpi/events/evgpeblk.c	2006-01-05 22:28:23.000000000 -0800
@@ -136,7 +136,7 @@ acpi_status acpi_ev_walk_gpe_list(ACPI_G
 	struct acpi_gpe_block_info *gpe_block;
 	struct acpi_gpe_xrupt_info *gpe_xrupt_info;
 	acpi_status status = AE_OK;
-	acpi_native_uint flags;
+	acpi_cpu_flags_t flags;
 
 	ACPI_FUNCTION_TRACE("ev_walk_gpe_list");
 
@@ -480,7 +480,7 @@ static struct acpi_gpe_xrupt_info *acpi_
 	struct acpi_gpe_xrupt_info *next_gpe_xrupt;
 	struct acpi_gpe_xrupt_info *gpe_xrupt;
 	acpi_status status;
-	acpi_native_uint flags;
+	acpi_cpu_flags_t flags;
 
 	ACPI_FUNCTION_TRACE("ev_get_gpe_xrupt_block");
 
@@ -554,7 +554,7 @@ static acpi_status
 acpi_ev_delete_gpe_xrupt(struct acpi_gpe_xrupt_info *gpe_xrupt)
 {
 	acpi_status status;
-	acpi_native_uint flags;
+	acpi_cpu_flags_t flags;
 
 	ACPI_FUNCTION_TRACE("ev_delete_gpe_xrupt");
 
@@ -612,7 +612,7 @@ acpi_ev_install_gpe_block(struct acpi_gp
 	struct acpi_gpe_block_info *next_gpe_block;
 	struct acpi_gpe_xrupt_info *gpe_xrupt_block;
 	acpi_status status;
-	acpi_native_uint flags;
+	acpi_cpu_flags_t flags;
 
 	ACPI_FUNCTION_TRACE("ev_install_gpe_block");
 
@@ -665,7 +665,7 @@ acpi_ev_install_gpe_block(struct acpi_gp
 acpi_status acpi_ev_delete_gpe_block(struct acpi_gpe_block_info *gpe_block)
 {
 	acpi_status status;
-	acpi_native_uint flags;
+	acpi_cpu_flags_t flags;
 
 	ACPI_FUNCTION_TRACE("ev_install_gpe_block");
 
diff -puN drivers/acpi/events/evgpe.c~acpi-cleanup-u32-flags-in-spin_lock-calls drivers/acpi/events/evgpe.c
--- devel/drivers/acpi/events/evgpe.c~acpi-cleanup-u32-flags-in-spin_lock-calls	2006-01-05 22:28:23.000000000 -0800
+++ devel-akpm/drivers/acpi/events/evgpe.c	2006-01-05 22:28:23.000000000 -0800
@@ -379,7 +379,7 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_x
 	u8 enabled_status_byte;
 	u32 status_reg;
 	u32 enable_reg;
-	acpi_native_uint flags;
+	acpi_cpu_flags_t flags;
 	acpi_native_uint i;
 	acpi_native_uint j;
 
diff -puN drivers/acpi/events/evxface.c~acpi-cleanup-u32-flags-in-spin_lock-calls drivers/acpi/events/evxface.c
--- devel/drivers/acpi/events/evxface.c~acpi-cleanup-u32-flags-in-spin_lock-calls	2006-01-05 22:28:23.000000000 -0800
+++ devel-akpm/drivers/acpi/events/evxface.c	2006-01-05 22:28:23.000000000 -0800
@@ -562,7 +562,7 @@ acpi_install_gpe_handler(acpi_handle gpe
 	struct acpi_gpe_event_info *gpe_event_info;
 	struct acpi_handler_info *handler;
 	acpi_status status;
-	acpi_native_uint flags;
+	acpi_cpu_flags_t flags;
 
 	ACPI_FUNCTION_TRACE("acpi_install_gpe_handler");
 
@@ -653,7 +653,7 @@ acpi_remove_gpe_handler(acpi_handle gpe_
 	struct acpi_gpe_event_info *gpe_event_info;
 	struct acpi_handler_info *handler;
 	acpi_status status;
-	acpi_native_uint flags;
+	acpi_cpu_flags_t flags;
 
 	ACPI_FUNCTION_TRACE("acpi_remove_gpe_handler");
 
diff -puN include/acpi/platform/aclinux.h~acpi-cleanup-u32-flags-in-spin_lock-calls include/acpi/platform/aclinux.h
--- devel/include/acpi/platform/aclinux.h~acpi-cleanup-u32-flags-in-spin_lock-calls	2006-01-05 22:28:23.000000000 -0800
+++ devel-akpm/include/acpi/platform/aclinux.h	2006-01-05 22:28:23.000000000 -0800
@@ -102,4 +102,6 @@
 
 #include "acgcc.h"
 
+typedef unsigned long acpi_cpu_flags_t;
+
 #endif				/* __ACLINUX_H__ */
_
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
