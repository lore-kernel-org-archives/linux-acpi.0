From: Al Stone <al.stone@linaro.org>
Subject: [PATCH v2 1/3] ACPI : introduce macros for using the ACPI specification version
Date: Thu, 18 Jun 2015 16:36:06 -0600
Message-ID: <1434666968-1543-2-git-send-email-al.stone@linaro.org>
References: <1434666968-1543-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:36591 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbbFRWgW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Jun 2015 18:36:22 -0400
Received: by iecrd14 with SMTP id rd14so64323212iec.3
        for <linux-acpi@vger.kernel.org>; Thu, 18 Jun 2015 15:36:21 -0700 (PDT)
In-Reply-To: <1434666968-1543-1-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, tglx@linutronix.de, jason@lakedaemon.net, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, linaro-kernel@lists.linaro.org, patches@linaro.org

Add the ACPI_SPEC_VERSION() macro to build a proper version number from
a major and minor revision number.  Add also the ACPI_FADT_SPEC_VERSION
that constructs a proper version number from the entries in the current
FADT.

These macros are added in order to simplify retrieving and comparing ACPI
specification version numbers, since this is becoming a more frequent need.
In particular, there are some architectures that require at least a certain
version of the spec, and there are differences in some structure sizes that
have changed with recent versions but can only be tracked by spec version
number.

Signed-off-by: Al Stone <al.stone@linaro.org>
---
 include/linux/acpi.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index a4acb55..33ed313 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -48,6 +48,11 @@
 #include <acpi/acpi_io.h>
 #include <asm/acpi.h>
 
+#define ACPI_SPEC_VERSION(major, minor)	((major<<8)|minor)
+#define ACPI_FADT_SPEC_VERSION	\
+	ACPI_SPEC_VERSION(acpi_gbl_FADT.header.revision, \
+			  acpi_gbl_FADT.minor_revision)
+
 static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
 {
 	return adev ? adev->handle : NULL;
-- 
2.4.0

