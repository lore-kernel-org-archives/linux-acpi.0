From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 3/3] ACPI: Bug compatibility for Windows on the ACPI reboot vector
Date: Thu,  9 Dec 2010 16:46:44 -0500
Message-ID: <1291931204-5854-3-git-send-email-mjg@redhat.com>
References: <1291931204-5854-1-git-send-email-mjg@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1291931204-5854-1-git-send-email-mjg@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org
Cc: hpa@zytor.com, linux-acpi@vger.kernel.org, lenb@kernel.org, linux-kernel@vger.kernel.org, Matthew Garrett <mjg@redhat.com>
List-Id: linux-acpi@vger.kernel.org

Windows ignores the bit_offset and bit_width, despite the spec requiring
that they be validated. Drop the checks so that we match this behaviour.
Windows also goes straight for the keyboard controller if the ACPI reboot
fails, so we shouldn't sleep if we're still alive.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/acpi/reboot.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/reboot.c b/drivers/acpi/reboot.c
index 93f9114..4870aaa 100644
--- a/drivers/acpi/reboot.c
+++ b/drivers/acpi/reboot.c
@@ -15,9 +15,10 @@ void acpi_reboot(void)
 
 	rr = &acpi_gbl_FADT.reset_register;
 
-	/* Is the reset register supported? */
-	if (!(acpi_gbl_FADT.flags & ACPI_FADT_RESET_REGISTER) ||
-	    rr->bit_width != 8 || rr->bit_offset != 0)
+	/* Is the reset register supported? The spec says we should be
+	 * checking the bit width and bit offset, but Windows ignores
+	 * these fields */
+	if (!(acpi_gbl_FADT.flags & ACPI_FADT_RESET_REGISTER))
 		return;
 
 	reset_value = acpi_gbl_FADT.reset_value;
@@ -45,6 +46,4 @@ void acpi_reboot(void)
 		acpi_reset();
 		break;
 	}
-	/* Wait ten seconds */
-	acpi_os_stall(10000000);
 }
-- 
1.7.3.2
