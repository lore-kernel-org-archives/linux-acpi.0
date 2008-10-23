From: Len Brown <lenb@kernel.org>
Subject: [PATCH 112/122] ACPICA: Optimize buffer allocation procedure
Date: Thu, 23 Oct 2008 02:39:26 -0400
Message-ID: <68e125c40597802b9789bc696775bf0246e7667d.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:55856 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754786AbYJWGkj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:39 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9600F08IJ89X94@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:21 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Eliminate duplicate code.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/utilities/utalloc.c |   53 ++++++++++++++++++++------------------
 1 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/utilities/utalloc.c b/drivers/acpi/utilities/utalloc.c
index 7dcb67e..241c535 100644
--- a/drivers/acpi/utilities/utalloc.c
+++ b/drivers/acpi/utilities/utalloc.c
@@ -232,7 +232,7 @@ acpi_status acpi_ut_validate_buffer(struct acpi_buffer * buffer)
  * RETURN:      Status
  *
  * DESCRIPTION: Validate that the buffer is of the required length or
- *              allocate a new buffer.  Returned buffer is always zeroed.
+ *              allocate a new buffer. Returned buffer is always zeroed.
  *
  ******************************************************************************/
 
@@ -240,7 +240,7 @@ acpi_status
 acpi_ut_initialize_buffer(struct acpi_buffer * buffer,
 			  acpi_size required_length)
 {
-	acpi_status status = AE_OK;
+	acpi_size input_buffer_length;
 
 	/* Parameter validation */
 
@@ -248,55 +248,58 @@ acpi_ut_initialize_buffer(struct acpi_buffer * buffer,
 		return (AE_BAD_PARAMETER);
 	}
 
-	switch (buffer->length) {
+	/*
+	 * Buffer->Length is used as both an input and output parameter. Get the
+	 * input actual length and set the output required buffer length.
+	 */
+	input_buffer_length = buffer->length;
+	buffer->length = required_length;
+
+	/*
+	 * The input buffer length contains the actual buffer length, or the type
+	 * of buffer to be allocated by this routine.
+	 */
+	switch (input_buffer_length) {
 	case ACPI_NO_BUFFER:
 
-		/* Set the exception and returned the required length */
+		/* Return the exception (and the required buffer length) */
 
-		status = AE_BUFFER_OVERFLOW;
-		break;
+		return (AE_BUFFER_OVERFLOW);
 
 	case ACPI_ALLOCATE_BUFFER:
 
 		/* Allocate a new buffer */
 
 		buffer->pointer = acpi_os_allocate(required_length);
-		if (!buffer->pointer) {
-			return (AE_NO_MEMORY);
-		}
-
-		/* Clear the buffer */
-
-		ACPI_MEMSET(buffer->pointer, 0, required_length);
 		break;
 
 	case ACPI_ALLOCATE_LOCAL_BUFFER:
 
 		/* Allocate a new buffer with local interface to allow tracking */
 
-		buffer->pointer = ACPI_ALLOCATE_ZEROED(required_length);
-		if (!buffer->pointer) {
-			return (AE_NO_MEMORY);
-		}
+		buffer->pointer = ACPI_ALLOCATE(required_length);
 		break;
 
 	default:
 
 		/* Existing buffer: Validate the size of the buffer */
 
-		if (buffer->length < required_length) {
-			status = AE_BUFFER_OVERFLOW;
-			break;
+		if (input_buffer_length < required_length) {
+			return (AE_BUFFER_OVERFLOW);
 		}
+		break;
+	}
 
-		/* Clear the buffer */
+	/* Validate allocation from above or input buffer pointer */
 
-		ACPI_MEMSET(buffer->pointer, 0, required_length);
-		break;
+	if (!buffer->pointer) {
+		return (AE_NO_MEMORY);
 	}
 
-	buffer->length = required_length;
-	return (status);
+	/* Have a valid buffer, clear it */
+
+	ACPI_MEMSET(buffer->pointer, 0, required_length);
+	return (AE_OK);
 }
 
 #ifdef NOT_USED_BY_LINUX
-- 
1.5.5.1

