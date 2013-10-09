From: al.stone@linaro.org
Subject: [PATCH] ACPI: improve acpi_extract_package() utility
Date: Wed,  9 Oct 2013 14:21:10 -0600
Message-ID: <1381350070-13208-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:59675 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754871Ab3JIUVd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Oct 2013 16:21:33 -0400
Received: by mail-ob0-f175.google.com with SMTP id uz6so1039669obc.6
        for <linux-acpi@vger.kernel.org>; Wed, 09 Oct 2013 13:21:33 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>, Al Stone <al.stone@linaro.org>

From: Al Stone <ahs3@redhat.com>

  The current version requires one to know the size of the package
  a priori; this is almost impossible if the package is composed of
  strings of variable length.  This change allows the utility to
  allocate a buffer of the proper size if asked.

Signed-off-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/utils.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 552248b..fc2cd32 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -169,11 +169,20 @@ acpi_extract_package(union acpi_object *package,
 	/*
 	 * Validate output buffer.
 	 */
-	if (buffer->length < size_required) {
+	if (buffer->length == ACPI_ALLOCATE_BUFFER) {
+		buffer->pointer = ACPI_ALLOCATE(size_required);
+		if (!buffer->pointer)
+			return AE_NO_MEMORY;
 		buffer->length = size_required;
-		return AE_BUFFER_OVERFLOW;
-	} else if (buffer->length != size_required || !buffer->pointer) {
-		return AE_BAD_PARAMETER;
+		memset(buffer->pointer, 0, size_required);
+	} else {
+		if (buffer->length < size_required) {
+			buffer->length = size_required;
+			return AE_BUFFER_OVERFLOW;
+		} else if (buffer->length != size_required ||
+			   !buffer->pointer) {
+			return AE_BAD_PARAMETER;
+		}
 	}
 
 	head = buffer->pointer;
-- 
1.8.3.1

