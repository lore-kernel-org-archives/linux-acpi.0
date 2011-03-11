From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 4/4] ACPI: Make sure the FADT is at least rev 2 before using the reset register
Date: Fri, 11 Mar 2011 16:12:20 -0500
Message-ID: <1299877940-6870-4-git-send-email-mjg@redhat.com>
References: <1299877940-6870-1-git-send-email-mjg@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1299877940-6870-1-git-send-email-mjg@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, Matthew Garrett <mjg@redhat.com>
List-Id: linux-acpi@vger.kernel.org

The reset register was only introduced with version 2 of the FADT, so we
should check that the FADT revision before trusting its contents.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/acpi/reboot.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/reboot.c b/drivers/acpi/reboot.c
index 4870aaa..a6c77e8b 100644
--- a/drivers/acpi/reboot.c
+++ b/drivers/acpi/reboot.c
@@ -15,6 +15,11 @@ void acpi_reboot(void)
 
 	rr = &acpi_gbl_FADT.reset_register;
 
+	/* ACPI reset register was only introduced with v2 of the FADT */
+
+	if (acpi_gbl_FADT.header.revision < 2)
+		return;
+
 	/* Is the reset register supported? The spec says we should be
 	 * checking the bit width and bit offset, but Windows ignores
 	 * these fields */
-- 
1.7.4.1
