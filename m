From: dl9pf@gmx.de
Subject: [PATCH] Fix section to __init. Align with usage in acpixf.h . Fixes warning during compilation with clang.
Date: Tue, 30 Apr 2013 11:39:04 +0200
Message-ID: <1367314744-9659-1-git-send-email-dl9pf@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@sisk.pl, lenb@kernel.org
Cc: dl9pf@gmx.de
List-Id: linux-acpi@vger.kernel.org

=46rom: Jan-Simon M=C3=B6ller <dl9pf@gmx.de>

Signed-off-by: Jan-Simon M=C3=B6ller <dl9pf@gmx.de>
---
 include/acpi/acpiosxf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 5b3d2bd..64b8c76 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -77,7 +77,7 @@ struct acpi_signal_fatal_info {
 /*
  * OSL Initialization and shutdown primitives
  */
-acpi_status __initdata acpi_os_initialize(void);
+acpi_status __init acpi_os_initialize(void);
=20
 acpi_status acpi_os_terminate(void);
=20
--=20
1.8.1.4
