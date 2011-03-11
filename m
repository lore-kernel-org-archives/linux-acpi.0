From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 2/4] ACPICA: Fix access width for reset vector
Date: Fri, 11 Mar 2011 16:12:18 -0500
Message-ID: <1299877940-6870-2-git-send-email-mjg@redhat.com>
References: <1299877940-6870-1-git-send-email-mjg@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1299877940-6870-1-git-send-email-mjg@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, Matthew Garrett <mjg@redhat.com>
List-Id: linux-acpi@vger.kernel.org

Section 4.7.3.6 of the ACPI specification requires that the register width
of the reset vector be 8 bits. Windows simply hardcodes the access to be
a byte and ignores the width provided in the FADT, so make sure that we
do the same.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/acpi/acpica/hwxface.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index 6f98d21..f75f81a 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -80,14 +80,14 @@ acpi_status acpi_reset(void)
 
 	if (reset_reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
 		/*
-		 * For I/O space, write directly to the OSL. This bypasses the port
-		 * validation mechanism, which may block a valid write to the reset
-		 * register.
+		 * For I/O space, write directly to the OSL. This
+		 * bypasses the port validation mechanism, which may
+		 * block a valid write to the reset register. Spec
+		 * section 4.7.3.6 requires register width to be 8.
 		 */
 		status =
 		    acpi_os_write_port((acpi_io_address) reset_reg->address,
-				       acpi_gbl_FADT.reset_value,
-				       reset_reg->bit_width);
+				       acpi_gbl_FADT.reset_value, 8);
 	} else {
 		/* Write the reset value to the reset register */
 
-- 
1.7.4.1
