From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 1/1 linux-next] ACPI: remove unnecessary sizeof(u8)
Date: Sun, 16 Nov 2014 10:57:00 +0100
Message-ID: <1416131820-7336-1-git-send-email-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Fabian Frederick <fabf@skynet.be>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

sizeof(u8) is always 1.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/acpi/utils.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 371ac12..dd8ff63 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -136,8 +136,7 @@ acpi_extract_package(union acpi_object *package,
 				break;
 			case 'B':
 				size_required +=
-				    sizeof(u8 *) +
-				    (element->buffer.length * sizeof(u8));
+				    sizeof(u8 *) + element->buffer.length;
 				tail_offset += sizeof(u8 *);
 				break;
 			default:
@@ -255,7 +254,7 @@ acpi_extract_package(union acpi_object *package,
 				memcpy(tail, element->buffer.pointer,
 				       element->buffer.length);
 				head += sizeof(u8 *);
-				tail += element->buffer.length * sizeof(u8);
+				tail += element->buffer.length;
 				break;
 			default:
 				/* Should never get here */
-- 
1.9.3
